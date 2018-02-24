local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

local GetTime = _G.GetTime

local localeSpecificFonts = {
	["zhCN"] = "Fonts\\ZYKai_T.TTF",
	["zhTW"] = "Fonts\\bLEI00D.TTF",
}


local function CreateFrameLayers(f)
	-- main frame
	f:SetFrameStrata("HIGH")
	f:SetFrameLevel(1)
	f:ClearAllPoints()
	f:SetWidth(f.settings.pulse.size) 
	f:SetHeight(f.settings.pulse.size)
	f:SetPoint(f.settings.pulse.point, UIParent, f.settings.pulse.relativePoint, f.settings.pulse.x, f.settings.pulse.y)
	f:SetAlpha(0.0)
	f:Show()
	
	-- highlight
	f.highlight = CreateFrame("Frame", nil, f)
	f.highlight:SetFrameStrata("HIGH")
	f.highlight:SetFrameLevel(2)
	f.highlight:ClearAllPoints()
	f.highlight:SetPoint("CENTER", f, "CENTER")
	f.highlight:SetWidth(f.settings.pulse.size)
	f.highlight:SetHeight(f.settings.pulse.size)
	
	f.highlight.texture = f:CreateTexture()
	f.highlight.texture:SetAllPoints(f)
	f.highlight.texture:SetTexture(0.5,0,0,1)
	f.highlight.texture:SetAlpha(0.5)

	f.highlight:SetBackdrop(
		{ bgFile = f.highlight.texture,
		  edgeFile = "", tile = false, tileSize = 0, edgeSize = 0, 
		  insets = { left = 0, right = 0, top = 0, bottom = 0 }
		} )
	
	f.highlight:Hide()
	f.highlight.texture:Show()

	-- text background
	f.textBack = CreateFrame("Frame", nil, f)
	f.textBack:SetFrameStrata("HIGH")
	f.textBack:SetFrameLevel(3)
	f.textBack:ClearAllPoints()
	f.textBack:SetPoint("CENTER", f, "CENTER")
	f.textBack:SetWidth(f.settings.pulse.size * 0.85)
	f.textBack:SetHeight(14 + ( ( 18 * f.settings.pulse.size ) / 256 ) * f.settings.pulse.fontScale )
	
	f.textBack.texture = f:CreateTexture()
	f.textBack.texture:SetAllPoints(f.textBack)
	f.textBack.texture:SetTexture(0, 0, 0, 1)
	f.textBack.texture:SetAlpha(0.90)

	f.textBack:SetBackdrop(
		{ bgFile = f.textBack.texture,
		  edgeFile = "", tile = false, tileSize = 0, edgeSize = 0, 
		  insets = { left = 0, right = 0, top = 0, bottom = 0 }
		} )
	
	f.textBack:Show()
	f.textBack.texture:Show()

	-- message text
	f.typeFace = "Fonts\\ARIALN.TTF"								-- default
	f.anchorText = f:CreateFontString(nil, "OVERLAY")
	f.anchorText:SetFont(f.typeFace, ( ( 18 * f.settings.pulse.size ) / 256 ) * f.settings.pulse.fontScale )
	f.anchorText:ClearAllPoints()
	f.anchorText:SetTextColor(1, 1, 1, 1)
	f.anchorText:SetPoint("CENTER", f, "CENTER")
	f.anchorText:SetWidth(f:GetWidth() * 0.85)
	f.anchorText:SetHeight(f:GetHeight())
	f.anchorText:SetJustifyH("CENTER")
	f.anchorText:SetJustifyV("MIDDLE")
	f.anchorText:SetParent(f)
	f.anchorText:SetText("")
	f.anchorText:SetAlpha(1.0)
	f.anchorText:Show()

	-- overlay
	f.overlayImage = CreateFrame("Frame", nil)
	f.overlayImage:SetFrameStrata("HIGH")
	f.overlayImage:SetFrameLevel(5)
	f.overlayImage:ClearAllPoints()
	f.overlayImage:SetPoint("CENTER", f, "CENTER")
	f.overlayImage:SetWidth(f.settings.pulse.size * f.settings.overlay.scale)
	f.overlayImage:SetHeight(f.settings.pulse.size * f.settings.overlay.scale)
	f.overlayImage:SetAlpha(0)
	
	f.overlayImage:SetBackdrop(
		{ bgFile = "Interface\\AddOns\\GhostPulse\\textures\\"..f.settings.overlay.texture,
		  edgeFile = "", tile = false, tileSize = 0, edgeSize = 0, 
		  insets = { left = 0, right = 0, top = 0, bottom = 0 }
		} )

	f.overlayImage:Show()
