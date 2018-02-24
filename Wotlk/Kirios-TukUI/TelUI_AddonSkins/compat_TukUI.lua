--[[
	Compatibility layer for TukUI v10 and v11
	
	Provides the base implementation of Mod_AddonSkins, Skin, Layout, and TelUI.config needed to
	support skinning inside of the TukUI environment. There is no OOP or memory management
	available.
	
	*TukUI Edit Authors*
	These skins can be easily hooked by defining methods in the CustomSkin object. There are several
	base functions defined by this file, and each skin has its own functions which can be hooked. Please
	check the headers of each file for a list and description of what methods can be customized. An example of overriding
	a skin would be as follows:
	
	function CustomSkin:SkinBackgroundFrame(frame)
		self:SkinFrame(frame)
		TukuiDB.CreateShadow(frame)
	end
	
	Here we're modifying the :SkinBackground() method to add shadows. Note that self is a reference to the skin object,
	which means you can call any of the other skinning functions from it. The above block of code may be placed anywhere
	in your own addon or code, so long as it is executed before the PLAYER_LOGIN event fires. To remove a skin customization,
	simply dereference the function like so:
	
	CustomSkin.SkinBackgroundFrame = nil
	
	This will cause the skins to fall back to the default skinning function. *PLEASE NOTE* All skinning functions must be able
	to handle being called with the same arguments many times. This means that Adding shadows or highlights must be able to
	check if they've already created and attached a shadow, to prevent memory leaks. Some of these functions are called many
	times a second with the same frame! Due to the way that these skins are implemented with TukUI, both SKIN functions and
	LAYOUT functions are customized through CustomSkin.
	
	Availble SKIN methods:
	
	:SkinFrame(frame) -- Applies a basic skin to the frame "frame". This method will be called to skin any frames created or managed
	by the skins, including frames that are stacked on top of one another.
	
	:SkinBackgroundFrame(frame) -- Similar to :SkinFrame(frame), this method only handles frames which are directly above the WorldFrame,
	or which are the base of a UI element. This is where you want to apply your shadows and such.
	
	:SkinButton(button) -- This method will skin a button, including icon, to fit within the skin.	
	
	File version v51.54
	(C)2010 Darth Android / Telroth-The Venture Co.
]]

-- Don't run if TelUI is loaded, or TukUI isn't.
if IsAddOnLoaded("TelUI") or Mod_AddonSkins or not IsAddOnLoaded("Tukui") or not TukuiDB then return end

local TukVer = tonumber(TukuiDB.version)

Mod_AddonSkins = CreateFrame("Frame")
local Mod_AddonSkins = Mod_AddonSkins

local function skinButton(self, button)
	self:SkinFrame(self, button)
	-- Crazy hacks which only work because self = Skin *AND* self = config
	local name = button:GetName()
	local icon = _G[name.."Icon"]
	if icon then
		icon:SetTexCoord(unpack(self.buttonZoom))
		icon:SetDrawLayer("ARTWORK")
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT",button,"TOPLEFT",self.borderWidth, -self.borderWidth)
		icon:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-self.borderWidth, self.borderWidth)
	end
end
Mod_AddonSkins.SkinFrame = function(self, frame)
	-- To cope with V10 -> V11 changes, all functions which take 1 argument have the argument simply duplicated.
	TukuiDB.SetTemplate(frame,frame)
end
-- Support for shadows from authors that have a CreateShadow() method defined. This can cause issues if the author's function
-- can't handle being called multiple times on the same frame.
if TukuiDB.CreateShadow then
	Mod_AddonSkins.SkinBackgroundFrame = function(self, frame)
		self:SkinFrame(frame)
		--TukuiDB.CreateShadow(frame,frame)
	end
else
	Mod_AddonSkins.SkinBackgroundFrame = Mod_AddonSkins.SkinFrame
