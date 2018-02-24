-- Built in StatusWindow modules

--
-- Placeholder
--
SWNone = {
	name = "Right Click",	
	Update = function(self, event)
		return ""
	end
}
StatusWindow:RegisterModule(SWNone)

--
-- Latency
--
SWLatency = {
	-- Setup and register
	name = "Latency",
	updateFrequency = 0.2,

	Update = function(self)
		local _,_,latency = GetNetStats()
		local colour = ((latency > 500) and "|c00ff0000") or ((latency > 200) and "|c00ffff00") or "|c0000ff00"
		return string.format("%s%d %s|r", colour, latency, MILLISECONDS_ABBR)
	end
}
StatusWindow:RegisterModule(SWLatency)

--
-- Framerate
--
SWFramerate = {
	name = "FPS",
	updateFrequency = .15,

	Update = function(self)
		return string.format("%d %s", GetFramerate(), StatusWindow.strings.FPSLABEL)
	end	
}
StatusWindow:RegisterModule(SWFramerate)

--
-- Clock
--
SWTime = {
	name = "Time",
	updateFrequency = 10,
	configFrame = StatusWindowClockOptions,

	Init = function(self)
		if not SWVar["clock"] then
			SWVar["clock"] = { offset = 0	}
		end
	end,

	Configure = function(self)
		StatusWindowClockOffsetLabel:SetText(StatusWindow.strings.OFFSET)
		StatusWindowClockOffsetText:SetText(string.format("%.1f", SWVar["clock"].offset))
		StatusWindowClockCheckButtonText:SetText(StatusWindow.strings.CLOCKTYPE)
		StatusWindowClockCheckButton:SetChecked(SWVar["clock"].twentyfourhourclock)
		StatusWindowClockOptions:Show()
	end,
	
	Update = function(self)
		local hour, minute = GetGameTime()
		local str, pm
		
		if (SWVar["clock"].offset > 0) then
			hour = hour + floor(SWVar["clock"].offset)
			if (SWVar["clock"].offset - floor(SWVar["clock"].offset) > 0) then
				minute = minute + 30
				if (minute > 60) then
					hour = hour + 1
					minute = minute - 60
				end
			end
			if (hour > 24) then
				hour = hour - 24
			end
		elseif (SWVar["clock"].offset < 0) then
			hour = hour + ceil(SWVar["clock"].offset)
			if (SWVar["clock"].offset - ceil(SWVar["clock"].offset) < 0) then
				minute = minute - 30
				if (minute < 0) then
					hour = hour - 1
					minute = minute + 60
				end
			end
			if (hour < 0) then
				hour = hour + 24
			end
		end
		
		if(hour >= 12 and hour < 24) and not SWVar["clock"].twentyfourhourclock then
			pm = "PM"
			hour = hour - 12
		else
			pm = "AM"
		end
		
		if (hour == 0) and not SWVar["clock"].twentyfourhourclock then
			hour = 12
		end
		
		if SWVar["clock"].twentyfourhourclock then
			return string.format("%02d:%02d", hour, minute)
		end
		return string.format("%d:%02d %s", hour, minute, pm)
	end,

	Clock24HourCheck = function(self)
		SWVar["clock"].twentyfourhourclock = this:GetChecked()
		StatusWindow:UpdateModulePanes(self)
	end,
	
	OffsetUp = function(self)
		if (SWVar["clock"].offset < 12) then
			SWVar["clock"].offset = SWVar["clock"].offset + 0.5
			StatusWindowClockOffsetText:SetText(string.format("%.1f", SWVar["clock"].offset))
			StatusWindow:UpdateModulePanes(self)
		end
	end,
	
	OffsetDown = function(self)
		if (SWVar["clock"].offset > -12) then
			SWVar["clock"].offset = SWVar["clock"].offset - 0.5
			StatusWindowClockOffsetText:SetText(string.format("%.1f", SWVar["clock"].offset))
			StatusWindow:UpdateModulePanes(self)
		end
	end,
}

StatusWindow:RegisterModule(SWTime)

--
-- Health Regeneration
--
SWHealth= {
	name = "Health Regen",
	updateFrequency = 2,
	lastHealth = 0,

	Update = function(self)
		local currHealth = UnitHealth("player")
		local regen = 0
		if self.force or (currHealth ~= self.lastHealth) then
			regen = currHealth - self.lastHealth
		end
		self.lastHealth = currHealth
		return StatusWindow.strings.HPTICK..regen.."|r"
	end
}
StatusWindow:RegisterModule(SWHealth)

--
-- Mana Regeneration
--
SWMana = {
	name = "Mana Regen",
	updateFrequency = 2,
	lastMana = 0,
		
	Update = function(self)
		local currMana = UnitMana("player")
		local regen = 0
		if self.force or (currMana ~= self.lastMana) then
			regen = currMana - self.lastMana
		end
		self.lastMana = currMana
		return StatusWindow.strings.MANATICK..regen.."|r"
	end	
}
StatusWindow:RegisterModule(SWMana)

