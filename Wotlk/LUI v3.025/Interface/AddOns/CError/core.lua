local event = CreateFrame"Frame"
local dummy = function() end

-- Edit this area here to put error messages back only if you know what you're doing



UIErrorsFrame:UnregisterEvent"UI_ERROR_MESSAGE"
event.UI_ERROR_MESSAGE = function(self, event, error)
	if(not stuff[error]) then
		UIErrorsFrame:AddMessage(error, 1, .1, .1)
	end
end
	
event:RegisterEvent"UI_ERROR_MESSAGE"