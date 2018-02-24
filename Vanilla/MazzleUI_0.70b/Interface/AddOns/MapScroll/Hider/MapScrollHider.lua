MapScroll.Hider = TRUE

--<< ================================================= >>--
-- Section II: The Spoofed Enable/Disable Functions.     --
--<< ================================================= >>--

function MapScroll:HiderInitialize()
	self.Msg = function(...) self.cmd:result(format(unpack(arg))) end
	self.Get = function(v) return self.db:get(self.profilePath, v) end
	self.Set = function(var, val) self.db:set(self.profilePath, var, val) end
	self.Tog = function(v, on, off)
		if self.db:toggle(self.profilePath, v) then
			self.Msg(on) else self.Msg(off) end
	end
end

function MapScroll:HiderEnable()
	if self.Get("zoomButtons") then
		self:Hide("MinimapZoomIn")
		self:Hide("MinimapZoomOut")
	end
	if self.Get("timeFrame") then
		self:Hide("GameTimeFrame")
	end
	if self.Get("toggleButton") then
		self:Hide("MinimapToggleButton")
	end
	if self.Get("zoneText") then
		self:Hide("MinimapZoneTextButton")
	end
	if self.Get("borderTop") then
		self:Hide("MinimapBorderTop")
	end
	if self.Get("mailFrame") then
		self:Hide("MiniMapMailFrame")
	end
	if self.Get("borderMain") then
		self:Alpha("MinimapBorder", 0)
	end
end

function MapScroll:HiderDisable()
	if self.Get("zoomButtons") then
		self:Show("MinimapZoomIn")
		self:Show("MinimapZoomOut")
	end
	if self.Get("timeFrame") then
		self:Show("GameTimeFrame")
	end
	if self.Get("toggleButton") then
		self:Show("MinimapToggleButton")
	end
	if self.Get("zoneText") then
		self:Show("MinimapZoneTextButton")
	end
	if self.Get("borderTop") then
		self:Show("MinimapBorderTop")
	end
	if self.Get("mailFrame") then
		self:Show("MiniMapMailFrame")
	end
	if self.Get("borderMain") then
		self:Alpha("MinimapBorder", 1)
	end
end

function MapScroll:Hide(f)
	f = getglobal(f)
	if f.VisorHide then
		f:VisorHide()
	else
		f:Hide()
	end
end

function MapScroll:Show(f)
	f = getglobal(f)
	if f.VisorShow then
		f:VisorShow()
	else
		f:Show()
	end
end

function MapScroll:Alpha(f, a)
	f = getglobal(f)
	if f.VisorSetAlpha then
		f:VisorSetAlpha(a)
	else
		f:SetAlpha(a)
	end
end

--<< ================================================= >>--
-- Section II: The Chat Options.                         --
--<< ================================================= >>--

function MapScroll:ToggleZoomButtons()
	local f = MapScrollLocals.Report_ZoomButtons
	self.Tog(
	 "zoomButtons",
	 format(MapScrollLocals.Chat_FrameHide, f),
	 format(MapScrollLocals.Chat_FrameShow, f)
	)
	self:HiderDisable() self:HiderEnable()
end

function MapScroll:ToggleTimeFrame()
	local f = MapScrollLocals.Report_TimeFrame
	self.Tog(
	 "timeFrame",
	 format(MapScrollLocals.Chat_FrameHide, f),
	 format(MapScrollLocals.Chat_FrameShow, f)
	)
	self:HiderDisable() self:HiderEnable()
end

function MapScroll:ToggleToggleButton()
	local f = MapScrollLocals.Report_ToggleButton
	self.Tog(
	 "toggleButton",
	 format(MapScrollLocals.Chat_FrameHide, f),
	 format(MapScrollLocals.Chat_FrameShow, f)
	)
	self:HiderDisable() self:HiderEnable()
end

function MapScroll:ToggleZoneText()
	local f = MapScrollLocals.Report_ZoneText
	self.Tog(
	 "zoneText",
	 format(MapScrollLocals.Chat_FrameHide, f),
	 format(MapScrollLocals.Chat_FrameShow, f)
	)
	self:HiderDisable() self:HiderEnable()
end

function MapScroll:ToggleBorderTop()
	local f = MapScrollLocals.Report_BorderTop
	self.Tog(
	 "borderTop",
	 format(MapScrollLocals.Chat_FrameHide, f),
	 format(MapScrollLocals.Chat_FrameShow, f)
	)
	self:HiderDisable() self:HiderEnable()
end

function MapScroll:ToggleMailFrame()
	local f = MapScrollLocals.Report_MailFrame
	self.Tog(
	 "mailFrame",
	 format(MapScrollLocals.Chat_FrameHide, f),
	 format(MapScrollLocals.Chat_FrameShow, f)
	)
	self:HiderDisable() self:HiderEnable()
end

function MapScroll:ToggleBorder()
	local f = MapScrollLocals.Report_Border
	self.Tog(
	 "borderMain",
	 format(MapScrollLocals.Chat_FrameHide, f),
	 format(MapScrollLocals.Chat_FrameShow, f)
	)
	self:HiderDisable() self:HiderEnable()
end

function MapScroll:Report()
	local zoom   = self.Get("zoomButtons")
	local time   = self.Get("timeFrame")
	local button = self.Get("toggleButton")
	local zone   = self.Get("zoneText")
	local bTop   = self.Get("borderTop")
	local mail   = self.Get("mailFrame")
	local border = self.Get("borderMain")
	self.cmd:report({
		{
			text = MapScrollLocals.Report_ZoomButtons,
			val  = zoom,
			map  = ACEG_MAP_ONOFF
		},
		{
			text = MapScrollLocals.Report_TimeFrame,
			val  = time,
			map  = ACEG_MAP_ONOFF
		},
		{
			text = MapScrollLocals.Report_ToggleButton,
			val  = button,
			map  = ACEG_MAP_ONOFF
		},
		{
			text = MapScrollLocals.Report_ZoneText,
			val  = zone,
			map  = ACEG_MAP_ONOFF
		},
		{
			text = MapScrollLocals.Report_BorderTop,
			val  = bTop,
			map  = ACEG_MAP_ONOFF
		},
		{
			text = MapScrollLocals.Report_MailFrame,
			val  = mail,
			map  = ACEG_MAP_ONOFF
		},
		{
			text = MapScrollLocals.Report_Border,
			val  = border,
			map  = ACEG_MAP_ONOFF
		}
	})
end

--<< ================================================= >>--
-- Section Omega: Register the AddOn Object.             --
--<< ================================================= >>--

MapScroll:RegisterForLoad()