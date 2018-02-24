if not TukuiCF["unitframes"].enable == true then return end

------------------------------------------------------------------------
--	local variables
------------------------------------------------------------------------

local db = TukuiCF["unitframes"]
local font1 = TukuiCF["media"].minimal
local font2 = TukuiCF["media"].font
local normTex = TukuiCF["media"].normTex
local glowTex = TukuiCF["media"].glowTex
local bubbleTex = TukuiCF["media"].bubbleTex

local backdrop = {
	bgFile = TukuiCF["media"].blank,
	insets = {top = -TukuiDB.mult, left = -TukuiDB.mult, bottom = -TukuiDB.mult, right = -TukuiDB.mult},
}

------------------------------------------------------------------------
--	Layout
------------------------------------------------------------------------

local function Shared(self, unit)
	-- set our own colors
	self.colors = TukuiDB.oUF_colors
	
	-- register click
	self:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	
	-- menu? lol
	self.menu = TukuiDB.SpawnMenu

	-- backdrop for every units
	self:SetBackdrop(backdrop)
	self:SetBackdropColor(0, 0, 0)

	-- this is the glow border
	TukuiDB.CreateShadow(self)
	
	------------------------------------------------------------------------
	--	Features we want for all units at the same time
	------------------------------------------------------------------------
	
	-- here we create an invisible frame for all element we want to show over health/power.
	local InvFrame = CreateFrame("Frame", nil, self)
	InvFrame:SetFrameStrata("HIGH")
	InvFrame:SetFrameLevel(5)
	InvFrame:SetAllPoints()
	
	-- symbols, now put the symbol on the frame we created above.
	local RaidIcon = InvFrame:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetTexture("Interface\\AddOns\\Tukui\\media\\textures\\raidicons.blp") -- thx hankthetank for texture
	RaidIcon:SetHeight(20)
	RaidIcon:SetWidth(20)
	RaidIcon:SetPoint("TOP", 0, 8)
	self.RaidIcon = RaidIcon
	
	------------------------------------------------------------------------
	--	Player and Target units layout (mostly mirror'd)
	------------------------------------------------------------------------
	
	 --  local example = CreateFrame("Frame", "Example", UIParent)
	--	TukuiDB.CreatePanel(nil, 30, 23, "RIGHT", InvTukuiActionBarBackground, "LEFT", -3, 0)
	
	--local tempcast = CreateFrame("Frame", nil, self)
	--	if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
	--		TukuiDB.CreatePanel(tempcast, 190, 23, "TOP", self, "TOP", 0, 54)
	--	else
		--	TukuiDB.CreatePanel(tempcast, 250, 23, "TOP", self, "TOP", 0, 50)
		--end
		--tempcast:SetFrameLevel(5)
		--tempcast:SetAlpha(0)
		

		
	if (unit == "player" or unit == "target") then
		-- create a panel
		local panel = CreateFrame("Frame", nil, self)
		if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
			TukuiDB.CreatePanel(panel, 186, 20, "BOTTOM", self, "BOTTOM", 0, -26) 
		else
			TukuiDB.CreatePanel(panel, 250, 21, "BOTTOM", self, "BOTTOM", 0, 0)
		end
		panel:SetFrameLevel(2)		
		TukuiDB.CreateShadow(panel)
		--panel:SetAlpha(0)
		panel:SetFrameStrata("MEDIUM")
		--panel:SetBackdropBorderColor(unpack(TukuiCF["media"].altbordercolor))
		--panel:SetBackdropColor(0, 0, 0, 0)
		self.panel = panel
	
		-- health bar
		local health = CreateFrame('StatusBar', nil, self)
		if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
			health:SetHeight(TukuiDB.Scale(29))
		else
			health:SetHeight(TukuiDB.Scale(26))
		end
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)
				
		-- health bar background
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
		health:SetFrameLevel(2)	
		
		--health:SetAlpha(.65)
	
		health.value = TukuiDB.SetFontString(health, font1, 10, "OUTLINEMONOCHROME")
		health.value:SetPoint("RIGHT", panel, "RIGHT", TukuiDB.Scale(-4), TukuiDB.Scale(1))
		health.PostUpdate = TukuiDB.PostUpdateHealth
				
		self.Health = health
		self.Health.bg = healthBG

		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorTapping = false
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorTapping = true	
			health.colorClass = true
			health.colorReaction = true			
		end

		-- power
		local power = CreateFrame('StatusBar', nil, self)
		power:SetHeight(TukuiDB.Scale(5))
		power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, -TukuiDB.mult)
		power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, -TukuiDB.mult)
		power:SetStatusBarTexture(normTex)
		
		local powerBG = power:CreateTexture(nil, 'BORDER')
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.3
		
		power.value = TukuiDB.SetFontString(power, font1, 10, "OUTLINEMONOCHROME")
		power.value:SetPoint("LEFT", panel, "LEFT", TukuiDB.Scale(4), TukuiDB.Scale(1))

		power.PreUpdate = TukuiDB.PreUpdatePower
		power.PostUpdate = TukuiDB.PostUpdatePower
				
		self.Power = power
		self.Power.bg = powerBG

		power.frequentUpdates = true
		power.colorDisconnected = true

		if db.showsmooth == true then
			power.Smooth = true
		end
		
		if db.unicolor == true then			
			power.colorTapping = true
			power.colorClass = true
			powerBG.multiplier = 0.1				
		else
			power.colorPower = true
		end

		-- portraits
		if (db.charportrait == true) then
			local portrait = CreateFrame("PlayerModel", nil, health)

            portrait:SetFrameLevel(health:GetFrameLevel())
            portrait:SetAllPoints(health)
            portrait.PostUpdate = function(self) self:SetAlpha(0) self:SetAlpha(0.35) end
			local overlay = CreateFrame("Frame", nil, self)
            overlay:SetFrameLevel(health:GetFrameLevel() + 2)    
            self.Portrait = portrait
			health.bg:ClearAllPoints()
            health.bg:SetPoint('BOTTOMLEFT', health:GetStatusBarTexture(), 'BOTTOMRIGHT')
            health.bg:SetPoint('TOPRIGHT', health)
            health.bg:SetDrawLayer("OVERLAY", 7)
            health.bg:SetParent(overlay)
			
			--portrait:SetFrameLevel(health:GetFrameLevel())
			
			--portrait:SetFrameLevel(8)
			--portrait.PostUpdate = function(self) self:SetAlpha(0) self:SetAlpha(0.3) end
			--portrait:SetAllPoints(health)

                --portrait:SetHeight(health:GetHeight())				
                --portrait:SetWidth(health:GetWidth())
                --if unit == "player" then
               --    portrait:SetPoint("TOPLEFT", health, "TOPLEFT", 0 ,0)
               --    portrait:SetPoint("TOPRIGHT", health, "TOPRIGHT", 0 ,0)
               -- else
                --   portrait:SetPoint("TOPLEFT", health, "TOPLEFT", 0, 0)
                --   portrait:SetPoint("TOPRIGHT", health, "TOPRIGHT", 0 ,0)
               -- end
			--if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
			--	portrait:SetHeight(36)
			--else
			--	portrait:SetHeight(57)
			--end
			--portrait:SetWidth(186)
			--portrait:SetAlpha(.10)
			--if unit == "player" then
			--	health:SetPoint("TOPLEFT", 0,0)
			--	health:SetPoint("TOPRIGHT")
			--	power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, -TukuiDB.mult)
			--	power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, -TukuiDB.mult)
			--	panel:SetPoint("TOPLEFT", power, "BOTTOMLEFT", 0, -TukuiDB.mult)
			--	panel:SetPoint("TOPRIGHT", power, "BOTTOMRIGHT", 0, -TukuiDB.mult)
			--	portrait:SetPoint("TOPLEFT", health, "TOPLEFT", 0,0)
			--elseif unit == "target" then
			--	health:SetPoint("TOPRIGHT", 0,0)
			--	health:SetPoint("TOPLEFT")
			--	power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, -TukuiDB.mult)
			--	power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, -TukuiDB.mult)
			--	panel:SetPoint("TOPRIGHT", power, "BOTTOMRIGHT", 0, -TukuiDB.mult)
			--	panel:SetPoint("TOPLEFT", power, "BOTTOMLEFT", 0, -TukuiDB.mult)
			--	portrait:SetPoint("TOPRIGHT", health, "TOPRIGHT", 0,0)
			--end
			--panel:SetWidth(panel:GetWidth() - 34) -- panel need to be resized if charportrait is enabled
			table.insert(self.__elements, TukuiDB.HidePortrait)
			--self.Portrait = portrait
		end

		if (unit == "player") then
			-- combat icon
			local Combat = health:CreateTexture(nil, "OVERLAY")
			Combat:SetHeight(TukuiDB.Scale(19))
			Combat:SetWidth(TukuiDB.Scale(19))
			Combat:SetPoint("CENTER", panel, "CENTER", 0, 0)
			Combat:SetVertexColor(0.69, 0.31, 0.31)
			self.Combat = Combat

			-- custom info (low mana warning)
			FlashInfo = CreateFrame("Frame", "FlashInfo", self)
			FlashInfo:SetScript("OnUpdate", TukuiDB.UpdateManaLevel)
			FlashInfo.parent = self
			FlashInfo:SetToplevel(true)
			FlashInfo:SetAllPoints(health)
			FlashInfo.ManaLevel = TukuiDB.SetFontString(FlashInfo, font1, 10)
			FlashInfo.ManaLevel:SetPoint("CENTER", panel, "CENTER", 0, 0)
			self.FlashInfo = FlashInfo
			
			-- pvp status text
			local status = TukuiDB.SetFontString(health, font1, 10)
			status:SetPoint("CENTER", panel, "CENTER", 0, 1)
			status:SetTextColor(0.69, 0.31, 0.31, 0)
			self.Status = status
			self:Tag(status, "[pvp]")
			
			-- leader icon
			local Leader = InvFrame:CreateTexture(nil, "OVERLAY")
			Leader:SetHeight(TukuiDB.Scale(14))
			Leader:SetWidth(TukuiDB.Scale(14))
			Leader:SetPoint("TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(8))
			self.Leader = Leader
			
			-- master looter
			local MasterLooter = InvFrame:CreateTexture(nil, "OVERLAY")
			MasterLooter:SetHeight(TukuiDB.Scale(14))
			MasterLooter:SetWidth(TukuiDB.Scale(14))
			self.MasterLooter = MasterLooter
			self:RegisterEvent("PARTY_LEADER_CHANGED", TukuiDB.MLAnchorUpdate)
			self:RegisterEvent("PARTY_MEMBERS_CHANGED", TukuiDB.MLAnchorUpdate)
						
			-- the threat bar on info left panel ? :P
			if (db.showthreat == true) then
				local ThreatBar = CreateFrame("StatusBar", self:GetName()..'_ThreatBar', TukuiInfoLeft)
				ThreatBar:SetFrameLevel(5)
				ThreatBar:SetPoint("TOPLEFT", TukuiInfoLeft, TukuiDB.Scale(2), TukuiDB.Scale(-2))
				ThreatBar:SetPoint("BOTTOMRIGHT", TukuiInfoLeft, TukuiDB.Scale(-2), TukuiDB.Scale(2))
			  
				ThreatBar:SetStatusBarTexture(normTex)
				ThreatBar:GetStatusBarTexture():SetHorizTile(false)
				ThreatBar:SetBackdrop(backdrop)
				ThreatBar:SetBackdropColor(0, 0, 0, 0)
		   
				ThreatBar.Text = TukuiDB.SetFontString(ThreatBar, font1, 10, "OUTLINEMONOCHROME")
				ThreatBar.Text:SetPoint("RIGHT", ThreatBar, "RIGHT", TukuiDB.Scale(-30), 0)
		
				ThreatBar.Title = TukuiDB.SetFontString(ThreatBar, font1, 10, "OUTLINEMONOCHROME")
				ThreatBar.Title:SetText(tukuilocal.unitframes_ouf_threattext)
				ThreatBar.Title:SetPoint("LEFT", ThreatBar, "LEFT", TukuiDB.Scale(30), 0)
					  
				ThreatBar.bg = ThreatBar:CreateTexture(nil, 'BORDER')
				ThreatBar.bg:SetAllPoints(ThreatBar)
				ThreatBar.bg:SetTexture(0.1,0.1,0.1)
		   
				ThreatBar.useRawThreat = false
				self.ThreatBar = ThreatBar
			end
			
			-- experience bar on player via mouseover for player currently levelling a character
			if TukuiDB.level ~= MAX_PLAYER_LEVEL then
				local Experience = CreateFrame("StatusBar", self:GetName().."_Experience", self)
				Experience:SetStatusBarTexture(normTex)
				Experience:SetStatusBarColor(.3, .3, .3, .8)
				Experience:SetBackdrop(backdrop)
				Experience:SetBackdropColor(unpack(TukuiCF["media"].backdropcolor))
				Experience:SetWidth(panel:GetWidth() - TukuiDB.Scale(4))
				Experience:SetHeight(panel:GetHeight() - TukuiDB.Scale(4))
				Experience:SetPoint("TOPLEFT", panel, TukuiDB.Scale(2), TukuiDB.Scale(-2))
				Experience:SetPoint("BOTTOMRIGHT", panel, TukuiDB.Scale(-2), TukuiDB.Scale(2))
				Experience:SetFrameLevel(10)
				Experience:SetAlpha(0)
				
				Experience:HookScript("OnEnter", function(self) self:SetAlpha(1) end)
				Experience:HookScript("OnLeave", function(self) self:SetAlpha(0) end)
				
				Experience.Tooltip = true						
				Experience.Rested = CreateFrame('StatusBar', nil, self)
				Experience.Rested:SetParent(Experience)
				Experience.Rested:SetAllPoints(Experience)
				local Resting = Experience:CreateTexture(nil, "OVERLAY")
				Resting:SetHeight(28)
				Resting:SetWidth(28)
				Resting:SetPoint("LEFT", -18, 68)
				Resting:SetTexture([=[Interface\CharacterFrame\UI-StateIcon]=])
				Resting:SetTexCoord(0, 0.5, 0, 0.421875)
				Resting:SetAlpha(0)
				self.Resting = Resting
				self.Experience = Experience
			end
			
			-- reputation bar for max level character
			if TukuiDB.level == MAX_PLAYER_LEVEL then
				local Reputation = CreateFrame("StatusBar", self:GetName().."_Reputation", self)
				Reputation:SetStatusBarTexture(normTex)
				Reputation:SetBackdrop(backdrop)
				Reputation:SetBackdropColor(unpack(TukuiCF["media"].backdropcolor))
				Reputation:SetWidth(panel:GetWidth() - TukuiDB.Scale(4))
				Reputation:SetHeight(panel:GetHeight() - TukuiDB.Scale(4))
				Reputation:SetPoint("TOPLEFT", panel, TukuiDB.Scale(2), TukuiDB.Scale(-2))
				Reputation:SetPoint("BOTTOMRIGHT", panel, TukuiDB.Scale(-2), TukuiDB.Scale(2))
				Reputation:SetFrameLevel(10)
				Reputation:SetAlpha(0)
				
				Reputation:HookScript("OnEnter", function(self) self:SetAlpha(1) end)
				Reputation:HookScript("OnLeave", function(self) self:SetAlpha(0) end)
				
				Reputation.PostUpdate = TukuiDB.UpdateReputationColor
				Reputation.Tooltip = true
				self.Reputation = Reputation
			end
			
			-- show druid mana when shapeshifted in bear, cat or whatever
			if TukuiDB.myclass == "DRUID" then
				CreateFrame("Frame"):SetScript("OnUpdate", function() TukuiDB.UpdateDruidMana(self) end)
				local DruidMana = TukuiDB.SetFontString(health, font1, 10, "OUTLINEMONOCHROME")
				DruidMana:SetTextColor(1, 0.49, 0.04)
				self.DruidMana = DruidMana
			end

			-- deathknight runes
			if TukuiDB.myclass == "DEATHKNIGHT" and db.runebar == true then
				-- rescale top shadow border
				self.shadow:SetPoint("TOPLEFT", TukuiDB.Scale(-4), TukuiDB.Scale(13))
				
				local Runes = CreateFrame("Frame", nil, self)
				Runes:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, TukuiDB.Scale(1))
				Runes:SetHeight(TukuiDB.Scale(8))
				if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
					Runes:SetWidth(TukuiDB.Scale(186))
				else
					Runes:SetWidth(TukuiDB.Scale(250))
				end
				Runes:SetBackdrop(backdrop)
				Runes:SetBackdropColor(0, 0, 0)

				for i = 1, 6 do
					Runes[i] = CreateFrame("StatusBar", self:GetName().."_Runes"..i, self)
					Runes[i]:SetHeight(TukuiDB.Scale(8))
					if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
						Runes[i]:SetWidth(TukuiDB.Scale(181) / 6)
					else
						Runes[i]:SetWidth(TukuiDB.Scale(245) / 6)
					end
					if (i == 1) then
						Runes[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, TukuiDB.Scale(1))
					else
						Runes[i]:SetPoint("TOPLEFT", Runes[i-1], "TOPRIGHT", TukuiDB.Scale(1), 0)
					end
					Runes[i]:SetStatusBarTexture(normTex)
					Runes[i]:GetStatusBarTexture():SetHorizTile(false)
				end

				self.Runes = Runes
			end
			
			-- shaman totem bar
			if TukuiDB.myclass == "SHAMAN" and db.totemtimer == true then
				-- rescale top shadow border
				self.shadow:SetPoint("TOPLEFT", TukuiDB.Scale(-4), TukuiDB.Scale(13))
				
				local TotemBar = {}
				TotemBar.Destroy = true
				for i = 1, 4 do
					TotemBar[i] = CreateFrame("StatusBar", self:GetName().."_TotemBar"..i, self)
					if (i == 1) then
					   TotemBar[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, TukuiDB.Scale(1))
					else
					   TotemBar[i]:SetPoint("TOPLEFT", TotemBar[i-1], "TOPRIGHT", TukuiDB.Scale(1), 0)
					end
					TotemBar[i]:SetStatusBarTexture(normTex)
					TotemBar[i]:SetHeight(TukuiDB.Scale(8))
					if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
						TotemBar[i]:SetWidth(TukuiDB.Scale(183) / 4)
					else
						TotemBar[i]:SetWidth(TukuiDB.Scale(247) / 4)
					end
					TotemBar[i]:SetBackdrop(backdrop)
					TotemBar[i]:SetBackdropColor(0, 0, 0)
					TotemBar[i]:SetMinMaxValues(0, 1)

					TotemBar[i].bg = TotemBar[i]:CreateTexture(nil, "BORDER")
					TotemBar[i].bg:SetAllPoints(TotemBar[i])
					TotemBar[i].bg:SetTexture(normTex)
					TotemBar[i].bg.multiplier = 0.3
				end
				self.TotemBar = TotemBar
			end
			
			-- script for pvp status and low mana
			self:SetScript("OnEnter", function(self)
				if self.EclipseBar and self.EclipseBar:IsShown() then 
					self.EclipseBar.Text:Hide()
				end
				FlashInfo.ManaLevel:SetAlpha(0) 
				status:SetAlpha(1) 
				UnitFrame_OnEnter(self) 
			end)
			self:SetScript("OnLeave", function(self) 
				if self.EclipseBar and self.EclipseBar:IsShown() then 
					self.EclipseBar.Text:Show()
				end
				FlashInfo.ManaLevel:SetAlpha(1)
				status:SetAlpha(0) 
				UnitFrame_OnLeave(self) 
			end)
		end
		
		if (unit == "target") then			
			-- Unit name on target
			local Name = health:CreateFontString(nil, "OVERLAY")
			Name:SetPoint("CENTER", panel, "CENTER", TukuiDB.Scale(2), TukuiDB.Scale(1)) 
			--Name:SetAlpha(0)
			--Name:SetJustifyH("LEFT")
			Name:SetFont(font1, 10, "OUTLINEMONOCHROME")
			Name:SetShadowColor(0, 0, 0)
			Name:SetShadowOffset(1.25, -1.25)

			self:Tag(Name, '[Tukui:getnamecolor][Tukui:nameshort] [Tukui:diffcolor]')
			self.Name = Name
			
			-- combo points on target
			local CPoints = {}
			CPoints.unit = PlayerFrame.unit
			for i = 1, 5 do
				CPoints[i] = health:CreateTexture(nil, "OVERLAY")
				CPoints[i]:SetHeight(TukuiDB.Scale(12))
				CPoints[i]:SetWidth(TukuiDB.Scale(12))
				CPoints[i]:SetTexture(bubbleTex)
				if i == 1 then
					if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
						CPoints[i]:SetPoint("TOPRIGHT", TukuiDB.Scale(15), TukuiDB.Scale(1.5))
					else
						CPoints[i]:SetPoint("TOPLEFT", TukuiDB.Scale(-15), TukuiDB.Scale(1.5))
					end
					CPoints[i]:SetVertexColor(0.69, 0.31, 0.31)
				else
					CPoints[i]:SetPoint("TOP", CPoints[i-1], "BOTTOM", TukuiDB.Scale(1))
				end
			end
			CPoints[2]:SetVertexColor(0.69, 0.31, 0.31)
			CPoints[3]:SetVertexColor(0.65, 0.63, 0.35)
			CPoints[4]:SetVertexColor(0.65, 0.63, 0.35)
			CPoints[5]:SetVertexColor(0.33, 0.59, 0.33)
			self.CPoints = CPoints
			self:RegisterEvent("UNIT_COMBO_POINTS", TukuiDB.UpdateCPoints)
		end

		if (unit == "target" and db.targetauras) or (unit == "player" and db.playerauras) then
			self.Debuffs = CreateFrame("Frame", nil, self)
			self.Debuffs:SetHeight(21)
			self.Debuffs:SetWidth(186)
			self.Debuffs.size = 41
			self.Debuffs.spacing = 3
			self.Debuffs.num = 24
			self.Debuffs.numDebuffs = 24
			local buffs = CreateFrame("Frame", nil, self)
			local debuffs = CreateFrame("Frame", nil, self)
			if (TukuiDB.myclass == "SHAMAN" or TukuiDB.myclass == "DEATHKNIGHT" or TukuiDB.myclass == "PALADIN" or TukuiDB.myclass == "WARLOCK") and (db.playerauras) and (unit == "player") then
				if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
					buffs:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 34)
					
				else
					buffs:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 38)
				end
			else
				if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
					buffs:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 27)
				else
					buffs:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 30)
				end
			end
			
			if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
				
				buffs:SetHeight(21.5)
				buffs:SetWidth(186)				
				buffs.size = 24
				buffs.num = 14		
				debuffs:SetHeight(21.5)
				debuffs:SetWidth(186)
				debuffs:SetPoint("BOTTOMLEFT", buffs, "TOPLEFT", 0, 32)
				debuffs.size = 24	
				debuffs.num = 14
			else				
				buffs:SetHeight(26)
				buffs:SetWidth(252)
				buffs.size = 22
				buffs.num = 8
				
				debuffs:SetHeight(26)
				debuffs:SetWidth(252)
				debuffs:SetPoint("BOTTOMLEFT", buffs, "TOPLEFT", -2, 2)
				debuffs.size = 24
				debuffs.num = 7
			end

			buffs.spacing = 3
			buffs.initialAnchor = 'TOPRIGHT'
			buffs["growth-y"] = "UP"
			buffs["growth-x"] = "LEFT"
			buffs.PostCreateIcon = TukuiDB.PostCreateAura
			buffs.PostUpdateIcon = TukuiDB.PostUpdateAura
			self.Buffs = buffs	
			
					
			debuffs.spacing = 3			
			debuffs.initialAnchor = 'TOPRIGHT'
			debuffs["growth-y"] = "UP"
			debuffs["growth-x"] = "LEFT"
			debuffs.PostCreateIcon = TukuiDB.PostCreateAura
			debuffs.PostUpdateIcon = TukuiDB.PostUpdateAura
			self.Debuffs = debuffs
			
		end
			
		-- cast bar for player and target
		if (db.unitcastbar == true) then
			-- castbar of player and target
			local castbar = CreateFrame("StatusBar", self:GetName().."_Castbar", self)
			castbar:SetHeight(TukuiDB.Scale(20))
			castbar:SetWidth(TukuiDB.Scale(165))
			castbar:SetStatusBarTexture(normTex)
			castbar:SetFrameLevel(6)
			castbar:SetPoint("TOPLEFT", panel, TukuiDB.Scale(21), TukuiDB.Scale(0))		
			
			castbar.bg = CreateFrame("Frame", nil, castbar)
			TukuiDB.SetTemplate(castbar.bg)
			castbar.bg:SetPoint("TOPLEFT", TukuiDB.Scale(-21), TukuiDB.Scale(0))
			castbar.bg:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(0), TukuiDB.Scale(0))
			castbar.bg:SetFrameLevel(5)
			--TukuiDB.CreateShadow(castbar.bg)
			
			castbar.CustomTimeText = TukuiDB.CustomCastTimeText
			castbar.CustomDelayText = TukuiDB.CustomCastDelayText
			castbar.PostCastStart = TukuiDB.CheckCast
			castbar.PostChannelStart = TukuiDB.CheckChannel

			castbar.time = TukuiDB.SetFontString(castbar, font1, 10, "OUTLINE")
			castbar.time:SetPoint("RIGHT", castbar, "RIGHT", TukuiDB.Scale(-4), 0)
			--castbar.time:SetTextColor(0.84, 0.75, 0.65)
			--castbar.time:SetJustifyH("RIGHT")

			castbar.Text = TukuiDB.SetFontString(castbar, font1, 10, "OUTLINE")
			castbar.Text:SetPoint("LEFT", castbar, "LEFT", TukuiDB.Scale(4), 0)
			castbar.Text:SetTextColor(0.84, 0.75, 0.65)
			
			if db.cbicons == true then
				castbar.button = CreateFrame("Frame", nil, castbar)
				castbar.button:SetHeight(TukuiDB.Scale(22))
				castbar.button:SetWidth(TukuiDB.Scale(22))
				TukuiDB.SetTemplate(castbar.button)
				TukuiDB.CreateShadow(castbar.button)

				castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
				castbar.icon:SetPoint("LEFT", castbar.bg, TukuiDB.Scale(0), TukuiDB.Scale(0))
				--castbar.icon:SetPoint("BOTTOMRIGHT", panel, TukuiDB.Scale(0), TukuiDB.Scale(0))
				castbar.icon:SetHeight(20)
				castbar.icon:SetWidth(20)
				castbar.icon:SetTexCoord(0.09, 0.92, 0.09, .92)
			
				--if unit == "player" then
				--	if db.charportrait == true then
				--		castbar.button:SetPoint("LEFT", -82.5, 26.5)
				--	else
				--		castbar.button:SetPoint("LEFT", -128, 0)
				--	end
				--elseif unit == "target" then
				--	if db.charportrait == true then
				--		castbar.button:SetPoint("RIGHT", 82.5, 26.5)
				--	else
				--		castbar.button:SetPoint("RIGHT", 46.5, 26.5)
				--	end					
				--end
			end
			
			-- cast bar latency on player
			if unit == "player" and db.cblatency == true then
				castbar.safezone = castbar:CreateTexture(nil, "ARTWORK")
				castbar.safezone:SetTexture(normTex)
				castbar.safezone:SetVertexColor(0.69, 0.31, 0.31, 0.75)
				castbar.SafeZone = castbar.safezone
			end
			
			self.Castbar = castbar
			self.Castbar.Time = castbar.time
			self.Castbar.Icon = castbar.icon
		end
		
		-- add combat feedback support
		if db.combatfeedback == true then
			local CombatFeedbackText 
			if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
				CombatFeedbackText = TukuiDB.SetFontString(health, font1, 8)
			else
				CombatFeedbackText = TukuiDB.SetFontString(health, font1, 14)
			end
			CombatFeedbackText:SetPoint("CENTER", 0, 1)
			CombatFeedbackText:SetShadowColor(0, 0, 0)
			CombatFeedbackText:SetShadowOffset(1.25, -1.25)
			CombatFeedbackText.colors = {
				DAMAGE = {0.69, 0.31, 0.31},
				CRUSHING = {0.69, 0.31, 0.31},
				CRITICAL = {0.69, 0.31, 0.31},
				GLANCING = {0.69, 0.31, 0.31},
				STANDARD = {0.84, 0.75, 0.65},
				IMMUNE = {0.84, 0.75, 0.65},
				ABSORB = {0.84, 0.75, 0.65},
				BLOCK = {0.84, 0.75, 0.65},
				RESIST = {0.84, 0.75, 0.65},
				MISS = {0.84, 0.75, 0.65},
				HEAL = {0.33, 0.59, 0.33},
				CRITHEAL = {0.33, 0.59, 0.33},
				ENERGIZE = {0.31, 0.45, 0.63},
				CRITENERGIZE = {0.31, 0.45, 0.63},
			}
			self.CombatFeedbackText = CombatFeedbackText
		end
		
		
		-- player aggro
		if db.playeraggro == true then
			table.insert(self.__elements, TukuiDB.UpdateThreat)
			self:RegisterEvent('PLAYER_TARGET_CHANGED', TukuiDB.UpdateThreat)
			self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', TukuiDB.UpdateThreat)
			self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', TukuiDB.UpdateThreat)
		end
	end
	
	------------------------------------------------------------------------
	--	Target of Target unit layout
	------------------------------------------------------------------------
	
	if (unit == "targettarget") then
		-- create panel if higher version
		local panel = CreateFrame("Frame", nil, self)
		--if not TukuiDB.lowversion then
		--	TukuiDB.CreatePanel(panel, 89, 17, "BOTTOM", self, "BOTTOM", 0, TukuiDB.Scale(0))
		--	panel:SetFrameLevel(2)
		--	panel:SetFrameStrata("MEDIUM")
		--	panel:SetBackdropBorderColor(unpack(TukuiCF["media"].altbordercolor))
		--	self.panel = panel
		--end
		
		-- health bar
		local health = CreateFrame('StatusBar', nil, self)
		health:SetHeight(TukuiDB.Scale(16))
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)
		
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
		
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true			
		end
		
		-- power
		local power = CreateFrame('StatusBar', nil, self)
		power:SetHeight(TukuiDB.Scale(5))
		power:SetPoint("BOTTOMLEFT")
		power:SetPoint("BOTTOMRIGHT")
		power:SetStatusBarTexture(normTex)
		
		power.frequentUpdates = true
		power.colorPower = false
		power.colorClass = true
		if db.showsmooth == true then
			power.Smooth = true
		end

		local powerBG = power:CreateTexture(nil, 'BORDER')
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.1
				
		self.Power = power
		self.Power.bg = powerBG
		
		-- Unit name
		local Name = health:CreateFontString(nil, "OVERLAY")
		if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
			Name:SetPoint("CENTER", health, "CENTER", 0, 0)
			Name:SetFont(font1, 10, "OUTLINEMONOCHROME")
			--Name:SetShadowColor(0, 0, 0)
			--Name:SetShadowOffset(1.25, -1.25, -1.25, -1.25)
		else
			Name:SetPoint("CENTER", health, "CENTER", 0, 0)
			Name:SetFont(font1, 10, "OUTLINEMONOCHROME")
			--Name:SetShadowColor(0, 0, 0)
			--Name:SetShadowOffset(1.25, -1.25)
		end
		Name:SetJustifyH("CENTER")


		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namemedium]')
		self.Name = Name
		
		if db.totdebuffs == true and TukuiDB.lowversion ~= true then
			local debuffs = CreateFrame("Frame", nil, health)
			debuffs:SetHeight(20)
			debuffs:SetWidth(127)
			debuffs.size = 20
			debuffs.spacing = 2
			debuffs.num = 6

			debuffs:SetPoint("TOPLEFT", health, "TOPLEFT", -0.5, 24)
			debuffs.initialAnchor = "TOPLEFT"
			debuffs["growth-y"] = "UP"
			debuffs.PostCreateIcon = TukuiDB.PostCreateAura
			debuffs.PostUpdateIcon = TukuiDB.PostUpdateAura
			self.Debuffs = debuffs
		end
	end
	
	------------------------------------------------------------------------
	--	Pet unit layout
	------------------------------------------------------------------------
	
	if (unit == "pet") then
		-- create panel if higher version
		local panel = CreateFrame("Frame", nil, self)
		if not TukuiDB.lowversion then
			TukuiDB.CreatePanel(panel, 89, 17, "BOTTOM", self, "BOTTOM", 0, TukuiDB.Scale(0))
			panel:SetFrameLevel(2)
			panel:SetFrameStrata("MEDIUM")
			panel:SetBackdropBorderColor(unpack(TukuiCF["media"].altbordercolor))
			self.panel = panel
		end
		
		-- health bar
		local health = CreateFrame('StatusBar', nil, self)
		health:SetHeight(TukuiDB.Scale(16))
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)
				
		self.Health = health
		self.Health.bg = healthBG
		
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
		
		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true	
			health.colorClass = true
			health.colorReaction = true	
			if TukuiDB.myclass == "HUNTER" then
				health.colorHappiness = true
			end
		end
		
		-- power
		local power = CreateFrame('StatusBar', nil, self)
		power:SetHeight(TukuiDB.Scale(5))
		power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, -TukuiDB.mult)
		power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, -TukuiDB.mult)
		power:SetStatusBarTexture(normTex)
		
		power.frequentUpdates = true
		power.colorPower = true
		if db.showsmooth == true then
			power.Smooth = true
		end

		local powerBG = power:CreateTexture(nil, 'BORDER')
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.3
				
		self.Power = power
		self.Power.bg = powerBG
				
		-- Unit name
		local Name = health:CreateFontString(nil, "OVERLAY")
		if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
			Name:SetPoint("CENTER", health, "CENTER", TukuiDB.Scale(2), 0)
			Name:SetFont(font1, 10, "OUTLINEMONOCHROME")
		else
			Name:SetPoint("CENTER", panel, "CENTER", 0, 0)
			Name:SetFont(font1, 10, "OUTLINEMONOCHROME")
		end
		Name:SetJustifyH("CENTER")
		--Name:SetShadowColor(0, 0, 0)
		--Name:SetShadowOffset(1.25, -1.25)

		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor]')
		self.Name = Name
		
		if (db.unitcastbar == true) then
			local castbar = CreateFrame("StatusBar", self:GetName().."_Castbar", self)
			castbar:SetStatusBarTexture(normTex)
			self.Castbar = castbar
			
			if not TukuiDB.lowversion then
				castbar.bg = castbar:CreateTexture(nil, "BORDER")
				castbar.bg:SetAllPoints(castbar)
				castbar.bg:SetTexture(normTex)
				castbar.bg:SetVertexColor(0.15, 0.15, 0.15)
				castbar:SetFrameLevel(6)
				castbar:SetPoint("TOPLEFT", panel, TukuiDB.Scale(2), TukuiDB.Scale(-2))
				castbar:SetPoint("BOTTOMRIGHT", panel, TukuiDB.Scale(-2), TukuiDB.Scale(2))
				
				castbar.CustomTimeText = TukuiDB.CustomCastTimeText
				castbar.CustomDelayText = TukuiDB.CustomCastDelayText
				castbar.PostCastStart = TukuiDB.CheckCast
				castbar.PostChannelStart = TukuiDB.CheckChannel

				castbar.time = TukuiDB.SetFontString(castbar, font1, 8)
				castbar.time:SetPoint("RIGHT", panel, "RIGHT", TukuiDB.Scale(-4), 0)
				castbar.time:SetTextColor(0.84, 0.75, 0.65)
				castbar.time:SetJustifyH("RIGHT")

				castbar.Text = TukuiDB.SetFontString(castbar, font1, 8)
				castbar.Text:SetPoint("LEFT", panel, "LEFT", TukuiDB.Scale(4), 0)
				castbar.Text:SetTextColor(0.84, 0.75, 0.65)
				
				self.Castbar.Time = castbar.time
			end
		end
		
		-- update pet name, this should fix "UNKNOWN" pet names on pet unit.
		self:RegisterEvent("UNIT_PET", TukuiDB.UpdatePetInfo)
	end


	------------------------------------------------------------------------
	--	Focus unit layout
	------------------------------------------------------------------------
	
	if (unit == "focus") then
		-- hide shadow
		self.shadow:SetAlpha(0)
		
		-- create health bar
		local health = CreateFrame('StatusBar', nil, self)
		health:SetPoint("TOPLEFT")
		health:SetPoint("BOTTOMRIGHT")
		health:SetStatusBarTexture(normTex)
		health:GetStatusBarTexture():SetHorizTile(false)
		
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
		
		health.value = TukuiDB.SetFontString(health, font1, 10, "OUTLINEMONOCHROME")
		health.value:SetPoint("RIGHT", health, "RIGHT", TukuiDB.Scale(-4), 0)
		health.PostUpdate = TukuiDB.PostUpdateHealth
		
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end
		
		-- Unit name
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("LEFT", health, "LEFT", TukuiDB.Scale(4), 0)
		Name:SetJustifyH("LEFT")
		Name:SetFont(font1, 10, "OUTLINEMONOCHROME")
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)

		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namelong] [Tukui:diffcolor] [shortclassification]')
		self.Name = Name

		-- create focus debuff feature
		if db.focusdebuffs == true then
			local debuffs = CreateFrame("Frame", nil, self)
			debuffs:SetHeight(26)
			debuffs:SetWidth(TukuiCF["panels"].tinfowidth - 10)
			debuffs.size = 30
			debuffs.spacing = 2
			debuffs.num = 40
						
			debuffs:SetPoint("TOPRIGHT", self, "TOPRIGHT", 2, 38)
			debuffs.initialAnchor = "TOPRIGHT"
			debuffs["growth-y"] = "UP"
			debuffs["growth-x"] = "LEFT"
			
			debuffs.PostCreateIcon = TukuiDB.PostCreateAura
			debuffs.PostUpdateIcon = TukuiDB.PostUpdateAura
			self.Debuffs = debuffs
		end
		
		-- focus cast bar in the center of the screen
		if db.unitcastbar == true then
			local castbar = CreateFrame("StatusBar", self:GetName().."_Castbar", self)
			castbar:SetHeight(TukuiDB.Scale(20))
			castbar:SetWidth(TukuiDB.Scale(240))
			castbar:SetStatusBarTexture(normTex)
			castbar:SetFrameLevel(6)
			castbar:SetPoint("CENTER", UIParent, "CENTER", 0, 250)		
			
			castbar.bg = CreateFrame("Frame", nil, castbar)
			TukuiDB.SetTemplate(castbar.bg)
			castbar.bg:SetPoint("TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
			castbar.bg:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
			castbar.bg:SetFrameLevel(5)
			TukuiDB.CreateShadow(castbar.bg)
			
			castbar.time = TukuiDB.SetFontString(castbar, font1, 8)
			castbar.time:SetPoint("RIGHT", castbar, "RIGHT", TukuiDB.Scale(-4), 0)
			castbar.time:SetTextColor(0.84, 0.75, 0.65)
			castbar.time:SetJustifyH("RIGHT")
			castbar.CustomTimeText = CustomCastTimeText

			castbar.Text = TukuiDB.SetFontString(castbar, font1, 8)
			castbar.Text:SetPoint("LEFT", castbar, "LEFT", TukuiDB.Scale(4), 0)
			castbar.Text:SetTextColor(0.84, 0.75, 0.65)
			
			castbar.CustomDelayText = TukuiDB.CustomCastDelayText
			castbar.PostCastStart = TukuiDB.CheckCast
			castbar.PostChannelStart = TukuiDB.CheckChannel
			
			if db.cbicons == true then
				castbar.button = CreateFrame("Frame", nil, castbar)
				castbar.button:SetHeight(TukuiDB.Scale(40))
				castbar.button:SetWidth(TukuiDB.Scale(40))
				castbar.button:SetPoint("CENTER", 0, TukuiDB.Scale(50))
				TukuiDB.SetTemplate(castbar.button)

				castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
				castbar.icon:SetPoint("TOPLEFT", castbar.button, TukuiDB.Scale(2), TukuiDB.Scale(-2))
				castbar.icon:SetPoint("BOTTOMRIGHT", castbar.button, TukuiDB.Scale(-2), TukuiDB.Scale(2))
				castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)
				
				TukuiDB.CreateShadow(castbar.button)
			end

			self.Castbar = castbar
			self.Castbar.Time = castbar.time
			self.Castbar.Icon = castbar.icon
		end
	end
	
	------------------------------------------------------------------------
	--	Focus target unit layout
	------------------------------------------------------------------------

	if (unit == "focustarget") then
		-- create panel if higher version
		local panel = CreateFrame("Frame", nil, self)
		TukuiDB.CreatePanel(panel, 89, 17, "BOTTOM", self, "BOTTOM", 0, 0)
		panel:SetFrameLevel(2)
		panel:SetFrameStrata("MEDIUM")
		panel:SetBackdropBorderColor(unpack(TukuiCF["media"].altbordercolor))
		self.panel = panel
		
		-- health bar
		local health = CreateFrame('StatusBar', nil, self)
		health:SetHeight(TukuiDB.Scale(18))
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)
		
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
		
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true			
		end
		
		-- Unit name
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", panel, "CENTER", 0, 0)
		Name:SetFont(font1, 8)
		Name:SetJustifyH("CENTER")

		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor][level]')
		self.Name = Name
	end

	------------------------------------------------------------------------
	--	Arena or boss units layout (both mirror'd)
	------------------------------------------------------------------------
	
	if (unit and unit:find("arena%d") and TukuiCF["arena"].unitframes == true) or (unit and unit:find("boss%d") and db.showboss == true) then
		-- Right-click focus on arena or boss units
		self:SetAttribute("type2", "focus")
		
		-- health 
		local health = CreateFrame('StatusBar', nil, self)
		health:SetHeight(TukuiDB.Scale(22))
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)

		health.frequentUpdates = true
		health.colorDisconnected = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		health.colorClass = true
		
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)

		health.value = TukuiDB.SetFontString(health, font1, 10, "OUTLINEMONOCHROME")
		health.value:SetPoint("LEFT", TukuiDB.Scale(2), 0)
		health.PostUpdate = TukuiDB.PostUpdateHealth
				
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end
	
		-- power
		local power = CreateFrame('StatusBar', nil, self)
		power:SetHeight(TukuiDB.Scale(6))
		power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, -TukuiDB.mult)
		power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, -TukuiDB.mult)
		power:SetStatusBarTexture(normTex)
		
		power.frequentUpdates = true
		power.colorPower = true
		if db.showsmooth == true then
			power.Smooth = true
		end

		local powerBG = power:CreateTexture(nil, 'BORDER')
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.3
		
		power.value = TukuiDB.SetFontString(health, font1, 10, "OUTLINEMONOCHROME")
		power.value:SetPoint("RIGHT", TukuiDB.Scale(-2), 0)
		power.PreUpdate = TukuiDB.PreUpdatePower
		power.PostUpdate = TukuiDB.PostUpdatePower
				
		self.Power = power
		self.Power.bg = powerBG
		
		-- names
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", health, "CENTER", 0, 0)
		Name:SetJustifyH("CENTER")
		Name:SetFont(font1, 10, "OUTLINEMONOCHROME")
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)
		
		self:Tag(Name, '[Tukui:getnamecolor][Tukui:nameshort]')
		self.Name = Name
		
		-- create buff at left of unit if they are boss units
		if (unit and unit:find("boss%d")) then
			local buffs = CreateFrame("Frame", nil, self)
			buffs:SetHeight(26)
			buffs:SetWidth(252)
			buffs:SetPoint("RIGHT", self, "LEFT", TukuiDB.Scale(-4), 0)
			buffs.size = 26
			buffs.num = 3
			buffs.spacing = 2
			buffs.initialAnchor = 'RIGHT'
			buffs["growth-x"] = "LEFT"
			buffs.PostCreateIcon = TukuiDB.PostCreateAura
			buffs.PostUpdateIcon = TukuiDB.PostUpdateAura
			self.Buffs = buffs
		end

		-- create debuff for both arena and boss units
		local debuffs = CreateFrame("Frame", nil, self)
		debuffs:SetHeight(26)
		debuffs:SetWidth(200)
		debuffs:SetPoint('LEFT', self, 'RIGHT', TukuiDB.Scale(4), 0)
		debuffs.size = 26
		debuffs.num = 5
		debuffs.spacing = 2
		debuffs.initialAnchor = 'LEFT'
		debuffs["growth-x"] = "RIGHT"
		debuffs.PostCreateIcon = TukuiDB.PostCreateAura
		debuffs.PostUpdateIcon = TukuiDB.PostUpdateAura
		self.Debuffs = debuffs	
				
		-- trinket feature via trinket plugin
		if (TukuiCF.arena.unitframes) and (unit and unit:find('arena%d')) then
			local Trinketbg = CreateFrame("Frame", nil, self)
			Trinketbg:SetHeight(26)
			Trinketbg:SetWidth(26)
			Trinketbg:SetPoint("RIGHT", self, "LEFT", -6, 0)				
			TukuiDB.SetTemplate(Trinketbg)
			Trinketbg:SetFrameLevel(0)
			self.Trinketbg = Trinketbg
			
			local Trinket = CreateFrame("Frame", nil, Trinketbg)
			Trinket:SetAllPoints(Trinketbg)
			Trinket:SetPoint("TOPLEFT", Trinketbg, TukuiDB.Scale(2), TukuiDB.Scale(-2))
			Trinket:SetPoint("BOTTOMRIGHT", Trinketbg, TukuiDB.Scale(-2), TukuiDB.Scale(2))
			Trinket:SetFrameLevel(1)
			Trinket.trinketUseAnnounce = true
			self.Trinket = Trinket
		end
	end

	------------------------------------------------------------------------
	--	Main tanks and Main Assists layout (both mirror'd)
	------------------------------------------------------------------------
	
	if(self:GetParent():GetName():match"oUF_MainTank" or self:GetParent():GetName():match"oUF_MainAssist") then
		-- Right-click focus on maintank or mainassist units
		self:SetAttribute("type2", "focus")
		
		-- health 
		local health = CreateFrame('StatusBar', nil, self)
		health:SetHeight(TukuiDB.Scale(20))
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)
		
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
				
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end
		
		-- names
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", health, "CENTER", 0, 0)
		Name:SetJustifyH("CENTER")
		Name:SetFont(font1, 8)
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)
		
		self:Tag(Name, '[Tukui:getnamecolor][Tukui:nameshort]')
		self.Name = Name
	end
	
	return self
