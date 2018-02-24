--[[
  OmniCC Basic
    A featureless, pure version of OmniCC.
    This version should work on absolutely everything, but Ive removed pretty much all of the options
--]]

--hide cooldown spiral true/false
local hide_cooldown_spiral = false

local TEXT_FONT = STANDARD_TEXT_FONT --what font to use
local FONT_SIZE = 24 --the base font size to use at a scale of 1
local MIN_SCALE = 0.5 --the minimum scale we want to show cooldown counts at, anything below this will be hidden
local MIN_DURATION = 3 --the minimum duration to show cooldown text for
--color for other cooldowns
local R, G, B = 1, 0.8, 0
--color for actionbuttons
local R2, G2, B2 = 0.8, 0.75, 0.75
--omg speed
local format = string.format
local floor = math.floor
local min = math.min

local function GetFormattedTime(s)
  if s >= 86400 then
    return format("%dd", floor(s/86400 + 0.5)), s % 86400
  elseif s >= 3600 then
    return format("%dh", floor(s/3600 + 0.5)), s % 3600
  elseif s >= 60 then
    return format("%dm", floor(s/60 + 0.5)), s % 60
  end
  return format("%d", floor(s + 0.5)), s - floor(s)
end

local function Timer_OnUpdate(self, elapsed)
  if self.text:IsShown() then
    if self.nextUpdate > 0 then
      self.nextUpdate = self.nextUpdate - elapsed
    else
      if (self:GetEffectiveScale()/UIParent:GetEffectiveScale()) < MIN_SCALE then
        self.text:SetText("")
        self.nextUpdate = 1
      else
        local remain = self.duration - (GetTime() - self.start)
        if floor(remain + 0.5) > 0 then
          local time, nextUpdate = GetFormattedTime(remain)
          self.text:SetText(time)
          self.nextUpdate = nextUpdate
        else
          self.text:Hide()
        end
      end
    end
  end
end

local function Timer_Create(self)
  local scale = min(self:GetParent():GetWidth() / 40, 1)
  if scale < MIN_SCALE then
    self.noOCC = true
  else
    local text = self:CreateFontString(nil, "OVERLAY")
    text:SetFont(TEXT_FONT, FONT_SIZE * scale, "OUTLINE")
    
    local parent = self:GetParent()
    if parent.action then
      --position the timer if the button is of type actionbutton
      text:SetPoint("CENTER", 0, 1)
      --use different color
      text:SetTextColor(R2, G2, B2)
    else
      --other cooldowns
      text:SetPoint("BOTTOM", 0, -2)
      text:SetTextColor(R, G, B)
    end
    
    if hide_cooldown_spiral and not parent.action then
      --make the spiral unvisible
      text:SetParent(parent)  
      self:HookScript("OnHide", function() text:Hide() end)
      self:HookScript("OnShow", function() text:Show() end)  
      self:SetAlpha(0)
    end
    
    self.text = text
    self:SetScript("OnUpdate", Timer_OnUpdate)
    return text
  end
end

local function Timer_Start(self, start, duration)
  self.start = start
  self.duration = duration
  self.nextUpdate = 0

  local text = self.text or (not self.noOCC and Timer_Create(self))
  if text then
    text:Show()
  end
end

local methods = getmetatable(ActionButton1Cooldown).__index
hooksecurefunc(methods, "SetCooldown", function(self, start, duration)
  if start > 0 and duration > MIN_DURATION then
    Timer_Start(self, start, duration)
  else
    local text = self.text
    if text then
      text:Hide()
    end
  end
end)