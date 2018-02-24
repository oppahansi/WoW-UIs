--
-- Status Window 
-- World of Warcraft UI AddOn to display time, frame rate, latency, health regen rate, and mana regen rate
-- 2005 Satrina@Stormrage
--

-- Saved Variables
SWVar = {}
--

-- Safeguard to prevent the magic frame parameter in the TokenUI from getting corrupted
local frame

local SML = LibStub and LibStub:GetLibrary('LibSharedMedia-3.0')

local tonum = function(value)
	local v = tonumber(value)
	return v or 0
end


StatusWindow = 
{ 
	version = 2.2, 
  _beta = false,
  minor = 0,
	debugLevel = 1,
	loadedModules = {},
	events = {},
  frames = {},
  windows = {},
}


function StatusWindow:debug(level, fmt, ...)
  if (level <= self.debugLevel) then
    ChatFrame1:AddMessage(format(fmt, ...))
  end
end

function StatusWindow.SlashCommands(msg)
	local loaded, message = LoadAddOn("StatusWindowOptions")
	if loaded then
    if not (StatusWindowOptions.minor or StatusWindowOptions.beta) then
      ChatFrame1:AddMessage(StatusWindow.strings.OLDOPTIONS)
      return
    end
    if (StatusWindow.version ~= StatusWindowOptions.version) or ((StatusWindow.version == StatusWindowOptions.version) and (StatusWindow.revision ~= StatusWindowOptions.revision)) then
      ChatFrame1:AddMessage(format(StatusWindow.strings.OPTIONSVERSION, StatusWindow.versionStr, StatusWindowOptions.versionStr))
      return
    end
		StatusWindowOptions:Open()
	else
		ChatFrame1:AddMessage(string.format(StatusWindow.strings.CONFIGERROR, message))
	end
end

function StatusWindow:OnFrameLoad()
	SLASH_STATUSWINDOW1 = "/statuswindow"
	SlashCmdList["STATUSWINDOW"] = self.SlashCommands
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
end

function StatusWindow:OnFrameEvent(event)
	if (event == "VARIABLES_LOADED") then
		StatusWindow:Initialise()		
	elseif (event == "PLAYER_ENTERING_WORLD") then
		StatusWindow:InitWindows()
		self.initialised = true
	end
	if not self.copyingProfile and self.events[event] then
		local frame
    for i,window in pairs(self.windows) do
      for index,frame in pairs(window.frames) do
        self.currentFrame = frame
        if frame._module and frame._module.events then
          for k,v in pairs(frame._module.events) do
            if (v == event) then
              self:InvokeFrameFunc(frame, "Update", event)
            end
          end
        end
			end
		end
	end
end

function StatusWindow:RegisterEvents()
	local index,event
	for event,data in pairs(self.events) do
		StatusWindowFrame:RegisterEvent(event)
	end
end

function StatusWindow:OnFrameUpdate(elapsed)
  if (self.finishedMoving > 0) then
    self.finishedMoving = self.finishedMoving - 1
  end
	if (self.elapsed >= 0.5) then
		self.timer = self.timer + 0.5
		if (self.timer > 3600) then
			self.timer = 0
		end
		self.elapsed = 0
    local frame
		if self.initialised and not self.copyingProfile then
      for i,window in ipairs(self.windows) do
        for index,frame in ipairs(window.frames) do
          if frame._module and frame._module.updateFrequency and (mod(self.timer, frame._module.updateFrequency) == 0) then
            self:InvokeFrameFunc(frame, "Update")
          end
        end
      end
			self.init = false
		end
	else
		self.elapsed = self.elapsed + elapsed
	end
end

--
-- Initialisation functions
--
function StatusWindow:Initialise()
	if self._beta then
		self.versionStr = string.format("%.01f beta %d", self.version, self.minor)
	else
		self.versionStr = string.format("%.01f.%d", self.version, self.minor)
	end
	self.player = UnitName("player").." of "..GetRealmName()
	self.elapsed = 1
	self.optionsElapsed = 1
	self.timer = 0
	self.count = 0
  self.finishedMoving = 0
  
  self:DoSavedVars()
	self._var = SWVar[self.player]

	StatusWindow:RegisterEvents()
end