--
-- Gear Durability
--
SWDurability = {
	name = "Durability",
	updateEvent = "UPDATE_INVENTORY_ALERTS",
	
	Init = function(self)
		if not self.initialised then
			StatusWindow:HookModuleEvent(self, "UPDATE_INVENTORY_ALERTS")
			self.initialised = 1
		end
	end,

	Update = function(self, event)
		if (event == "UPDATE_INVENTORY_ALERTS") then
			local durability = self:GetDurability()
			local color
			if (durability > 50) then
				color = string.format("|c00%2xff00", ((durability > 50) and (255 - 2.55*durability)) or (2.55*durability))
			else
				color = string.format("|c00ff%2x00", (2.55*durability))
			end
			return string.format("%s%s%d%%|r", color, StatusWindow.strings.DURABILITYLABEL, durability)
		end
	end,

	GetDurability = function(self)
		local totalCurrent = 0
		local totalMax = 0
		local current, full
		
		for i=1,19 do
			current,full = self:ItemDurability(i)
			if current then
				totalCurrent = totalCurrent + current
				totalMax = totalMax + full
			end
		end
		if (totalMax == 0) then
			totalCurrent = 1
			totalMax = 1
		end
		return floor(totalCurrent * 100 / totalMax)
	end,

	ItemDurability = function(self, slot)
		local current, full
		SWTooltip:SetOwner(UIParent, "ANCHOR_NONE");
		local hasItem, hasCooldown, repairCost = SWTooltip:SetInventoryItem("player", slot)
		if hasItem then
			for i=1,10 do
				str = getglobal("SWTooltipTextLeft"..i):GetText()
				if not str then
					return nil,nil
				end
				_,_,current,full = string.find(str, "Durability (%d+) / (%d+)")
				if current then
					return current,full
				end
			end
		end
	end
}
StatusWindow:RegisterModule(SWDurability)

--
-- Experience
--
SWExperience = {
	name = "Experience",
	updateEvent = "PLAYER_XP_UPDATE",
	
	Init = function(self)
		if not self.initialised then
			StatusWindow:HookModuleEvent(self, "PLAYER_XP_UPDATE")
			StatusWindow:HookModuleEvent(self, "PLAYER_LEVEL_UP")
			StatusWindow:HookModuleEvent(self, "PLAYER_ENTERING_WORLD")
			self.initialised = 1
		end
	end,
	
	Update = function(self, event)
		local colour = (GetXPExhaustion() and "|c000099ff") or "|c00ffffff"
		return string.format("Level %d: %s %d%%|r", UnitLevel("player"), colour, floor(UnitXP("player")/UnitXPMax("player")* 100))
	end,
	
	Tooltip = function(self)
		local currXP = UnitXP("player");
		local nextlevelXP = UnitXPMax("player");
		local restXP = GetXPExhaustion();
		
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
		GameTooltip:SetText(currXP.."/"..nextlevelXP, 255/255, 209/255, 0/255);
		GameTooltip:AddLine((nextlevelXP-currXP).." to level "..UnitLevel("player")+1, 1.00, 1.00, 1.00);
		if (restXP) then
			GameTooltip:AddLine((restXP/2).." bonus XP", 1.00, 1.00, 1.00);
		end
		GameTooltip:Show();
	end,
}	
StatusWindow:RegisterModule(SWExperience)

--
-- Position Coordinates
--
SWPosition = {
	name = "Position",
	needZoneUpdate = true,
	updateFrequency = 1,

	Init = function(self)
		if not self.initialised then
			StatusWindow:HookModuleEvent(self, "MINIMAP_ZONE_CHANGED")
			self.initialised = 1
		end
	end,
	
	Update = function(self, event)
		if (event == "MINIMAP_ZONE_CHANGED") then
			self.needZoneUpdate = true
		end

		if self.needZoneUpdate and not WorldMapFrame:IsVisible() then
			self.needZoneUpdate = false
			SetMapToCurrentZone()
		end
		
		local x,y = GetPlayerMapPosition("player");
		return string.format("(%.0f,%.0f)", 100*x, 100*y)
	end
}
StatusWindow:RegisterModule(SWPosition)

--
-- Ammunition
--
SWAmmunition = {
	name = "Ammunition",
	updateEvent = "UNIT_INVENTORY_CHANGED",

	Init = function(self)
		if not self.initialised then
			StatusWindow:HookModuleEvent(self, "ITEM_LOCK_CHANGED")
			StatusWindow:HookModuleEvent(self, "UNIT_INVENTORY_CHANGED")
			self.initialised = 1
		end
	end,
	
	Update = function(self, event)
		local ammoSlot = GetInventorySlotInfo("ammoSlot")
		local rangedSlot = GetInventorySlotInfo("rangedSlot")
		local str = "No Ammo"
		if GetInventoryItemQuality("player", ammoSlot) then
			str = "Ammo: "..GetInventoryItemCount("player", ammoSlot)
		elseif GetInventoryItemQuality("player", rangedSlot) then
			str = "Ammo: "..GetInventoryItemCount("player", rangedSlot)
		end
		return str
	end,
}
StatusWindow:RegisterModule(SWAmmunition)