end

local function CreateVisualFunctions(f)
	f.Disable = function(this)
		this.enabled = false
		this:SetScript("OnUpdate", nil)
		this:SetScript("OnEvent", nil)
		this:SetScript("OnDragStart", nil)
		this:SetScript("OnDragStop", nil)
		this:FadeOut()
		this:SetLocked(true)
	end
	
	f.SetFont = function(this, font)
		f.typeFace = font
		this.anchorText:SetFont(font, ( ( 18 * this.settings.pulse.size ) / 256 ) * f.settings.pulse.fontScale )
	end
	
	f.SetSize = function(this, size)
		this.settings.pulse.size = size
		
		this:SetWidth(size)
		this:SetHeight(size)
		
		this.textBack:SetWidth(size * 0.85)
		this.textBack:SetHeight(14 + ( ( 18 * size ) / 256 ) * f.settings.pulse.fontScale )

		this.anchorText:SetFont(f.typeFace, ( ( 18 * size ) / 256 ) * f.settings.pulse.fontScale )
		this.anchorText:SetWidth(this.textBack:GetWidth())
		
		this.overlayImage:SetWidth(this.settings.pulse.size * this.settings.overlay.scale)
		this.overlayImage:SetHeight(this.settings.pulse.size * this.settings.overlay.scale)
	end
	
	f.SetTexture = function(this, texture)
		this:SetBackdrop(
		{ bgFile = texture,
		  edgeFile = "",
		  tile = false,
		  tileSize = 0,
		  edgeSize = 0, 
		  insets = { left = 0, right = 0, top = 0, bottom = 0 }
		} )		
	end

	f.SetLocked = function(this, value)
		local canDrag = not value
		
		
		this.locked = value
		
		this:EnableMouse(canDrag)
		this:SetMovable(canDrag)
		this.isMoving = false
		this.canMove = canDrag
		
		if canDrag and this.settings.unlockedTexture then
			this:SetTexture(this.settings.unlockedTexture)
			this.highlight:Hide()
			this.highlight.texture:Hide()
			this.textBack:Show()
			this.textBack.texture:Show()
			this.anchorText:Show()
			this.anchorText:SetText(this.pulseName)	
			this.overlayImage:SetAlpha(1)	    
			this:SetAlpha(1)
		else
			this.overlayImage:SetAlpha(0)	    
			this:SetAlpha(0)			
		end
	end
	
	f:SetScript("OnDragStart", function(this)
		if this.canMove then
			this:StartMoving()
			this.isMoving = true
		end
	end)
		
	f:SetScript("OnDragStop", function(this)
		this:StopMovingOrSizing()
		this.isMoving = false
		
		if this.OnFrameMoved and type(this.OnFrameMoved) == "function" then
			this:OnFrameMoved()
		end
	end)

	f:RegisterForDrag("LeftButton")
end