end

------------------------------------------------------------------------
--	Default position of Tukui unitframes
------------------------------------------------------------------------

-- for lower reso
local adjustXY = 0
local totdebuffs = 0
if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then adjustXY = 24 end
if db.totdebuffs then totdebuffs = 24 end

oUF:RegisterStyle('Tukz', Shared)

-- player
local player = oUF:Spawn('player', "oUF_Tukz_player")
player:SetPoint("BOTTOM", InvTukuiActionBarBackground, "TOP", -95,43+adjustXY)
if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
	player:SetSize(TukuiDB.Scale(186), TukuiDB.Scale(35))
else
	player:SetSize(TukuiDB.Scale(250), TukuiDB.Scale(57))
end

-- focus
local focus = oUF:Spawn('focus', "oUF_Tukz_focus")
focus:SetPoint("CENTER", TukuiInfoRight, "CENTER")
focus:SetSize(TukuiInfoRight:GetWidth() - TukuiDB.Scale(4), TukuiInfoRight:GetHeight() - TukuiDB.Scale(4))

-- target
local target = oUF:Spawn('target', "oUF_Tukz_target")
target:SetPoint("BOTTOM", InvTukuiActionBarBackground, "TOP", 95,43+adjustXY)
if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
	target:SetSize(TukuiDB.Scale(186), TukuiDB.Scale(35))
