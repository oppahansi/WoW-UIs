MapScroll.Hider = TRUE

--<< ================================================= >>--
-- Section I: The Spoofed Enable/Disable Functions.      --
--<< ================================================= >>--

function MapScroll:HiderInitialize() end

function MapScroll:HiderEnable()
	self:Hide("MinimapZoomIn")
	self:Hide("MinimapZoomOut")
	self:Hide("GameTimeFrame")
	self:Hide("MinimapToggleButton")
	self:Hide("MinimapZoneTextButton")
	self:Hide("MinimapBorderTop")
	self:Hide("MiniMapMailFrame")
	self:Alpha("MinimapBorder", 0)
end

function MapScroll:HiderDisable()
	self:Show("MinimapZoomIn")
	self:Show("MinimapZoomOut")
	self:Show("GameTimeFrame")
	self:Show("MinimapToggleButton")
	self:Show("MinimapZoneTextButton")
	self:Show("MinimapBorderTop")
	self:Show("MiniMapMailFrame")
	self:Alpha("MinimapBorder", 1)
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
-- Section Omega: Closure.                               --
--<< ================================================= >>--