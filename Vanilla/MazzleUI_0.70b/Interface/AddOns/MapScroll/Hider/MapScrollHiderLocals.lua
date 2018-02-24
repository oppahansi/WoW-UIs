if not ace:LoadTranslation("MapScroll") then

--<< ================================================= >>--
-- Section I: The Chat Options.                          --
--<< ================================================= >>--

MapScrollLocals.ChatOpt = {
	{
		option            = "zoom",
		desc              = "display/hide the zoom buttons (toggle).",
		method            = "ToggleZoomButtons"
	},
	{
		option            = "time",
		desc              = "display/hide the time frame (toggle).",
		method            = "ToggleTimeFrame"
	},
	{
		option            = "button",
		desc              = "display/hide the toggle button (toggle).",
		method            = "ToggleToggleButton"
	},
	{
		option            = "zone",
		desc              = "display/hide the zone text (toggle).",
		method            = "ToggleZoneText"
	},
	{
		option            = "border",
		desc              = "display/hide the top border (toggle).",
		method            = "ToggleBorderTop"
	},
	{
		option            = "mail",
		desc              = "display/hide the mail frame (toggle).",
		method            = "ToggleMailFrame"
	}
}

--<< ================================================= >>--
-- Section I: The Chat Variables.                        --
--<< ================================================= >>--

MapScrollLocals.Chat_FrameHide      = "The %s will be hidden from now on."
MapScrollLocals.Chat_FrameShow      = "The %s will be shown from now on."
MapScrollLocals.Report_ZoomButtons  = "Zoom Buttons"
MapScrollLocals.Report_TimeFrame    = "Time Frame"
MapScrollLocals.Report_ToggleButton = "Toggle Button"
MapScrollLocals.Report_ZoneText     = "Zone Text"
MapScrollLocals.Report_BorderTop    = "Top Border"
MapScrollLocals.Report_MailFrame    = "Mail Frame"
MapScrollLocals.Report_Border       = "Border"

--<< ================================================= >>--
-- Section Omega: Closure.                               --
--<< ================================================= >>--

end