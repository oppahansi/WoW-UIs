-------------------------------------------------------------------------------
-- Title: Mik's Scrolling Battle Text Profiles
-- Author: Mikord
--
-- Quick and dirty hack to work around SPELL_AURA_APPLIED combat log event bug
-- in Patch 3.3.  I really don't like doing things this way, but this will make
-- triggers work until Blizzard fixes the SPELL_AURA_APPLIED event.
-------------------------------------------------------------------------------

-- Create module and set its name.
local module = {}
local moduleName = "AuraHack"
MikSBT[moduleName] = module


-------------------------------------------------------------------------------
-- Imports.
-------------------------------------------------------------------------------

-- Local references to various modules for faster access.
local MSBTTriggers = MikSBT.Triggers

-- Local references to various functions for faster access.
local GetSkillName = MikSBT.GetSkillName


-------------------------------------------------------------------------------
-- Private constants.
-------------------------------------------------------------------------------

-- Define auras that aren't being reported to the combat log properly.
local MISSING_AURAS = {
 [GetSkillName(46916)] = true, -- Bloodsurge (Slam!)
 [GetSkillName(57761)] = true, -- Brain Freeze (Fireball!)
 [GetSkillName(48516)] = true, -- Eclipse
 [GetSkillName(44445)] = true, -- Hot Streak
 [GetSkillName(11103)] = true, -- Impact
 [GetSkillName(56342)] = true, -- Lock and Load
 [GetSkillName(44404)] = true, -- Missile Barrage
 [GetSkillName(17941)] = true, -- Nightfall (Shadow Trance)
 [GetSkillName(46953)] = true, -- Sword and Board
} 

-- Commonly used flag combinations.
local FLAGS_ME = 0x511


-------------------------------------------------------------------------------
-- Private variables.
-------------------------------------------------------------------------------

-- Dynamically created frame for receiving events.
local eventFrame

-- Holds the player's name and GUID.
local playerName, playerGUID

-- Hold information to detect when auras are applied.
local activeAuras = {}


-------------------------------------------------------------------------------
-- Aura Scanning Functions.
-------------------------------------------------------------------------------

-- ****************************************************************************
-- Manually scans for auras that are missing from the SPELL_AURA_APPLIED
-- combat log event and fakes a combat log event for triggers to parse.
-- ****************************************************************************
local function ScanAuras()
 -- Remove the entries for inactive auras.
 for auraName in pairs(activeAuras) do
  local name = UnitAura("player", auraName)
  if (not name) then activeAuras[auraName] = nil end
 end

 -- Manually scan for auras that are missing from the combat log.
 for auraName in pairs(MISSING_AURAS) do
  local name, _, _, amount, _, _, _, _, _, _, skillID = UnitAura("player", auraName)

  -- Fake a combat log event when the has been applied.
  if (name) then
   if (not activeAuras[name]) then
    activeAuras[name] = true

    -- Fake a combat log event.
    if amount <= 1 then amount = nil end
    local event = amount and "SPELL_AURA_APPLIED_DOSE" or "SPELL_AURA_APPLIED"
    MSBTTriggers.HandleCombatLogTriggers(now, event, playerGUID, playerName, FLAGS_ME, playerGUID, playerName, FLAGS_ME, skillID, name, nil, "BUFF", amount)
   end
  end -- Aura is active on player
 end -- Loop through search auras
end


-------------------------------------------------------------------------------
-- Event handlers.
-------------------------------------------------------------------------------

-- ****************************************************************************
-- Called when the registered events occur.
-- ****************************************************************************
local function OnEvent(self, event, arg1)
 if (event == "UNIT_AURA" and arg1 == "player") then
  if (not playerGUID) then playerGUID = UnitGUID("player") end
  ScanAuras()
 end
end


-------------------------------------------------------------------------------
-- Initialization.
-------------------------------------------------------------------------------

-- Create a frame to receive events.
eventFrame = CreateFrame("Frame")
eventFrame:Hide()
eventFrame:SetScript("OnEvent", OnEvent)

-- Get the name, GUID, and class of the player.
playerName = UnitName("player")
playerGUID = UnitGUID("player")

-- Register for aura changes.
eventFrame:RegisterEvent("UNIT_AURA")