else
	target:SetSize(TukuiDB.Scale(250), TukuiDB.Scale(57))
end

-- tot
local tot = oUF:Spawn('targettarget', "oUF_Tukz_targettarget")
if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
	tot:SetPoint("BOTTOMRIGHT", InvTukuiActionBarBackground, "TOPRIGHT", 0,11)
	tot:SetSize(TukuiDB.Scale(186), TukuiDB.Scale(22))
else
	tot:SetPoint("BOTTOM", InvTukuiActionBarBackground, "TOP", 0,8)
	tot:SetSize(TukuiDB.Scale(129), TukuiDB.Scale(35))
end

-- pet
local pet = oUF:Spawn('pet', "oUF_Tukz_pet")
if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
	pet:SetPoint("BOTTOMLEFT", InvTukuiActionBarBackground, "TOPLEFT", 0,11)
	pet:SetSize(TukuiDB.Scale(186), TukuiDB.Scale(22))
else
	pet:SetPoint("BOTTOM", InvTukuiActionBarBackground, "TOP", 0,49+totdebuffs)
	pet:SetSize(TukuiDB.Scale(129), TukuiDB.Scale(36))
end

if db.showfocustarget then 
	local focustarget = oUF:Spawn("focustarget", "oUF_Tukz_focustarget")
	focustarget:SetPoint("BOTTOM", 0, 224)
	focustarget:SetSize(TukuiDB.Scale(129), TukuiDB.Scale(36))
