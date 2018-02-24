-------------------------------------------------------------------------------------
--Config
-------------------------------------------------------------------------------------
local scale = 0.9
local relpoint = "BOTTOMRIGHT"
local point = "BOTTOMRIGHT"
local xpoint = -50
local ypoint = 200
local cursor = false
local playerTitles = true
local texture = "Interface\\AddOns\\rTextures\\statusbar" --Health Bar
local colorStatusBar = true
local backdrop = {
    bgFile = "Interface\\Buttons\\WHITE8x8",
    --bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    --edgeFile = "Interface\\AddOns\\FreebTip\\media\\border",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = {left = 3, right = 3, top = 3, bottom = 3},
}
local bdcR, bdcG, bdcB = .05, .05, .05  --Background color
local bdbcR, bdbcG, bdbcB = .3, .3, .3  --Border color
local gColorR, gColorG, gColorB = 255/255, 20/255, 200/255  --Guild Color
local TARGET = "|cfffed100"..TARGET..":|r "
local TARGETYOU = "<You>"
local worldBoss = "??"
local rareElite = "Rare+"
local rare = "Rare"
-------------------------------------------------------------------------------------
--End Config
-------------------------------------------------------------------------------------

local function GetHexColor(color)
  return ("|cff%.2x%.2x%.2x"):format(color.r * 255, color.g * 255, color.b * 255)
end

local ClassColors = {}
for class, color in pairs(RAID_CLASS_COLORS) do
  ClassColors[class] = GetHexColor(RAID_CLASS_COLORS[class])
end

local Reaction = {}
for i = 1, #rFACTION_BAR_COLORS do
  Reaction[i] = GetHexColor(rFACTION_BAR_COLORS[i])
end

local function getTargetLine(unit)
  if UnitIsUnit(unit, "player") then
    return ("|cffff00ff%s|r"):format(TARGETYOU)
  elseif UnitIsPlayer(unit, "player")then
    return ClassColors[select(2, UnitClass(unit, "player"))]..UnitName(unit).."|r"
  elseif UnitReaction(unit, "player") then
    return ("%s%s|r"):format(Reaction[UnitReaction(unit, "player")], UnitName(unit))
  else
    return ("|cffffffff%s|r"):format(UnitName(unit))
  end
end

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
local unit = select(2, self:GetUnit())
  if unit then
  local level = UnitLevel(unit)
  local color = GetQuestDifficultyColor(level)
  local textLevel = ("%s%d|r"):format(GetHexColor(color), level)
  local unitPvP = ""
  local pattern = "%s"
  if level == "??" or level == -1 then
    textLevel = "|cffff0000??|r"
  end
  
  if UnitIsPlayer(unit) then
      local unitRace = UnitRace(unit)
      local unitClass, engclass = UnitClass(unit)
      local r, g, b = rGameTooltip_UnitColor(unit)
      GameTooltipTextLeft1:SetTextColor(r,g,b)
      
      if UnitIsAFK(unit) then
        self:AppendText((" |cff00cc00%s|r"):format(CHAT_FLAG_AFK))
      elseif UnitIsDND(unit) then 
        self:AppendText((" |cff00cc00%s|r"):format(CHAT_FLAG_DND))
      end
      
      for i = 2, GameTooltip:NumLines() do
        if _G["GameTooltipTextLeft"..i]:GetText():find(LEVEL) then
          pattern = pattern.." %s %s %s"
          _G["GameTooltipTextLeft"..i]:SetText((pattern):format(unitPvP, textLevel, unitRace, unitClass):trim())
          break
        end
      end
      
      local unitGuild = GetGuildInfo(unit)
      local text = GameTooltipTextLeft2:GetText()
      if unitGuild and text and text:find("^"..unitGuild) then  
        GameTooltipTextLeft2:SetTextColor(gColorR, gColorG, gColorB)
      end
  else
      local text = GameTooltipTextLeft2:GetText()
      local reaction = UnitReaction(unit, "player")
      
      local r, g, b = rGameTooltip_UnitColor(unit)
      GameTooltipTextLeft1:SetTextColor(r,g,b)
      
      if reaction and text and not text:find(LEVEL) then
        GameTooltipTextLeft2:SetTextColor(rFACTION_BAR_COLORS[reaction].r, rFACTION_BAR_COLORS[reaction].g, rFACTION_BAR_COLORS[reaction].b)
      end
      if level ~= 0 then
        
          local class = UnitClassification(unit)
          if class == "worldboss" then
            textLevel = ("|cffff0000%s|r"):format(worldBoss)
          elseif class == "rareelite" then
            if level == -1 then
              textLevel = ("|cffff0000??+|r %s"):format(rareElite)
            else
              textLevel = ("%s%d+|r %s"):format(GetHexColor(color), level, rareElite)
            end
          elseif class == "elite" then
            if level == -1 then
              textLevel = "|cffff0000??+|r"
            else
              textLevel = ("%s%d+|r"):format(GetHexColor(color), level)
            end
          elseif class == "rare" then
            if level == -1 then
              textLevel = ("|cffff0000??|r %s"):format(rare)
            else
              textLevel = ("%s%d|r %s"):format(GetHexColor(color), level, rare)
            end
          end
        
        local creatureType = UnitCreatureType(unit)
        for i = 2, GameTooltip:NumLines() do
          if _G["GameTooltipTextLeft"..i]:GetText():find(LEVEL) then
            pattern = pattern.." %s %s"
            _G["GameTooltipTextLeft"..i]:SetText((pattern):format(unitPvP, textLevel, creatureType or ""):trim())
            break
          end
        end
      end
  end

    if UnitIsPVP(unit) then
      for i = 2, GameTooltip:NumLines() do
        if _G["GameTooltipTextLeft"..i]:GetText():find(PVP) then
          _G["GameTooltipTextLeft"..i]:SetText(nil)
          break
        end
      end
    end

    if (UnitExists(unit .. "target")) then
      local text = ("%s%s"):format(TARGET, getTargetLine(unit.."target"))
      GameTooltip:AddLine(text)  
    end
    
  	if colorStatusBar then
  		local r, g, b = rGameTooltip_UnitColor(unit)
  		GameTooltipStatusBar:SetStatusBarColor(r, g, b)
  	end    
  
    if (UnitIsDead(unit) or UnitIsGhost(unit)) then
      GameTooltipStatusBar:Hide()
    else
      self:AddLine(" ")
      GameTooltipStatusBar:Show()
      GameTooltipStatusBar:ClearAllPoints()
      GameTooltipStatusBar:SetPoint("LEFT", self:GetName().."TextLeft"..self:NumLines(), "LEFT", 0, -1)
      GameTooltipStatusBar:SetPoint("RIGHT", self, "RIGHT", -10, -1)
    end
  end
