MapScroll.Hider = TRUE

--<< ================================================= >>--
-- Section I: The Spoofed Enable/Disable Functions.      --
--<< ================================================= >>--

function MapScroll:HiderEnable()
	self:Hide("MinimapZoomIn")
	self:Hide("MinimapZoomOut")
	self:Hide("GameTimeFrame")
	self:Hide("MinimapToggleButton")
	self:Hide("MinimapZoneTextButton")
	self:Hide("MinimapBorderTop")
	self:Hide("MiniMapMailFrame")
end

function MapScroll:HiderDisable()
	self:Show("MinimapZoomIn")
	self:Show("MinimapZoomOut")
	self:Show("GameTimeFrame")
	self:Show("MinimapToggleButton")
	self:Show("MinimapZoneTextButton")
	self:Show("MinimapBorderTop")
	self:Show("MiniMapMailFrame")
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

--<< ================================================= >>--
-- Section Omega: Closure.                               --
--<< ================================================= >>--