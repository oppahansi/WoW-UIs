local _G = _G

local Simple3DPortraits = LibStub("AceAddon-3.0"):NewAddon("Simple3DPortraits", "AceEvent-3.0")
local S3DFrameScripts = {}
local S3DMoverScripts = {}
local frames = {}

_G.Simple3DPortraits = Simple3DPortraits

local myprint = LibStub("AceConsole-3.0")

local getOpt, setOpt, setFrameStrata, setLevel

do
   function getOpt(info)
      local key = info[#info]
      return Simple3DPortraits.db.profile[key]
   end

   function setOpt(info, value)
      local key = info[#info]
      Simple3DPortraits.db.profile[key] = value
      Simple3DPortraits:Refresh()
   end

   function setFrameStrata(info, value)
      local key = info[#info]
      Simple3DPortraits.db.profile[key] = value
      local frame
      if key == "playerFrStrata" then
	 frame = frames["player"]
      elseif key == "targetFrStrata" then
	 frame = frames["target"]
      elseif key == "targettargetFrStrata" then
	 frame = frames["targettarget"]
      elseif key == "focusFrStrata" then
	 frame = frames["focus"]
      elseif key == "petFrStrata" then
	 frame = frames["pet"]
      end
      frame:SetFrameStrata(value)
      frame.model:SetFrameStrata(value)
      frame.overlay:SetFrameStrata(value)
   end

   function setFrameLevel(info, value)
      local key = info[#info]
      --print(key, value)
      Simple3DPortraits.db.profile[key] = value
      local frame
      if key == "playerFrLevel" then
	 frame = frames["player"]
      elseif key == "targetFrLevel" then
	 frame = frames["target"]
      elseif key == "targettargetFrLevel" then
	 frame = frames["targettarget"]
      elseif key == "focusFrLevel" then
	 frame = frames["focus"]
      elseif key == "petFrLevel" then
	 frame = frames["pet"]
      end
      if not frame then return end
      frame:SetFrameLevel(value)
      frame.model:SetFrameLevel(value+1)
      frame.overlay:SetFrameLevel(value+2)
   end
end

local frameStrata = {
   BACKGROUND = "BACKGROUND",
   LOW = "LOW",
   MEDIUM = "MEDIUM",
   HIGH = "HIGH",
   DIALOG = "DIALOG",
   TOOLTIP = "TOOLTIP",
}


Simple3DPortraits.options = {
   type = "group",
   args = {
      global = {
	 type = "group",
	 name = "Global Settings",
	 order = 1,
	 args = {
	    __header1 = {
	       type = "description",
	       name = "Global Options",
	       order = 1,
	    },
	    show = {
	       name = "Show",
	       type = "toggle",
	       desc = "Show or hide the frames",
	       set = setOpt,
	       get = getOpt,
	       width = "half",
	       order = 10,
	       disabled = true,
	    },
	    lockMovement = {
	       name = "Lock Frames",
	       type = "toggle",
	       desc = "Lock frames in position",
	       set = setOpt,
	       get = getOpt,
	       order = 11,
	       disabled = pb4InUse,
	    },
	    isClamped = {
	       name = "Clamp to screen",
	       type = "toggle",
	       desc = "Clamp frames to screen",
	       set = setOpt,
	       get = getOpt,
	       order = 16,
	    },
	    dimensionsHeading = {
	       type = "header",
	       name = "Scale and placement",
	       order = 17,
	    },
	    scale = {
	       name = "Scale",
	       type = "range",
	       desc = "Overall scaling of frames",
	       min = 0.1, max = 3, step = 0.005,
	       get = getOpt,
	       set = setOpt,
	       order = 99,
	       disabled = true,
	    },
	    playerHeading = {
	       type = "header",
	       name = "Player frame",
	       order = 100,
	    },
	    playerXpos = {
	       name = "Player x position",
	       type = "range",
	       desc = "Offset from center of screen in the horizontal direction",
	       min = -1000, max = 1000, softMin = -200, softMax = 200, step = 0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 101,
	    },
	    playerYpos = {
	       name = "Player y position",
	       type = "range",
	       desc = "Offset from center of screen in the vertical direction",
	       min = -1000, max = 1000, softMin = -200, softMax = 200, step=0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 102,
	    },
	    playerXsize = {
	       name = "Player x size",
	       type = "range",
	       desc = "Horizontal frame size",
	       min = 15, max = 500, softMin = 15, softMax = 100, step = 0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 103,
	    },
	    playerYsize = {
	       name = "Player y size",
	       type = "range",
	       desc = "Vertical frame size",
	       min = 15, max = 500, softMin = 15, softMax = 100, step = 0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 104,
	    },
	    playerHide = {
	       name = "Hide player",
	       type = "toggle",
	       desc = "Hide frame model",
	       set = setOpt,
	       get = getOpt,
	       order = 108,
	    },
	    playerFrStrata = {
	       name = "Frame strata",
	       type = "select",
	       desc = "Set frame strata",
	       values = frameStrata,
	       get = getOpt,
	       set = setFrameStrata,
	       order = 106,
	    },
	    playerFrLevel = {
	       name = "Frame level",
	       type = "range",
	       desc = "Set frame's level relative to others in its strata",
	       min = 0, max = 10, step = 1,
	       get = getOpt,
	       set = setFrameLevel,
	       order = 107,
	    },
	    targetHeading = {
	       type = "header",
	       name = "Target frame",
	       order = 200,
	    },
	    targetXpos = {
	       name = "Target x",
	       type = "range",
	       desc = "Offset from center of screen in the horizontal direction",
	       min = -1000, max = 1000, softMin = -200, softMax = 200, step=0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 201,
	    },
	    targetYpos = {
	       name = "Target y",
	       type = "range",
	       desc = "Offset from center of screen in the vertical direction",
	       min = -1000, max = 1000, softMin = -200, softMax = 200, step=0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 202,
	    },
	    targetXsize = {
	       name = "Target x size",
	       type = "range",
	       desc = "Horizontal frame size",
	       min = 15, max = 500, softMin = 15, softMax = 100, step = 0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 203,
	    },
	    targetYsize = {
	       name = "Target y size",
	       type = "range",
	       desc = "Vertical frame size",
	       min = 15, max = 500, softMin = 15, softMax = 100, step = 0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 204,
	    },
	    targetHide = {
	       name = "Hide target",
	       type = "toggle",
	       desc = "Hide frame model",
	       set = setOpt,
	       get = getOpt,
	       order = 208,
	    },
	    targetFrStrata = {
	       name = "Frame strata",
	       type = "select",
	       desc = "Set frame strata",
	       values = frameStrata,
	       get = getOpt,
	       set = setFrameStrata,
	       order = 206,
	    },
	    targetFrLevel = {
	       name = "Frame level",
	       type = "range",
	       desc = "Set frame's level relative to others in its strata",
	       min = 0, max = 10, step = 1,
	       get = getOpt,
	       set = setFrameLevel,
	       order = 207,
	    },
	    targettargetHeading = {
	       type = "header",
	       name = "Target of target frame",
	       order = 300,
	    },
	    targettargetXpos = {
	       name = "Target of target x",
	       type = "range",
	       desc = "Offset from center of screen in the horizontal direction",
	       min = -1000, max = 1000, softMin = -200, softMax = 200, step=0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 301,
	    },
	    targettargetYpos = {
	       name = "Target of target y",
	       type = "range",
	       desc = "Offset from center of screen in the vertical direction",
	       min = -1000, max = 1000, softMin = -200, softMax = 200, step=0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 302,
	    },
	    targettargetXsize = {
	       name = "Target of target x size",
	       type = "range",
	       desc = "Horizontal frame size",
	       min = 15, max = 500, softMin = 15, softMax = 100, step = 0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 303,
	    },
	    targettargetYsize = {
	       name = "Target of target y size",
	       type = "range",
	       desc = "Vertical frame size",
	       min = 15, max = 500, softMin = 15, softMax = 100, step = 0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 304,
	    },
	    targettargetHide = {
	       name = "Hide target of target",
	       type = "toggle",
	       desc = "Hide frame model",
	       set = setOpt,
	       get = getOpt,
	       order = 308,
	    },
	    targettargetFrStrata = {
	       name = "Frame strata",
	       type = "select",
	       desc = "Set frame strata",
	       values = frameStrata,
	       get = getOpt,
	       set = setFrameStrata,
	       order = 306,
	    },
	    targettargetFrLevel = {
	       name = "Frame level",
	       type = "range",
	       desc = "Set frame's level relative to others in its strata",
	       min = 0, max = 10, step = 1,
	       get = getOpt,
	       set = setFrameLevel,
	       order = 307,
	    },
	    focusHeading = {
	       type = "header",
	       name = "focus frame",
	       order = 400,
	    },
	    focusXpos = {
	       name = "Focus x",
	       type = "range",
	       desc = "Offset from center of screen in the horizontal direction",
	       min = -1000, max = 1000, softMin = -200, softMax = 200, step=0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 401,
	    },
	    focusYpos = {
	       name = "Focus y",
	       type = "range",
	       desc = "Offset from center of screen in the vertical direction",
	       min = -1000, max = 1000, softMin = -200, softMax = 200, step=0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 402,
	    },
	    focusXsize = {
	       name = "Focus x size",
	       type = "range",
	       desc = "Horizontal frame size",
	       min = 15, max = 500, softMin = 15, softMax = 100, step = 0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 403,
	    },
	    focusYsize = {
	       name = "Focus y size",
	       type = "range",
	       desc = "Vertical frame size",
	       min = 15, max = 500, softMin = 15, softMax = 100, step = 0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 404,
	    },
	    focusHide = {
	       name = "Hide focus",
	       type = "toggle",
	       desc = "Hide frame model",
	       set = setOpt,
	       get = getOpt,
	       order = 408,
	    },
	    focusFrStrata = {
	       name = "Frame strata",
	       type = "select",
	       desc = "Set frame strata",
	       values = frameStrata,
	       get = getOpt,
	       set = setFrameStrata,
	       order = 406,
	    },
	    focusFrLevel = {
	       name = "Frame level",
	       type = "range",
	       desc = "Set frame's level relative to others in its strata",
	       min = 0, max = 10, step = 1,
	       get = getOpt,
	       set = setFrameLevel,
	       order = 407,
	    },
	    petHeading = {
	       type = "header",
	       name = "Pet frame",
	       order = 500,
	    },
	    petXpos = {
	       name = "Pet x",
	       type = "range",
	       desc = "Offset from center of screen in the horizontal direction",
	       min = -1000, max = 1000, softMin = -200, softMax = 200, step=0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 501,
	    },
	    petYpos = {
	       name = "Pet y",
	       type = "range",
	       desc = "Offset from center of screen in the vertical direction",
	       min = -1000, max = 1000, softMin = -200, softMax = 200, step=0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 502,
	    },
	    petXsize = {
	       name = "Pet x size",
	       type = "range",
	       desc = "Horizontal frame size",
	       min = 15, max = 500, softMin = 15, softMax = 100, step = 0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 503,
	    },
	    petYsize = {
	       name = "Pet y size",
	       type = "range",
	       desc = "Vertical frame size",
	       min = 15, max = 500, softMin = 15, softMax = 100, step = 0.5,
	       get = getOpt,
	       set = setOpt,
	       order = 504,
	    },
	    petHide = {
	       name = "Hide pet",
	       type = "toggle",
	       desc = "Hide frame model",
	       set = setOpt,
	       get = getOpt,
	       order = 508,
	    },
	    petFrStrata = {
	       name = "Frame strata",
	       type = "select",
	       desc = "Set frame strata",
	       values = frameStrata,
	       get = getOpt,
	       set = setFrameStrata,
	       order = 506,
	    },
	    petFrLevel = {
	       name = "Frame level",
	       type = "range",
	       desc = "Set frame's level relative to others in its strata",
	       min = 0, max = 10, step = 1,
	       get = getOpt,
	       set = setFrameLevel,
	       order = 507,
	    },
	 },
      },
   },
}

local defaults = {
   profile = {
      show = true,
      lockMovement = false,
      isClamped = true,
      scale = 1.0,
      playerXpos = -290,
      playerYpos = -226,
      playerXsize = 55,
      playerYsize = 55,
      playerHide = false,
      playerFrStrata = "LOW",
      playerFrLevel = 1,
      targetXpos = 290,
      targetYpos = -226,
      targetXsize = 55,
      targetYsize = 55,
      targetHide = false,
      targetFrStrata = "LOW",
      targetFrLevel = 1,
      targettargetXpos = 410,
      targettargetYpos = 30,
      targettargetXsize = 50,
      targettargetYsize = 40,
      targettargetHide = true,
      targettargetFrStrata = "LOW",
      targettargetFrLevel = 1,
      focusXpos = -400,
      focusYpos = 165,
      focusXsize = 50,
      focusYsize = 40,
      focusHide = true,
      focusFrStrata = "LOW",
      focusFrLevel = 1,
      petXpos = -260,
      petYpos = -20,
      petXsize = 80,
      petYsize = 60,
      petHide = true,
      petFrStrata = "LOW",
      petFrLevel = 1,
   },
}



function Simple3DPortraits:OnInitialize()
   self.db = LibStub("AceDB-3.0"):New("Simple3DPortraitsDB", defaults, true)
   self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
   self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
   self.db.RegisterCallback(self, "OnProfileReset", "Refresh")
   self.options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
   self.options.args.profiles.order = 100
end

function Simple3DPortraits:OnEnable()
   LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("Simple3DPortraits",
							 self.options,
							 nil)
   local ACD = LibStub("AceConfigDialog-3.0")
   self.OptionsPanel = ACD:AddToBlizOptions(self.name, self.name, nil, "global")
   self.OptionsPanel.Profiles = ACD:AddToBlizOptions(self.name, "Profiles", self.name, "profiles")

   Simple3DPortraits:RegisterEvent("UNIT_MODEL_CHANGED")
   Simple3DPortraits:RegisterEvent("PLAYER_TARGET_CHANGED")
   Simple3DPortraits:RegisterEvent("PLAYER_ENTERING_WORLD")
   Simple3DPortraits:RegisterEvent("PLAYER_FOCUS_CHANGED")

   -- Create frames and models

   Simple3DPortraits.PlayerPortrait = Simple3DPortraits:CreatePortrait("PlayerS3D", UIParent, "player", true)
   Simple3DPortraits.TargetPortrait = Simple3DPortraits:CreatePortrait("TargetS3D", UIParent, "target", true)
   Simple3DPortraits.PetPortrait = Simple3DPortraits:CreatePortrait("PetS3D", UIParent, "pet", true)
   Simple3DPortraits.TargetTargetPortrait = Simple3DPortraits:CreatePortrait("TargetTargetS3D", UIParent, "targettarget", true)
   Simple3DPortraits.FocusPortrait = Simple3DPortraits:CreatePortrait("FocusS3D", UIParent, "focus", true)

   -- You can add any more frames you'd like, like "party1" or "raid3".  Any target, or target of that
   --   target, like "pettarget".  Also add them to the 'frames' table like in the next lines.
   --   You'll also need to create the correct option variables above to hold your new frame sizes
   --   and positions.

   frames["player"] = Simple3DPortraits.PlayerPortrait
   frames["target"] = Simple3DPortraits.TargetPortrait
   frames["pet"] = Simple3DPortraits.PetPortrait
   frames["targettarget"] = Simple3DPortraits.TargetTargetPortrait
   frames["focus"] = Simple3DPortraits.FocusPortrait
end

function Simple3DPortraits:UNIT_MODEL_CHANGED(junk, unit)
   local hide = Simple3DPortraits.db.profile[unit.."Hide"]
   if not frames[unit] then return end;
   Simple3DPortraits:RefreshModel(frames[unit], hide)
end

function Simple3DPortraits:PLAYER_TARGET_CHANGED()
   local db = Simple3DPortraits.db.profile
   Simple3DPortraits:RefreshModel(frames.target, db.targetHide)
   Simple3DPortraits:RefreshModel(frames.targettarget, db.targettargetHide)
end

function Simple3DPortraits:PLAYER_FOCUS_CHANGED()
   Simple3DPortraits:RefreshModel(frames.focus, Simple3DPortraits.db.profile.focusHide)
end

function Simple3DPortraits:PLAYER_ENTERING_WORLD()
   for key, val in pairs(frames) do
      local unit = val.unitID
      Simple3DPortraits:RefreshModel(val, Simple3DPortraits.db.profile[unit.."Hide"])
   end
end

function Simple3DPortraits:Refresh()
   local db = Simple3DPortraits.db.profile
   for key, frame in pairs(frames) do
      local unit = frame.unitID
      local hide = db[unit.."Hide"]
      if db.lockMovement then
	 frame.visible:SetTexture(0, 0, 0, 0)
	 frame.overlay:Hide()
      elseif not db.lockMovement then
	 frame.visible:SetTexture(0.5, 0.55, 0.55, 0.3)
	 frame.overlay:Show()
      end
      if hide and frame.isRegisteredForWatch and db.lockMovement then
	 UnregisterUnitWatch(frame)
	 frame:Hide()
	 frame.isRegisteredForWatch = false
      end
      if not hide and not frame.isRegisteredForWatch and db.lockMovement then
	 frame:Show()
	 RegisterUnitWatch(frame)
	 frame.isRegisteredForWatch = true
      end
      if not hide and not db.lockMovement and frame.isRegisteredForWatch then
	 UnregisterUnitWatch(frame)
	 frame.isRegisteredForWatch = nil
	 frame:Show()
      end
      if hide and not db.lockMovement and not frame.isRegisteredForWatch then
	 frame:Hide()
      end
      if not hide and not db.lockMovement and not frame.isRegisteredForWatch then
	 frame:Show()
      end

      --print('isReg', unit, frame.isRegisteredForWatch)

      if db.isClamped then
	 frame:SetClampedToScreen(true)
      else
	 frame:SetClampedToScreen(false)
      end

      local xpos, ypos = db[unit.."Xpos"], db[unit.."Ypos"]
      local xsize, ysize = db[unit.."Xsize"], db[unit.."Ysize"]
      frame:ClearAllPoints()
	  local anchor
	  if unit == "player" then
		anchor = PitBullUnitFrame1
		xpos = -268
		ypos = 226
		elseif unit == "target" then
		anchor = PitBullUnitFrame3
		xpos = 268
		ypos = 226
		end
      frame:SetPoint("CENTER", anchor, "CENTER", xpos, ypos)
      frame:SetWidth(xsize)
	  frame:SetHeight(ysize)
   end
end

local frameThatsMoving = nil
local frameThatsResizing = nil

function S3DMoverScripts:OnDragStart()
   local db = Simple3DPortraits.db.profile
   if db.lockMovement or InCombatLockdown() then
      return
   end
   local parent = self:GetParent()

   parent:StartSizing()
   frameThatsResizing = parent
end

function S3DMoverScripts:OnDragStop()
   local parent = self:GetParent()
   if frameThatsResizing ~= parent then return end
   frameThatsResizing = nil
   parent:StopMovingOrSizing()

   local uiScale = UIParent:GetEffectiveScale()
   local scale = parent:GetEffectiveScale()/uiScale
   local x, y = parent:GetSize()
   x, y = x*scale, y*scale

   local unit = parent.unitID
   Simple3DPortraits.db.profile[unit.."Xsize"] = x/parent:GetScale()
   Simple3DPortraits.db.profile[unit.."Ysize"] = y/parent:GetScale()

   x, y = parent:GetCenter()
   x, y = x*scale, y*scale
   x = x - GetScreenWidth()/2
   y = y - GetScreenHeight()/2

   Simple3DPortraits.db.profile[unit.."Xpos"] = x/parent:GetScale()
   Simple3DPortraits.db.profile[unit.."Ypos"] = y/parent:GetScale()

   LibStub("AceConfigRegistry-3.0"):NotifyChange("Simple3DPortraits")
   Simple3DPortraits:Refresh()
end

function S3DFrameScripts:OnDragStart()
   local db = Simple3DPortraits.db.profile
   if db.lockMovement or InCombatLockdown() then
      return
   end

   self:StartMoving()
   frameThatsMoving = self
end

function S3DFrameScripts:OnDragStop()
   if frameThatsMoving ~= self then return end
   frameThatsMoving = nil
   self:StopMovingOrSizing()

   local uiScale = UIParent:GetEffectiveScale()
   local scale = self:GetEffectiveScale() / uiScale
   local x, y = self:GetCenter()
   x, y = x*scale, y*scale
   x = x - GetScreenWidth()/2
   y = y - GetScreenHeight()/2

   local unit = self.unitID
   Simple3DPortraits.db.profile[unit.."Xpos"] = x/self:GetScale()
   Simple3DPortraits.db.profile[unit.."Ypos"] = y/self:GetScale()

   LibStub("AceConfigRegistry-3.0"):NotifyChange("Simple3DPortraits")
   Simple3DPortraits:Refresh()
end

function S3DFrameScripts:OnMouseUp(button)
   if button == "LeftButton" then
      return S3DFrameScripts.OnDragStop(self)
   end
end

function S3DFrameScripts:OnShow()
   self.model:SetCamera(0)
end

function S3DFrameScripts:OnEnter()
   if InCombatLockdown() then return end
   local unit = self.unitID
   GameTooltip_SetDefaultAnchor(GameTooltip, self)
   GameTooltip:SetUnit(unit)
   local r, g, b = GameTooltip_UnitColor(unit)
   GameTooltipTextLeft1:SetTextColor(r, g, b)
   GameTooltip:Show()
end

function S3DFrameScripts:OnLeave()
   GameTooltip:Hide()
end

function Simple3DPortraits:CreatePortrait(name, parent, unit, isSecure)
   local frameDimension = 128
   local secStr = "SecureUnitButtonTemplate"
   local fr, mod, ovl, ovlt, vis = "Frame", "Model", "Overlay", "OverlayTex", "Visible"
   if not isSecure then
      secStr = nil
   end
   local db = Simple3DPortraits.db.profile
   
   local frame = CreateFrame("Button",
			     name..fr,
			     parent,
			     secStr)
   frame:SetMovable(true)
   frame:SetResizable(true)
   frame:SetMinResize(20, 20)

   local fstrata, flevel = db[unit.."FrStrata"], db[unit.."FrLevel"]
   if fstrata then
      frame:SetFrameStrata(fstrata)
   end
   if flevel then
      frame:SetFrameLevel(flevel)
   end
   
   frame.visible = frame:CreateTexture(name..vis, "BACKGROUND")
   frame.visible:SetAllPoints()
   frame.model = CreateFrame("PlayerModel",
			     name..mod,
			     frame)
   frame.model:SetAllPoints()
   frame.model:EnableMouse(false)
   frame.overlay = CreateFrame("Button",
			       name..ovl,
			       frame)
   frame.overlay:RegisterForDrag("LeftButton")
   frame.overlay:SetFrameLevel(frame:GetFrameLevel()+1)
   frame.overlay:SetWidth(20)
   frame.overlay:SetHeight(20)
   frame.overlay:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 4.5, -4.5)
   frame.overlayTex = frame.overlay:CreateTexture(name..ovlt, "OVERLAY")
   frame.overlayTex:SetAllPoints()
   frame.overlayTex:SetTexture("Interface\\AchievementFrame\\UI-Achievement-MetalBorder-joint")
   frame:Hide()
   frame:RegisterForDrag("LeftButton")
   if isSecure then
      frame:RegisterForClicks("AnyUp")
      frame:SetAttribute("type1", "target")
      frame:SetAttribute("unit", unit)
      frame:SetAttribute("toggleForVehicle", "true")
   end
   frame.unitID = unit
   local isClamped = db.isClamped
   local show = db.show
   local lock = db.lockMovement
   if lock or not show then
      frame.visible:SetTexture(0, 0, 0, 0)
      frame.overlay:Hide()
   else
      frame.visible:SetTexture(0.5, 0.55, 0.55, 0.3)
      frame.overlay:Show()
   end
   if isClamped then
      frame:SetClampedToScreen(true)
   else
      frame:SetClampedToScreen(false)
   end
   local hide = db[unit.."Hide"]
   Simple3DPortraits:RefreshModel(frame, hide)
   if show and lock and isSecure and not hide then 
      RegisterUnitWatch(frame)
      frame.isRegisteredForWatch = true
   elseif hide or not show then
      frame:Hide()
   else
      frame:Show()
   end
   
   for key, val in pairs(S3DFrameScripts) do
      if isSecure then
	 frame:HookScript(key, val)
      else
	 frame:SetScript(key, val)
      end
   end
   
   for key, val in pairs(S3DMoverScripts) do
      frame.overlay:SetScript(key, val)
   end
   
   local xpos, ypos = db[unit.."Xpos"], db[unit.."Ypos"]
   local xsize, ysize = db[unit.."Xsize"], db[unit.."Ysize"]
   local anchor
	  if unit == "player" then
		anchor = PlayerFrame
		xpos = 0
		ypos = 0
		
	elseif unit == "target" then
		anchor = TargetFrame
		xpos = 0
		ypos = 0
		end
   frame:SetPoint("CENTER", anchor, "CENTER", xpos, ypos)
   	  frame:SetWidth(xsize)
	  frame:SetHeight(ysize)
   --frame.overlay:SetSize(xsize+15.5, ysize+15.5)

   return frame
end

function Simple3DPortraits:RefreshModel(frame, hide)
   local unit = frame.unitID
   if UnitExists(unit) and not hide then
      frame.model:SetUnit(unit)
   else
      frame.model:ClearModel()
   end
   frame.model:SetCamera(0)
end