local function CreatePulseFunctions(f)
	f:SetScript("OnUpdate", function(this)
		local fadeIt = false
		
		
		if this.shown == true and this.locked == true and this.nextFadeTime ~= nil and this.settings.pulse.autoFade == true then
			if GetTime() >= this.nextFadeTime then
				fadeIt = true
			end
		end
		
		if fadeIt then
			this:FadeOut()
			this.nextFadeTime = nil
		end
	end)
	
	f.FadeOut = function(this)
		if this.shown == true then
			UIFrameFadeIn(this, this.settings.pulse.fadeOutTime, this.settings.pulse.alpha, 0.0)
			UIFrameFadeIn(this.overlayImage, this.settings.pulse.fadeOutTime, f.settings.overlay.alpha, 0.0)
			this.lastShownAlertType = nil
			this.shown = false
		end
	end

	f.Pulse = function(this, texture, message, sound, forceSound, r, g, b)
		if this.locked == true and texture ~= nil then
			if this.settings.pulse.autoFade == true or ( this.settings.pulse.autoFade == false and this.shown == false ) then
				-- fade out the existing displayed
				-- frame if the time is right
				if this.settings.pulse.autoFade == true and this.nextFadeTime ~= nil and GetTime() >= this.nextFadeTime then
					this:FadeOut()
				end
				
				-- set up ready for the new pulse
				this.highlight.texture:SetTexture(r, g, b, 0.75)
				this.highlight.texture:SetAlpha(0.75)									

				if r == 0 and g == 0 and b == 0 then
					this.highlight:Hide()
					this.highlight.texture:Hide()
				else
					this.highlight:Show()
					this.highlight.texture:Show()
				end
								
				-- play a sound
				if this.PlaySound ~= nil and type(this.PlaySound) == "function" then
					local soundToPlay = sound
					
					
					if not forceSound and this.settings.overrideSound ~= nil and this.settings.overrideSound ~= "" and this.settings.overrideSound ~= L["None"] then
						soundToPlay = this.settings.overrideSound
					end
					
					this:PlaySound(soundToPlay)
				end
				
				-- set the texture
			    this:SetTexture(texture)		
				
				-- always set the text, even it's nothing
			    this.anchorText:SetText(message)
			    
			    if message == nil or message == "" or not this.settings.pulse.showText then
			    	this.textBack:Hide()
			    	this.textBack.texture:Hide()
			    	this.anchorText:Hide()
			    else
			    	this.textBack:Show()
			    	this.textBack.texture:Show()
			    	this.anchorText:Show()
			    end
			    
				-- fade the frame in and record the time we should hide it,
				-- so it will be faded out at the right time.
			    UIFrameFadeIn(this, this.settings.pulse.fadeInTime, 0.0, this.settings.pulse.alpha)
			    
			    if this.settings.overlay.texture then
				    this.overlayImage:ClearAllPoints()
					this.overlayImage:SetPoint("CENTER", this, "CENTER")
					this.overlayImage:SetWidth(this.settings.pulse.size * this.settings.overlay.scale)
					this.overlayImage:SetHeight(this.settings.pulse.size * this.settings.overlay.scale)

				    UIFrameFadeIn(this.overlayImage, this.settings.pulse.fadeInTime, 0.0, f.settings.overlay.alpha)
				end
				
				this.nextFadeTime = GetTime() + this.settings.pulse.fadeInTime + this.settings.pulse.holdTime
			    this.shown = true
			end
		end
	end
end

local function CanShowThing(thing, whitelist, blacklist)
	local rc = true
	
	
	if thing then
		if whitelist and table.isEmpty(whitelist) == false then
			rc = whitelist[thing]
		else
			if blacklist and blacklist[thing] then
				rc = false
			end
		end
	end

	return rc
end