end

if TukuiCF.arena.unitframes then
	local arena = {}
	for i = 1, 5 do
		arena[i] = oUF:Spawn("arena"..i, "oUF_Arena"..i)
		if i == 1 then
			arena[i]:SetPoint("BOTTOM", UIParent, "BOTTOM", 252, 460)
		else
			arena[i]:SetPoint("BOTTOM", arena[i-1], "TOP", 0, 10)
		end
		arena[i]:SetSize(TukuiDB.Scale(200), TukuiDB.Scale(29))
	end
end

if db.showboss then
	for i = 1,MAX_BOSS_FRAMES do
		local t_boss = _G["Boss"..i.."TargetFrame"]
		t_boss:UnregisterAllEvents()
		t_boss.Show = TukuiDB.dummy
		t_boss:Hide()
		_G["Boss"..i.."TargetFrame".."HealthBar"]:UnregisterAllEvents()
		_G["Boss"..i.."TargetFrame".."ManaBar"]:UnregisterAllEvents()
	end

	local boss = {}
	for i = 1, MAX_BOSS_FRAMES do
		boss[i] = oUF:Spawn("boss"..i, "oUF_Boss"..i)
		if i == 1 then
			boss[i]:SetPoint("BOTTOM", UIParent, "BOTTOM", 252, 460)
		else
			boss[i]:SetPoint('BOTTOM', boss[i-1], 'TOP', 0, 10)             
		end
		boss[i]:SetSize(TukuiDB.Scale(200), TukuiDB.Scale(29))
	end
