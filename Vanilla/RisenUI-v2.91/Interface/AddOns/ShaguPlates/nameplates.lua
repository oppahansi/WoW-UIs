ShaguPlates = CreateFrame("Frame", "ShaguPlates", UIParent)
ShaguPlates:RegisterEvent("PLAYER_ENTERING_WORLD")
ShaguPlates:RegisterEvent("PLAYER_TARGET_CHANGED")
ShaguPlates:RegisterEvent("UNIT_AURA")

ShaguPlates_ClickThrough = false

--[[ ShaguUI
local font = "Interface\\AddOns\\ShaguUI\\fonts\\arial.ttf"
local img_norm = "Interface\\AddOns\\ShaguUI\\img\\normTex"
local img_glow = "Interface\\AddOns\\ShaguUI\\img\\glow"
]]--

local font = "Interface\\AddOns\\ShaguPlates\\fonts\\arial.ttf"
local img_norm = "Interface\\AddOns\\ShaguPlates\\img\\normTex"
local img_glow = "Interface\\AddOns\\ShaguPlates\\img\\glow"
  
function round(input, places)
  if not places then places = 0 end
  if type(input) == "number" and type(places) == "number" then
    local pow = 1
    for i = 1, places do pow = pow * 10 end
    return floor(input * pow + 0.5) / pow
  end
end
    
local currentDebuffs = {}
local Players = {}
local Mobs = {}
local Targets = {}

ShaguPlates:SetScript("OnEvent", function()
    if event == "PLAYER_ENTERING_WORLD" then
      ShowNameplates()
      HideFriendNameplates()
    end

    if event == "PLAYER_TARGET_CHANGED" or event == "UNIT_AURA" then
      local i = 1
      currentDebuffs = {}
      local debuff = UnitDebuff("target", i)
      while debuff do
        currentDebuffs[i] = debuff
        i = i + 1
        debuff = UnitDebuff("target", i)
      end
    end
  end)