function StatusWindow:DoSavedVars()
  if SWVar.version and (SWVar.version > 10) then
    ChatFrame1:AddMessage(self.strings.RESET)	
    self:PutTable(SWVar)
    SWVar = self:GetTable()
  end
	
  if not SWVar.version then
		SWVar.version = self.version
  elseif (SWVar.version < self.version) then
		SWVar.version = self.version
	end

  if self.beta then
    if not SWVar.beta or (SWVar.beta < 2) then
      ChatFrame1:AddMessage(self.strings.RESET)	
      self:PutTable(SWVar)
      SWVar = self:GetTable()
      SWVar.beta = self.beta
    end
  else
    SWVar.beta = nil
  end

  if not SWVar[self.player] then
    self:NewPlayer()
	end
  
end

function StatusWindow:NewPlayer()
	UIErrorsFrame:AddMessage(self.strings.NEWPLAYER..self.player, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)	

	SWVar[self.player] = 
	{
		frames = 
		{
			{ module = "Time", window = 1, position = 1, width = 60, height = 17, textAlign = "LEFT", padding = 5},
			{ module = "Latency", window = 1, position = 2, width = 60, height = 17, textAlign = "LEFT", padding = 5 },
			{ module = "FPS", window = 1, position = 3, width = 60, height = 17, textAlign = "LEFT", padding = 5 },
			{ module = "Durability", window = 1, position = 4, width = 60, height = 17, textAlign = "LEFT", padding = 5 },
			{ module = "Bag Slots", window = 1, position = 5, width = 60, height = 17, textAlign = "LEFT", padding = 5 },
		},
		
		windows = {
			{ y = 130, x = -73, relPoint = "BOTTOM", relTo = "BOTTOM" },
		},
	}
end

--
-- Module functions
--
function StatusWindow:RegisterModule(module)
	self:debug(3, "Registering module "..module.name)
	self.loadedModules[module.name] = module
end

function StatusWindow:HookEvents(frame)
	if frame._module and frame._module.events then
		for index,event in pairs(frame._module.events) do
			if not self.events[event] then
				self:debug(3, "Hooking "..event)
				StatusWindowFrame:RegisterEvent(event)
				self.events[event] = 1
			else
				self.events[event] = self.events[event] + 1
			end
		end
	end
end

function StatusWindow:UnhookEvents(frame)
	if frame._module and frame._module.events then
		for index,event in pairs(frame._module.events) do
			self.events[event] = self.events[event] - 1
			if (self.events[event] == 0) then
				self:debug(3, "Unhooking "..event)
				StatusWindowFrame:UnregisterEvent(event)
			end
		end
	end
end

function StatusWindow:AttachModule(frame, new)
  if not frame._var.module then
    self:debug(0, "nil module specified, ignoring it.  You might want to reset your profile")
    return false
  end
  
  -- Change event hooks
  self:UnhookEvents(frame)
  frame._module = self.loadedModules[frame._var.module]
  self:HookEvents(frame)
  
	-- Get the pane
  if frame._module and frame._module.GetPane then
		frame.pane = frame._module:GetPane()
	elseif not frame.pane then
    frame.pane = self:GetPane()
	end
	frame.pane.frame = frame
  frame.pane.fmt = nil

  -- Saved variables
  if not frame._var.modVar then
    frame._var.modVar = self:GetTable()
  end

  -- Local variables
  self:PutTable(frame.locals)
  frame.locals = self:GetTable()

  if not frame._var.new then
    StatusWindow:InvokeFrameFunc(frame, "New", frame._var.modVar)
    frame._var.new = true
  end

  self:InvokeFrameFunc(frame, "Init")
  self:debug(3, "Attached module %s to window %d frame %d", frame._var.module, frame._var.window, frame._var.position)
  return true
end

