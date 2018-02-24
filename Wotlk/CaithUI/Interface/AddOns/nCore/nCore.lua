
local f = CreateFrame('Frame')
f:RegisterEvent('PLAYER_LOGIN')
f:RegisterEvent('CHAT_MSG_WHISPER')
f:SetScript('OnEvent', function(_, event, ...)
    if (event == 'PLAYER_LOGIN') then
        SetCVar('ScreenshotQuality', 10)
    end
    
    if (event == 'CHAT_MSG_WHISPER') then 
        if (arg1 == 'raid' or arg1 == 'RAID' or arg1 == 'Raid' or arg1 == 'invite' or arg1 == 'inv') then
--            SendChatMessage('Autoinvite inc', 'WHISPER', nil, arg2)
--            InviteUnit(arg2)
        end
    end
end)

SlashCmdList['FRAMENAME'] = function()
    DEFAULT_CHAT_FRAME:AddMessage('|cff00FF00   '..GetMouseFocus():GetName())
end

SLASH_FRAMENAME1 = '/frame'

SlashCmdList['RELOADUI'] = function()
    ReloadUI()
end

SLASH_RELOADUI1 = '/rl'