--
-- Money
--
SWMoney = {
	name = "Money",

	Init = function(self)
		if not self.initialised then
			StatusWindow:HookModuleEvent(self, "PLAYER_ENTERING_WORLD")
			StatusWindow:HookModuleEvent(self, "PLAYER_MONEY")
			self.initialised = 1
		end
	end,
	
	Update = function(self, event)
		local m = GetMoney()
		local g = floor(m/10000)
		local s = floor((m - (10000*g))/100)
		local c = m - (10000*g) - (100*s)
		return string.format("%s.|c00ffffff%s|r|c000099ff.|r|c00c96333%s|r",g,s,c)
	end,
}
StatusWindow:RegisterModule(SWMoney)

--
-- Bag slots
--
SWBagSlots = {
	name = "Bag Slots",
	updateEvent = "UNIT_INVENTORY_CHANGED",

	Init = function(self)
		if not self.initialised then
			StatusWindow:HookModuleEvent(self, "UNIT_INVENTORY_CHANGED")
			StatusWindow:HookModuleEvent(self, "BAG_UPDATE");
			StatusWindow:HookModuleEvent(self, "BAG_OPEN");
			StatusWindow:HookModuleEvent(self, "ITEM_LOCK_CHANGED");
			StatusWindow:HookModuleEvent(self, "UPDATE_INVENTORY_ALERTS");
			self.initialised = 1
		end
	end,
	
	Update = function(self, event)
		local used,total
		used = 0
		total = 0
		for i=0,4 do
			used = used + self:CountBagSlots(i)
			total = total + (GetContainerNumSlots(i) or 0)
		end
		return string.format("Bags: %d/%d", used, total)
	end,

	CountBagSlots = function(self, bag)
		local used = 0
		for i=1,GetContainerNumSlots(bag) do
			used = used + ((GetContainerItemInfo(bag, i) and 1) or 0)
		end
		return used
	end,
}
StatusWindow:RegisterModule(SWBagSlots)

--
-- PvP kills
--
SWPVPKills = {
	name = "PvP Kills",
	updateEvent = "PLAYER_PVP_KILLS_CHANGED",

	Init = function(self)
		if not self.initialised then
			StatusWindow:HookModuleEvent(self, "PLAYER_PVP_KILLS_CHANGED")
			self.initialised = 1
		end
	end,
	
	Update = function(self, event)
		return string.format("HK: |c0000ff00%d|r", GetPVPSessionStats())
	end,
}
StatusWindow:RegisterModule(SWPVPKills)

--
-- Memory
--
SWMemory = {
	name = "Memory",
	updateFrequency = 2,

	Update = function(self)
		return string.format("UI: %dMB", gcinfo()/1024)
	end
}
StatusWindow:RegisterModule(SWMemory)

--
-- Friends online
--
SWFriends = {
	name = "Friends",
	updateEvent = "FRIENDLIST_UPDATE",
	
	Init = function(self)
		if not self.initialised then
			StatusWindow:HookModuleEvent(self, "FRIENDLIST_UPDATE")
			self.initialised = 1
		end
	end,
	
	Update = function(self, event)
		local name, level, class, area, connected, status 
		local onlineCount = 0
		self.friends = {}
		for i=1,GetNumFriends() do
			name, level, class, area, connected, status = GetFriendInfo(i)
			if connected then
				self.friends[name] = area
				onlineCount = onlineCount + 1
			end
		end
		table.sort(self.friends)
		return string.format("Friends: %d", onlineCount)
	end,

	Tooltip = function(self)
		self:Update()
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
		GameTooltip:SetText("Friends Online");
		for name,location in self.friends do
			GameTooltip:AddLine(name.." - "..location);
		end
		GameTooltip:Show();
	end,
}
StatusWindow:RegisterModule(SWFriends)

--
-- Guild online
--
SWGuild = {
	name = "Guild",
	updateEvent = "PLAYER_ENTERING_WORLD",
	online = 0,
	
	Init = function(self)
		if not self.initialised then
			StatusWindow:HookModuleEvent(self, "GUILD_ROSTER_UPDATE")
			StatusWindow:HookModuleEvent(self, "CHAT_MSG_SYSTEM")
			self.initialised = 1
		end
	end,
	
	Update = function(self, event)
		if (event == "GUILD_ROSTER_UPDATE") then
			local name, rank, rankIndex, level, class, zone, note, officernote, online
			self.online = 0
	
			for i=1,GetNumGuildMembers() do
				name, rank, rankIndex, level, class, zone, note, officernote, online = GetGuildRosterInfo(i);
				if online then
					self.online = self.online + 1
				end
			end
		elseif arg1 and (string.find(arg1, "online") or string.find(arg1, "offline")) then
			GuildRoster()		
		end
		return string.format("Guild: %d", self.online)
	end,

}
StatusWindow:RegisterModule(SWGuild)