ShaguPlates:SetScript("OnUpdate", function()
    local frames = { WorldFrame:GetChildren() }
    for _, namePlate in ipairs(frames) do
      if IsNamePlateFrame(namePlate) then
        local HealthBar = namePlate:GetChildren()
        local Border, Glow, Name, Level, LevelIcon , RaidTargetIcon = namePlate:GetRegions()

        local name = Name:GetText() --Set Name text and saves it in a list

        -- scan player (idle targeting)
        if Players[name] == nil and UnitName("target") == nil and Targets[name] == nil then
          if Targets[name] == nil then
            TargetByName(name, true)
            table.insert(Targets, name)
            Targets[name] = "ok"
            if UnitIsPlayer("target") then
              local _, class = UnitClass("target")
              table.insert(Players, name)
              Players[name] = {["class"] = class}
            elseif UnitClassification("target") ~= "normal" then
              local elite = UnitClassification("target")
              table.insert(Mobs, name)
              Mobs[name] = {["elite"] = elite}
            end
          end
          ClearTarget()
        end

        -- scan player (mouseover)
        if Players[name] == nil and UnitName("mouseover") == name and Targets[name] == nil then
          table.insert(Targets, name)
          Targets[name] = "ok"
          if UnitIsPlayer("mouseover") then
            local _, class = UnitClass("mouseover")
            table.insert(Players, name)
            Players[name] = {["class"] = class}
          elseif UnitClassification("mouseover") ~= "normal" then
            local elite = UnitClassification("mouseover")
            table.insert(Mobs, name)
            Mobs[name] = {["elite"] = elite}
          end
        end

        -- scan player (target)
        if Players[name] == nil and UnitName("target") == name and Targets[name] == nil then
          table.insert(Targets, name)
          Targets[name] = "ok"
          if UnitIsPlayer("target") then
            local _, class = UnitClass("target")
            table.insert(Players, name)
            Players[name] = {["class"] = class}
          elseif UnitClassification("target") ~= "normal" then
            local elite = UnitClassification("target")
            table.insert(Mobs, name)
            Mobs[name] = {["elite"] = elite}
          end
        end

        if ShaguPlates.CasterDB[name] ~= nil and ShaguPlates.CasterDB[name]["sp"] ~= nil then

          if HealthBar.castbar == nil then

            HealthBar.castbar = CreateFrame("StatusBar", nil, HealthBar)
            HealthBar.castbar:SetWidth(110)
            HealthBar.castbar:SetHeight(7)
            HealthBar.castbar:SetPoint("TOPLEFT", HealthBar, "BOTTOMLEFT", 0, -5)
            HealthBar.castbar:Hide()

            HealthBar.castbar:SetBackdrop({  bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
                                    insets = {left = -1, right = -1, top = -1, bottom = -1} }) 

            HealthBar.castbar:SetBackdropColor(0,0,0,1)
            HealthBar.castbar:SetStatusBarTexture(img_norm)
            HealthBar.castbar:SetStatusBarColor(.9,.8,0,1)
            
            if HealthBar.castbar.glow == nil then
              HealthBar.castbar.glow = CreateFrame("Frame", nil, HealthBar.castbar)
              HealthBar.castbar.glow:SetPoint("TOPLEFT", HealthBar.castbar, "TOPLEFT", -8, 8)
              HealthBar.castbar.glow:SetPoint("BOTTOMRIGHT", HealthBar.castbar, "BOTTOMRIGHT", 8, -8)
              HealthBar.castbar.glow:SetFrameLevel(HealthBar.castbar:GetFrameLevel())
              HealthBar.castbar.glow:SetBackdrop({ edgeFile = img_glow, edgeSize = 8,
                insets = {left = 0, right = 0, top = 0, bottom = 0} })
              HealthBar.castbar.glow:SetBackdropBorderColor(0,0,0,.5)
            end

            if HealthBar.castbar.text == nil then
              HealthBar.castbar.text = HealthBar.castbar:CreateFontString("Status", "DIALOG", "GameFontNormal")
              HealthBar.castbar.text:SetPoint("RIGHT", HealthBar.castbar, "LEFT")
              HealthBar.castbar.text:SetNonSpaceWrap(false)
              HealthBar.castbar.text:SetFontObject(GameFontWhite)
              HealthBar.castbar.text:SetTextColor(1,1,1,.5)
              HealthBar.castbar.text:SetFont(font, 10, "OUTLINE")
            end

            if HealthBar.castbar.icon == nil and ShaguPlates.CasterDB[name]["ic"] ~= nil then
              HealthBar.castbar.icon = HealthBar.castbar:CreateTexture(nil, "BORDER")
              HealthBar.castbar.icon:ClearAllPoints()
              HealthBar.castbar.icon:SetPoint("BOTTOMLEFT", HealthBar.castbar, "BOTTOMRIGHT", 5, 0)
              HealthBar.castbar.icon:SetWidth(18)
              HealthBar.castbar.icon:SetHeight(18)
            end

            if HealthBar.castbar.icon ~= nil and HealthBar.castbar.icon.glow == nil then
              HealthBar.castbar.icon.glow = CreateFrame("Frame", nil, HealthBar.castbar)
              HealthBar.castbar.icon.glow:SetPoint("TOPLEFT", HealthBar.castbar.icon, "TOPLEFT", -8, 8)
              HealthBar.castbar.icon.glow:SetPoint("BOTTOMRIGHT", HealthBar.castbar.icon, "BOTTOMRIGHT", 8, -8)
              HealthBar.castbar.icon.glow:SetFrameLevel(HealthBar.castbar:GetFrameLevel())
              HealthBar.castbar.icon.glow:SetBackdrop({ edgeFile = img_glow, edgeSize = 8,
                insets = {left = 0, right = 0, top = 0, bottom = 0} })
              HealthBar.castbar.icon.glow:SetBackdropBorderColor(0,0,0,.5)
            end
          end


          if ShaguPlates.CasterDB[name]["st"] + ShaguPlates.CasterDB[name]["ct"] <= GetTime() then
            ShaguPlates.CasterDB[name] = nil
            HealthBar.castbar:Hide()
          else
            HealthBar.castbar:SetMinMaxValues(0, ShaguPlates.CasterDB[name]["ct"])
            HealthBar.castbar:SetValue(GetTime() - ShaguPlates.CasterDB[name]["st"])
            HealthBar.castbar.text:SetText(round(ShaguPlates.CasterDB[name]["st"] + ShaguPlates.CasterDB[name]["ct"] - GetTime(),1))
            HealthBar.castbar:Show()

            if ShaguPlates.CasterDB[name] and ShaguPlates.CasterDB[name]["ic"] ~= nil then
              HealthBar.castbar.icon:SetTexture("Interface\\Icons\\" .. ShaguPlates.CasterDB[name]["ic"])
              HealthBar.castbar.icon:SetTexCoord(.1,.9,.1,.9)
            end
          end

        else
          if HealthBar.castbar then HealthBar.castbar:Hide() end
        end

        --Healthbar
        HealthBar:SetStatusBarTexture(img_norm)
        HealthBar:ClearAllPoints()
        HealthBar:SetPoint("CENTER", namePlate, "CENTER", 0, -10)
        HealthBar:SetWidth(110) --Edit this for width of the healthbar
        HealthBar:SetHeight(7) --Edit this for height of the healthbar

        if HealthBar.glow == nil then
          HealthBar.glow = CreateFrame("Frame", nil, HealthBar)
          HealthBar.glow:SetPoint("TOPLEFT", HealthBar, "TOPLEFT", -8, 8)
          HealthBar.glow:SetPoint("BOTTOMRIGHT", HealthBar, "BOTTOMRIGHT", 8, -8)
          HealthBar.glow:SetFrameLevel(HealthBar:GetFrameLevel())
          HealthBar.glow:SetBackdrop({ edgeFile = img_glow, edgeSize = 8,
              insets = {left = 0, right = 0, top = 0, bottom = 0} })
          HealthBar.glow:SetBackdropBorderColor(0,0,0,.5)
        end

        if HealthBar.bg == nil then
          HealthBar.bg = HealthBar:CreateTexture(nil, "BORDER")
          HealthBar.bg:SetTexture(0,0,0,0.90)
          HealthBar.bg:ClearAllPoints()
          HealthBar.bg:SetPoint("CENTER", namePlate, "CENTER", 0, -10)
          HealthBar.bg:SetWidth(HealthBar:GetWidth() + 3)
          HealthBar.bg:SetHeight(HealthBar:GetHeight() + 3)
        end

        --RaidTarget
        RaidTargetIcon:ClearAllPoints()
        RaidTargetIcon:SetWidth(15) --Edit this for width of the raidicon
        RaidTargetIcon:SetHeight(15) --Edit this for height of the raidicon
        RaidTargetIcon:SetPoint("CENTER", HealthBar, "CENTER", 0, -5) --Last two parameters are x,y coords for position relative to Healthbar
        if namePlate.debuffIcons == nil then
          namePlate.debuffIcons = {}
        end

        --DebuffIcons on TargetPlates
        for j=1,16,1 do
          if namePlate.debuffIcons[j] == nil and j<=8 then --first row
            namePlate.debuffIcons[j] = namePlate:CreateTexture(nil, "BORDER")
            namePlate.debuffIcons[j]:SetTexture(0,0,0,0)
            namePlate.debuffIcons[j]:ClearAllPoints()
            namePlate.debuffIcons[j]:SetPoint("BOTTOMLEFT", HealthBar, "BOTTOMLEFT", (j-1) * 12, -15) --Edit this for position of the debufficons, change 12 to the width of the icon in this case
            namePlate.debuffIcons[j]:SetWidth(12) --Edit this for width of the debufficons
            namePlate.debuffIcons[j]:SetHeight(12) --Edit this for height of the debufficons
          elseif namePlate.debuffIcons[j] == nil and j>8 then --second row
            namePlate.debuffIcons[j] = namePlate:CreateTexture(nil, "BORDER")
            namePlate.debuffIcons[j]:SetTexture(0,0,0,0)
            namePlate.debuffIcons[j]:ClearAllPoints()
            namePlate.debuffIcons[j]:SetPoint("BOTTOMLEFT", HealthBar, "BOTTOMLEFT", (j-9) * 12, -28) --as in first row
            namePlate.debuffIcons[j]:SetWidth(12)
            namePlate.debuffIcons[j]:SetHeight(12)
          end
        end

        if UnitExists("target") and HealthBar:GetAlpha() == 1 then --Sets the texture of debuffs to debufficons
          local j = 1
          local k = 1
          for j, e in ipairs(currentDebuffs) do
            namePlate.debuffIcons[j]:SetTexture(currentDebuffs[j])
            namePlate.debuffIcons[j]:SetTexCoord(.078, .92, .079, .937)
            namePlate.debuffIcons[j]:SetAlpha(0.9)
            k = k + 1
          end
          for j=k,16,1 do
            namePlate.debuffIcons[j]:SetTexture(nil)
          end
        else
          for j=1,16,1 do
            namePlate.debuffIcons[j]:SetTexture(nil)
          end
        end

        Border:Hide()
        Glow:Hide()

        Name:SetFontObject(GameFontNormal)
        Name:SetFont(font,12,"OUTLINE")
        Name:SetPoint("BOTTOM", HealthBar, "CENTER", 0, 7)

        Level:SetFontObject(GameFontNormal)
        Level:SetFont(font,12, "OUTLINE") --
        Level:SetPoint("RIGHT", HealthBar, "LEFT", -1, 0)
        LevelIcon:SetPoint("RIGHT", HealthBar, "LEFT", -1, 0)

        HealthBar:Show()
        Name:Show()

        local red, green, blue, _ = Name:GetTextColor() --Set Color of Namelabel
        -- Print(red.." "..green.." "..blue)
        if red > 0.99 and green == 0 and blue == 0 then
          Name:SetTextColor(1,0.4,0.2,0.85)
        elseif red > 0.99 and green > 0.81 and green < 0.82 and blue == 0 then
          Name:SetTextColor(1,1,1,0.85)
        end

        -- if you're having float problems, I feel bad for you, son. I got 99 problems
        -- but a float ain't 1.00000000000000022204
        local red, green, blue, _ = Name:GetTextColor()
        if red > 0.9 and green > 0.3 and green < 0.4 and blue > 0.1 and blue < 0.2 then
          HealthBar.glow:SetBackdropBorderColor(1,0,0,.5)
        else
          HealthBar.glow:SetBackdropBorderColor(0,0,0,.5)
        end

        local red, green, blue, _ = Level:GetTextColor() --Set Color of Level
        if red > 0.99 and green == 0 and blue == 0 then
          Level:SetTextColor(1,0.4,0.2,0.85)
        elseif red > 0.99 and green > 0.81 and green < 0.82 and blue == 0 then
          Level:SetTextColor(1,1,1,0.85)
        end

        local red, green, blue, _ = HealthBar:GetStatusBarColor() --Set Color of Healthbar

        if Level:GetText() ~= nil then
          if Mobs[name] and Mobs[name]["elite"] == "elite" and not string.find(Level:GetText(), "+") then
            Level:SetText(Level:GetText() .. "+")
          elseif Mobs[name] and Mobs[name]["elite"] == "rareelite" and not string.find(Level:GetText(), "R+") then
            Level:SetText(Level:GetText() .. "R+")
          elseif Mobs[name] and Mobs[name]["elite"] == "rare" and not string.find(Level:GetText(), "R") then
            Level:SetText(Level:GetText() .. "R")
          end
        end

        if Players[name] and Players[name]["class"] then
          HealthBar:SetStatusBarColor(
            RAID_CLASS_COLORS[Players[name]["class"]].r,
            RAID_CLASS_COLORS[Players[name]["class"]].g,
            RAID_CLASS_COLORS[Players[name]["class"]].b,
            0.9)
        elseif red > 0.9 and green < 0.2 and blue < 0.2 then
          HealthBar:SetStatusBarColor(.9,.2,.3,0.8)
        elseif red > 0.9 and green > 0.9 and blue < 0.2 then
          HealthBar:SetStatusBarColor(1,1,.3,0.8)
        elseif blue > 0.9 and red == 0 and green == 0 then
          HealthBar:SetStatusBarColor(0.2,0.6,1,0.8)
        elseif red == 0 and green > 0.99 and blue == 0 then
          HealthBar:SetStatusBarColor(0.6,1,0,0.8)
        end

        if ShaguPlates_ClickThrough then
          namePlate:EnableMouse(false)
        else
          namePlate:EnableMouse(true)
        end
      end

    end

  end)

function IsNamePlateFrame(frame)
  local overlayRegion = frame:GetRegions()
  if not overlayRegion or overlayRegion:GetObjectType() ~= "Texture" or overlayRegion:GetTexture() ~= "Interface\\Tooltips\\Nameplate-Border" then
    return false
  end
  return true
end