end)

GameTooltipStatusBar:SetScript("OnValueChanged", nil)

GameTooltipStatusBar:SetStatusBarTexture(texture)
local bg = GameTooltipStatusBar:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints(GameTooltipStatusBar)
bg:SetTexture(texture)
bg:SetVertexColor(0.5, 0.5, 0.5, 0.5)

local function ShortValue(value)
  if value >= 1e7 then
    return ('%.1fm'):format(value / 1e6):gsub('%.?0+([km])$', '%1')
  elseif value >= 1e6 then
    return ('%.2fm'):format(value / 1e6):gsub('%.?0+([km])$', '%1')
  elseif value >= 1e5 then
    return ('%.0fk'):format(value / 1e3)
  elseif value >= 1e3 then
    return ('%.1fk'):format(value / 1e3):gsub('%.?0+([km])$', '%1')
  else
    return value
  end
end

local Tooltips = {GameTooltip, ItemRefTooltip, ShoppingTooltip1, ShoppingTooltip2, ShoppingTooltip3}
for i, v in ipairs(Tooltips) do
  v:SetBackdrop(backdrop)
  v:SetScale(scale)
  v:SetScript("OnShow", function(self)
    self:SetBackdropColor(bdcR, bdcG, bdcB)
    local name, item = self:GetItem()
    if(item) then
      local quality = select(3, GetItemInfo(item))
      if(quality) then
        local r, g, b = GetItemQualityColor(quality)
        self:SetBackdropBorderColor(r, g, b)
      end
    else
      self:SetBackdropBorderColor(bdbcR, bdbcG, bdbcB)
    end
  end)
end

hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
  local frame = GetMouseFocus()
  if cursor and frame == WorldFrame then
    tooltip:SetOwner(parent, "ANCHOR_CURSOR")
  else
    tooltip:SetOwner(parent, "ANCHOR_NONE")  
    tooltip:SetPoint(point, UIParent, relpoint, xpoint, ypoint)
  end
  tooltip.default = 1
end)

if playerTitles then return end
GameTooltip:HookScript("OnTooltipSetUnit", function(self)
  local unitName, unit = self:GetUnit()
  if unit and UnitIsPlayer(unit) then
    local title = UnitPVPName(unit)
    if title then
      title = title:gsub(unitName, "")
      name = GameTooltipTextLeft1:GetText()
      name = name:gsub(title, "")
      if name then GameTooltipTextLeft1:SetText(name) end
    end
  end
end)