end

local assisttank_width  = 100
local assisttank_height  = 20
if TukuiCF["unitframes"].maintank == true then
	local tank = oUF:SpawnHeader('oUF_MainTank', nil, 'raid',
		'oUF-initialConfigFunction', ([[
			self:SetWidth(%d)
			self:SetHeight(%d)
		]]):format(assisttank_width, assisttank_height),
		'showRaid', true,
		'groupFilter', 'MAINTANK',
		'yOffset', 7,
		'point' , 'BOTTOM',
		'template', 'oUF_tukzMtt'
	)
	tank:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
end
 
if TukuiCF["unitframes"].mainassist == true then
	local assist = oUF:SpawnHeader("oUF_MainAssist", nil, 'raid',
		'oUF-initialConfigFunction', ([[
			self:SetWidth(%d)
			self:SetHeight(%d)
		]]):format(assisttank_width, assisttank_height),
		'showRaid', true,
		'groupFilter', 'MAINASSIST',
		'yOffset', 7,
		'point' , 'BOTTOM',
		'template', 'oUF_tukzMtt'
	)
	if TukuiCF["unitframes"].maintank == true then
		assist:SetPoint("TOPLEFT", oUF_MainTank, "BOTTOMLEFT", 2, -50)
	else
		assist:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
end

