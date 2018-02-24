
  -- This mod is made by evl
  -- http://wow.curseforge.com/projects/evl/
  -- heavy modifications by roth for Roth UI but the base is evl_NamePlates

  ------------------------------------
  --NEW OPTIONS
  ------------------------------------
  
  --switch red to grey 0/1
  local usered = 0
  local targethealthtab = { r=0.75,g=0,b=0,a=1 }

  
  ------------------------------------
  --TEXTURES / FONTS
  ------------------------------------
  
  local texture = "Interface\\Addons\\rTextures\\statusbar256"
  local bordertexture = "Interface\\Addons\\rTextures\\d3_nameplate_border"
  local bordertexture2 = "Interface\\Addons\\rTextures\\d3_nameplate_border_glow"
  local d3font = "FONTS\\FRIZQT__.ttf"


  ------------------------------------
  --FUNCTIONS
  ------------------------------------

  --chat output func
  local function am(text)
    DEFAULT_CHAT_FRAME:AddMessage(text)
  end

  local evl_NamePlates = CreateFrame("Frame", nil, UIParent)

  --nameplate func
  local function IsNamePlateFrame(frame)
    if frame:GetName() then
      return false
    end
    
    --local overlayRegion = frame:GetRegions()
    local overlayRegion = select(2,frame:GetRegions())
    if not overlayRegion or overlayRegion:GetObjectType() ~= "Texture" or overlayRegion:GetTexture() ~= "Interface\\Tooltips\\Nameplate-Border" then
      return false
    end
    
    return true
  end

  --init func
  function evl_NamePlates:new()
    self:SetScript("OnUpdate", self.onUpdate)
  end
  
  
  --onupdate func
  local lastUpdate = 0
  local frame
  function evl_NamePlates:onUpdate(elapsed)
    lastUpdate = lastUpdate + elapsed
    
    if lastUpdate > 1 then
      lastUpdate = 0
  
      for i = 1, select("#", WorldFrame:GetChildren()) do
        frame = select(i, WorldFrame:GetChildren())
      
        if not frame.background and IsNamePlateFrame(frame) then 
          self:setupNamePlate(frame)
        end
      end  
    end
  end

  --do format func
  local function do_format(v)
    local string = ""
    if v > 1000000 then
      string = (floor((v/1000000)*10)/10).."m"
    elseif v > 1000 then
      string = (floor((v/1000)*10)/10).."k"
    else
      string = v
    end  
    return string
  end

  --checkhp func
  local function checkhp(self,value)
    if self then
      self.LowHP:SetAlpha(0)
      if usered == 0 then
        self.fakeHP:SetAlpha(0)
      end
    end
    if self and value then
      local min, max = self:GetMinMaxValues()
      if min and max then
        local p = floor(value/max*100)
        local str = do_format(value).." / "..p.."%"
        --am(str)
        if p < 100 then
          local w = self.barwidth
          if usered == 0 then
            self.fakeHP:SetWidth(w-(w*p/100))
            self.fakeHP:SetAlpha(1)
          end
          self.hpval:SetText(str)
          if p <= 25 then
            self.LowHP:SetAlpha(1)
          end
        else
          self.hpval:SetText("")
        end
      end
    end
  end
  
  --fontstring func
  local function SetFontString(parent, fontName, fontHeight, fontStyle)
    local fs = parent:CreateFontString(nil, "OVERLAY")
    fs:SetFont(fontName, fontHeight, fontStyle)
    fs:SetShadowColor(0,0,0,1)
    return fs
  end

  --setup func
  function evl_NamePlates:setupNamePlate(frame)
    local healthBar, castBar = frame:GetChildren()
    local threatRegion, overlayRegion, _, _, _, highlightRegion, nameTextRegion, levelTextRegion, bossIconRegion, raidIconRegion, dragon = frame:GetRegions()
    
    if dragon then
      dragon:SetAlpha(0)
    end
    
    overlayRegion:SetTexture("")
    overlayRegion:SetAlpha(0)
    
    threatRegion:SetTexture(bordertexture2)
    threatRegion:ClearAllPoints()
    threatRegion:SetTexCoord(0,1,0,1)
    threatRegion:SetPoint("TOPLEFT",healthBar,"TOPLEFT",-20,13)
    threatRegion:SetPoint("BOTTOMRIGHT",healthBar,"BOTTOMRIGHT",17,-14)
    
    -- Icons we don't need
    bossIconRegion:Hide()
    
    -- Name text
    nameTextRegion:ClearAllPoints()
    nameTextRegion:SetPoint("BOTTOM", healthBar, "TOP", 0, 6)
    nameTextRegion:SetPoint("LEFT", healthBar, "LEFT", 0, 0)
    nameTextRegion:SetPoint("RIGHT", healthBar, "RIGHT", 0, 0)
    nameTextRegion:SetFont(d3font, 12, "THINOUTLINE")
    nameTextRegion:SetShadowColor(1,1,1,0)
    
    -- Level text
    levelTextRegion:ClearAllPoints()
    levelTextRegion:SetPoint("LEFT", healthBar, "RIGHT", 17, 0)
    levelTextRegion:SetFont(d3font, 12, "THINOUTLINE")
    levelTextRegion:SetShadowColor(1,1,1,0)
    
    -- Highlight which shows up on mouseover
    highlightRegion:SetAlpha(0)
    
    local LowHP = healthBar:CreateTexture(nil, "ARTWORK")
    LowHP:SetPoint("TOPLEFT",healthBar,"TOPLEFT",-74,28)
    LowHP:SetPoint("BOTTOMRIGHT",healthBar,"BOTTOMRIGHT",68,-28)
    LowHP:SetTexture("Interface\\AddOns\\rTextures\\d3_targetframe_lowhp.tga")
    LowHP:SetBlendMode("ADD")
    LowHP:SetVertexColor(1, 0, 0, 1)
    LowHP:SetAlpha(0)
    healthBar.LowHP = LowHP
  
    if usered == 0 then
      healthBar:SetStatusBarTexture("")
      local fakeHP = healthBar:CreateTexture(nil, "BORDER ")
      fakeHP:SetPoint("RIGHT",0,0)
      fakeHP:SetHeight(healthBar:GetHeight())
      fakeHP:SetTexture(texture)
      fakeHP:SetVertexColor(targethealthtab.r,targethealthtab.g,targethealthtab.b,targethealthtab.a)
      healthBar.fakeHP = fakeHP
      healthBar.fakeHP:SetAlpha(0)
      healthBar.barwidth = healthBar:GetWidth()
    else
      healthBar:SetStatusBarTexture(texture)
    end

    healthBar:SetScript("OnValueChanged", checkhp)
    local hpval = SetFontString(healthBar, d3font, 10, "THINOUTLINE")
    hpval:SetPoint("RIGHT", 0, 1)
    healthBar.hpval = hpval

    
    -- Background
    local background = healthBar:CreateTexture(nil, "BACKGROUND")
    background:SetPoint("TOPLEFT",healthBar,"TOPLEFT",-20,13)
    background:SetPoint("BOTTOMRIGHT",healthBar,"BOTTOMRIGHT",17,-14)
    background:SetTexture(bordertexture)
    background:SetVertexColor(1,1,1,1) 
    
    frame.background = background
  end
  
  ------------------------------------
  --CALL
  ------------------------------------
  evl_NamePlates:new()