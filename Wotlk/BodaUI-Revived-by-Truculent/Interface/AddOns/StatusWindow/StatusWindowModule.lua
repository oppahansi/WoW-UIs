-- Built in StatusWindow modules

local ScrollingDropDown = LibStub and LibStub:GetLibrary('LibScrollingDropDown-1.0')

local GetTableArgs = function(...)
  local t = StatusWindow:GetTable()
  if ... then
    local k,v
    for i=1,#...,2 do
      t[select(i,...)] = select(i+1,...)
    end
  end
  return t
end

local GetTable = function()
  return StatusWindow:GetTable()
end

local PutTable = function(t)
  StatusWindow:PutTable(t)
  t = nil
end

local NewTable = function(t)
  StatusWindow:PutTable(t)
  t = StatusWindow:GetTable()
end

local SetText = function(f, format, ...)
  if f.SetFormattedText then
		f:SetFormattedText(format, ...)
	else
		f:SetText(string.format(format, ...))
	end
end

local GetFormat = function(format, ...)
  StatusWindowFrameTmp:SetFormattedText(format, ...)
  return StatusWindowFrameTmp:GetText()
end

--
-- None
--
SWNone = {
  width = 50,
	name = "None",
}
StatusWindow:RegisterModule(SWNone)

--
-- Latency
--
SWLatency = {
	name = "Latency",
	updateFrequency = 3,
  width = 50,
  helpStrings = {
    StatusWindow.strings.LATENCYHELP1,
  },
  
  New = function(self)
    self.modVar.label = StatusWindow.strings.LATENCY
  end,
  
	Init = function(self)
    self.pane.text:SetFont(StatusWindow:GetWindowFont(self.window))
    self.locals.elements = GetTable()
  end,

	Configure = function(self)
    StatusWindowOptions:SetupGenericConfig()
    StatusWindowOptions:OpenConfigFrames(StatusWindowGenericOptions)
	end,

	Update = function(self, event)
    local _,_,latency = GetNetStats()
    self.locals.elements[0] = ((latency > 500) and "|cffff0000") or ((latency > 200) and "|cffffff00") or "|cff00ff00"
    self.locals.elements[1] = latency
		StatusWindow:UpdateCurrentPane()
	end,
}
StatusWindow:RegisterModule(SWLatency)

--
-- Framerate
--
SWFramerate = {
	name = "FPS",
	updateFrequency = 2,
  icon = [[Interface\AddOns\StatusWindow\Images\fps]],
  width = 55,
  helpStrings = {
    StatusWindow.strings.FRAMERATEHELP1,
    StatusWindow.strings.FRAMERATEHELP2,
  },
  
  New = function(self)
    self.modVar.label = StatusWindow.strings.FPSLABEL
  end,
  
	Init = function(self)
    self.pane.text:SetFont(StatusWindow:GetWindowFont(self.window))
		self.pane.icon:SetTexture(self.icon)
    self.locals.elements = GetTable()
  end,
  
  Configure = function(self)
    StatusWindowOptions:SetupGenericConfig()
    StatusWindowOptions:OpenConfigFrames(StatusWindowGenericOptions)
	end,

	Update = function(self, event)
    self.locals.elements[1] = floor(GetFramerate())
    self.locals.elements[2] = floor(GetFramerate() * 10)/10
    StatusWindow:UpdateCurrentPane()
	end,
}
StatusWindow:RegisterModule(SWFramerate)