-- this is just a fake party to hide Blizzard frame if no Tukui raid layout are loaded.
local party = oUF:SpawnHeader("oUF_noParty", nil, "party", "showParty", true)

------------------------------------------------------------------------
--	Just a command to test buffs/debuffs alignment
------------------------------------------------------------------------

local testui = TestUI or function() end
TestUI = function()
	testui()
	UnitAura = function()
		-- name, rank, texture, count, dtype, duration, timeLeft, caster
		return 'penancelol', 'Rank 2', 'Interface\\Icons\\Spell_Holy_Penance', random(5), 'Magic', 0, 0, "player"
	end
	if(oUF) then
		for i, v in pairs(oUF.units) do
			if(v.UNIT_AURA) then
				v:UNIT_AURA("UNIT_AURA", v.unit)
			end
		end
	end
end
SlashCmdList.TestUI = TestUI
SLASH_TestUI1 = "/testui"

------------------------------------------------------------------------
-- Right-Click on unit frames menu. 
-- Doing this to remove SET_FOCUS eveywhere.
-- SET_FOCUS work only on default unitframes.
-- Main Tank and Main Assist, use /maintank and /mainassist commands.
------------------------------------------------------------------------

do
	UnitPopupMenus["SELF"] = { "PVP_FLAG", "LOOT_METHOD", "LOOT_THRESHOLD", "OPT_OUT_LOOT_TITLE", "LOOT_PROMOTE", "DUNGEON_DIFFICULTY", "RAID_DIFFICULTY", "RESET_INSTANCES", "RAID_TARGET_ICON", "LEAVE", "CANCEL" };
	UnitPopupMenus["PET"] = { "PET_PAPERDOLL", "PET_RENAME", "PET_ABANDON", "PET_DISMISS", "CANCEL" };
	UnitPopupMenus["PARTY"] = { "MUTE", "UNMUTE", "PARTY_SILENCE", "PARTY_UNSILENCE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "PROMOTE", "PROMOTE_GUIDE", "LOOT_PROMOTE", "VOTE_TO_KICK", "UNINVITE", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" }
	UnitPopupMenus["PLAYER"] = { "WHISPER", "INSPECT", "INVITE", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" }
	UnitPopupMenus["RAID_PLAYER"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "RAID_LEADER", "RAID_PROMOTE", "RAID_DEMOTE", "LOOT_PROMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" }
	UnitPopupMenus["RAID"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "RAID_LEADER", "RAID_PROMOTE", "LOOT_PROMOTE", "RAID_DEMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "CANCEL" }
	UnitPopupMenus["VEHICLE"] = { "RAID_TARGET_ICON", "VEHICLE_LEAVE", "CANCEL" }
	UnitPopupMenus["TARGET"] = { "RAID_TARGET_ICON", "CANCEL" }
	UnitPopupMenus["ARENAENEMY"] = { "CANCEL" }
	UnitPopupMenus["FOCUS"] = { "RAID_TARGET_ICON", "CANCEL" }
	UnitPopupMenus["BOSS"] = { "RAID_TARGET_ICON", "CANCEL" }
end