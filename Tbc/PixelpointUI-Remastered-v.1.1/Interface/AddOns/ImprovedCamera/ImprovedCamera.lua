
do
	for i, control in pairs(InterfaceOptionsCameraPanel.controls) do
		if control.event == "MAX_FOLLOW_DIST" then
			control:SetMinMaxValues(1.0, 3.4)
			control:SetValue(GetCVar("cameraDistanceMaxFactor"))

			control.tooltipText = OPTION_TOOLTIP_MAX_FOLLOW_DIST
				.."\n|cff00CC33Improved Max Camera Distance limit from 30 to 50"
			
			break
		end
	end
end
