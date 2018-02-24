
clearBlizzardConfig = {
	["PlayerFrame"] = true,
	["TargetFrame"] = true,
	["PartyMemberFrame1"] = true,
	["PartyMemberFrame1PetFrame"] = true,
	["PartyMemberFrame2"] = true,
	["PartyMemberFrame2PetFrame"] = true,
	["PartyMemberFrame3"] = true,
	["PartyMemberFrame3PetFrame"] = true,
	["PartyMemberFrame4"] = true,
	["PartyMemberFrame4PetFrame"] = true,
}

local clearBlizzardHandlers = {}

local function clearBlizzardOnEventHandler()
end

local function clearBlizzardOnShowHandler()
	this:Hide()
end

local function clearBlizzardFrameDisable(frameObject)
	local frameName = frameObject:GetName()
	if (clearBlizzardHandlers[frameName]) then
		return
	end
	
	clearBlizzardHandlers[frameName] = {}
	clearBlizzardHandlers[frameName].onEvent = frameObject:GetScript("OnEvent")
	clearBlizzardHandlers[frameName].onShow = frameObject:GetScript("OnShow")
	
	frameObject:SetScript("OnEvent", clearBlizzardOnEventHandler)
	frameObject:SetScript("OnShow", clearBlizzardOnShowHandler)
	
	frameObject:Hide()
	
	clearBlizzardConfig[frameName] = true
end

local function clearBlizzardFrameEnable(frameObject)
	local frameName = frameObject:GetName()
	if (clearBlizzardHandlers[frameName] == nil) then
		DEFAULT_CHAT_FRAME:AddMessage("clearBlizzard: no handlers for frame '"..frameName.."'")
		return
	end
	
	frameObject:SetScript("OnEvent", clearBlizzardHandlers[frameName].onEvent)
	frameObject:SetScript("OnShow", clearBlizzardHandlers[frameName].onShow)
	
	DEFAULT_CHAT_FRAME:AddMessage("clearBlizzard: clearing config for frame '"..frameName.."'")
	clearBlizzardHandlers[frameName] = nil
	clearBlizzardConfig[frameName] = nil
end

function clearBlizzardOnLoad()
	this:RegisterEvent("VARIABLES_LOADED")
end

function clearBlizzardOnEvent(event)
	for frameName, _ in clearBlizzardConfig do
		local frameObject = getglobal(frameName)
		clearBlizzardFrameDisable(frameObject)
	end
end

SLASH_CLEAR_BLIZZARD1 = "/clearBlizzard"
SlashCmdList["CLEAR_BLIZZARD"] = function(msg)
	local _, _, frameName, cmd = string.find(msg, "([%a%d]+) ([%a]+)")
	
	if (frameName == nil) then
		DEFAULT_CHAT_FRAME:AddMessage("clearBlizzard: syntax: /clearBlizzard [frameName] [disable/enable]")
		return
	end
	
	local frameObject = getglobal(frameName)
	if (frameObject == nil) then
		DEFAULT_CHAT_FRAME:AddMessage("clearBlizzard: frame '"..frameName.."' doesn't exist")
		return
	end
	
	if (cmd == "disable") then
		DEFAULT_CHAT_FRAME:AddMessage("clearBlizzard: disabling: '"..frameName.."'")
		clearBlizzardFrameDisable(frameObject)
	elseif (cmd == "enable") then
		DEFAULT_CHAT_FRAME:AddMessage("clearBlizzard: enabling: '"..frameName.."'")
		clearBlizzardFrameEnable(frameObject)
	else
		DEFAULT_CHAT_FRAME:AddMessage("clearBlizzard: unknown command: '"..cmd.."'")
	end
end
