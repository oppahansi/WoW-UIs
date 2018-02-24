local mod = Chatter:NewModule("Auto Popup", "AceHook-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Chatter")
mod.modName = L["Automatic Whisper Windows"]

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_WHISPER","ProcessWhisper")
	self:RegisterEvent("CHAT_MSG_WHISPER_INFORM","ProcessWhisper")
end

function mod:OnDisable()
	self:UnregisterEvent("CHAT_MSG_WHISPER")
	self:UnregisterEvent("CHAT_MSG_WHISPER_INFORM")
end

function mod:ProcessWhisper(event,message,sender,language,channelString,target,flags,...)
	-- Do we have a temp window already for this target
	if FCFManager_GetNumDedicatedFrames("WHISPER", sender) == 0 then
		FCF_OpenTemporaryWindow("WHISPER",sender)
	end
end