--
-- Pane functions
--
StatusWindow.paneCache = {}
function StatusWindow:GetPane()
	local p
	for k,pane in pairs(self.paneCache) do
		if not pane.inUse then
			p = pane
			break
		end
	end
	if not p then
		p = CreateFrame("Button", "SWPane"..(#self.paneCache + 1), UIParent, "StatusWindowPaneTemplate")
		table.insert(self.paneCache, p)
	end
	p.inUse = true
	return p
end

function StatusWindow:PutPane(p)
  if not p then
    return
  end
	p.inUse = false
  p.icon:SetTexture(nil)
  p.text:SetText("")
	p:ClearAllPoints()
	p:Hide()
end

--
-- Frame functions
--

function StatusWindow:ValidateFrameVars(var)
  var.padding = var.padding or 5
  var.height = var.height or 20
  if var.textAlign then
    var.modVar.textAlign = var.textAlign
  end
  var.modVar.textAlign = var.modVar.textAlign or "LEFT"
end

function StatusWindow:PutFrame(f)
  for i,window in pairs(self.windows) do
    for k,v in pairs(window.frames) do
      if (f == v) then
        table.remove(window.frames, k)
      end
    end
  end
	for k,v in pairs(self.frames) do
    if (f == v) then
      table.remove(self.frames, k)
      break
    end
  end
  self:PutPane(f.pane)
	self:PutTable(f)
end

function StatusWindow:GetFrame(fvar)
	local frame
  for k,v in pairs(self.frames) do
    if (v._var == fvar) then
      frame = v
    end
  end
	if not frame then
    frame = self:GetTable()
    frame._var = fvar
    if not self:AttachModule(frame) then
      self:PutFrame(frame)
      return nil
    end
    self:ValidateFrameVars(fvar)
    self:FinishFrame(frame)
    table.insert(self.frames, frame)
  end
  return frame
end

function StatusWindow:FinishFrame(frame)
  if frame._module and frame._module.registerClicks then
    frame.pane:RegisterForClicks(unpack(frame._module.registerClicks))
  else
    frame.pane:RegisterForClicks()
  end
  if frame._var.modVar.label then
    frame._var.icon = (string.find(frame._var.modVar.label, "$i") == 1)
  end
  frame.pane.fmt = nil
end

--
-- Window functions
--
function StatusWindow:ValidateWindowVars(window)
  local var = window._var
  
  var.font = var.font or "Friz Quadrata TT"
  var.fontSize = var.fontSize or 10
  var.scale = var.scale or 1
  var.backgroundColour = var.backgroundColour or {r = 0, g = 0, b = 0, a = 1}
  var.backgroundColour.a = var.backgroundColour.a or 1
  var.borderColour = var.borderColour or {r = 1, g = 1, b = 1, a = 1}
  var.borderColour.a = var.borderColour.a or 1
  var.borderSize = var.borderSize or 16
  var.background = var.background or "Blizzard Tooltip" -- self.strings.NONE
  var.border = var.border or self.strings.NOBORDER
  var.opacity = var.opacity or 1
  var.height = nil
  var.textColour = var.textColour or {r=1.0, g=0.82, b=0}
  var.textColour.a = nil
  if not var.rowCount or (var.rowCount < 1) then
    var.rowCount = 1
  end
end

StatusWindow.windowCache = {}
function StatusWindow:GetWindow(index)
	local window, j
	for i,w in ipairs(self.windowCache) do
		if not w.inUse then
			window = w
			break
		end
	end
	if not window then
		j = #self.windowCache + 1
    window = CreateFrame("Frame", "StatusWindowWindow"..j, UIParent, "StatusWindowWindowTemplate")
		window.content = getglobal(window:GetName().."Content")
    window.frames = {}
    self.windowCache[j] = window
	end
	window.inUse = true
	window.index = index
	return window
end

function StatusWindow:PutWindow(window)
  while (#window.frames > 0) do
    self:PutFrame(table.remove(window.frames))
  end
  window:ClearAllPoints()
  window:Hide()
  window.inUse = false
	window.index = nil
  window._var = nil
end

function StatusWindow:InitWindows()
	self:debug(2, "Initialising Windows")
	for k = 1,#self._var.windows do
		self:MakeWindow(k)
	end
end

function StatusWindow:UpdateSavedVars(window)
	for k,frame in pairs(window.frames) do
		frame._var.position = k
		frame._var.window = window.index
	end
end

function StatusWindow:MakeWindow(index)
	local window = self.windows[index]
  if not window then
    window = self:GetWindow(index)
    self.windows[index] = window
  end
  if self:AssembleWindow(window) then
    self:FinishWindow(window)
    self:UpdateWindow(window)
  end
end
	
function StatusWindow:AssembleWindow(window)
	local lastFrame = window.content
  window._var = self._var.windows[window.index]
  self:ValidateWindowVars(window)
  
	local f, frame
  while (#window.frames > 0) do
    f = table.remove(window.frames)
    f.pane:ClearAllPoints()
  end  
  for k,fvar in pairs(self._var.frames) do
		if (fvar.window == window.index) then
      f = self:GetFrame(fvar)
      if f then
        f.window = window
        window.frames[fvar.position] = f
      end
    end 
  end
 	if (#window.frames > 0) then
    local numRows = ceil(#window.frames/window._var.rowCount)
    local lastAnchor, lastFrame
    local curFrame = 1
    window.width,window.height = 0,0

    for i=1,numRows do
      for j=1,window._var.rowCount do
        frame = window.frames[curFrame]
        if (i == 1) then
          window.width = window.width + frame._var.width
        end
        if not frame then
          break
        end
        if (j == 1) then
          if not lastAnchor then
            frame.pane:SetPoint("TOPLEFT", window.content, "TOPLEFT", 0, 0)
          else
            frame.pane:SetPoint("TOPLEFT", lastAnchor.pane, "BOTTOMLEFT", 0, 0)
          end
          lastAnchor = frame
          window.height = window.height + frame._var.height
        else
          frame.pane:SetPoint("LEFT", lastFrame.pane, "RIGHT")
        end
        lastFrame = frame
        curFrame = curFrame + 1
      end
    end
  else
    window:Hide()
    return false
  end
  return true
end

function StatusWindow:FinishWindow(window)
  local width, height = 0,0
  local wWidth, wHeight

  if not self.insets then
    self.insets = {}
  end

  window.textColourCode = format("|cff%02x%02x%02x", window._var.textColour.r*255,  window._var.textColour.g*255, window._var.textColour.b*255)
  local bgFile = SML:Fetch("background", window._var.background)
  local edgeFile = SML:Fetch("border", window._var.border)
  local hasBorder = (edgeFile == self.strings.NOBORDER)
  
  if hasBorder then
    self.insets.left = 0
    self.insets.right = 0
    self.insets.top = 0
    self.insets.bottom = 0
  else
    self.insets.left = window._var.borderSize/4
    self.insets.right = window._var.borderSize/4
    self.insets.top = window._var.borderSize/4
    self.insets.bottom = window._var.borderSize/4
  end
  window.frames[1].pane:ClearAllPoints()
  window.frames[1].pane:SetPoint("TOPLEFT", window.content, "TOPLEFT", 0, -self.insets.top)
     
  window.content:SetHeight(window.height + self.insets.top * 2)
  window.content:SetWidth(window.width + self.insets.left * 2)
  window.content:SetScale(window._var.scale or 1.0)
  window.content:SetAlpha(window._var.opacity or 1.0)
  local effScale = 	window:GetEffectiveScale()
 
  if Skinner then
    Skinner:applySkin(window.content)
  else
    window.content:SetBackdrop( { bgFile = bgFile, edgeFile = edgeFile, tile = false, tileSize = 16, edgeSize = window._var.borderSize, insets = self.insets })
    window.content:SetBackdropColor(window._var.backgroundColour.r, window._var.backgroundColour.g, window._var.backgroundColour.b, window._var.backgroundColour.a)
    window.content:SetBackdropBorderColor(window._var.borderColour.r, window._var.borderColour.g, window._var.borderColour.b, window._var.borderColour.a)
  end
  
  for index,frame in pairs(window.frames) do
    frame.pane:SetParent(window.content)
    self:SetupPane(frame)
  end

  window:SetWidth(window.content:GetWidth()*effScale)
  window:SetHeight(window.content:GetHeight()*effScale)
  window:ClearAllPoints()
  if window._var.x and window._var.y then
    window:SetPoint(window._var.relPoint, UIParent, window._var.relTo, window._var.x, window._var.y)
  else
    window:SetPoint("CENTER", UIParent, "CENTER", 300, 0)
  end
  window:Show()
end

function StatusWindow:InvokeFrameFunc(frame, func, ...)
  if frame and frame._module and frame._module[func] then
    self.currentFrame = frame
		frame._module.locals = frame.locals
		frame._module.modVar = frame._var.modVar
		frame._module.pane = frame.pane
    frame._module.window = frame._var.window
    frame._module.frame = frame._var.position
		frame._module[func](frame._module, ...)
		frame._module.locals = nil
		frame._module.modVar = nil
		frame._module.pane = nil
    frame._module.window = nil
    frame._module.frame = nil
    self.currentFrame = nil
	end
end

function StatusWindow:GetFrameVar(var)
  return self.currentFrame._var[var]
end

function StatusWindow:UpdateWindow(window, frame)
  if (type(window) == "number") then
    window = self.windows[window]
  end
	for index,f in pairs(window.frames) do
    if not frame or (index == frame) then
      if f._module then
        self:InvokeFrameFunc(f, "Update", f._module.updateEvent)
      end
    end
	end
end

function StatusWindow:GetWindowFont(index)
  return SML:Fetch("font", self.windows[index]._var.font), self.windows[index]._var.fontSize
end

function StatusWindow:GetWindowTextColourCode(index)
  if self.windows[index] then
    return self.windows[index].textColourCode
  end
  return NORMAL_FONT_COLOR_CODE
end

--
-- Pane interaction
--

function StatusWindow:FrameOnEnter()
	self:InvokeFrameFunc(this.frame, "OnEnter")
end

function StatusWindow:FrameOnLeave()
	self:InvokeFrameFunc(this.frame, "OnLeave")
	GameTooltip:Hide()
end

function StatusWindow:Click(clickType)
  if IsAltKeyDown() or IsShiftKeyDown() or this:GetParent():GetParent().moving or (self.finishedMoving > 0) then
    return
  end
  self:InvokeFrameFunc(this.frame, "OnClick", clickType)
end

function StatusWindow:MouseDown(clickType)
	if (clickType == "LeftButton") then
    if IsAltKeyDown() then
      this:GetParent():GetParent().moving = true
      this:GetParent():GetParent():StartMoving()
      return
    elseif IsShiftKeyDown() and SWOptions:IsShown() then
      StatusWindowOptions:SelectWindow(this:GetParent():GetParent().index)
      return
    end
  end
end

function StatusWindow:MouseUp(clickType)
	local f = this:GetParent():GetParent()
  if f.moving then
    f:StopMovingOrSizing()
    f._var.relPoint, _, f._var.relTo, f._var.x, f._var.y = f:GetPoint()
    f.moving = false
    self.finishedMoving = 5
    return
  end
end

StatusWindow.CopyTable = function(self, src)
  local dst = self:GetTable()
  for k,v in pairs(src) do
    if (type(v) == "table") and not v.IsObjectType then
      dst[k] = self:CopyTable(v)
    else
      dst[k] = v
    end
  end
  return dst
end

StatusWindow.tables = {}
function StatusWindow:GetTable()
	if (#self.tables == 0) then
		return {}
	end
	return table.remove(self.tables, 1)
end

function StatusWindow:PutTable(t)
	if not t then
		return
	end
	for k,v in pairs(t) do
		if (type(v) == "table") and not v.IsObjectType and (string.byte(k, 1) ~= 95) then
			self:PutTable(v)
		end
		t[k] = nil
	end
	table.insert(self.tables, t)
end

function StatusWindow:SetupPane(frame)
  if frame._module and frame._module.SetupPane then
    self:InvokeFrameFunc(frame, "SetupPane", frame)
  else
    self:SetupDefaultPane(frame)
  end
end

--
-- Default pane template
--
function StatusWindow:HasIcon(frame)
  if not frame then
    frame = self.currentFrame
  end
  if frame and frame._module then
    return frame._module.icon or frame._var.modVar.icon
  end
  return false
end

function StatusWindow:HasLabel(frame)
  if not frame then
    frame = self.currentFrame
  end
  if frame then
    return frame._var.modVar.label
  end
  return false
end

function StatusWindow:ShowingIcon(frame)
  if not frame then
    frame = self.currentFrame
  end
  if frame then
    if frame._var.showIcon then
      return true
    elseif not frame._var.modVar.label and (frame._module and frame._module.icon or frame._var.modVar.icon) then
      return true
    else
      return false
    end
  end
  return false
end

function StatusWindow:SetupDefaultPane(frame)
  local pane = frame.pane
  local pad = frame._var.padding
  local windowVar = self.windows[frame._var.window]._var
  
	pane:SetHeight(frame._var.height)
  pane:SetWidth(frame._var.width)
  pane.text:ClearAllPoints()
  local a,b
  
  pane.text:SetJustifyH(frame._var.modVar.textAlign)
  pane.text:SetFont(SML:Fetch("font", windowVar.font), windowVar.fontSize)
  pane.text:Show()
  if frame._var.icon then
    pane.icon:Show()
		pane.icon:SetPoint("LEFT", pane, "LEFT", pad,  0)
    pane.text:SetPoint("LEFT", pane.icon, "RIGHT", 2, 0)
    pane.text:SetWidth(frame._var.width - pane.icon:GetWidth() - pad + 2)
	else
		pane.icon:Hide()
		pane.text:SetPoint("LEFT", pane, "LEFT", pad, 0)
		pane.text:SetWidth(frame._var.width - pad)
	end
  pane:Show()
end

function StatusWindow:UpdateCurrentPane()
  local frame = self.currentFrame
  local window = self.currentFrame.window
  local pane = self.currentFrame.pane
  local str = self.currentFrame._var.modVar.label
  local elements = self.currentFrame.locals.elements
  
  if not (pane and str and elements) then
    self:debug(1, "UpdateCurrentPane missing pane, string, or elements")
    return
  end
  
  if not pane.fmt then
    local f = string.gsub(str, "$i%s?", "")
    f = string.gsub(f, "%%", "%%%%")
    f = string.gsub(f, "$%d", "%%s")
    pane.fmt = format("%%s%s|r", f)
  end

  local t = self:GetTable()
  local e 
  if elements[0] and not window._var.useWindowColour then
    table.insert(t, elements[0])
  else
    table.insert(t, window.textColourCode)
  end
    
  for element in string.gmatch(str, "$(%d)") do
    e = tonumber(element)
    if elements[e] then
      table.insert(t, elements[e])
    else
      self:debug(0, self.strings.BADELEMENT, element, frame._module.name)
      table.insert(t, "err")
    end
  end
  pane.text:SetFormattedText(pane.fmt, unpack(t))
  self:PutTable(t)
end

function StatusWindow:ClassColorCode(class)
  if not self.classColorCode then
    self.classColorCode = {
      [self.strings.HUNTER] = "|cffaad372", -- { r = 0.67, g = 0.83, b = 0.45 }
      [self.strings.WARLOCK] = "|cff8282c9",  -- { r = 0.58, g = 0.51, b = 0.79 }
      [self.strings.PRIEST] = "|cffffffff",   -- { r = 1.0, g = 1.0, b = 1.0 }
      [self.strings.PALADIN] = "|cfff28cba",  -- { r = 0.96, g = 0.55, b = 0.73 }
      [self.strings.MAGE] = "|cff68ccef",     -- { r = 0.41, g = 0.8, b = 0.94 }
      [self.strings.ROGUE] = "|cfffff268",    -- { r = 1.0, g = 0.96, b = 0.41 }
      [self.strings.DRUID] = "|cffff7c0a",    -- { r = 1.0, g = 0.49, b = 0.04 }
      [self.strings.SHAMAN] = "|cff2359ff",   -- { r = 0.14, g = 0.35, b = 1.0 }
      [self.strings.WARRIOR] = "|cffc99b6d",  -- { r = 0.78, g = 0.61, b = 0.43 }
    }
  end
  return self.classColorCode[class] or NORMAL_FONT_COLOR_CODE
end

function StatusWindow:ClassColorRGB(class)
  if not self.classColorRGB then
    self.classColorRGB = {
      [self.strings.HUNTER] = RAID_CLASS_COLORS["HUNTER"], 
      [self.strings.WARLOCK] = RAID_CLASS_COLORS["WARLOCK"],
      [self.strings.PRIEST] = RAID_CLASS_COLORS["PRIEST"],
      [self.strings.PALADIN] = RAID_CLASS_COLORS["PALADIN"],
      [self.strings.MAGE] = RAID_CLASS_COLORS["MAGE"],
      [self.strings.ROGUE] = RAID_CLASS_COLORS["ROGUE"],
      [self.strings.DRUID] = RAID_CLASS_COLORS["DRUID"],
      [self.strings.SHAMAN] = RAID_CLASS_COLORS["SHAMAN"],
      [self.strings.WARRIOR] = RAID_CLASS_COLORS["WARRIOR"],
    }
  end
  return self.classColorRGB[class] or NORMAL_FONT_COLOR
end