--
-- 
--
SWTime = {
	name = "Time",
	updateFrequency = 5,
  width = 60,
  helpStrings = {
    StatusWindow.strings.TIMEHELP1,
    StatusWindow.strings.TIMEHELP2,
    StatusWindow.strings.TIMEHELP3,
    StatusWindow.strings.TIMEHELP4,
  },
  
  New = function(self)
    self.modVar.offset = 0
    self.modVar.label = "$2:$3 $4"
  end,

	Init = function(self)
    self.pane.text:SetFont(StatusWindow:GetWindowFont(self.window))
    self.locals.elements = GetTable()
	end,

	Configure = function(self)
    SetText(StatusWindowClockOffsetLabel, "%s", StatusWindow.strings.OFFSET)
    SetText(StatusWindowClockOffsetText, "%.1f", self.modVar.offset)
    SetText(StatusWindowLocalTimeCheckButtonText, "%s", StatusWindow.strings.LOCALTIME)
    StatusWindowLocalTimeCheckButton:SetChecked(self.modVar.localTime)
    StatusWindowOptions:SetupGenericConfig(self)
    StatusWindowOptions:OpenConfigFrames(StatusWindowGenericOptions, StatusWindowClockOptions)
	end,
	
	Update = function(self, event)
		local minutes, hour, minute, pm
    if self.modVar.localTime then
      local t = date("*t", time())
      hour = t.hour
      minute = t.min
    else
      hour, minute = GetGameTime()
    end
    
    minutes = (hour*60) + minute + (self.modVar.offset * 60)
    if (minutes > 1440) then
      minutes = minutes - 1440
    end
    minutes = abs(minutes)
    self.locals.elements[1] = format("%02d", floor(minutes/60))
    self.locals.elements[2] = floor(minutes/60)
    self.locals.elements[3] = format("%02d", mod(minutes, 60))
    if minutes > 719 then
      if minutes > 779 then
        self.locals.elements[2] = floor(minutes/60) - 12
      end
      self.locals.elements[4] = StatusWindow.strings.TIMEPM
    else
      if (self.locals.elements[2] == 0) then
        self.locals.elements[2] = 12
      end
      self.locals.elements[4] = StatusWindow.strings.TIMEAM
    end
    StatusWindow:UpdateCurrentPane()
	end,

  ClockLocalTime = function(self)
		self.modVar.localTime = this:GetChecked()
		StatusWindowOptions:DoUpdate()
  end,
	
	OffsetUp = function(self)
		if (self.modVar.offset < 12) then
			self.modVar.offset = self.modVar.offset + 0.5
			SetText(StatusWindowClockOffsetText, "%.1f", self.modVar.offset)
			StatusWindowOptions:DoUpdate()
		end
	end,
	
	OffsetDown = function(self)
		if (self.modVar.offset > -12) then
			self.modVar.offset = self.modVar.offset - 0.5
			SetText(StatusWindowClockOffsetText, "%.1f", self.modVar.offset)
			StatusWindowOptions:DoUpdate()
		end
	end,
}
StatusWindow:RegisterModule(SWTime)

--
-- Health Regeneration
--
SWHealth= {
	name = "Health Regen",
	updateFrequency = 1,
  width = 100,
  helpStrings = {
    StatusWindow.strings.HREGENHELP1,
    StatusWindow.strings.HREGENHELP2,
    StatusWindow.strings.HREGENHELP3,
  },
  
	Configure = function(self)
    StatusWindowOptions:SetupGenericConfig()
    StatusWindowOptions:OpenConfigFrames(StatusWindowGenericOptions)
	end,

  New = function(self)
    self.modVar.label = StatusWindow.strings.HPTICK
  end,
  
	Init = function(self)
    self.pane.text:SetFont(StatusWindow:GetWindowFont(self.window))
		self.locals.lastHealth = 0
    self.locals.elements = GetTable()
	end,

	Update = function(self, event)
		local e = self.locals.elements
    e[2] = UnitHealth("player")
		e[3] = UnitHealthMax("player")
		e[1] = e[2] - self.locals.lastHealth
		self.locals.lastHealth = e[2]
		StatusWindow:UpdateCurrentPane()
	end,
}
StatusWindow:RegisterModule(SWHealth)