end
Mod_AddonSkins.SkinButton = skinButton
if TukuiCF then
	Mod_AddonSkins.normTexture = TukuiCF.media.normTex
	Mod_AddonSkins.bgTexture = TukuiCF.media.blank
	Mod_AddonSkins.font = TukuiCF.media.font
	Mod_AddonSkins.smallFont = TukuiCF.media.font
else
	Mod_AddonSkins.normTexture = TukuiDB.media.normTex
	Mod_AddonSkins.bgTexture = TukuiDB.media.blank
	Mod_AddonSkins.font = TukuiDB.media.font
	Mod_AddonSkins.smallFont = TukuiDB.media.font
end
Mod_AddonSkins.fontSize = 17
Mod_AddonSkins.buttonSize = TukuiDB.Scale(27,27)
Mod_AddonSkins.buttonSpacing = TukuiDB.Scale(4,4)
Mod_AddonSkins.borderWidth = TukuiDB.Scale(2,2)
Mod_AddonSkins.buttonZoom = {.09,.91,.09,.91}
Mod_AddonSkins.barSpacing = TukuiDB.Scale(1,1)
Mod_AddonSkins.barHeight = TukuiDB.Scale(20,20)
Mod_AddonSkins.skins = {}
Mod_AddonSkins.__index = Mod_AddonSkins

-- TukUI-Specific Integration Support

local CustomSkin = setmetatable({},Mod_AddonSkins)

-- Custom SexyCooldown positioning. This is used to lock the bars into place above the action bar or over either info bar.
-- To achieve this, the user must name their bar either "actionbar", "infoleft", or "inforight" depending on where they want
-- the bar anchored.
function CustomSkin:PositionSexyCooldownBar(bar)
	if bar.settings.bar.name == "actionbar" then
		self:SCDStripLayoutSettings(bar)
		bar.settings.bar.inactiveAlpha = 1
		bar:SetHeight(self.buttonSize)
		bar:SetWidth(TukuiActionBarBackground:GetWidth() - 2 * self.buttonSpacing)
		bar:SetPoint("TOPLEFT",TukuiActionBarBackground,"TOPLEFT",self.buttonSpacing,-self.buttonSpacing)
		bar:SetPoint("TOPRIGHT",TukuiActionBarBackground,"TOPRIGHT",-self.buttonSpacing,-self.buttonSpacing)
		if not TukuiActionBarBackground.resized then
			TukuiActionBarBackground:SetHeight(TukuiActionBarBackground:GetHeight() + self.buttonSize + self.buttonSpacing)
			TukuiActionBarBackground.resized = true
		end
	elseif bar.settings.bar.name == "infoleft" then
		self:SCDStripLayoutSettings(bar)
		bar.settings.bar.inactiveAlpha = 0
		bar:SetAllPoints(TukuiInfoLeft)
	elseif bar.settings.bar.name == "inforight" then
		self:SCDStripLayoutSettings(bar)
		bar.settings.bar.inactiveAlpha = 0
		bar:SetAllPoints(TukuiInfoRight)
	end
end

-- Dummy function expected by some skins
function dummy() end


function Mod_AddonSkins:RegisterSkin(name, initFunc)
	self = Mod_AddonSkins -- Static function
	if type(initFunc) ~= "function" then error("initFunc must be a function!",2) end
	self.skins[name] = initFunc
	if name == "LibSharedMedia" then -- Load LibSharedMedia early.
		initFunc(self, CustomSkin, self, CustomSkin, self)
		self.skins[name] = nil
	end
end

Mod_AddonSkins:RegisterEvent("PLAYER_LOGIN")
Mod_AddonSkins:SetScript("OnEvent",function(self)
	self:UnregisterEvent("PLAYER_LOGIN")
	self:SetScript("OnEvent",nil)
	-- Initialize all skins
	for name, func in pairs(self.skins) do
		func(self,CustomSkin,self,CustomSkin,self) -- Mod_AddonSkins functions as skin, layout, and config.
	end
end)