Pulse = {

	--[[
		The options should be specified according to this structure...
		
		unlockedTexture						The texture to display when the pulse is unlocked and draggable
		overrideSound						The sound to play instead of any supplied sound
		alertTypes							Table (string, boolean) of the alerts that this pulse is to show (default is all types)
		whitelist							Table (string, boolean) of the things that the pulse is restricted to showing (default empty)
		blacklist							Table (string, boolean) of the things that the pulse is not allowed to show (default empty)
		
		overlay.texture						The texture to 'skin' the pulse with
		overlay.scale						The scale (in fractional-percentage terms) of the 'skin' compared with the pulse itself
		overlay.alpha						The alpha level of the 'skin' texture
		
		pulse.autoFade						If true, the pulse will automatically disappear when needed, otherwise, it will have to be manually hidden using :FadeOut()

		pulse.alpha							The transparency of the pulse, once fully shown (default 0.4)
		pulse.showText						If true, text is placed on the pulse explaining the reason for the alert (default true)
		pulse.fontScale						The size of the font, as a percentage of 'normal' (default 1.0)
		pulse.fadeInTime					The time it takes for the pulse to become visible when being shown (default 0.25 seconds)
		pulse.fadeOutTime					The time it takes for the pulse to disappear when being hidden (default 0.75 seconds)
		pulse.holdTime						The time that the pulse remains visible when being shown (default 0.5 seconds)
		pulse.x								Initial horizontal position of the pulse (default 0)
		pulse.y								Initial vertical position of the pulse (default 0)
		pulse.point							The point on the pulse that is represented by .x and .y (default "CENTER")
		pulse.relativePoint					The relative point of UIParent (default "CENTER")
		pulse.size							The size of the pulse (8-256) (default 192)		
	]]
	
	pulses = { },
	
	New = function(this, name, frameSavePositionFunction, playSoundFunction, options)
		if this.pulses[name] == nil then
			if frameSavePositionFunction then
				if type(frameSavePositionFunction) ~= "function" then
					error("If supplied, the 'frameSavePositionFunction' must be a function")
				end
			end
			
			if playSoundFunction then
				if type(playSoundFunction) ~= "function" then
					error("If supplied, the 'playSoundFunction' must be a function")
				end
			end
	
	
			local f = CreateFrame("Frame", nil, UIParent)
		
			
			f.settings = options or Pulse.CreateDefaultOptions()
			f.OnFrameMoved = frameSavePositionFunction
			f.PlaySound = playSoundFunction
			
			f.pulseName = name
			f.locked = true
			f.shown = false
			f.nextFadeTime = nil
			f.enabled = true
			
			CreateFrameLayers(f)
			CreateVisualFunctions(f)
			CreatePulseFunctions(f)

			-- font			
			if localeSpecificFonts[GetLocale()] then
				f:SetFont(localeSpecificFonts[GetLocale()])
			end
		
			-- remember the pulse frame
			this.pulses[name] = f
		else
			f = this.pulses[name]
		end
				
		return f
	end,
	
	-- static class functions (these run on ALL created pulses)
	SetLocked = function(this, value)
		for _, f in pairs(this.pulses) do
			if value == true or f.enabled then
				f:SetLocked(value)
			end
		end
	end,
	
	Disable = function(this, name)
		if this.pulses[name] then
			this.pulses[name]:Disable() 
		end
	end,
	
	Release = function(this, alertType)
		for _, f in pairs(this.pulses) do
			if f.enabled then
				if f.lastShownAlertType == alertType then
					f.settings.pulse.autoFade = true
				end
			end
		end
	end,
	
	Alert = function(this, alertType, nameOfThing, texture, message, sound, forceSound, r, g, b, holdFrame)
		for _, f in pairs(this.pulses) do
			if f.enabled then
				-- check if this pulse can show this type of alert
				if f.settings.alertTypes[alertType] then
					-- check that this pulse can show the 'nameOfThing'
					if CanShowThing(nameOfThing, f.settings.whitelist, f.settings.blacklist) then
						if f.settings.pulse.autoFade == true then
							f.lastShownAlertType = alertType
							f.settings.pulse.autoFade = not holdFrame
							f:Pulse(texture, message, sound, forceSound, r, g, b)
						end
					end
				end
			end
		end
	end,
	
	GetFrame = function(this, pulseName)
		return this.pulses[pulseName]
	end,
	
	CreateDefaultOptions = function()
		local rc = {
			unlockedTexture = "Interface\\Icons\\Spell_Nature_ElementalPrecision_1",
			overrideSound = "",
			whitelist = { },
			blacklist = { },
			
			alertTypes = {
			},
	
			overlay = {
				texture = "",
				scale = 0.875,
				alpha = 0.4,
			},
			
			pulse = {
				alpha = 0.4,
				fontScale = 1.0,
				fadeInTime = 0.25,
				fadeOutTime = 0.75,
				holdTime = 0.5,
				showText = true,
				autoFade = true,
				x = 0,
				y = 0,
				point = "CENTER",
				relativePoint = "CENTER",
				size = 192,
			},
		}
		
		return rc
	end
}
