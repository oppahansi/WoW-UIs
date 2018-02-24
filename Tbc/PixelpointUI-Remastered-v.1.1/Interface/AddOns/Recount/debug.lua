
if false then

function Recount:DPrint(str)
end

--Recount.DPrint = function() end

else

Recount.Debug = true

function Recount:GetDebugFrame()
	for i=1,NUM_CHAT_WINDOWS do
		local windowName = GetChatWindowInfo(i);
		if windowName == "Debug" then
			return getglobal("ChatFrame" .. i)
		end
	end
end

function Recount:DPrint(str)
	local debugframe = Recount:GetDebugFrame()

	if debugframe then
		Recount:Print(debugframe, str)
	end
end

end
