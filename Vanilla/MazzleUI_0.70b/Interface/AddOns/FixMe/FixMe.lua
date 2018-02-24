--[[ 
-- FixMe!
-- By: Thrae
-- Contributors: ckknight
--
-- $ Revision $
--
-- This addon fixes various problems with the
-- current interface without adding enough 
-- overhead to make it prohibitive.
-- It will disable itself with each new
-- WoW interface version until an update is
-- made.
--]]

local _G = getfenv(0)

local expected = "1.12.1"
local expected_nonUS = "1.12.2"
local version = _G.GetBuildInfo()

if version ~= expected_nonUS and version ~= expected then
	DisableAddOn("FixMe")
	error("|cff00ff33FixMe is out of date.  It will be disabled on next reload.  Please download an updated version.")
	return
end
expected,expected_nonUS,version = nil,nil,nil

local GameTooltip = _G.GameTooltip
local EventFrame

--------------------------------------------------------
-- Localization
--[[
if locale == "deDE" then
	AlteracValley = "Alteractal"
	ArathiBasin 	= "Arathibecken"
	WarsongGulch	= "Warsongschlucht"
elseif locale == "frFR" then
	AlteracValley = "Vall\195\169e d'Alterac"
	ArathiBasin		= "Bassin d'Arathi"
	WarsongGulch	= "Goulet des Warsong"
elseif locale == "zhCH" then
	AlteracValley = "\229\165\165\231\137\185\229\133\176\229\133\139\229\177\177\232\176\183"
	ArathiBasin		= "\233\152\191\230\139\137\229\184\140\231\155\134\229\156\176"
	WarsongGulch	= "\230\136\152\230\173\140\229\179\161\232\176\183"
elseif locale == "koKR" then
	AlteracValley = "알터랙 계곡"
	ArathiBasin		= "아라시 분지"
	WarsongGulch	= "전쟁노래 협곡"
else
	AlteracValley = "Alterac Valley"
	ArathiBasin		= "Arathi Basin"
	WarsongGulch	= "Warsong Gulch"
end
locale = nil
--]]

-------------------------------------------------
-- ContainerFrameItemButton and GameTooltip

local Old_ContainerFrameItemButton_OnEnter, currentBtn
local function CFIB_OnEnter(button,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10)
	if not button then button = this end
	if currentBtn ~= button then currentBtn = button end
	currentBtn._hasCooldown = GameTooltip:SetBagItem(button:GetParent():GetID(),button:GetID())
    if Old_ContainerFrameItemButton_OnEnter then
        Old_ContainerFrameItemButton_OnEnter(button,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10)
    end
end

local Old_ContainerFrameItemButton_OnUpdate
local CFIB_elapsed = 0
local function CFIB_OnUpdate()
    if this ~= currentBtn or not currentBtn or not currentBtn._hasCooldown then return end
	CFIB_elapsed = CFIB_elapsed + _G.arg1
	if CFIB_elapsed >= 1  then
		CFIB_elapsed = 0
		CFIB_OnEnter(currentBtn)
	end
end

local Old_GameTooltip_OnHide
local function GameTooltip_OnHide(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10)
    CFIB_elapsed = 0
    if Old_GameTooltip_OnHide then
        Old_GameTooltip_OnHide(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10)
	end
end

---------------------------------------------------
-- Initialization

local function OnEvent()
	if _G.event == "ADDON_LOADED" and arg1 == "FixMe" then
        -- This is StopTheLagness's hooking of the ContainerFrame and GameTooltip.
        -- It tries the reduce the amount of memory tooltips take up.
        if not Old_ContainerFrameItemButton_OnEnter then
            Old_ContainerFrameItemButton_OnEnter = _G.ContainerFrameItemButton_OnEnter
            _G.ContainerFrameItemButton_OnEnter = CFIB_OnEnter
        end
        if not Old_ContainerFrameItemButton_OnUpdate then
            Old_ContainerFrameItemButton_OnUpdate = _G.ContainerFrameItemButton_OnUpdate 
            _G.ContainerFrameItemButton_OnUpdate = CFIB_OnUpdate
        end
        if not Old_GameTooltip_OnHide then
            Old_GameTooltip_OnHide = GameTooltip:GetScript("OnHide")
            GameTooltip:SetScript("OnHide", GameTooltip_OnHide)
        end
        EventFrame:RegisterEvent("PLAYER_LOGIN")
    elseif _G.event == "PLAYER_LOGIN" then
        -- dirty way of making sure we have ANY ChatFrames shown
        local chatframe
        for i = 1,7 do
            chatframe = _G[ "ChatFrame" .. i] 
            if chatframe and chatframe:IsShown() then
                _G.ChatFrame1Tab:Click()
                break
            end
        end
	end
end

EventFrame = _G.CreateFrame("Frame", nil, _G.UIParent)
EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:SetScript( "OnEvent", OnEvent)
