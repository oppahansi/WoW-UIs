--<< ================================================= >>--
-- Section I: Initialize the AddOn Object.               --
--<< ================================================= >>--

MapScroll        = AceAddonClass:new({
	name          = MapScrollLocals.Title,
	version       = MapScrollLocals.Version,
	description   = MapScrollLocals.Desc,
	author        = "Rowne",
	authorEmail   = "wuffxiii@gmail.com",
	aceCompatible = "100",
	category      = ACE_CATEGORY_MAP,
	db            = AceDbClass:new("MapScrollDB"),
	cmd           = AceChatCmdClass:new(MapScrollLocals.ChatCmd, (MapScrollLocals.ChatOpt or {}))
})

function MapScroll:Initialize()
	if self.Hider then self:HiderInitialize() end
end

function MapScroll:Enable()
	if self.Hider then self:HiderEnable() return end
	MinimapZoomIn:Hide()
	MinimapZoomOut:Hide()
end

function MapScroll:Disable()
	if self.Hider then self:HiderDisable() return end
	MinimapZoomIn:Show()
	MinimapZoomOut:Show()
end

--<< ================================================= >>--
-- Section II: The Minimap Scroller Functions.           --
--<< ================================================= >>--

function MapScroll:ZoomIn()
	if Minimap:GetZoom() == 5 then return end
	Minimap:SetZoom(Minimap:GetZoom() + 1)
end

function MapScroll:ZoomOut()
	if Minimap:GetZoom() == 0 then return end
	Minimap:SetZoom(Minimap:GetZoom() - 1)
end

function MapScroll:Wheel(s)
	if s > 0 then self:ZoomIn() return end
	self:ZoomOut()
end

--<< ================================================= >>--
-- Section Omega: Register the AddOn Object.             --
--<< ================================================= >>--

MapScroll:RegisterForLoad()