--
-- Mana Regeneration
--
SWMana = {
	name = "Mana Regen",
	updateFrequency = 1,
  width = 100,
  helpStrings = {
    StatusWindow.strings.MREGENHELP1,
    StatusWindow.strings.MREGENHELP2,
    StatusWindow.strings.MREGENHELP3,
  },
  
  New = function(self)
    self.modVar.label = StatusWindow.strings.MANATICK
  end,

	Init = function(self)
    self.pane.text:SetFont(StatusWindow:GetWindowFont(self.window))
		self.locals.lastMana = 0
    self.locals.window = GetTable()
    self.locals.update = false
    self.locals.elements = GetTable()
  end,
	
	Configure = function(self)
    StatusWindowOptions:SetupGenericConfig()
    StatusWindowOptions:OpenConfigFrames(StatusWindowGenericOptions)
	end,

	Update = function(self, event)
    local w = self.locals.window
    local m = UnitMana("player") 
    table.insert(w, m - self.locals.lastMana)
    self.locals.lastMana = m
    if(#w > 5) then
      table.remove(w, 1)
    end
    self.locals.update = not self.locals.update
    if self.locals.update then
      self.locals.elements[1] = 0
      for i=1,min(#w,5) do
        self.locals.elements[1] = self.locals.elements[1] + w[i]
      end
      StatusWindow:UpdateCurrentPane()  
    end
    
	end,
}
StatusWindow:RegisterModule(SWMana)

--
-- Gear Durability
--
SWDurability = {
	name = "Durability",
	events = { "UPDATE_INVENTORY_ALERTS", "ITEM_LOCK_CHANGED", "PLAYER_ENTERING_WORLD", "CHAT_MSG_COMBAT_MISC_INFO", "PLAYER_MONEY", "UNIT_GHOST" },
  icon = [[Interface\AddOns\StatusWindow\Images\repair]],
  width = 55,
  helpStrings = {
    StatusWindow.strings.DURABILITYHELP1,
    StatusWindow.strings.DURABILITYHELP2,
    StatusWindow.strings.DURABILITYHELP3,
    StatusWindow.strings.DURABILITYHELP4,
    StatusWindow.strings.DURABILITYHELP5,
  },
  
  New = function(self)
    self.modVar.label = StatusWindow.strings.DURABILITY
    self.modVar.textAlign = "LEFT"
  end,

	Init = function(self)
    self.pane.text:SetFont(StatusWindow:GetWindowFont(self.window))
		self.pane.icon:SetTexture(self.icon)
    self.locals.elements = GetTable()
  end,

	Configure = function(self)
    StatusWindowOptions:SetupGenericConfig()
    StatusWindowOptions:OpenConfigFrames(StatusWindowGenericOptions)
	end,
	
	Update = function(self, event)
		local durability = self:GetDurability()
    if (type(durability) == "number") then
      if durability > 50 then
        self.locals.elements[0] = GetFormat("|cff%2xff00", ((durability > 50) and (255 - 2.55*durability) or (2.55*durability)), durability)
      else
        self.locals.elements[0] = GetFormat("|cffff%2x00", (2.55*durability), durability)
      end
    else
    self.locals.elements[0] = nil
    end
    StatusWindow:UpdateCurrentPane()
	end,

	OnEnter = function(self)
		self:GetDurability()
		GameTooltip_SetDefaultAnchor(GameTooltip, this)
		GameTooltip:SetText("Durability")
		local r,g,b,n
		 for index,data in pairs(self.locals.items) do
			n = data.current/data.full
			if(n > 0.5) then
				r = 2 - (2*n)
				g = 1
				b = 0
			else
				r = 1
				g = 2*n
				b = 0
			end			
			GameTooltip:AddDoubleLine(data.name, data.current.."/"..data.full, 
				ITEM_QUALITY_COLORS[data.quality].r, ITEM_QUALITY_COLORS[data.quality].g, ITEM_QUALITY_COLORS[data.quality].b, r, g, b)
		end
		GameTooltip:Show()
	end,

	GetDurability = function(self)
		self.locals.elements[2] = 0
		self.locals.elements[3] = 0
		self.locals.elements[5] = 100
		local current, full, name, pct
    local lowestCur,lowestFull = 500,0
		PutTable(self.locals.items)
		self.locals.items = GetTable()
		
		for i=1,19 do
			current, full = GetInventoryItemDurability(i) 
			if current and full then
        pct = floor(100*current/full + 0.5)
        if (pct < self.locals.elements[5]) then
          self.locals.elements[5] = pct
        end
        if (current < lowestCur) then
          lowestCur = current
          lowestFull = full
        end
				self.locals.elements[2] = self.locals.elements[2] + current
				self.locals.elements[3] = self.locals.elements[3] + full
				if not self.locals.items[i] then
					self.locals.items[i] = GetTable()
				end
				self.locals.items[i].name = string.match(GetInventoryItemLink("player", i), "%[(.+)%]")
				self.locals.items[i].current = current
				self.locals.items[i].full = full
				self.locals.items[i].quality = GetInventoryItemQuality("player", i)
			end
		end
		self.locals.elements[4] = format("%d/%d", lowestCur, lowestFull)
		if (self.locals.elements[3] == 0) then
			self.locals.elements[1] = "N/A"
		else
      self.locals.elements[1] = floor(self.locals.elements[2] * 100 / self.locals.elements[3])
    end
    return self.locals.elements[1]
	end,
}
StatusWindow:RegisterModule(SWDurability)

--
-- Experience
--
SWExperience = {
	name = "Experience",
	updateEvent = "PLAYER_XP_UPDATE",
	events = { "PLAYER_XP_UPDATE", "PLAYER_LEVEL_UP", "PLAYER_ENTERING_WORLD", "UPDATE_EXHAUSTION" },
  width = 100,
  helpStrings = {
    StatusWindow.strings.XPHELP1,
    StatusWindow.strings.XPHELP2,
    StatusWindow.strings.XPHELP3,
    StatusWindow.strings.XPHELP4,
    StatusWindow.strings.XPHELP5,
    StatusWindow.strings.XPHELP6,
    StatusWindow.strings.XPHELP7,
    StatusWindow.strings.XPHELP8,
  },
  
	New = function(self)
    self.modVar.label = StatusWindow.strings.XPLABEL
  end,
  
	Init = function(self)
    self.pane.text:SetFont(StatusWindow:GetWindowFont(self.window))
    self.locals.elements = GetTable()
  end,

	Configure = function(self)
    StatusWindowOptions:SetupGenericConfig()
    StatusWindowOptions:OpenConfigFrames(StatusWindowGenericOptions)
	end,

	Update = function(self, event)
    local e = self.locals.elements
    e[1] = UnitXP("player")
    e[2] = UnitXPMax("player")
    e[3] = e[2]-e[1]
    e[4] = floor(e[1]/e[2]* 100)
    e[5] = floor(e[3]/e[2]* 100)
    e[6] = (GetXPExhaustion() or 0)/2
		e[7] = UnitLevel("player")
		e[8] = e[7] + 1
    e[0] = (e[6] and e[6] > 0 and "|cff0099ff") or nil
		StatusWindow:UpdateCurrentPane()
	end,
	
	OnEnter = function(self)
    local e = self.locals.elements
		GameTooltip_SetDefaultAnchor(GameTooltip, this)
		GameTooltip:SetText(e[1].."/"..e[2], 255/255, 209/255, 0/255)
		GameTooltip:AddLine(e[3].." to level "..e[8], 1.00, 1.00, 1.00)
		if (e[6] and e[6] > 0) then
			GameTooltip:AddLine(e[6].." bonus XP", 1.00, 1.00, 1.00)
		end
		GameTooltip:Show()
	end,
}	
StatusWindow:RegisterModule(SWExperience)

--
-- Position Coordinates
--
SWPosition = {
	name = "Position",
	updateFrequency = 0.5,
	events = { "MINIMAP_ZONE_CHANGED", "ZONE_CHANGED" },
  width = 45,
  helpStrings = {
    StatusWindow.strings.LOCHELP1,
    StatusWindow.strings.LOCHELP2,
    StatusWindow.strings.LOCHELP3,
    StatusWindow.strings.LOCHELP4,
  },
  
	New = function(self)
    self.modVar.label = StatusWindow.strings.LOC
  end,

	Init = function(self)
    self.pane.text:SetFont(StatusWindow:GetWindowFont(self.window))
    self.locals.elements = GetTable()
		self.locals.needZoneUpdate = true
  end,

	Configure = function(self)
    StatusWindowOptions:SetupGenericConfig()
    StatusWindowOptions:OpenConfigFrames(StatusWindowGenericOptions)
	end,

	Update = function(self, event)
		if (event == "MINIMAP_ZONE_CHANGED") then
			self.locals.needZoneUpdate = true
		end

		if self.locals.needZoneUpdate and not WorldMapFrame:IsVisible() then
			self.locals.needZoneUpdate = false
			SetMapToCurrentZone()
		end
		
		local x,y = GetPlayerMapPosition("player")
    self.locals.elements[1] = format("%d", x*100)
    self.locals.elements[2] = format("%d", y*100)
    self.locals.elements[3] = format("%.1f", x*100)
    self.locals.elements[4] = format("%.1f", y*100)
    StatusWindow:UpdateCurrentPane()
	end,
	
	OnClick = function(self)
		self.locals.needZoneUpdate = true
		self:Update()
	end,
}
StatusWindow:RegisterModule(SWPosition)

--
-- Money
--
SWMoney = {
	name = "Money",
	events = { "PLAYER_ENTERING_WORLD", "PLAYER_MONEY" }, 		
  width = 75,
  helpStrings = {
    StatusWindow.strings.MONEYHELP1,
    StatusWindow.strings.MONEYHELP2,
    StatusWindow.strings.MONEYHELP3,
  },
  
	New = function(self)
    self.modVar.label = StatusWindow.strings.MONEYLABEL
  end,
  
	Init = function(self)
    self.pane.text:SetFont(StatusWindow:GetWindowFont(self.window))
    self.locals.elements = GetTable()
  end,

	Configure = function(self)
    StatusWindowOptions:SetupGenericConfig()
    StatusWindowOptions:OpenConfigFrames(StatusWindowGenericOptions)
	end,

	Update = function(self, event)
		local m = GetMoney()
		self.locals.elements[1] = floor(m/10000)
		self.locals.elements[2] = floor((m - (10000*self.locals.elements[1]))/100)
		self.locals.elements[3] = m - (10000*self.locals.elements[1]) - (100*self.locals.elements[2])
		StatusWindow:UpdateCurrentPane()
	end,
}
StatusWindow:RegisterModule(SWMoney)

--
-- Bag slots
--
SWBagSlots = {
	name = "Bag Slots",
	updateEvent = "UNIT_INVENTORY_CHANGED",
	events = { "UNIT_INVENTORY_CHANGED", "BAG_UPDATE", "BAG_OPEN", "ITEM_LOCK_CHANGED", "UPDATE_INVENTORY_ALERTS" },
	registerClicks = { "LeftButtonDown" },
  icon = [[Interface\AddOns\StatusWindow\Images\Bag]],
  width = 55,
  helpStrings = {
    StatusWindow.strings.BAGHELP1,
    StatusWindow.strings.BAGHELP2,
    StatusWindow.strings.BAGHELP3,
  },
  
	New = function(self)
    self.modVar.label = StatusWindow.strings.BAGLABEL
    self.modVar.textAlign = "LEFT"
  end,

	Init = function(self)
    self.pane.text:SetFont(StatusWindow:GetWindowFont(self.window))
		self.pane.icon:SetTexture(self.icon)
    self.locals.elements = GetTable()
  end,

	Configure = function(self)
    StatusWindowOptions:SetupGenericConfig()
    StatusWindowOptions:OpenConfigFrames(StatusWindowGenericOptions)
	end,

	Update = function(self, event)
		local used,total = 0,0

		for i=0,4 do
			used = used + self:CountBagSlots(i)
			total = total + (GetContainerNumSlots(i) or 0)
		end
    self.locals.elements[1] = used
    self.locals.elements[2] = total - used
    self.locals.elements[3] = total
    StatusWindow:UpdateCurrentPane()
	end,
  
  OnClick = function(self, event)
    -- OpenAllBags()
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
-- Memory
--
SWMemory = {
	name = "Memory",
	updateFrequency = 5,
	
	New = function(self)
    self.modVar.label = StatusWindow.strings.MEMLABEL
  end,

	Init = function(self)
    self.pane.text:SetFont(StatusWindow:GetWindowFont(self.window))
    self.locals.elements = GetTable()
  end,

	Configure = function(self)
    StatusWindowOptions:SetupGenericConfig()
    StatusWindowOptions:OpenConfigFrames(StatusWindowGenericOptions)
	end,

	Update = function(self, event)
		if not self.locals.addons then
			self.locals.addons = {}
		end
		if self.showingTT then
			self:OnEnter()
		else
			self.updateFrequency = 1
		end
    self.locals.elements[1] = format("%.2f", collectgarbage("count")/1024)
		StatusWindow:UpdateCurrentPane()
	end,
	
	OnClick = function(self)
		collectgarbage()
	end,
	
	Sort = function(a,b)
		return a.mem > b.mem
	end,
	
	OnEnter = function(self)
		self.updateFrequency = 1
		UpdateAddOnMemoryUsage()
		local a,t,num,show
		for i,t in pairs(self.locals.addons) do
			PutTable(t)
			self.locals.addons[i] = nil
		end
    num = GetNumAddOns()
		for i=1,num do 
			a = GetAddOnMemoryUsage(i)
			if (a > 0) then
				t = GetTable()
				_,t.name = GetAddOnInfo(i)
				t.mem = a
				table.insert(self.locals.addons, t)
			end
		end
		table.sort(self.locals.addons, self.Sort)
    num = #self.locals.addons
    GameTooltip_SetDefaultAnchor(GameTooltip, this)
    if IsShiftKeyDown() then
      show = num
    else
      show = min(num,25)
    end
		GameTooltip:SetText(format(StatusWindow.strings.MEMTITLE, show, num))
    for i=1,show do
			m = self.locals.addons[i]
      if m then
        if (m.mem > 1024) then
          SetText(StatusWindowFrameTmp, StatusWindow.strings.MEMMIB, m.mem/1024)
          GameTooltip:AddDoubleLine(m.name, StatusWindowFrameTmp:GetText())
        else
          SetText(StatusWindowFrameTmp, StatusWindow.strings.MEMKIB, m.mem)
          GameTooltip:AddDoubleLine(m.name, StatusWindowFrameTmp:GetText())
        end
      end
		end
		GameTooltip:AddLine(" ")
    if (show < num) then
      GameTooltip:AddLine(StatusWindow.strings.MEMSHIFT)
    end
		GameTooltip:AddLine(StatusWindow.strings.MEMCLICK)
		GameTooltip:Show()
		self.updateFrequency = 1
		self.showingTT = true
	end,
	
	OnLeave = function(self)
		self.showingTT = false
	end,
}
StatusWindow:RegisterModule(SWMemory)

--
-- Friends online
--
SWFriends = {
	name = "Friends",
	events = { "FRIENDLIST_UPDATE" },
	registerClicks = { "LeftButtonDown", "RightButtonDown" },
	
	New = function(self)
    self.modVar.label = StatusWindow.strings.FRIENDLABEL
  end,

	Init = function(self)
    self.pane.text:SetFont(StatusWindow:GetWindowFont(self.window))
    self.pane.dropDownOptions = {
      clearOnHide = true,
      noSelection = true,
    }
    self.locals.elements = GetTable()
    ShowFriends()
	end,
	
	Configure = function(self)
    StatusWindowOptions:SetupGenericConfig()
    StatusWindowOptions:OpenConfigFrames(StatusWindowGenericOptions)
	end,

	Update = function(self, event)
		local connected, count
    self.locals.elements[1] = 0
		for i=1,GetNumFriends() do
			_, _, _, _, connected = GetFriendInfo(i)
			if connected then
        self.locals.elements[1] = self.locals.elements[1] + 1
      end
		end
    StatusWindow:UpdateCurrentPane()
	end,

  DropDownCallback = function(item)
    ChatFrame_SendTell(item.value.name)
  end,

  DropDownTooltip = function(item)
		GameTooltip_SetDefaultAnchor(GameTooltip, this)
    -- GameTooltip:AddLine(GetFormat("%s%s%s", item.value.status, (string.len(item.value.status) == 0 and "") or " ", item.value.name))
    GameTooltip:AddLine(item.value.name)
    GameTooltip:AddLine(GetFormat("%d %s%s|r", item.value.level, StatusWindow:ClassColorCode(item.value.class), item.value.class))
    GameTooltip:AddLine(item.value.location)
    GameTooltip:Show()
  end,
  
  OnClick = function(self, event)
    if event == "RightButton" then
      if ScrollingDropDown:IsShown() then
        ScrollingDropDown:Close()
      else
        local name, level, class, area, connected, status
        local item = GetTable()
        item.value = GetTable()
        item.callback = self.DropDownCallback
        item.tooltipCallback = self.DropDownTooltip
        for i=1,GetNumFriends() do
          name, level, class, area, connected, status = GetFriendInfo(i)
          if connected then
            item.text = name
            item._textRGB = StatusWindow:ClassColorRGB(class)
            item.value.name = name
            item.value.level = level
            item.value.class = class
            item.value.location = area
            -- item.value.status = status
            ScrollingDropDown:AddItem(self.pane, item)
          end
        end
        PutTable(item)
        ScrollingDropDown:Open(self.pane)
      end
    else
      FriendsFrame:Show()
      FriendsFrame_ShowSubFrame("FriendsListFrame")
    end
	end,
}
StatusWindow:RegisterModule(SWFriends)

--
-- Guild online
--
SWGuild = {
	name = "Guild",
	registerClicks = { "LeftButtonDown", "RightButtonDown" },
	updateEvent = "PLAYER_ENTERING_WORLD",
	events = { "GUILD_ROSTER_UPDATE", "CHAT_MSG_SYSTEM", "PLAYER_ENTERING_WORLD" },
  
	New = function(self)
    self.modVar.label = StatusWindow.strings.GUILDLABEL
  end,

  Init = function(self)
    self.pane.text:SetFont(StatusWindow:GetWindowFont(self.window))
    self.pane.dropDownOptions = {
      clearOnHide = true,
      noSelection = true,
    }
    self.locals.elements = GetTable()
		GuildRoster()		
  end,

	Configure = function(self)
    StatusWindowOptions:SetupGenericConfig()
    StatusWindowOptions:OpenConfigFrames(StatusWindowGenericOptions)
	end,

	Update = function(self, event)
		if (event == "GUILD_ROSTER_UPDATE") then
			local name, rank, rankIndex, level, class, zone, note, officernote, online, t
      PutTable(self.locals.online)
      self.locals.online = GetTable()
			self.locals.elements[2] = GetNumGuildMembers()
      for i=1,self.locals.elements[2] do
        name, rank, rankIndex, level, class, zone, note, officernote, online = GetGuildRosterInfo(i)
        if online then
          t = GetTable()
          t.name = name
          t.level = level
          t.class = class
          t.note = note
          t.rank = rank
          t.location = zone
          table.insert(self.locals.online, t)
        end
			end
      self.locals.elements[1] = #self.locals.online
      StatusWindow:UpdateCurrentPane()
		elseif (event == "PLAYER_ENTERING_WORLD") or (arg1 and (string.find(arg1, "online") or string.find(arg1, "offline"))) then
			GuildRoster()		
		end
	end,

	OnEnter = function(self)
		GameTooltip_SetDefaultAnchor(GameTooltip, this)
		GameTooltip:AddLine("Right click for list")
		GameTooltip:Show()
	end,

  DropDownCallback = function(item)
    ChatFrame_SendTell(item._value.name)
  end,

  DropDownTooltip = function(item)
		GameTooltip_SetDefaultAnchor(GameTooltip, this)
    GameTooltip:AddLine(item._value.name)
    if item._value.note and (string.len(item._value.note) > 0) then
      GameTooltip:AddLine(item._value.note)
    end
    GameTooltip:AddLine(GetFormat("%d %s%s|r", item._value.level, StatusWindow:ClassColorCode(item._value.class), item._value.class))
    GameTooltip:AddLine(item._value.rank)
    GameTooltip:AddLine(item._value.location)
    GameTooltip:Show()
  end,
  
	OnClick = function(self, event)
    if event == "RightButton" then
      if ScrollingDropDown:IsShown() then
        ScrollingDropDown:Close()
      else
        local item = GetTable()
        item.callback = self.DropDownCallback
        item.tooltipCallback = self.DropDownTooltip
        for k,v in pairs(self.locals.online) do
          item.text = v.name
          item._textRGB = StatusWindow:ClassColorRGB(v.class)
          item._value = v
          ScrollingDropDown:AddItem(self.pane, item)
        end
        PutTable(item)
        ScrollingDropDown:Open(self.pane)
      end
    else
      FriendsFrame:Show()
      FriendsFrame_ShowSubFrame("GuildFrame")
    end
	end,
}
StatusWindow:RegisterModule(SWGuild)

--
-- Item Count
--
SWItemCount = {
	name = "Item Count",
	registerClicks = { "RightButtonDown" },
  updateEvent = "UNIT_INVENTORY_CHANGED",
	events = { "ITEM_LOCK_CHANGED", "UNIT_INVENTORY_CHANGED", "BAG_UPDATE", "ITEM_PUSH" },
  icon = [[Interface\Icons\INV_Misc_QuestionMark]],
  width = 45,
  helpStrings = {
    StatusWindow.strings.COUNTHELP1,
  },
  
	New = function(self)
    self.modVar.icon = self.icon
    self.modVar.label = "$i $1"
    self.modVar.textAlign = "LEFT"
  end,
  
	Init = function(self)
    self.pane.dropDownOptions = {
      clearOnHide = true,
      noSelection = true,
    }
		self.pane.icon:SetTexture(self.icon)
    self.locals.elements = GetTable()
	end,
	
	Configure = function(self)
		StatusWindowCountOptionsIconIconTexture:SetTexture(self.modVar.icon)
    StatusWindowOptions:SetupGenericConfig()
    StatusWindowOptions:OpenConfigFrames(StatusWindowGenericOptions, StatusWindowCountOptions)
	end,

	Update = function(self, event)
		if not self.modVar.itemID then
      self.locals.elements[1] = "--"
    else
      self.pane.icon:SetTexture(self.modVar.icon or self.icon)
      PutTable(self.locals.items)
      self.locals.items = GetTable()
      
      self.locals.elements[1] = 0
      local t, link
      for bag=0,4 do
        for slot=1,GetContainerNumSlots(bag) do
          link = GetContainerItemLink(bag, slot)
          if link and (tonumber(string.match(link, "Hitem:(.-):")) == self.modVar.itemID) then
            _,t = GetContainerItemInfo(bag, slot)
            if not self.locals.items[bag] then
              self.locals.items[bag] = t
            else
              self.locals.items[bag] = self.locals.items[bag] + t
            end
            self.locals.elements[1] = self.locals.elements[1] + t
          end
        end
      end
    end
		StatusWindow:UpdateCurrentPane()
	end,

	OnEnter = function(self)
    if self.modVar.itemName then
      GameTooltip_SetDefaultAnchor(GameTooltip, this)
      GameTooltip:SetText(self.modVar.itemName)
      for bag,num in pairs(self.locals.items) do
        GameTooltip:AddDoubleLine(GetBagName(bag), num)
      end
      GameTooltip:AddLine(" ")
      GameTooltip:AddLine(StatusWindow.strings.COUNTCHANGE)
      GameTooltip:Show()
    end
	end,

	ReceiveItem = function(self)
		if CursorHasItem() then
			local id, name, stack, texture
			_,id = GetCursorInfo()
			name, _, _, _, _, _, _, stack, _, texture = GetItemInfo(id)
      self.modVar.itemID = id
      self.modVar.itemName = name
      self.modVar.icon = texture
      StatusWindowCountOptionsIconIconTexture:SetTexture(texture)
      self:Update()
		end
		ClearCursor()
	end,

  DropDownCallback = function(item)
    item._var.itemID = tonumber(item.value)
    item._var.itemName = item.text
    item._var.icon = item.texture
    StatusWindow:UpdateWindow(item.window, item.frame)
  end,
  
	OnClick = function(self, event)
    if event == "RightButton" then
      local item = GetTable()
      item.callback = self.DropDownCallback
      item._var = self.modVar   -- Prefixing with _ means that PutTable will not try to recycle this sub-table (and blow away saved vars)
      item.window = self.window
      item.frame = self.frame
      for bag=0,4 do
        for slot=1,GetContainerNumSlots(bag) do
          link = GetContainerItemLink(bag, slot)
          if link then
            item.value,item.text = string.match(link, "Hitem:(.-):.+%[(.+)]")
            item.texture = GetContainerItemInfo(bag, slot)
            ScrollingDropDown:AddItem(self.pane, item)
          end
        end
      end
      PutTable(item)
      ScrollingDropDown:Open(self.pane)
    else
      -- .
    end
	end,
}
StatusWindow:RegisterModule(SWItemCount)

--
-- Honor
--
SWHonor = {
	name = "Honor",
  events = { "CHAT_MSG_COMBAT_HONOR_GAIN" },
  width = 65,
  helpStrings = {
    StatusWindow.strings.HONORHELP1,
    StatusWindow.strings.HONORHELP2,
  },
  
	New = function(self)
    self.modVar.label = StatusWindow.strings.HONORLABEL
  end,

	Init = function(self)
    self.pane.text:SetFont(StatusWindow:GetWindowFont(self.window))
    self.locals.elements = GetTable()
  end,

	Configure = function(self)
    StatusWindowOptions:SetupGenericConfig()
    StatusWindowOptions:OpenConfigFrames(StatusWindowGenericOptions)
	end,

	Update = function(self, event)
    self.locals.elements[2], self.locals.elements[1] = GetPVPSessionStats()
		StatusWindow:UpdateCurrentPane()
	end,
}
StatusWindow:RegisterModule(SWHonor)

