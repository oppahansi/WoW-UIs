--
-- Mail icon replacement
--

SWMail = {
	name = "Mail",
	events = { "UPDATE_PENDING_MAIL" },
  
  Init = function(self)
    MiniMapMailFrame:UnregisterAllEvents()
    MiniMapMailFrame:Hide()
  end,

  SetupPane = function(self, frame)
    frame.pane:SetHeight(frame._var.height)
    frame.pane:SetWidth(frame._var.width)
    frame.pane.text:SetWidth(0)
    frame.pane.text:Hide()
    frame.pane.icon:ClearAllPoints()
    frame.pane.icon:SetPoint("LEFT", frame.pane, "LEFT", frame._var.padding, 0)
    frame.pane.icon:Show()
  end,
  
  Update = function(self, event)
    if HasNewMail() then
      self.pane.icon:SetTexture("Interface\\AddOns\\SWMail\\mail")
    else
      self.pane.icon:SetTexture("Interface\\AddOns\\SWMail\\nomail")
    end
  end,
  
  OnEnter = function(self)
    GameTooltip_SetDefaultAnchor(GameTooltip, this)
		if HasNewMail()then
      MinimapMailFrameUpdate()
    else
      GameTooltip:SetText(_strings.NOMAIL);
    end
  end,
}
StatusWindow:RegisterModule(SWMail)

_strings = {}
_strings.NOMAIL = "No mail"