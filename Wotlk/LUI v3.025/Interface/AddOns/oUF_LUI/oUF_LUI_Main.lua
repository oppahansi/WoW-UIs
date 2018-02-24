------------------------------------------------------------------------
--	oUF LUI Layout
--	Version 2.0
-- 	Date: 06/05/2010
--	DO NOT USE THIS LAYOUT WITHOUT LUI
------------------------------------------------------------------------

local LSM = LibStub("LibSharedMedia-3.0")
LUI = LibStub("AceAddon-3.0"):GetAddon("LUI")
db = LUI.db.profile

if db == nil then return end
if db.oUF.Settings.Enable ~= true then return end

LUI = {oUF = {
scale = 1, 										-- scale of the unitframes (dont edit this or pixel perfect is gone)
lowThreshold = 0, 								-- low mana threshold for all mana classes
highThreshold = 0, 								-- high mana treshold for hunters
highlight = true,								-- MouseOver Highlight?

--font = [=[Interface\Addons\oUF_LUI\media\fonts\Sansation_Bold.ttf]=],
font = [=[Interface\Addons\SharedMedia_MyMedia\font\vibrocen.ttf]=],

coords = {
	playerX = tonumber(db.oUF.Player.X),
	playerY = tonumber(db.oUF.Player.Y), 

	targetX = tonumber(db.oUF.Target.X), 
	targetY = tonumber(db.oUF.Target.Y), 
	
	totX = tonumber(db.oUF.ToT.X),
	totY = tonumber(db.oUF.ToT.Y),
	
	petX = tonumber(db.oUF.Pet.X),
	petY = tonumber(db.oUF.Pet.Y),
	
	focusX = tonumber(db.oUF.Focus.X),
	focusY = tonumber(db.oUF.Focus.Y),
	
	foctarX = tonumber(db.oUF.FocusTarget.X),
	foctarY = tonumber(db.oUF.FocusTarget.Y),
	
	tototX = tonumber(db.oUF.ToToT.X),
	tototY = tonumber(db.oUF.ToToT.Y),
	
	pettarX = tonumber(db.oUF.PetTarget.X),
	pettarY = tonumber(db.oUF.PetTarget.Y),
	
	bossX = tonumber(db.oUF.Boss.X),
	bossY = tonumber(db.oUF.Boss.Y),
}}}

-- extra options
showrange = false						-- show range on raid unit
showthreat = false						-- show target threat via tpanels left info bar
local ouf_lowmana = "Low Mana"

------------------------------------------------------------------------
--	Textures and Medias
------------------------------------------------------------------------

local settings = LUI.oUF
local mediaPath = [=[Interface\Addons\oUF_LUI\media\]=]

local floor = math.floor
local format = string.format
local sort = math.floor

local normTex = mediaPath..[=[textures\normTex]=]
local glowTex = mediaPath..[=[textures\glowTex]=]
local bubbleTex = mediaPath..[=[textures\bubbleTex]=]
local buttonTex = mediaPath..[=[textures\buttonTex]=]
local highlightTex = mediaPath..[=[textures\highlightTex]=]
local borderTex = mediaPath..[=[textures\border]=]
local blankTex = mediaPath..[=[textures\blank]=]

local backdrop = {
	bgFile = blankTex,
	insets = {top = -1, left = -1, bottom = -1, right = -1},
}

local backdrop2 = {
	bgFile = blankTex,
	edgeFile = blankTex, 
	tile = false, tileSize = 0, edgeSize = 1, 
	insets = {top = -1, left = -1, bottom = -1, right = -1},
}

local font = settings.font
local fontn = mediaPath..[=[fonts\KhmerUI.ttf]=]
local font2 = [=[Fonts\ARIALN.ttf]=]
local font3 = [=[Interface\Addons\SharedMedia_MyMedia\font\Prototype.ttf]=]
local _, class = UnitClass("player")

local lowThreshold = settings.lowThreshold
local highThreshold = settings.highThreshold
local highlight = settings.highlight

------------------------------------------------------------------------
--	Colors
------------------------------------------------------------------------

local colors = setmetatable({
	power = setmetatable({
		["MANA"] = {tonumber(db.oUF.Colors.Power.Mana.r), tonumber(db.oUF.Colors.Power.Mana.g), tonumber(db.oUF.Colors.Power.Mana.b)},
		["RAGE"] = {tonumber(db.oUF.Colors.Power.Rage.r), tonumber(db.oUF.Colors.Power.Rage.g), tonumber(db.oUF.Colors.Power.Rage.b)},
		["FOCUS"] = {tonumber(db.oUF.Colors.Power.Focus.r), tonumber(db.oUF.Colors.Power.Focus.g), tonumber(db.oUF.Colors.Power.Focus.b)},
		["ENERGY"] = {tonumber(db.oUF.Colors.Power.Energy.r), tonumber(db.oUF.Colors.Power.Energy.g), tonumber(db.oUF.Colors.Power.Energy.b)},
		["RUNES"] = {tonumber(db.oUF.Colors.Power.Runes.r), tonumber(db.oUF.Colors.Power.Runes.g), tonumber(db.oUF.Colors.Power.Runes.b)},
		["RUNIC_POWER"] = {tonumber(db.oUF.Colors.Power.RunicPower.r), tonumber(db.oUF.Colors.Power.RunicPower.g), tonumber(db.oUF.Colors.Power.RunicPower.b)},
		["AMMOSLOT"] = {tonumber(db.oUF.Colors.Power.AmmoSlot.r), tonumber(db.oUF.Colors.Power.AmmoSlot.g), tonumber(db.oUF.Colors.Power.AmmoSlot.b)},
		["FUEL"] = {tonumber(db.oUF.Colors.Power.Fuel.r), tonumber(db.oUF.Colors.Power.Fuel.g), tonumber(db.oUF.Colors.Power.Fuel.b)},
		["POWER_TYPE_STEAM"] = {0.55, 0.57, 0.61},
		["POWER_TYPE_PYRITE"] = {0.60, 0.09, 0.17},
	}, {__index = oUF.colors.power}),
	class = setmetatable({
		["WARRIOR"] = {tonumber(db.oUF.Colors.Class.Warrior.r), tonumber(db.oUF.Colors.Class.Warrior.g), tonumber(db.oUF.Colors.Class.Warrior.b)},
		["PRIEST"] = {tonumber(db.oUF.Colors.Class.Priest.r), tonumber(db.oUF.Colors.Class.Priest.g), tonumber(db.oUF.Colors.Class.Priest.b)},
		["DRUID"] = {tonumber(db.oUF.Colors.Class.Druid.r), tonumber(db.oUF.Colors.Class.Druid.g), tonumber(db.oUF.Colors.Class.Druid.b)},
		["HUNTER"] = {tonumber(db.oUF.Colors.Class.Hunter.r), tonumber(db.oUF.Colors.Class.Hunter.g), tonumber(db.oUF.Colors.Class.Hunter.b)},
		["MAGE"] = {tonumber(db.oUF.Colors.Class.Mage.r), tonumber(db.oUF.Colors.Class.Mage.g), tonumber(db.oUF.Colors.Class.Mage.b)},
		["PALADIN"] = {tonumber(db.oUF.Colors.Class.Paladin.r), tonumber(db.oUF.Colors.Class.Paladin.g), tonumber(db.oUF.Colors.Class.Paladin.b)},
		["SHAMAN"] = {tonumber(db.oUF.Colors.Class.Shaman.r), tonumber(db.oUF.Colors.Class.Shaman.g), tonumber(db.oUF.Colors.Class.Shaman.b)},
		["WARLOCK"] = {tonumber(db.oUF.Colors.Class.Warlock.r), tonumber(db.oUF.Colors.Class.Warlock.g), tonumber(db.oUF.Colors.Class.Warlock.b)},
		["ROGUE"] = {tonumber(db.oUF.Colors.Class.Rogue.r), tonumber(db.oUF.Colors.Class.Rogue.g), tonumber(db.oUF.Colors.Class.Rogue.b)},
		["DEATH KNIGHT"] = {tonumber(db.oUF.Colors.Class.DeathKnight.r), tonumber(db.oUF.Colors.Class.DeathKnight.g), tonumber(db.oUF.Colors.Class.DeathKnight.b)},
	}, {__index = oUF.colors.class}),
	happiness = setmetatable({
		[1] = {tonumber(db.oUF.Colors.Happiness.Happiness1.r), tonumber(db.oUF.Colors.Happiness.Happiness1.g), tonumber(db.oUF.Colors.Happiness.Happiness1.b)},
		[2] = {tonumber(db.oUF.Colors.Happiness.Happiness2.r), tonumber(db.oUF.Colors.Happiness.Happiness2.g), tonumber(db.oUF.Colors.Happiness.Happiness2.b)},
		[3] = {tonumber(db.oUF.Colors.Happiness.Happiness3.r), tonumber(db.oUF.Colors.Happiness.Happiness3.g), tonumber(db.oUF.Colors.Happiness.Happiness3.b)},
	}, {__index = oUF.colors.happiness}),
	runes = setmetatable({
		[1] = {tonumber(db.oUF.Colors.Runes.Rune1.r), tonumber(db.oUF.Colors.Runes.Rune1.g), tonumber(db.oUF.Colors.Runes.Rune1.b)},
		[2] = {tonumber(db.oUF.Colors.Runes.Rune2.r), tonumber(db.oUF.Colors.Runes.Rune2.g), tonumber(db.oUF.Colors.Runes.Rune2.b)},
		[3] = {tonumber(db.oUF.Colors.Runes.Rune3.r), tonumber(db.oUF.Colors.Runes.Rune3.g), tonumber(db.oUF.Colors.Runes.Rune3.b)},
		[4] = {tonumber(db.oUF.Colors.Runes.Rune4.r), tonumber(db.oUF.Colors.Runes.Rune4.g), tonumber(db.oUF.Colors.Runes.Rune4.b)},
	}, {__index = oUF.colors.runes}),
	totembar = setmetatable({
		[1] = {tonumber(db.oUF.Colors.Totems.Fire.r), tonumber(db.oUF.Colors.Totems.Fire.g), tonumber(db.oUF.Colors.Totems.Fire.b)},
		[2] = {tonumber(db.oUF.Colors.Totems.Earth.r), tonumber(db.oUF.Colors.Totems.Earth.g), tonumber(db.oUF.Colors.Totems.Earth.b)},		
		[3] = {tonumber(db.oUF.Colors.Totems.Water.r), tonumber(db.oUF.Colors.Totems.Water.g), tonumber(db.oUF.Colors.Totems.Water.b)},
		[4] = {tonumber(db.oUF.Colors.Totems.Air.r), tonumber(db.oUF.Colors.Totems.Air.g), tonumber(db.oUF.Colors.Totems.Air.b)},	
	}, {__index = oUF.colors.totembar}),
}, {__index = oUF.colors})

oUF.colors.LUI = {db.Theme.IndividualColor_r,db.Theme.IndividualColor_g,db.Theme.IndividualColor_b}
ColorsTapped = {tonumber(db.oUF.Colors.Tapped.r), tonumber(db.oUF.Colors.Tapped.g), tonumber(db.oUF.Colors.Tapped.b)}
oUF.colors.disconnected = {0.11,0.11,0.11}

oUF.colors.smooth = {tonumber(db.oUF.Colors.Smooth.Smooth1.r),tonumber(db.oUF.Colors.Smooth.Smooth1.g), tonumber(db.oUF.Colors.Smooth.Smooth1.b),tonumber(db.oUF.Colors.Smooth.Smooth2.r),tonumber(db.oUF.Colors.Smooth.Smooth2.g),tonumber(db.oUF.Colors.Smooth.Smooth2.b),tonumber(db.oUF.Colors.Smooth.Smooth3.r),tonumber(db.oUF.Colors.Smooth.Smooth3.g),tonumber(db.oUF.Colors.Smooth.Smooth3.b)}

local _, playerClass = UnitClass("player")

local runeloadcolors = {
	[1] = {tonumber(db.oUF.Colors.Runebar.Rune1.r),tonumber(db.oUF.Colors.Runebar.Rune1.g),tonumber(db.oUF.Colors.Runebar.Rune1.g)},
	[2] = {tonumber(db.oUF.Colors.Runebar.Rune2.r),tonumber(db.oUF.Colors.Runebar.Rune2.g),tonumber(db.oUF.Colors.Runebar.Rune2.g)},
	[3] = {tonumber(db.oUF.Colors.Runebar.Rune3.r),tonumber(db.oUF.Colors.Runebar.Rune3.g),tonumber(db.oUF.Colors.Runebar.Rune3.g)},
	[4] = {tonumber(db.oUF.Colors.Runebar.Rune4.r),tonumber(db.oUF.Colors.Runebar.Rune4.g),tonumber(db.oUF.Colors.Runebar.Rune4.g)},
	[5] = {tonumber(db.oUF.Colors.Runebar.Rune5.r),tonumber(db.oUF.Colors.Runebar.Rune5.g),tonumber(db.oUF.Colors.Runebar.Rune5.g)},
	[6] = {tonumber(db.oUF.Colors.Runebar.Rune6.r),tonumber(db.oUF.Colors.Runebar.Rune6.g),tonumber(db.oUF.Colors.Runebar.Rune6.g)},
}

local combopointcolors = {
	[1] = {tonumber(db.oUF.Colors.ComboPoints.Combo1.r),tonumber(db.oUF.Colors.ComboPoints.Combo1.g),tonumber(db.oUF.Colors.ComboPoints.Combo1.b)},
	[2] = {tonumber(db.oUF.Colors.ComboPoints.Combo2.r),tonumber(db.oUF.Colors.ComboPoints.Combo2.g),tonumber(db.oUF.Colors.ComboPoints.Combo2.b)},
	[3] = {tonumber(db.oUF.Colors.ComboPoints.Combo3.r),tonumber(db.oUF.Colors.ComboPoints.Combo3.g),tonumber(db.oUF.Colors.ComboPoints.Combo3.b)},
	[4] = {tonumber(db.oUF.Colors.ComboPoints.Combo4.r),tonumber(db.oUF.Colors.ComboPoints.Combo4.g),tonumber(db.oUF.Colors.ComboPoints.Combo4.b)},
	[5] = {tonumber(db.oUF.Colors.ComboPoints.Combo5.r),tonumber(db.oUF.Colors.ComboPoints.Combo5.g),tonumber(db.oUF.Colors.ComboPoints.Combo5.b)},
}

------------------------------------------------------------------------
--	Don't edit this if you don't know what you are doing!
------------------------------------------------------------------------

local SetUpAnimGroup = function(self)
	self.anim = self:CreateAnimationGroup("Flash")
	self.anim.fadein = self.anim:CreateAnimation("ALPHA", "FadeIn")
	self.anim.fadein:SetChange(1)
	self.anim.fadein:SetOrder(2)

	self.anim.fadeout = self.anim:CreateAnimation("ALPHA", "FadeOut")
	self.anim.fadeout:SetChange(-1)
	self.anim.fadeout:SetOrder(1)
end

local Flash = function(self, duration)
	if not self.anim then
		SetUpAnimGroup(self)
	end

	self.anim.fadein:SetDuration(duration)
	self.anim.fadeout:SetDuration(duration)
	self.anim:Play()
end

local StopFlash = function(self)
	if self.anim then
		self.anim:Finish()
	end
end

local UnitFrame_OnEnter = function(self)
	UnitFrame_OnEnter(self)
	if(highlight)then
	  self.Highlight:Show()	
  	end
end

local UnitFrame_OnLeave = function(self)
	UnitFrame_OnLeave(self)
	if(highlight)then
	  self.Highlight:Hide()	
  	end
end

local Menu = function(self)
	local unit = self.unit:gsub("(.)", string.upper, 1) 
	if _G[unit.."FrameDropDown"] then
		ToggleDropDownMenu(1, nil, _G[unit.."FrameDropDown"], "cursor")
	elseif (self.unit:match("party")) then
		ToggleDropDownMenu(1, nil, _G["PartyMemberFrame"..self.id.."DropDown"], "cursor")
	else
		FriendsDropDown.unit = self.unit
		FriendsDropDown.id = self.id
		FriendsDropDown.initialize = RaidFrameDropDown_Initialize
		ToggleDropDownMenu(1, nil, FriendsDropDown, "cursor")
	end
end

local SetFontString = function(parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH("LEFT")
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(1.25, -1.25)
	return fs
end

local ShortValue = function(value)
	if value >= 1e6 then
		return ("%.1fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e3 or value <= -1e3 then
		return ("%.1fk"):format(value / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return value
	end
end

local GetHealthOptions = function(self, unit)
	if((unit and unit:find("boss%d")) or (strsub(SecureButton_GetUnit(self), 0, 4) == "boss")) then
		Health_ColorClass = db.oUF.Boss.Health.ColorClass
		Health_IndividualColor = db.oUF.Boss.Health.IndividualColor.Enable
		Health_IndividualColor_r = db.oUF.Boss.Health.IndividualColor.r
		Health_IndividualColor_g = db.oUF.Boss.Health.IndividualColor.g
		Health_IndividualColor_b = db.oUF.Boss.Health.IndividualColor.b
		Health_ColorGradient = db.oUF.Boss.Health.ColorGradient
		
		Health_Value_Enable = db.oUF.Boss.Texts.Health.Enable
		Health_Value_Format = db.oUF.Boss.Texts.Health.Format
		Health_Value_ColorClass = db.oUF.Boss.Texts.Health.ColorClass
		Health_Value_ColorGradient = db.oUF.Boss.Texts.Health.ColorGradient
		Health_Value_IndividualColor_Enable = db.oUF.Boss.Texts.Health.IndividualColor.Enable
		Health_Value_IndividualColor_r = db.oUF.Boss.Texts.Health.IndividualColor.r
		Health_Value_IndividualColor_g = db.oUF.Boss.Texts.Health.IndividualColor.g
		Health_Value_IndividualColor_b = db.oUF.Boss.Texts.Health.IndividualColor.b
		Health_Value_ShowDead = db.oUF.Boss.Texts.Health.ShowDead
		
		Health_Percent_Enable = db.oUF.Boss.Texts.HealthPercent.Enable
		Health_Percent_ShowAlways = db.oUF.Boss.Texts.HealthPercent.ShowAlways
		Health_Percent_ColorClass = db.oUF.Boss.Texts.HealthPercent.ColorClass
		Health_Percent_ColorGradient = db.oUF.Boss.Texts.HealthPercent.ColorGradient
		Health_Percent_IndividualColor_Enable = db.oUF.Boss.Texts.HealthPercent.IndividualColor.Enable
		Health_Percent_IndividualColor_r = db.oUF.Boss.Texts.HealthPercent.IndividualColor.r
		Health_Percent_IndividualColor_g = db.oUF.Boss.Texts.HealthPercent.IndividualColor.g
		Health_Percent_IndividualColor_b = db.oUF.Boss.Texts.HealthPercent.IndividualColor.b
		Health_Percent_ShowDead = db.oUF.Boss.Texts.HealthPercent.ShowDead
		
		Health_Missing_Enable = db.oUF.Boss.Texts.HealthMissing.Enable
		Health_Missing_ShortValue = db.oUF.Boss.Texts.HealthMissing.ShortValue
		Health_Missing_ShowAlways = db.oUF.Boss.Texts.HealthMissing.ShowAlways
		Health_Missing_ColorClass = db.oUF.Boss.Texts.HealthMissing.ColorClass
		Health_Missing_ColorGradient = db.oUF.Boss.Texts.HealthMissing.ColorGradient
		Health_Missing_IndividualColor_Enable = db.oUF.Boss.Texts.HealthMissing.IndividualColor.Enable
		Health_Missing_IndividualColor_r = db.oUF.Boss.Texts.HealthMissing.IndividualColor.r
		Health_Missing_IndividualColor_g = db.oUF.Boss.Texts.HealthMissing.IndividualColor.g
		Health_Missing_IndividualColor_b = db.oUF.Boss.Texts.HealthMissing.IndividualColor.b
	elseif unit == "player" then
		if entering == true then
			Health_ColorClass = db.oUF.Pet.Health.ColorClass
			Health_IndividualColor = db.oUF.Pet.Health.IndividualColor.Enable
			Health_IndividualColor_r = db.oUF.Pet.Health.IndividualColor.r
			Health_IndividualColor_g = db.oUF.Pet.Health.IndividualColor.g
			Health_IndividualColor_b = db.oUF.Pet.Health.IndividualColor.b
			Health_ColorGradient = db.oUF.Pet.Health.ColorGradient
			Health_ColorHappy = db.oUF.Pet.Health.ColorHappy
			
			Health_Value_Enable = db.oUF.Pet.Texts.Health.Enable
			Health_Value_Format = db.oUF.Pet.Texts.Health.Format
			Health_Value_ColorClass = db.oUF.Pet.Texts.Health.ColorClass
			Health_Value_ColorGradient = db.oUF.Pet.Texts.Health.ColorGradient
			Health_Value_IndividualColor_Enable = db.oUF.Pet.Texts.Health.IndividualColor.Enable
			Health_Value_IndividualColor_r = db.oUF.Pet.Texts.Health.IndividualColor.r
			Health_Value_IndividualColor_g = db.oUF.Pet.Texts.Health.IndividualColor.g
			Health_Value_IndividualColor_b = db.oUF.Pet.Texts.Health.IndividualColor.b
			Health_Value_ShowDead = db.oUF.Pet.Texts.Health.ShowDead
			
			Health_Percent_Enable = db.oUF.Pet.Texts.HealthPercent.Enable
			Health_Percent_ShowAlways = db.oUF.Pet.Texts.HealthPercent.ShowAlways
			Health_Percent_ColorClass = db.oUF.Pet.Texts.HealthPercent.ColorClass
			Health_Percent_ColorGradient = db.oUF.Pet.Texts.HealthPercent.ColorGradient
			Health_Percent_IndividualColor_Enable = db.oUF.Pet.Texts.HealthPercent.IndividualColor.Enable
			Health_Percent_IndividualColor_r = db.oUF.Pet.Texts.HealthPercent.IndividualColor.r
			Health_Percent_IndividualColor_g = db.oUF.Pet.Texts.HealthPercent.IndividualColor.g
			Health_Percent_IndividualColor_b = db.oUF.Pet.Texts.HealthPercent.IndividualColor.b
			Health_Percent_ShowDead = db.oUF.Pet.Texts.HealthPercent.ShowDead
			
			Health_Missing_Enable = db.oUF.Pet.Texts.HealthMissing.Enable
			Health_Missing_ShortValue = db.oUF.Pet.Texts.HealthMissing.ShortValue
			Health_Missing_ShowAlways = db.oUF.Pet.Texts.HealthMissing.ShowAlways
			Health_Missing_ColorClass = db.oUF.Pet.Texts.HealthMissing.ColorClass
			Health_Missing_ColorGradient = db.oUF.Pet.Texts.HealthMissing.ColorGradient
			Health_Missing_IndividualColor_Enable = db.oUF.Pet.Texts.HealthMissing.IndividualColor.Enable
			Health_Missing_IndividualColor_r = db.oUF.Pet.Texts.HealthMissing.IndividualColor.r
			Health_Missing_IndividualColor_g = db.oUF.Pet.Texts.HealthMissing.IndividualColor.g
			Health_Missing_IndividualColor_b = db.oUF.Pet.Texts.HealthMissing.IndividualColor.b
		else
			Health_ColorClass = db.oUF.Player.Health.ColorClass
			Health_IndividualColor = db.oUF.Player.Health.IndividualColor.Enable
			Health_IndividualColor_r = db.oUF.Player.Health.IndividualColor.r
			Health_IndividualColor_g = db.oUF.Player.Health.IndividualColor.g
			Health_IndividualColor_b = db.oUF.Player.Health.IndividualColor.b
			Health_ColorGradient = db.oUF.Player.Health.ColorGradient
			
			Health_Value_Enable = db.oUF.Player.Texts.Health.Enable
			Health_Value_Format = db.oUF.Player.Texts.Health.Format
			Health_Value_ColorClass = db.oUF.Player.Texts.Health.ColorClass
			Health_Value_ColorGradient = db.oUF.Player.Texts.Health.ColorGradient
			Health_Value_IndividualColor_Enable = db.oUF.Player.Texts.Health.IndividualColor.Enable
			Health_Value_IndividualColor_r = db.oUF.Player.Texts.Health.IndividualColor.r
			Health_Value_IndividualColor_g = db.oUF.Player.Texts.Health.IndividualColor.g
			Health_Value_IndividualColor_b = db.oUF.Player.Texts.Health.IndividualColor.b
			Health_Value_ShowDead = db.oUF.Player.Texts.Health.ShowDead
			
			Health_Percent_Enable = db.oUF.Player.Texts.HealthPercent.Enable
			Health_Percent_ShowAlways = db.oUF.Player.Texts.HealthPercent.ShowAlways
			Health_Percent_ColorClass = db.oUF.Player.Texts.HealthPercent.ColorClass
			Health_Percent_ColorGradient = db.oUF.Player.Texts.HealthPercent.ColorGradient
			Health_Percent_IndividualColor_Enable = db.oUF.Player.Texts.HealthPercent.IndividualColor.Enable
			Health_Percent_IndividualColor_r = db.oUF.Player.Texts.HealthPercent.IndividualColor.r
			Health_Percent_IndividualColor_g = db.oUF.Player.Texts.HealthPercent.IndividualColor.g
			Health_Percent_IndividualColor_b = db.oUF.Player.Texts.HealthPercent.IndividualColor.b
			Health_Percent_ShowDead = db.oUF.Player.Texts.HealthPercent.ShowDead
			
			Health_Missing_Enable = db.oUF.Player.Texts.HealthMissing.Enable
			Health_Missing_ShortValue = db.oUF.Player.Texts.HealthMissing.ShortValue
			Health_Missing_ShowAlways = db.oUF.Player.Texts.HealthMissing.ShowAlways
			Health_Missing_ColorClass = db.oUF.Player.Texts.HealthMissing.ColorClass
			Health_Missing_ColorGradient = db.oUF.Player.Texts.HealthMissing.ColorGradient
			Health_Missing_IndividualColor_Enable = db.oUF.Player.Texts.HealthMissing.IndividualColor.Enable
			Health_Missing_IndividualColor_r = db.oUF.Player.Texts.HealthMissing.IndividualColor.r
			Health_Missing_IndividualColor_g = db.oUF.Player.Texts.HealthMissing.IndividualColor.g
			Health_Missing_IndividualColor_b = db.oUF.Player.Texts.HealthMissing.IndividualColor.b
		end
	elseif unit == "vehicle" then
		Health_ColorClass = db.oUF.Player.Health.ColorClass
		Health_IndividualColor = db.oUF.Player.Health.IndividualColor.Enable
		Health_IndividualColor_r = db.oUF.Player.Health.IndividualColor.r
		Health_IndividualColor_g = db.oUF.Player.Health.IndividualColor.g
		Health_IndividualColor_b = db.oUF.Player.Health.IndividualColor.b
		Health_ColorGradient = db.oUF.Player.Health.ColorGradient
		
		Health_Value_Enable = db.oUF.Player.Texts.Health.Enable
		Health_Value_Format = db.oUF.Player.Texts.Health.Format
		Health_Value_ColorClass = db.oUF.Player.Texts.Health.ColorClass
		Health_Value_ColorGradient = db.oUF.Player.Texts.Health.ColorGradient
		Health_Value_IndividualColor_Enable = db.oUF.Player.Texts.Health.IndividualColor.Enable
		Health_Value_IndividualColor_r = db.oUF.Player.Texts.Health.IndividualColor.r
		Health_Value_IndividualColor_g = db.oUF.Player.Texts.Health.IndividualColor.g
		Health_Value_IndividualColor_b = db.oUF.Player.Texts.Health.IndividualColor.b
		Health_Value_ShowDead = db.oUF.Player.Texts.Health.ShowDead
		
		Health_Percent_Enable = db.oUF.Player.Texts.HealthPercent.Enable
		Health_Percent_ShowAlways = db.oUF.Player.Texts.HealthPercent.ShowAlways
		Health_Percent_ColorClass = db.oUF.Player.Texts.HealthPercent.ColorClass
		Health_Percent_ColorGradient = db.oUF.Player.Texts.HealthPercent.ColorGradient
		Health_Percent_IndividualColor_Enable = db.oUF.Player.Texts.HealthPercent.IndividualColor.Enable
		Health_Percent_IndividualColor_r = db.oUF.Player.Texts.HealthPercent.IndividualColor.r
		Health_Percent_IndividualColor_g = db.oUF.Player.Texts.HealthPercent.IndividualColor.g
		Health_Percent_IndividualColor_b = db.oUF.Player.Texts.HealthPercent.IndividualColor.b
		Health_Percent_ShowDead = db.oUF.Player.Texts.HealthPercent.ShowDead
		
		Health_Missing_Enable = db.oUF.Player.Texts.HealthMissing.Enable
		Health_Missing_ShortValue = db.oUF.Player.Texts.HealthMissing.ShortValue
		Health_Missing_ShowAlways = db.oUF.Player.Texts.HealthMissing.ShowAlways
		Health_Missing_ColorClass = db.oUF.Player.Texts.HealthMissing.ColorClass
		Health_Missing_ColorGradient = db.oUF.Player.Texts.HealthMissing.ColorGradient
		Health_Missing_IndividualColor_Enable = db.oUF.Player.Texts.HealthMissing.IndividualColor.Enable
		Health_Missing_IndividualColor_r = db.oUF.Player.Texts.HealthMissing.IndividualColor.r
		Health_Missing_IndividualColor_g = db.oUF.Player.Texts.HealthMissing.IndividualColor.g
		Health_Missing_IndividualColor_b = db.oUF.Player.Texts.HealthMissing.IndividualColor.b
	elseif unit == "target" then
		Health_ColorClass = db.oUF.Target.Health.ColorClass
		Health_IndividualColor = db.oUF.Target.Health.IndividualColor.Enable
		Health_IndividualColor_r = db.oUF.Target.Health.IndividualColor.r
		Health_IndividualColor_g = db.oUF.Target.Health.IndividualColor.g
		Health_IndividualColor_b = db.oUF.Target.Health.IndividualColor.b
		Health_ColorGradient = db.oUF.Target.Health.ColorGradient
		
		Health_Value_Enable = db.oUF.Target.Texts.Health.Enable
		Health_Value_Format = db.oUF.Target.Texts.Health.Format
		Health_Value_ColorClass = db.oUF.Target.Texts.Health.ColorClass
		Health_Value_ColorGradient = db.oUF.Target.Texts.Health.ColorGradient
		Health_Value_IndividualColor_Enable = db.oUF.Target.Texts.Health.IndividualColor.Enable
		Health_Value_IndividualColor_r = db.oUF.Target.Texts.Health.IndividualColor.r
		Health_Value_IndividualColor_g = db.oUF.Target.Texts.Health.IndividualColor.g
		Health_Value_IndividualColor_b = db.oUF.Target.Texts.Health.IndividualColor.b
		Health_Value_ShowDead = db.oUF.Target.Texts.Health.ShowDead
		
		Health_Percent_Enable = db.oUF.Target.Texts.HealthPercent.Enable
		Health_Percent_ShowAlways = db.oUF.Target.Texts.HealthPercent.ShowAlways
		Health_Percent_ColorClass = db.oUF.Target.Texts.HealthPercent.ColorClass
		Health_Percent_ColorGradient = db.oUF.Target.Texts.HealthPercent.ColorGradient
		Health_Percent_IndividualColor_Enable = db.oUF.Target.Texts.HealthPercent.IndividualColor.Enable
		Health_Percent_IndividualColor_r = db.oUF.Target.Texts.HealthPercent.IndividualColor.r
		Health_Percent_IndividualColor_g = db.oUF.Target.Texts.HealthPercent.IndividualColor.g
		Health_Percent_IndividualColor_b = db.oUF.Target.Texts.HealthPercent.IndividualColor.b
		Health_Percent_ShowDead = db.oUF.Target.Texts.HealthPercent.ShowDead
		
		Health_Missing_Enable = db.oUF.Target.Texts.HealthMissing.Enable
		Health_Missing_ShortValue = db.oUF.Target.Texts.HealthMissing.ShortValue
		Health_Missing_ShowAlways = db.oUF.Target.Texts.HealthMissing.ShowAlways
		Health_Missing_ColorClass = db.oUF.Target.Texts.HealthMissing.ColorClass
		Health_Missing_ColorGradient = db.oUF.Target.Texts.HealthMissing.ColorGradient
		Health_Missing_IndividualColor_Enable = db.oUF.Target.Texts.HealthMissing.IndividualColor.Enable
		Health_Missing_IndividualColor_r = db.oUF.Target.Texts.HealthMissing.IndividualColor.r
		Health_Missing_IndividualColor_g = db.oUF.Target.Texts.HealthMissing.IndividualColor.g
		Health_Missing_IndividualColor_b = db.oUF.Target.Texts.HealthMissing.IndividualColor.b
	elseif unit == "targettarget" then
		Health_ColorClass = db.oUF.ToT.Health.ColorClass
		Health_IndividualColor = db.oUF.ToT.Health.IndividualColor.Enable
		Health_IndividualColor_r = db.oUF.ToT.Health.IndividualColor.r
		Health_IndividualColor_g = db.oUF.ToT.Health.IndividualColor.g
		Health_IndividualColor_b = db.oUF.ToT.Health.IndividualColor.b
		Health_ColorGradient = db.oUF.ToT.Health.ColorGradient
		
		Health_Value_Enable = db.oUF.ToT.Texts.Health.Enable
		Health_Value_Format = db.oUF.ToT.Texts.Health.Format
		Health_Value_ColorClass = db.oUF.ToT.Texts.Health.ColorClass
		Health_Value_ColorGradient = db.oUF.ToT.Texts.Health.ColorGradient
		Health_Value_IndividualColor_Enable = db.oUF.ToT.Texts.Health.IndividualColor.Enable
		Health_Value_IndividualColor_r = db.oUF.ToT.Texts.Health.IndividualColor.r
		Health_Value_IndividualColor_g = db.oUF.ToT.Texts.Health.IndividualColor.g
		Health_Value_IndividualColor_b = db.oUF.ToT.Texts.Health.IndividualColor.b
		Health_Value_ShowDead = db.oUF.ToT.Texts.Health.ShowDead
		
		Health_Percent_Enable = db.oUF.ToT.Texts.HealthPercent.Enable
		Health_Percent_ShowAlways = db.oUF.ToT.Texts.HealthPercent.ShowAlways
		Health_Percent_ColorClass = db.oUF.ToT.Texts.HealthPercent.ColorClass
		Health_Percent_ColorGradient = db.oUF.ToT.Texts.HealthPercent.ColorGradient
		Health_Percent_IndividualColor_Enable = db.oUF.ToT.Texts.HealthPercent.IndividualColor.Enable
		Health_Percent_IndividualColor_r = db.oUF.ToT.Texts.HealthPercent.IndividualColor.r
		Health_Percent_IndividualColor_g = db.oUF.ToT.Texts.HealthPercent.IndividualColor.g
		Health_Percent_IndividualColor_b = db.oUF.ToT.Texts.HealthPercent.IndividualColor.b
		Health_Percent_ShowDead = db.oUF.ToT.Texts.HealthPercent.ShowDead
		
		Health_Missing_Enable = db.oUF.ToT.Texts.HealthMissing.Enable
		Health_Missing_ShortValue = db.oUF.ToT.Texts.HealthMissing.ShortValue
		Health_Missing_ShowAlways = db.oUF.ToT.Texts.HealthMissing.ShowAlways
		Health_Missing_ColorClass = db.oUF.ToT.Texts.HealthMissing.ColorClass
		Health_Missing_ColorGradient = db.oUF.ToT.Texts.HealthMissing.ColorGradient
		Health_Missing_IndividualColor_Enable = db.oUF.ToT.Texts.HealthMissing.IndividualColor.Enable
		Health_Missing_IndividualColor_r = db.oUF.ToT.Texts.HealthMissing.IndividualColor.r
		Health_Missing_IndividualColor_g = db.oUF.ToT.Texts.HealthMissing.IndividualColor.g
		Health_Missing_IndividualColor_b = db.oUF.ToT.Texts.HealthMissing.IndividualColor.b
	elseif unit == "targettargettarget" then
		Health_ColorClass = db.oUF.ToToT.Health.ColorClass
		Health_IndividualColor = db.oUF.ToToT.Health.IndividualColor.Enable
		Health_IndividualColor_r = db.oUF.ToToT.Health.IndividualColor.r
		Health_IndividualColor_g = db.oUF.ToToT.Health.IndividualColor.g
		Health_IndividualColor_b = db.oUF.ToToT.Health.IndividualColor.b
		Health_ColorGradient = db.oUF.ToToT.Health.ColorGradient
		
		Health_Value_Enable = db.oUF.ToToT.Texts.Health.Enable
		Health_Value_Format = db.oUF.ToToT.Texts.Health.Format
		Health_Value_ColorClass = db.oUF.ToToT.Texts.Health.ColorClass
		Health_Value_ColorGradient = db.oUF.ToToT.Texts.Health.ColorGradient
		Health_Value_IndividualColor_Enable = db.oUF.ToToT.Texts.Health.IndividualColor.Enable
		Health_Value_IndividualColor_r = db.oUF.ToToT.Texts.Health.IndividualColor.r
		Health_Value_IndividualColor_g = db.oUF.ToToT.Texts.Health.IndividualColor.g
		Health_Value_IndividualColor_b = db.oUF.ToToT.Texts.Health.IndividualColor.b
		Health_Value_ShowDead = db.oUF.ToToT.Texts.Health.ShowDead
		
		Health_Percent_Enable = db.oUF.ToToT.Texts.HealthPercent.Enable
		Health_Percent_ShowAlways = db.oUF.ToToT.Texts.HealthPercent.ShowAlways
		Health_Percent_ColorClass = db.oUF.ToToT.Texts.HealthPercent.ColorClass
		Health_Percent_ColorGradient = db.oUF.ToToT.Texts.HealthPercent.ColorGradient
		Health_Percent_IndividualColor_Enable = db.oUF.ToToT.Texts.HealthPercent.IndividualColor.Enable
		Health_Percent_IndividualColor_r = db.oUF.ToToT.Texts.HealthPercent.IndividualColor.r
		Health_Percent_IndividualColor_g = db.oUF.ToToT.Texts.HealthPercent.IndividualColor.g
		Health_Percent_IndividualColor_b = db.oUF.ToToT.Texts.HealthPercent.IndividualColor.b
		Health_Percent_ShowDead = db.oUF.ToToT.Texts.HealthPercent.ShowDead
		
		Health_Missing_Enable = db.oUF.ToToT.Texts.HealthMissing.Enable
		Health_Missing_ShortValue = db.oUF.ToToT.Texts.HealthMissing.ShortValue
		Health_Missing_ShowAlways = db.oUF.ToToT.Texts.HealthMissing.ShowAlways
		Health_Missing_ColorClass = db.oUF.ToToT.Texts.HealthMissing.ColorClass
		Health_Missing_ColorGradient = db.oUF.ToToT.Texts.HealthMissing.ColorGradient
		Health_Missing_IndividualColor_Enable = db.oUF.ToToT.Texts.HealthMissing.IndividualColor.Enable
		Health_Missing_IndividualColor_r = db.oUF.ToToT.Texts.HealthMissing.IndividualColor.r
		Health_Missing_IndividualColor_g = db.oUF.ToToT.Texts.HealthMissing.IndividualColor.g
		Health_Missing_IndividualColor_b = db.oUF.ToToT.Texts.HealthMissing.IndividualColor.b
	elseif unit == "focus" then
		Health_ColorClass = db.oUF.Focus.Health.ColorClass
		Health_IndividualColor = db.oUF.Focus.Health.IndividualColor.Enable
		Health_IndividualColor_r = db.oUF.Focus.Health.IndividualColor.r
		Health_IndividualColor_g = db.oUF.Focus.Health.IndividualColor.g
		Health_IndividualColor_b = db.oUF.Focus.Health.IndividualColor.b
		Health_ColorGradient = db.oUF.Focus.Health.ColorGradient
		
		Health_Value_Enable = db.oUF.Focus.Texts.Health.Enable
		Health_Value_Format = db.oUF.Focus.Texts.Health.Format
		Health_Value_ColorClass = db.oUF.Focus.Texts.Health.ColorClass
		Health_Value_ColorGradient = db.oUF.Focus.Texts.Health.ColorGradient
		Health_Value_IndividualColor_Enable = db.oUF.Focus.Texts.Health.IndividualColor.Enable
		Health_Value_IndividualColor_r = db.oUF.Focus.Texts.Health.IndividualColor.r
		Health_Value_IndividualColor_g = db.oUF.Focus.Texts.Health.IndividualColor.g
		Health_Value_IndividualColor_b = db.oUF.Focus.Texts.Health.IndividualColor.b
		Health_Value_ShowDead = db.oUF.Focus.Texts.Health.ShowDead
		
		Health_Percent_Enable = db.oUF.Focus.Texts.HealthPercent.Enable
		Health_Percent_ShowAlways = db.oUF.Focus.Texts.HealthPercent.ShowAlways
		Health_Percent_ColorClass = db.oUF.Focus.Texts.HealthPercent.ColorClass
		Health_Percent_ColorGradient = db.oUF.Focus.Texts.HealthPercent.ColorGradient
		Health_Percent_IndividualColor_Enable = db.oUF.Focus.Texts.HealthPercent.IndividualColor.Enable
		Health_Percent_IndividualColor_r = db.oUF.Focus.Texts.HealthPercent.IndividualColor.r
		Health_Percent_IndividualColor_g = db.oUF.Focus.Texts.HealthPercent.IndividualColor.g
		Health_Percent_IndividualColor_b = db.oUF.Focus.Texts.HealthPercent.IndividualColor.b
		Health_Percent_ShowDead = db.oUF.Focus.Texts.HealthPercent.ShowDead
		
		Health_Missing_Enable = db.oUF.Focus.Texts.HealthMissing.Enable
		Health_Missing_ShortValue = db.oUF.Focus.Texts.HealthMissing.ShortValue
		Health_Missing_ShowAlways = db.oUF.Focus.Texts.HealthMissing.ShowAlways
		Health_Missing_ColorClass = db.oUF.Focus.Texts.HealthMissing.ColorClass
		Health_Missing_ColorGradient = db.oUF.Focus.Texts.HealthMissing.ColorGradient
		Health_Missing_IndividualColor_Enable = db.oUF.Focus.Texts.HealthMissing.IndividualColor.Enable
		Health_Missing_IndividualColor_r = db.oUF.Focus.Texts.HealthMissing.IndividualColor.r
		Health_Missing_IndividualColor_g = db.oUF.Focus.Texts.HealthMissing.IndividualColor.g
		Health_Missing_IndividualColor_b = db.oUF.Focus.Texts.HealthMissing.IndividualColor.b
	elseif unit == "focustarget" then
		Health_ColorClass = db.oUF.FocusTarget.Health.ColorClass
		Health_IndividualColor = db.oUF.FocusTarget.Health.IndividualColor.Enable
		Health_IndividualColor_r = db.oUF.FocusTarget.Health.IndividualColor.r
		Health_IndividualColor_g = db.oUF.FocusTarget.Health.IndividualColor.g
		Health_IndividualColor_b = db.oUF.FocusTarget.Health.IndividualColor.b
		Health_ColorGradient = db.oUF.FocusTarget.Health.ColorGradient
		
		Health_Value_Enable = db.oUF.FocusTarget.Texts.Health.Enable
		Health_Value_Format = db.oUF.FocusTarget.Texts.Health.Format
		Health_Value_ColorClass = db.oUF.FocusTarget.Texts.Health.ColorClass
		Health_Value_ColorGradient = db.oUF.FocusTarget.Texts.Health.ColorGradient
		Health_Value_IndividualColor_Enable = db.oUF.FocusTarget.Texts.Health.IndividualColor.Enable
		Health_Value_IndividualColor_r = db.oUF.FocusTarget.Texts.Health.IndividualColor.r
		Health_Value_IndividualColor_g = db.oUF.FocusTarget.Texts.Health.IndividualColor.g
		Health_Value_IndividualColor_b = db.oUF.FocusTarget.Texts.Health.IndividualColor.b
		Health_Value_ShowDead = db.oUF.FocusTarget.Texts.Health.ShowDead
		
		Health_Percent_Enable = db.oUF.FocusTarget.Texts.HealthPercent.Enable
		Health_Percent_ShowAlways = db.oUF.FocusTarget.Texts.HealthPercent.ShowAlways
		Health_Percent_ColorClass = db.oUF.FocusTarget.Texts.HealthPercent.ColorClass
		Health_Percent_ColorGradient = db.oUF.FocusTarget.Texts.HealthPercent.ColorGradient
		Health_Percent_IndividualColor_Enable = db.oUF.FocusTarget.Texts.HealthPercent.IndividualColor.Enable
		Health_Percent_IndividualColor_r = db.oUF.FocusTarget.Texts.HealthPercent.IndividualColor.r
		Health_Percent_IndividualColor_g = db.oUF.FocusTarget.Texts.HealthPercent.IndividualColor.g
		Health_Percent_IndividualColor_b = db.oUF.FocusTarget.Texts.HealthPercent.IndividualColor.b
		Health_Percent_ShowDead = db.oUF.FocusTarget.Texts.HealthPercent.ShowDead
		
		Health_Missing_Enable = db.oUF.FocusTarget.Texts.HealthMissing.Enable
		Health_Missing_ShortValue = db.oUF.FocusTarget.Texts.HealthMissing.ShortValue
		Health_Missing_ShowAlways = db.oUF.FocusTarget.Texts.HealthMissing.ShowAlways
		Health_Missing_ColorClass = db.oUF.FocusTarget.Texts.HealthMissing.ColorClass
		Health_Missing_ColorGradient = db.oUF.FocusTarget.Texts.HealthMissing.ColorGradient
		Health_Missing_IndividualColor_Enable = db.oUF.FocusTarget.Texts.HealthMissing.IndividualColor.Enable
		Health_Missing_IndividualColor_r = db.oUF.FocusTarget.Texts.HealthMissing.IndividualColor.r
		Health_Missing_IndividualColor_g = db.oUF.FocusTarget.Texts.HealthMissing.IndividualColor.g
		Health_Missing_IndividualColor_b = db.oUF.FocusTarget.Texts.HealthMissing.IndividualColor.b
	elseif unit == "pet" then
		Health_ColorClass = db.oUF.Pet.Health.ColorClass
		Health_IndividualColor = db.oUF.Pet.Health.IndividualColor.Enable
		Health_IndividualColor_r = db.oUF.Pet.Health.IndividualColor.r
		Health_IndividualColor_g = db.oUF.Pet.Health.IndividualColor.g
		Health_IndividualColor_b = db.oUF.Pet.Health.IndividualColor.b
		Health_ColorGradient = db.oUF.Pet.Health.ColorGradient
		Health_ColorHappy = db.oUF.Pet.Health.ColorHappy
		
		Health_Value_Enable = db.oUF.Pet.Texts.Health.Enable
		Health_Value_Format = db.oUF.Pet.Texts.Health.Format
		Health_Value_ColorClass = db.oUF.Pet.Texts.Health.ColorClass
		Health_Value_ColorGradient = db.oUF.Pet.Texts.Health.ColorGradient
		Health_Value_IndividualColor_Enable = db.oUF.Pet.Texts.Health.IndividualColor.Enable
		Health_Value_IndividualColor_r = db.oUF.Pet.Texts.Health.IndividualColor.r
		Health_Value_IndividualColor_g = db.oUF.Pet.Texts.Health.IndividualColor.g
		Health_Value_IndividualColor_b = db.oUF.Pet.Texts.Health.IndividualColor.b
		Health_Value_ShowDead = db.oUF.Pet.Texts.Health.ShowDead
		
		Health_Percent_Enable = db.oUF.Pet.Texts.HealthPercent.Enable
		Health_Percent_ShowAlways = db.oUF.Pet.Texts.HealthPercent.ShowAlways
		Health_Percent_ColorClass = db.oUF.Pet.Texts.HealthPercent.ColorClass
		Health_Percent_ColorGradient = db.oUF.Pet.Texts.HealthPercent.ColorGradient
		Health_Percent_IndividualColor_Enable = db.oUF.Pet.Texts.HealthPercent.IndividualColor.Enable
		Health_Percent_IndividualColor_r = db.oUF.Pet.Texts.HealthPercent.IndividualColor.r
		Health_Percent_IndividualColor_g = db.oUF.Pet.Texts.HealthPercent.IndividualColor.g
		Health_Percent_IndividualColor_b = db.oUF.Pet.Texts.HealthPercent.IndividualColor.b
		Health_Percent_ShowDead = db.oUF.Pet.Texts.HealthPercent.ShowDead
		
		Health_Missing_Enable = db.oUF.Pet.Texts.HealthMissing.Enable
		Health_Missing_ShortValue = db.oUF.Pet.Texts.HealthMissing.ShortValue
		Health_Missing_ShowAlways = db.oUF.Pet.Texts.HealthMissing.ShowAlways
		Health_Missing_ColorClass = db.oUF.Pet.Texts.HealthMissing.ColorClass
		Health_Missing_ColorGradient = db.oUF.Pet.Texts.HealthMissing.ColorGradient
		Health_Missing_IndividualColor_Enable = db.oUF.Pet.Texts.HealthMissing.IndividualColor.Enable
		Health_Missing_IndividualColor_r = db.oUF.Pet.Texts.HealthMissing.IndividualColor.r
		Health_Missing_IndividualColor_g = db.oUF.Pet.Texts.HealthMissing.IndividualColor.g
		Health_Missing_IndividualColor_b = db.oUF.Pet.Texts.HealthMissing.IndividualColor.b
	elseif unit == "pettarget" then
		Health_ColorClass = db.oUF.PetTarget.Health.ColorClass
		Health_IndividualColor = db.oUF.PetTarget.Health.IndividualColor.Enable
		Health_IndividualColor_r = db.oUF.PetTarget.Health.IndividualColor.r
		Health_IndividualColor_g = db.oUF.PetTarget.Health.IndividualColor.g
		Health_IndividualColor_b = db.oUF.PetTarget.Health.IndividualColor.b
		Health_ColorGradient = db.oUF.PetTarget.Health.ColorGradient
		
		Health_Value_Enable = db.oUF.PetTarget.Texts.Health.Enable
		Health_Value_Format = db.oUF.PetTarget.Texts.Health.Format
		Health_Value_ColorClass = db.oUF.PetTarget.Texts.Health.ColorClass
		Health_Value_ColorGradient = db.oUF.PetTarget.Texts.Health.ColorGradient
		Health_Value_IndividualColor_Enable = db.oUF.PetTarget.Texts.Health.IndividualColor.Enable
		Health_Value_IndividualColor_r = db.oUF.PetTarget.Texts.Health.IndividualColor.r
		Health_Value_IndividualColor_g = db.oUF.PetTarget.Texts.Health.IndividualColor.g
		Health_Value_IndividualColor_b = db.oUF.PetTarget.Texts.Health.IndividualColor.b
		Health_Value_ShowDead = db.oUF.PetTarget.Texts.Health.ShowDead
		
		Health_Percent_Enable = db.oUF.PetTarget.Texts.HealthPercent.Enable
		Health_Percent_ShowAlways = db.oUF.PetTarget.Texts.HealthPercent.ShowAlways
		Health_Percent_ColorClass = db.oUF.PetTarget.Texts.HealthPercent.ColorClass
		Health_Percent_ColorGradient = db.oUF.PetTarget.Texts.HealthPercent.ColorGradient
		Health_Percent_IndividualColor_Enable = db.oUF.PetTarget.Texts.HealthPercent.IndividualColor.Enable
		Health_Percent_IndividualColor_r = db.oUF.PetTarget.Texts.HealthPercent.IndividualColor.r
		Health_Percent_IndividualColor_g = db.oUF.PetTarget.Texts.HealthPercent.IndividualColor.g
		Health_Percent_IndividualColor_b = db.oUF.PetTarget.Texts.HealthPercent.IndividualColor.b
		Health_Percent_ShowDead = db.oUF.PetTarget.Texts.HealthPercent.ShowDead
		
		Health_Missing_Enable = db.oUF.PetTarget.Texts.HealthMissing.Enable
		Health_Missing_ShortValue = db.oUF.PetTarget.Texts.HealthMissing.ShortValue
		Health_Missing_ShowAlways = db.oUF.PetTarget.Texts.HealthMissing.ShowAlways
		Health_Missing_ColorClass = db.oUF.PetTarget.Texts.HealthMissing.ColorClass
		Health_Missing_ColorGradient = db.oUF.PetTarget.Texts.HealthMissing.ColorGradient
		Health_Missing_IndividualColor_Enable = db.oUF.PetTarget.Texts.HealthMissing.IndividualColor.Enable
		Health_Missing_IndividualColor_r = db.oUF.PetTarget.Texts.HealthMissing.IndividualColor.r
		Health_Missing_IndividualColor_g = db.oUF.PetTarget.Texts.HealthMissing.IndividualColor.g
		Health_Missing_IndividualColor_b = db.oUF.PetTarget.Texts.HealthMissing.IndividualColor.b
	end
end

local PostUpdateHealth = function(self, event, unit, bar, min, max)
	
	local pClass, pToken = UnitClass(unit)
	local color = colors.class[pToken]
	local r, g, b
	
	GetHealthOptions(self, unit)
	
	r, g, b = oUF.ColorGradient(min/max, tonumber(db.oUF.Colors.Smooth.Smooth1.r),tonumber(db.oUF.Colors.Smooth.Smooth1.g), tonumber(db.oUF.Colors.Smooth.Smooth1.b),tonumber(db.oUF.Colors.Smooth.Smooth2.r),tonumber(db.oUF.Colors.Smooth.Smooth2.g),tonumber(db.oUF.Colors.Smooth.Smooth2.b),tonumber(db.oUF.Colors.Smooth.Smooth3.r),tonumber(db.oUF.Colors.Smooth.Smooth3.g),tonumber(db.oUF.Colors.Smooth.Smooth3.b))
	
	if Health_ColorClass == true then
		if color then
			self.Health:SetStatusBarColor(color[1], color[2], color[3])
			local bg = self.Health.bg
			local mu = bg.multiplier or 1
			bg:SetVertexColor(color[1]*mu, color[2]*mu, color[3]*mu)
		else
			self.Health:SetStatusBarColor(0.5, 0.5, 0.5)
			local bg = self.Health.bg
			local mu = bg.multiplier or 1
			bg:SetVertexColor(0.5*mu, 0.5*mu, 0.5*mu)
		end
	elseif Health_ColorHappy == true then
		if(playerClass == "HUNTER") and self.unit == "pet" then
			local pHappy = GetPetHappiness()
			
			if pHappy then
				local color3 = colors.happiness[pHappy]
				if color3 then
					self.Health:SetStatusBarColor(color3[1], color3[2], color3[3])
					local bg = self.Health.bg
					local mu = bg.multiplier or 1
					bg:SetVertexColor(color3[1]*mu, color3[2]*mu, color3[3]*mu)
				else
					self.Health:SetStatusBarColor(0.5, 0.5, 0.5)
					local bg = self.Health.bg
					local mu = bg.multiplier or 1
					bg:SetVertexColor(0.5*mu, 0.5*mu, 0.5*mu)
				end
			end
		end
	elseif Health_IndividualColor == true then
		self.Health:SetStatusBarColor(Health_IndividualColor_r, Health_IndividualColor_g, Health_IndividualColor_b)
		local bg = self.Health.bg
		local mu = bg.multiplier or 1
		bg:SetVertexColor(Health_IndividualColor_r*mu, Health_IndividualColor_g*mu, Health_IndividualColor_b*mu)
	elseif Health_ColorGradient == true then
		self.Health:SetStatusBarColor(r,g,b)
		local bg = self.Health.bg
		local mu = bg.multiplier or 1
		bg:SetVertexColor(r*mu, g*mu, b*mu)
	end
	
	if(bar.colorTapping and UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit)) then
		self.Health:SetStatusBarColor(ColorsTapped[1],ColorsTapped[2],ColorsTapped[3])
		local bg = self.Health.bg
		local mu = bg.multiplier or 1
		bg:SetVertexColor(ColorsTapped[1]*mu, ColorsTapped[2]*mu, ColorsTapped[3]*mu)
	end

	if not UnitIsConnected(unit) then
		bar:SetValue(0)
		bar.valueMissing:SetText()
		
		if Health_Value_ShowDead == true then
			bar.value:SetText("|cffD7BEA5Offline|r")
		else
			bar.value:SetText()
		end
		
		if Health_Percent_ShowDead == true then
			bar.valuePercent:SetText("|cffD7BEA5Offline|r")
		else
			bar.valuePercent:SetText()
		end
	elseif UnitIsDead(unit) then
		bar:SetValue(0)
		bar.valueMissing:SetText()
		
		if Health_Value_ShowDead == true then
			bar.value:SetText("|cffD7BEA5Dead|r")
		else
			bar.value:SetText()
		end
		
		if Health_Percent_ShowDead == true then
			bar.valuePercent:SetText("|cffD7BEA5Dead|r")
		else
			bar.valuePercent:SetText()
		end
	elseif UnitIsGhost(unit) then
		bar:SetValue(0)
		bar.valueMissing:SetText()
		
		if Health_Value_ShowDead == true then
			bar.value:SetText("|cffD7BEA5Ghost|r")
		else
			bar.value:SetText()
		end
		
		if Health_Percent_ShowDead == true then
			bar.valuePercent:SetText("|cffD7BEA5Ghost|r")
		else
			bar.valuePercent:SetText()
		end
	else
		local healthPercent = 100 * min / max
		healthPercent = string.format("%.1f", healthPercent)
		healthPercent = healthPercent.."%"
		
		if Health_Value_Enable == true then
			if min >= 1 then
				bar.value:Show()
				
				if Health_Value_Format == "Absolut" then
					bar.value:SetFormattedText("%s/%s",min,max)
				elseif Health_Value_Format == "Absolut & Percent" then
					bar.value:SetFormattedText("%s/%s | %s",min,max,healthPercent)
				elseif Health_Value_Format == "Absolut Short" then
					bar.value:SetFormattedText("%s/%s",ShortValue(min),ShortValue(max))
				elseif Health_Value_Format == "Absolut Short & Percent" then
					bar.value:SetFormattedText("%s/%s | %s",ShortValue(min),ShortValue(max),healthPercent)
				elseif Health_Value_Format == "Standard" then
					bar.value:SetText(min)
				elseif Health_Value_Format == "Standard Short" then
					bar.value:SetText(ShortValue(min))
				else
					bar.value:SetText(min)
				end
				
				if Health_Value_ColorClass == true then
					if color then
						bar.value:SetTextColor(color[1],color[2],color[3])
					else
						bar.value:SetTextColor(0, 0, 0)
					end
				elseif Health_Value_ColorGradient == true then
					bar.value:SetTextColor(r,g,b)
				elseif Health_Value_IndividualColor_Enable == true then
					bar.value:SetTextColor(Health_Value_IndividualColor_r, Health_Value_IndividualColor_g, Health_Value_IndividualColor_b)
				end
			else
				bar.value:SetText()
				bar.value:Hide()
			end
		else
			bar.value:SetText()
			bar.value:Hide()
		end
		
		if Health_Percent_Enable == true then
			bar.valuePercent:SetText(healthPercent)
			
			if Health_Percent_ShowAlways == true then
				bar.valuePercent:Show()
			else
				if min ~= max then
					bar.valuePercent:Show()
				else
					bar.valuePercent:Hide()
				end
			end
			
			if Health_Percent_ColorClass == true then
				if color then
					bar.valuePercent:SetTextColor(color[1],color[2],color[3])
				else
					bar.valuePercent:SetTextColor(0, 0, 0)
				end
			elseif Health_Percent_ColorGradient == true then
				bar.valuePercent:SetTextColor(r,g,b)
			elseif Health_Percent_IndividualColor_Enable == true then
				bar.valuePercent:SetTextColor(Health_Percent_IndividualColor_r, Health_Percent_IndividualColor_g, Health_Percent_IndividualColor_b)
			end
		else
			bar.valuePercent:SetText()
			bar.valuePercent:Hide()
		end
		
		if Health_Missing_Enable == true then
			local healthMissing = max-min
			
			if Health_Missing_ShortValue == true then
				bar.valueMissing:SetText("-"..ShortValue(healthMissing))
			else
				bar.valueMissing:SetText("-"..healthMissing)
			end
			
			if Health_Missing_ShowAlways == true then
				bar.valueMissing:Show()
			else
				if healthMissing > 0 then
					bar.valueMissing:Show()
				else
					bar.valueMissing:Hide()
				end
			end

			if Health_Missing_ColorClass == true then
				if color then
					bar.valueMissing:SetTextColor(color[1],color[2],color[3])
				else
					bar.valueMissing:SetTextColor(0, 0, 0)
				end
			elseif Health_Missing_ColorGradient == true then
				bar.valueMissing:SetTextColor(r,g,b)
			elseif Health_Missing_IndividualColor_Enable == true then
				bar.valueMissing:SetTextColor(Health_Missing_IndividualColor_r, Health_Missing_IndividualColor_g, Health_Missing_IndividualColor_b)
			end
		else
			bar.valueMissing:SetText()
			bar.valueMissing:Hide()
		end
	end
end

do
	local f = CreateFrame("Frame")

	f:RegisterEvent("UNIT_ENTERED_VEHICLE")
	f:RegisterEvent("UNIT_EXITED_VEHICLE")
	
	local delay = 0.5
	local OnUpdate = function(self, elapsed)
		self.elapsed = (self.elapsed or delay) - elapsed
		if self.elapsed <= 0 then
			local petframe = oUF_LUI_pet
			petframe:PLAYER_ENTERING_WORLD()
			self:SetScript("OnUpdate", nil)
			if entering and petframe.PostEnterVehicle then
				petframe:PostEnterVehicle("enter")
			elseif not entering and petframe.PostExitVehicle then
				petframe:PostExitVehicle("exit")
			end
		end
	end

	f:SetScript("OnEvent", function(self, event, unit)
		if unit == "player" then
			if event == "UNIT_ENTERED_VEHICLE" then
				entering = true
			else
				entering = false
			end
			f.elapsed = delay
			f:SetScript("OnUpdate", OnUpdate)
		end
	end)
end

local EnterVehicle = function(self, event)
	if event == "enter" then
	
	end
end

local ExitVehicle = function(self, event)
	if event == "exit" then
		
	end
end

local OverrideUpdatePower = function(self, event, unit, bar, min, max)
	if(self.unit ~= unit) then return end
	local _, pType = UnitPowerType(unit)
	local pClass, pToken = UnitClass(unit)
	local color = colors.class[pToken]
	local color2 = colors.power[pType]
	
	if((unit and unit:find("boss%d")) or (strsub(SecureButton_GetUnit(self), 0, 4) == "boss")) then
		Power_ColorClass = db.oUF.Boss.Power.ColorClass
		Power_IndividualColor = db.oUF.Boss.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.Boss.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.Boss.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.Boss.Power.IndividualColor.b
		Power_ColorType = db.oUF.Boss.Power.ColorType
		
		Power_Value_Enable = db.oUF.Boss.Texts.Power.Enable
		Power_Value_Format = db.oUF.Boss.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.Boss.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.Boss.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.Boss.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.Boss.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.Boss.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.Boss.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.Boss.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.Boss.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.Boss.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.Boss.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.Boss.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.Boss.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.Boss.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.Boss.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.Boss.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.Boss.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.Boss.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.Boss.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.Boss.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.Boss.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.Boss.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.Boss.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.Boss.Texts.PowerMissing.IndividualColor.b	
	elseif unit == "player" then
		if entering == true then
			Power_ColorClass = db.oUF.Pet.Power.ColorClass
			Power_IndividualColor = db.oUF.Pet.Power.IndividualColor.Enable
			Power_IndividualColor_r = db.oUF.Pet.Power.IndividualColor.r
			Power_IndividualColor_g = db.oUF.Pet.Power.IndividualColor.g
			Power_IndividualColor_b = db.oUF.Pet.Power.IndividualColor.b
			Power_ColorType = db.oUF.Pet.Power.ColorType
			Power_ColorHappy = db.oUF.Pet.Power.ColorHappy
			
			Power_Value_Enable = db.oUF.Pet.Texts.Power.Enable
			Power_Value_Format = db.oUF.Pet.Texts.Power.Format
			Power_Value_ColorClass = db.oUF.Pet.Texts.Power.ColorClass
			Power_Value_ColorType = db.oUF.Pet.Texts.Power.ColorType
			Power_Value_IndividualColor_Enable = db.oUF.Pet.Texts.Power.IndividualColor.Enable
			Power_Value_IndividualColor_r = db.oUF.Pet.Texts.Power.IndividualColor.r
			Power_Value_IndividualColor_g = db.oUF.Pet.Texts.Power.IndividualColor.g
			Power_Value_IndividualColor_b = db.oUF.Pet.Texts.Power.IndividualColor.b
			
			Power_Percent_Enable = db.oUF.Pet.Texts.PowerPercent.Enable
			Power_Percent_ShowAlways = db.oUF.Pet.Texts.PowerPercent.ShowAlways
			Power_Percent_ColorClass = db.oUF.Pet.Texts.PowerPercent.ColorClass
			Power_Percent_ColorType = db.oUF.Pet.Texts.PowerPercent.ColorType
			Power_Percent_IndividualColor_Enable = db.oUF.Pet.Texts.PowerPercent.IndividualColor.Enable
			Power_Percent_IndividualColor_r = db.oUF.Pet.Texts.PowerPercent.IndividualColor.r
			Power_Percent_IndividualColor_g = db.oUF.Pet.Texts.PowerPercent.IndividualColor.g
			Power_Percent_IndividualColor_b = db.oUF.Pet.Texts.PowerPercent.IndividualColor.b
			
			Power_Missing_Enable = db.oUF.Pet.Texts.PowerMissing.Enable
			Power_Missing_ShortValue = db.oUF.Pet.Texts.PowerMissing.ShortValue
			Power_Missing_ShowAlways = db.oUF.Pet.Texts.PowerMissing.ShowAlways
			Power_Missing_ColorClass = db.oUF.Pet.Texts.PowerMissing.ColorClass
			Power_Missing_ColorType = db.oUF.Pet.Texts.PowerMissing.ColorType
			Power_Missing_IndividualColor_Enable = db.oUF.Pet.Texts.PowerMissing.IndividualColor.Enable
			Power_Missing_IndividualColor_r = db.oUF.Pet.Texts.PowerMissing.IndividualColor.r
			Power_Missing_IndividualColor_g = db.oUF.Pet.Texts.PowerMissing.IndividualColor.g
			Power_Missing_IndividualColor_b = db.oUF.Pet.Texts.PowerMissing.IndividualColor.b
		else
			Power_ColorClass = db.oUF.Player.Power.ColorClass
			Power_IndividualColor = db.oUF.Player.Power.IndividualColor.Enable
			Power_IndividualColor_r = db.oUF.Player.Power.IndividualColor.r
			Power_IndividualColor_g = db.oUF.Player.Power.IndividualColor.g
			Power_IndividualColor_b = db.oUF.Player.Power.IndividualColor.b
			Power_ColorType = db.oUF.Player.Power.ColorType
			
			Power_Value_Enable = db.oUF.Player.Texts.Power.Enable
			Power_Value_Format = db.oUF.Player.Texts.Power.Format
			Power_Value_ColorClass = db.oUF.Player.Texts.Power.ColorClass
			Power_Value_ColorType = db.oUF.Player.Texts.Power.ColorType
			Power_Value_IndividualColor_Enable = db.oUF.Player.Texts.Power.IndividualColor.Enable
			Power_Value_IndividualColor_r = db.oUF.Player.Texts.Power.IndividualColor.r
			Power_Value_IndividualColor_g = db.oUF.Player.Texts.Power.IndividualColor.g
			Power_Value_IndividualColor_b = db.oUF.Player.Texts.Power.IndividualColor.b
			
			Power_Percent_Enable = db.oUF.Player.Texts.PowerPercent.Enable
			Power_Percent_ShowAlways = db.oUF.Player.Texts.PowerPercent.ShowAlways
			Power_Percent_ColorClass = db.oUF.Player.Texts.PowerPercent.ColorClass
			Power_Percent_ColorType = db.oUF.Player.Texts.PowerPercent.ColorType
			Power_Percent_IndividualColor_Enable = db.oUF.Player.Texts.PowerPercent.IndividualColor.Enable
			Power_Percent_IndividualColor_r = db.oUF.Player.Texts.PowerPercent.IndividualColor.r
			Power_Percent_IndividualColor_g = db.oUF.Player.Texts.PowerPercent.IndividualColor.g
			Power_Percent_IndividualColor_b = db.oUF.Player.Texts.PowerPercent.IndividualColor.b
			
			Power_Missing_Enable = db.oUF.Player.Texts.PowerMissing.Enable
			Power_Missing_ShortValue = db.oUF.Player.Texts.PowerMissing.ShortValue
			Power_Missing_ShowAlways = db.oUF.Player.Texts.PowerMissing.ShowAlways
			Power_Missing_ColorClass = db.oUF.Player.Texts.PowerMissing.ColorClass
			Power_Missing_ColorType = db.oUF.Player.Texts.PowerMissing.ColorType
			Power_Missing_IndividualColor_Enable = db.oUF.Player.Texts.PowerMissing.IndividualColor.Enable
			Power_Missing_IndividualColor_r = db.oUF.Player.Texts.PowerMissing.IndividualColor.r
			Power_Missing_IndividualColor_g = db.oUF.Player.Texts.PowerMissing.IndividualColor.g
			Power_Missing_IndividualColor_b = db.oUF.Player.Texts.PowerMissing.IndividualColor.b
		end
	elseif unit == "vehicle" then
		Power_ColorClass = db.oUF.Player.Power.ColorClass
		Power_IndividualColor = db.oUF.Player.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.Player.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.Player.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.Player.Power.IndividualColor.b
		Power_ColorType = db.oUF.Player.Power.ColorType
		
		Power_Value_Enable = db.oUF.Player.Texts.Power.Enable
		Power_Value_Format = db.oUF.Player.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.Player.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.Player.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.Player.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.Player.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.Player.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.Player.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.Player.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.Player.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.Player.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.Player.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.Player.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.Player.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.Player.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.Player.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.Player.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.Player.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.Player.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.Player.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.Player.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.Player.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.Player.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.Player.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.Player.Texts.PowerMissing.IndividualColor.b
	elseif unit == "target" then
		Power_ColorClass = db.oUF.Target.Power.ColorClass
		Power_IndividualColor = db.oUF.Target.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.Target.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.Target.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.Target.Power.IndividualColor.b
		Power_ColorType = db.oUF.Target.Power.ColorType
		
		Power_Value_Enable = db.oUF.Target.Texts.Power.Enable
		Power_Value_Format = db.oUF.Target.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.Target.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.Target.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.Target.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.Target.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.Target.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.Target.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.Target.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.Target.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.Target.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.Target.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.Target.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.Target.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.Target.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.Target.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.Target.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.Target.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.Target.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.Target.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.Target.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.Target.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.Target.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.Target.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.Target.Texts.PowerMissing.IndividualColor.b
	elseif unit == "targettarget" then
		Power_ColorClass = db.oUF.ToT.Power.ColorClass
		Power_IndividualColor = db.oUF.ToT.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.ToT.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.ToT.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.ToT.Power.IndividualColor.b
		Power_ColorType = db.oUF.ToT.Power.ColorType
		
		Power_Value_Enable = db.oUF.ToT.Texts.Power.Enable
		Power_Value_Format = db.oUF.ToT.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.ToT.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.ToT.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.ToT.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.ToT.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.ToT.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.ToT.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.ToT.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.ToT.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.ToT.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.ToT.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.ToT.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.ToT.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.ToT.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.ToT.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.ToT.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.ToT.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.ToT.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.ToT.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.ToT.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.ToT.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.ToT.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.ToT.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.ToT.Texts.PowerMissing.IndividualColor.b
	elseif unit == "targettargettarget" then
		Power_ColorClass = db.oUF.ToToT.Power.ColorClass
		Power_IndividualColor = db.oUF.ToToT.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.ToToT.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.ToToT.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.ToToT.Power.IndividualColor.b
		Power_ColorType = db.oUF.ToToT.Power.ColorType
		
		Power_Value_Enable = db.oUF.ToToT.Texts.Power.Enable
		Power_Value_Format = db.oUF.ToToT.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.ToToT.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.ToToT.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.ToToT.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.ToToT.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.ToToT.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.ToToT.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.ToToT.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.ToToT.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.ToToT.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.ToToT.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.ToToT.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.ToToT.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.ToToT.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.ToToT.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.ToToT.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.ToToT.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.ToToT.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.ToToT.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.ToToT.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.ToToT.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.ToToT.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.ToToT.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.ToToT.Texts.PowerMissing.IndividualColor.b
	elseif unit == "focus" then
		Power_ColorClass = db.oUF.Focus.Power.ColorClass
		Power_IndividualColor = db.oUF.Focus.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.Focus.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.Focus.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.Focus.Power.IndividualColor.b
		Power_ColorType = db.oUF.Focus.Power.ColorType
		
		Power_Value_Enable = db.oUF.Focus.Texts.Power.Enable
		Power_Value_Format = db.oUF.Focus.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.Focus.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.Focus.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.Focus.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.Focus.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.Focus.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.Focus.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.Focus.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.Focus.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.Focus.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.Focus.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.Focus.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.Focus.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.Focus.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.Focus.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.Focus.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.Focus.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.Focus.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.Focus.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.Focus.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.Focus.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.Focus.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.Focus.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.Focus.Texts.PowerMissing.IndividualColor.b
	elseif unit == "focustarget" then
		Power_ColorClass = db.oUF.FocusTarget.Power.ColorClass
		Power_IndividualColor = db.oUF.FocusTarget.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.FocusTarget.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.FocusTarget.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.FocusTarget.Power.IndividualColor.b
		Power_ColorType = db.oUF.FocusTarget.Power.ColorType
		
		Power_Value_Enable = db.oUF.FocusTarget.Texts.Power.Enable
		Power_Value_Format = db.oUF.FocusTarget.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.FocusTarget.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.FocusTarget.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.FocusTarget.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.FocusTarget.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.FocusTarget.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.FocusTarget.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.FocusTarget.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.FocusTarget.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.FocusTarget.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.FocusTarget.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.FocusTarget.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.FocusTarget.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.FocusTarget.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.FocusTarget.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.FocusTarget.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.FocusTarget.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.FocusTarget.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.FocusTarget.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.FocusTarget.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.FocusTarget.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.FocusTarget.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.FocusTarget.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.FocusTarget.Texts.PowerMissing.IndividualColor.b
	elseif unit == "pet" then
		Power_ColorClass = db.oUF.Pet.Power.ColorClass
		Power_IndividualColor = db.oUF.Pet.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.Pet.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.Pet.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.Pet.Power.IndividualColor.b
		Power_ColorType = db.oUF.Pet.Power.ColorType
		Power_ColorHappy = db.oUF.Pet.Power.ColorHappy
		
		Power_Value_Enable = db.oUF.Pet.Texts.Power.Enable
		Power_Value_Format = db.oUF.Pet.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.Pet.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.Pet.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.Pet.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.Pet.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.Pet.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.Pet.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.Pet.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.Pet.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.Pet.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.Pet.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.Pet.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.Pet.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.Pet.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.Pet.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.Pet.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.Pet.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.Pet.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.Pet.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.Pet.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.Pet.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.Pet.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.Pet.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.Pet.Texts.PowerMissing.IndividualColor.b
	elseif unit == "pettarget" then
		Power_ColorClass = db.oUF.PetTarget.Power.ColorClass
		Power_IndividualColor = db.oUF.PetTarget.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.PetTarget.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.PetTarget.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.PetTarget.Power.IndividualColor.b
		Power_ColorType = db.oUF.PetTarget.Power.ColorType
		
		Power_Value_Enable = db.oUF.PetTarget.Texts.Power.Enable
		Power_Value_Format = db.oUF.PetTarget.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.PetTarget.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.PetTarget.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.PetTarget.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.PetTarget.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.PetTarget.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.PetTarget.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.PetTarget.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.PetTarget.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.PetTarget.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.PetTarget.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.PetTarget.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.PetTarget.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.PetTarget.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.PetTarget.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.PetTarget.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.PetTarget.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.PetTarget.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.PetTarget.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.PetTarget.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.PetTarget.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.PetTarget.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.PetTarget.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.PetTarget.Texts.PowerMissing.IndividualColor.b
	end
	
	if Power_ColorClass == true then
		if color then
			self.Power:SetStatusBarColor(color[1], color[2], color[3])
			local bg = self.Power.bg
			local mu = bg.multiplier or 1
			bg:SetVertexColor(color[1]*mu, color[2]*mu, color[3]*mu)
		else
			if color2 then
				self.Power:SetStatusBarColor(color2[1], color2[2], color2[3])
				local bg = self.Power.bg
				local mu = bg.multiplier or 1
				bg:SetVertexColor(color2[1]*mu, color2[2]*mu, color2[3]*mu)
			else
				self.Power:SetStatusBarColor(0.5, 0.5, 0.5)
				local bg = self.Power.bg
				local mu = bg.multiplier or 1
				bg:SetVertexColor(0.5*mu, 0.5*mu, 0.5*mu)
			end
		end
	elseif Power_ColorHappy == true then
		if(playerClass == "HUNTER") and self.unit == "pet" then
			local pHappy = GetPetHappiness()
			
			if pHappy then
				local color3 = colors.happiness[pHappy]
				if color3 then
					self.Power:SetStatusBarColor(color3[1], color3[2], color3[3])
					local bg = self.Power.bg
					local mu = bg.multiplier or 1
					bg:SetVertexColor(color3[1]*mu, color3[2]*mu, color3[3]*mu)
				else
					self.Power:SetStatusBarColor(0.5, 0.5, 0.5)
					local bg = self.Power.bg
					local mu = bg.multiplier or 1
					bg:SetVertexColor(0.5*mu, 0.5*mu, 0.5*mu)
				end
			end
		end
	elseif Power_IndividualColor == true then
		self.Power:SetStatusBarColor(Power_IndividualColor_r, Power_IndividualColor_g, Power_IndividualColor_b)
		local bg = self.Power.bg
		local mu = bg.multiplier or 1
		bg:SetVertexColor(Power_IndividualColor_r*mu, Power_IndividualColor_g*mu, Power_IndividualColor_b*mu)
	elseif Power_ColorType == true then
		if color2 then
			self.Power:SetStatusBarColor(color2[1], color2[2], color2[3])
			local bg = self.Power.bg
			local mu = bg.multiplier or 1
			bg:SetVertexColor(color2[1]*mu, color2[2]*mu, color2[3]*mu)
		else
			if color then
				self.Power:SetStatusBarColor(color[1], color[2], color[3])
				local bg = self.Power.bg
				local mu = bg.multiplier or 1
				bg:SetVertexColor(color[1]*mu, color[2]*mu, color[3]*mu)
			else
				self.Power:SetStatusBarColor(0.5, 0.5, 0.5)
				local bg = self.Power.bg
				local mu = bg.multiplier or 1
				bg:SetVertexColor(0.5*mu, 0.5*mu, 0.5*mu)
			end
		end
	end
	
	if not UnitIsConnected(unit) then
		bar:SetValue(0)
		bar.valuePercent:SetText()
		bar.valueMissing:SetText()
		bar.value:SetText()
	elseif UnitIsDead(unit) then
		bar:SetValue(0)
		bar.valuePercent:SetText()
		bar.valueMissing:SetText()
		bar.value:SetText()
	elseif UnitIsGhost(unit) then
		bar:SetValue(0)
		bar.valuePercent:SetText()
		bar.valueMissing:SetText()
		bar.value:SetText()
	else
		local powerPercent = 100 * min / max
		powerPercent = string.format("%.1f", powerPercent)
		powerPercent = powerPercent.."%"
	
		
		if Power_Value_Enable == true and min >= 1 then
			bar.value:Show()
			
			if Power_Value_Format == "Absolut" then
				bar.value:SetFormattedText("%s/%s",min,max)
			elseif Power_Value_Format == "Absolut & Percent" then
				bar.value:SetFormattedText("%s/%s | %s",min,max,powerPercent)
			elseif Power_Value_Format == "Absolut Short" then
				bar.value:SetFormattedText("%s/%s",ShortValue(min),ShortValue(max))
			elseif Power_Value_Format == "Absolut Short & Percent" then
				bar.value:SetFormattedText("%s/%s | %s",ShortValue(min),ShortValue(max),powerPercent)
			elseif Power_Value_Format == "Standard" then
				bar.value:SetText(min)
			elseif Power_Value_Format == "Standard Short" then
				bar.value:SetText(ShortValue(min))
			else
				bar.value:SetText(min)
			end
			
			if Power_Value_ColorClass == true then
				if color then
					bar.value:SetTextColor(color[1],color[2],color[3])
				else
					if color2 then
						bar.value:SetTextColor(color2[1],color2[2],color2[3])
					else
						bar.value:SetTextColor(0, 0, 0)
					end
				end
			elseif Power_Value_ColorType == true then
				if color2 then
					bar.value:SetTextColor(color2[1],color2[2],color2[3])
				else
					if color then
						bar.value:SetTextColor(color[1],color[2],color[3])
					else
						bar.value:SetTextColor(0, 0, 0)
					end
				end
			elseif Power_Value_IndividualColor_Enable == true then
				bar.value:SetTextColor(Power_Value_IndividualColor_r, Power_Value_IndividualColor_g, Power_Value_IndividualColor_b)
			end
		else
			bar.value:SetText()
			bar.value:Hide()
		end
		
		if Power_Percent_Enable == true then
			bar.valuePercent:SetText(powerPercent)
			
			if Power_Percent_ShowAlways == true then
				bar.valuePercent:Show()
			else
				if min ~= max then
					bar.valuePercent:Show()
				else
					bar.valuePercent:Hide()
				end
			end
			
			if Power_Percent_ColorClass == true then
				if color then
					bar.valuePercent:SetTextColor(color[1],color[2],color[3])
				else
					if color2 then
						bar.valuePercent:SetTextColor(color2[1],color2[2],color2[3])
					else
						bar.valuePercent:SetTextColor(0, 0, 0)
					end
				end
			elseif Power_Percent_ColorType == true then
				if color2 then
					bar.valuePercent:SetTextColor(color2[1],color2[2],color2[3])
				else
					if color then
						bar.valuePercent:SetTextColor(color[1],color[2],color[3])
					else
						bar.valuePercent:SetTextColor(0, 0, 0)
					end
				end
			elseif Power_Percent_IndividualColor_Enable == true then
				bar.valuePercent:SetTextColor(Power_Percent_IndividualColor_r, Power_Percent_IndividualColor_g, Power_Percent_IndividualColor_b)
			end
		else
			bar.valuePercent:SetText()
			bar.valuePercent:Hide()
		end
		
		if Power_Missing_Enable == true then
			local powerMissing = max-min
			
			if Power_Missing_ShortValue == true then
				bar.valueMissing:SetText("-"..ShortValue(powerMissing))
			else
				bar.valueMissing:SetText("-"..powerMissing)
			end
			
			if Power_Missing_ShowAlways == true then
				bar.valueMissing:Show()
			else
				if powerMissing > 0 then
					bar.valueMissing:Show()
				else
					bar.valueMissing:Hide()
				end
			end

			if Power_Missing_ColorClass == true then
				if color then
					bar.valueMissing:SetTextColor(color[1],color[2],color[3])
				else
					if color2 then
						bar.valueMissing:SetTextColor(color2[1],color2[2],color2[3])
					else
						bar.valueMissing:SetTextColor(0, 0, 0)
					end
				end
			elseif Power_Missing_ColorType == true then
				if color2 then
					bar.valueMissing:SetTextColor(color2[1],color2[2],color2[3])
				else
					if color then
						bar.valueMissing:SetTextColor(color[1],color[2],color[3])
					else
						bar.valueMissing:SetTextColor(0, 0, 0)
					end
				end
			elseif Power_Missing_IndividualColor_Enable == true then
				bar.valueMissing:SetTextColor(Power_Missing_IndividualColor_r, Power_Missing_IndividualColor_g, Power_Missing_IndividualColor_b)
			end
		else
			bar.valueMissing:SetText()
			bar.valueMissing:Hide()
		end
	end
end

local PreUpdatePower = function(self, event, unit)
	if(self.unit ~= unit) then return end
	local _, pType = UnitPowerType(unit)
	local pClass, pToken = UnitClass(unit)
	local color = colors.class[pToken]
	local color2 = colors.power[pType]
	
	if((unit and unit:find("boss%d")) or (strsub(SecureButton_GetUnit(self), 0, 4) == "boss")) then
		Power_ColorClass = db.oUF.Boss.Power.ColorClass
		Power_IndividualColor = db.oUF.Boss.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.Boss.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.Boss.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.Boss.Power.IndividualColor.b
		Power_ColorType = db.oUF.Boss.Power.ColorType
	elseif unit == "player" then
		if entering == true then
			Power_ColorClass = db.oUF.Pet.Power.ColorClass
			Power_IndividualColor = db.oUF.Pet.Power.IndividualColor.Enable
			Power_IndividualColor_r = db.oUF.Pet.Power.IndividualColor.r
			Power_IndividualColor_g = db.oUF.Pet.Power.IndividualColor.g
			Power_IndividualColor_b = db.oUF.Pet.Power.IndividualColor.b
			Power_ColorType = db.oUF.Pet.Power.ColorType
			Power_ColorHappy = db.oUF.Pet.Power.ColorHappy
		else
			Power_ColorClass = db.oUF.Player.Power.ColorClass
			Power_IndividualColor = db.oUF.Player.Power.IndividualColor.Enable
			Power_IndividualColor_r = db.oUF.Player.Power.IndividualColor.r
			Power_IndividualColor_g = db.oUF.Player.Power.IndividualColor.g
			Power_IndividualColor_b = db.oUF.Player.Power.IndividualColor.b
			Power_ColorType = db.oUF.Player.Power.ColorType
		end
	elseif unit == "vehicle" then
		Power_ColorClass = db.oUF.Player.Power.ColorClass
		Power_IndividualColor = db.oUF.Player.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.Player.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.Player.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.Player.Power.IndividualColor.b
		Power_ColorType = db.oUF.Player.Power.ColorType
	elseif unit == "target" then
		Power_ColorClass = db.oUF.Target.Power.ColorClass
		Power_IndividualColor = db.oUF.Target.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.Target.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.Target.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.Target.Power.IndividualColor.b
		Power_ColorType = db.oUF.Target.Power.ColorType
	elseif unit == "targettarget" then
		Power_ColorClass = db.oUF.ToT.Power.ColorClass
		Power_IndividualColor = db.oUF.ToT.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.ToT.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.ToT.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.ToT.Power.IndividualColor.b
		Power_ColorType = db.oUF.ToT.Power.ColorType
	elseif unit == "targettargettarget" then
		Power_ColorClass = db.oUF.ToToT.Power.ColorClass
		Power_IndividualColor = db.oUF.ToToT.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.ToToT.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.ToToT.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.ToToT.Power.IndividualColor.b
		Power_ColorType = db.oUF.ToToT.Power.ColorType
	elseif unit == "focus" then
		Power_ColorClass = db.oUF.Focus.Power.ColorClass
		Power_IndividualColor = db.oUF.Focus.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.Focus.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.Focus.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.Focus.Power.IndividualColor.b
		Power_ColorType = db.oUF.Focus.Power.ColorType
	elseif unit == "focustarget" then
		Power_ColorClass = db.oUF.FocusTarget.Power.ColorClass
		Power_IndividualColor = db.oUF.FocusTarget.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.FocusTarget.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.FocusTarget.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.FocusTarget.Power.IndividualColor.b
		Power_ColorType = db.oUF.FocusTarget.Power.ColorType
	elseif unit == "pet" then
		Power_ColorClass = db.oUF.Pet.Power.ColorClass
		Power_IndividualColor = db.oUF.Pet.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.Pet.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.Pet.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.Pet.Power.IndividualColor.b
		Power_ColorType = db.oUF.Pet.Power.ColorType
		Power_ColorHappy = db.oUF.Pet.Power.ColorHappy
	elseif unit == "pettarget" then
		Power_ColorClass = db.oUF.PetTarget.Power.ColorClass
		Power_IndividualColor = db.oUF.PetTarget.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.PetTarget.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.PetTarget.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.PetTarget.Power.IndividualColor.b
		Power_ColorType = db.oUF.PetTarget.Power.ColorType
	end
	
	if Power_ColorClass == true then
		if color then
			self.Power:SetStatusBarColor(color[1], color[2], color[3])
			local bg = self.Power.bg
			local mu = bg.multiplier or 1
			bg:SetVertexColor(color[1]*mu, color[2]*mu, color[3]*mu)
		else
			if color2 then
				self.Power:SetStatusBarColor(color2[1], color2[2], color2[3])
				local bg = self.Power.bg
				local mu = bg.multiplier or 1
				bg:SetVertexColor(color2[1]*mu, color2[2]*mu, color2[3]*mu)
			else
				self.Power:SetStatusBarColor(0.5, 0.5, 0.5)
				local bg = self.Power.bg
				local mu = bg.multiplier or 1
				bg:SetVertexColor(0.5*mu, 0.5*mu, 0.5*mu)
			end
		end
	elseif Power_ColorHappy == true then
		if(playerClass == "HUNTER") and self.unit == "pet" then
			local pHappy = GetPetHappiness()
			
			if pHappy then
				local color3 = colors.happiness[pHappy]
				if color3 then
					self.Power:SetStatusBarColor(color3[1], color3[2], color3[3])
					local bg = self.Power.bg
					local mu = bg.multiplier or 1
					bg:SetVertexColor(color3[1]*mu, color3[2]*mu, color3[3]*mu)
				else
					self.Power:SetStatusBarColor(0.5, 0.5, 0.5)
					local bg = self.Power.bg
					local mu = bg.multiplier or 1
					bg:SetVertexColor(0.5*mu, 0.5*mu, 0.5*mu)
				end
			end
		end
	elseif Power_IndividualColor == true then
		self.Power:SetStatusBarColor(Power_IndividualColor_r, Power_IndividualColor_g, Power_IndividualColor_b)
		local bg = self.Power.bg
		local mu = bg.multiplier or 1
		bg:SetVertexColor(Power_IndividualColor_r*mu, Power_IndividualColor_g*mu, Power_IndividualColor_b*mu)
	elseif Power_ColorType == true then
		if color2 then
			self.Power:SetStatusBarColor(color2[1], color2[2], color2[3])
			local bg = self.Power.bg
			local mu = bg.multiplier or 1
			bg:SetVertexColor(color2[1]*mu, color2[2]*mu, color2[3]*mu)
		else
			if color then
				self.Power:SetStatusBarColor(color[1], color[2], color[3])
				local bg = self.Power.bg
				local mu = bg.multiplier or 1
				bg:SetVertexColor(color[1]*mu, color[2]*mu, color[3]*mu)
			else
				self.Power:SetStatusBarColor(0.5, 0.5, 0.5)
				local bg = self.Power.bg
				local mu = bg.multiplier or 1
				bg:SetVertexColor(0.5*mu, 0.5*mu, 0.5*mu)
			end
		end
	end
end

local PostUpdatePower = function(self, event, unit, bar, min, max)
	local _, pType = UnitPowerType(unit)
	local pClass, pToken = UnitClass(unit)
	local color = colors.class[pToken]
	local color2 = colors.power[pType]
	
	if((unit and unit:find("boss%d")) or (strsub(SecureButton_GetUnit(self), 0, 4) == "boss")) then
		Power_ColorClass = db.oUF.Boss.Power.ColorClass
		Power_IndividualColor = db.oUF.Boss.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.Boss.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.Boss.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.Boss.Power.IndividualColor.b
		Power_ColorType = db.oUF.Boss.Power.ColorType
		
		Power_Value_Enable = db.oUF.Boss.Texts.Power.Enable
		Power_Value_Format = db.oUF.Boss.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.Boss.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.Boss.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.Boss.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.Boss.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.Boss.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.Boss.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.Boss.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.Boss.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.Boss.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.Boss.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.Boss.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.Boss.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.Boss.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.Boss.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.Boss.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.Boss.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.Boss.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.Boss.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.Boss.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.Boss.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.Boss.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.Boss.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.Boss.Texts.PowerMissing.IndividualColor.b
	elseif unit == "player" then
		if entering == true then
			Power_ColorClass = db.oUF.Pet.Power.ColorClass
			Power_IndividualColor = db.oUF.Pet.Power.IndividualColor.Enable
			Power_IndividualColor_r = db.oUF.Pet.Power.IndividualColor.r
			Power_IndividualColor_g = db.oUF.Pet.Power.IndividualColor.g
			Power_IndividualColor_b = db.oUF.Pet.Power.IndividualColor.b
			Power_ColorType = db.oUF.Pet.Power.ColorType
			Power_ColorHappy = db.oUF.Pet.Power.ColorHappy
			
			Power_Value_Enable = db.oUF.Pet.Texts.Power.Enable
			Power_Value_Format = db.oUF.Pet.Texts.Power.Format
			Power_Value_ColorClass = db.oUF.Pet.Texts.Power.ColorClass
			Power_Value_ColorType = db.oUF.Pet.Texts.Power.ColorType
			Power_Value_IndividualColor_Enable = db.oUF.Pet.Texts.Power.IndividualColor.Enable
			Power_Value_IndividualColor_r = db.oUF.Pet.Texts.Power.IndividualColor.r
			Power_Value_IndividualColor_g = db.oUF.Pet.Texts.Power.IndividualColor.g
			Power_Value_IndividualColor_b = db.oUF.Pet.Texts.Power.IndividualColor.b
			
			Power_Percent_Enable = db.oUF.Pet.Texts.PowerPercent.Enable
			Power_Percent_ShowAlways = db.oUF.Pet.Texts.PowerPercent.ShowAlways
			Power_Percent_ColorClass = db.oUF.Pet.Texts.PowerPercent.ColorClass
			Power_Percent_ColorType = db.oUF.Pet.Texts.PowerPercent.ColorType
			Power_Percent_IndividualColor_Enable = db.oUF.Pet.Texts.PowerPercent.IndividualColor.Enable
			Power_Percent_IndividualColor_r = db.oUF.Pet.Texts.PowerPercent.IndividualColor.r
			Power_Percent_IndividualColor_g = db.oUF.Pet.Texts.PowerPercent.IndividualColor.g
			Power_Percent_IndividualColor_b = db.oUF.Pet.Texts.PowerPercent.IndividualColor.b
			
			Power_Missing_Enable = db.oUF.Pet.Texts.PowerMissing.Enable
			Power_Missing_ShortValue = db.oUF.Pet.Texts.PowerMissing.ShortValue
			Power_Missing_ShowAlways = db.oUF.Pet.Texts.PowerMissing.ShowAlways
			Power_Missing_ColorClass = db.oUF.Pet.Texts.PowerMissing.ColorClass
			Power_Missing_ColorType = db.oUF.Pet.Texts.PowerMissing.ColorType
			Power_Missing_IndividualColor_Enable = db.oUF.Pet.Texts.PowerMissing.IndividualColor.Enable
			Power_Missing_IndividualColor_r = db.oUF.Pet.Texts.PowerMissing.IndividualColor.r
			Power_Missing_IndividualColor_g = db.oUF.Pet.Texts.PowerMissing.IndividualColor.g
			Power_Missing_IndividualColor_b = db.oUF.Pet.Texts.PowerMissing.IndividualColor.b
		else
			Power_ColorClass = db.oUF.Player.Power.ColorClass
			Power_IndividualColor = db.oUF.Player.Power.IndividualColor.Enable
			Power_IndividualColor_r = db.oUF.Player.Power.IndividualColor.r
			Power_IndividualColor_g = db.oUF.Player.Power.IndividualColor.g
			Power_IndividualColor_b = db.oUF.Player.Power.IndividualColor.b
			Power_ColorType = db.oUF.Player.Power.ColorType
			
			Power_Value_Enable = db.oUF.Player.Texts.Power.Enable
			Power_Value_Format = db.oUF.Player.Texts.Power.Format
			Power_Value_ColorClass = db.oUF.Player.Texts.Power.ColorClass
			Power_Value_ColorType = db.oUF.Player.Texts.Power.ColorType
			Power_Value_IndividualColor_Enable = db.oUF.Player.Texts.Power.IndividualColor.Enable
			Power_Value_IndividualColor_r = db.oUF.Player.Texts.Power.IndividualColor.r
			Power_Value_IndividualColor_g = db.oUF.Player.Texts.Power.IndividualColor.g
			Power_Value_IndividualColor_b = db.oUF.Player.Texts.Power.IndividualColor.b
			
			Power_Percent_Enable = db.oUF.Player.Texts.PowerPercent.Enable
			Power_Percent_ShowAlways = db.oUF.Player.Texts.PowerPercent.ShowAlways
			Power_Percent_ColorClass = db.oUF.Player.Texts.PowerPercent.ColorClass
			Power_Percent_ColorType = db.oUF.Player.Texts.PowerPercent.ColorType
			Power_Percent_IndividualColor_Enable = db.oUF.Player.Texts.PowerPercent.IndividualColor.Enable
			Power_Percent_IndividualColor_r = db.oUF.Player.Texts.PowerPercent.IndividualColor.r
			Power_Percent_IndividualColor_g = db.oUF.Player.Texts.PowerPercent.IndividualColor.g
			Power_Percent_IndividualColor_b = db.oUF.Player.Texts.PowerPercent.IndividualColor.b
			
			Power_Missing_Enable = db.oUF.Player.Texts.PowerMissing.Enable
			Power_Missing_ShortValue = db.oUF.Player.Texts.PowerMissing.ShortValue
			Power_Missing_ShowAlways = db.oUF.Player.Texts.PowerMissing.ShowAlways
			Power_Missing_ColorClass = db.oUF.Player.Texts.PowerMissing.ColorClass
			Power_Missing_ColorType = db.oUF.Player.Texts.PowerMissing.ColorType
			Power_Missing_IndividualColor_Enable = db.oUF.Player.Texts.PowerMissing.IndividualColor.Enable
			Power_Missing_IndividualColor_r = db.oUF.Player.Texts.PowerMissing.IndividualColor.r
			Power_Missing_IndividualColor_g = db.oUF.Player.Texts.PowerMissing.IndividualColor.g
			Power_Missing_IndividualColor_b = db.oUF.Player.Texts.PowerMissing.IndividualColor.b
		end
	elseif unit == "vehicle" then
		Power_ColorClass = db.oUF.Player.Power.ColorClass
		Power_IndividualColor = db.oUF.Player.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.Player.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.Player.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.Player.Power.IndividualColor.b
		Power_ColorType = db.oUF.Player.Power.ColorType
		
		Power_Value_Enable = db.oUF.Player.Texts.Power.Enable
		Power_Value_Format = db.oUF.Player.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.Player.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.Player.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.Player.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.Player.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.Player.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.Player.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.Player.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.Player.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.Player.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.Player.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.Player.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.Player.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.Player.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.Player.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.Player.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.Player.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.Player.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.Player.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.Player.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.Player.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.Player.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.Player.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.Player.Texts.PowerMissing.IndividualColor.b
	elseif unit == "target" then
		Power_ColorClass = db.oUF.Target.Power.ColorClass
		Power_IndividualColor = db.oUF.Target.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.Target.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.Target.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.Target.Power.IndividualColor.b
		Power_ColorType = db.oUF.Target.Power.ColorType
		
		Power_Value_Enable = db.oUF.Target.Texts.Power.Enable
		Power_Value_Format = db.oUF.Target.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.Target.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.Target.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.Target.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.Target.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.Target.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.Target.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.Target.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.Target.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.Target.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.Target.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.Target.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.Target.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.Target.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.Target.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.Target.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.Target.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.Target.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.Target.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.Target.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.Target.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.Target.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.Target.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.Target.Texts.PowerMissing.IndividualColor.b
	elseif unit == "targettarget" then
		Power_ColorClass = db.oUF.ToT.Power.ColorClass
		Power_IndividualColor = db.oUF.ToT.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.ToT.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.ToT.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.ToT.Power.IndividualColor.b
		Power_ColorType = db.oUF.ToT.Power.ColorType
		
		Power_Value_Enable = db.oUF.ToT.Texts.Power.Enable
		Power_Value_Format = db.oUF.ToT.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.ToT.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.ToT.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.ToT.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.ToT.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.ToT.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.ToT.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.ToT.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.ToT.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.ToT.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.ToT.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.ToT.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.ToT.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.ToT.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.ToT.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.ToT.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.ToT.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.ToT.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.ToT.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.ToT.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.ToT.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.ToT.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.ToT.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.ToT.Texts.PowerMissing.IndividualColor.b
	elseif unit == "targettargettarget" then
		Power_ColorClass = db.oUF.ToToT.Power.ColorClass
		Power_IndividualColor = db.oUF.ToToT.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.ToToT.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.ToToT.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.ToToT.Power.IndividualColor.b
		Power_ColorType = db.oUF.ToToT.Power.ColorType
		
		Power_Value_Enable = db.oUF.ToToT.Texts.Power.Enable
		Power_Value_Format = db.oUF.ToToT.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.ToToT.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.ToToT.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.ToToT.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.ToToT.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.ToToT.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.ToToT.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.ToToT.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.ToToT.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.ToToT.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.ToToT.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.ToToT.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.ToToT.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.ToToT.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.ToToT.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.ToToT.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.ToToT.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.ToToT.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.ToToT.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.ToToT.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.ToToT.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.ToToT.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.ToToT.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.ToToT.Texts.PowerMissing.IndividualColor.b
	elseif unit == "focus" then
		Power_ColorClass = db.oUF.Focus.Power.ColorClass
		Power_IndividualColor = db.oUF.Focus.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.Focus.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.Focus.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.Focus.Power.IndividualColor.b
		Power_ColorType = db.oUF.Focus.Power.ColorType
		
		Power_Value_Enable = db.oUF.Focus.Texts.Power.Enable
		Power_Value_Format = db.oUF.Focus.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.Focus.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.Focus.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.Focus.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.Focus.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.Focus.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.Focus.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.Focus.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.Focus.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.Focus.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.Focus.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.Focus.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.Focus.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.Focus.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.Focus.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.Focus.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.Focus.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.Focus.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.Focus.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.Focus.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.Focus.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.Focus.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.Focus.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.Focus.Texts.PowerMissing.IndividualColor.b
	elseif unit == "focustarget" then
		Power_ColorClass = db.oUF.FocusTarget.Power.ColorClass
		Power_IndividualColor = db.oUF.FocusTarget.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.FocusTarget.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.FocusTarget.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.FocusTarget.Power.IndividualColor.b
		Power_ColorType = db.oUF.FocusTarget.Power.ColorType
		
		Power_Value_Enable = db.oUF.FocusTarget.Texts.Power.Enable
		Power_Value_Format = db.oUF.FocusTarget.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.FocusTarget.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.FocusTarget.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.FocusTarget.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.FocusTarget.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.FocusTarget.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.FocusTarget.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.FocusTarget.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.FocusTarget.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.FocusTarget.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.FocusTarget.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.FocusTarget.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.FocusTarget.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.FocusTarget.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.FocusTarget.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.FocusTarget.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.FocusTarget.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.FocusTarget.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.FocusTarget.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.FocusTarget.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.FocusTarget.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.FocusTarget.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.FocusTarget.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.FocusTarget.Texts.PowerMissing.IndividualColor.b
	elseif unit == "pet" then
		Power_ColorClass = db.oUF.Pet.Power.ColorClass
		Power_IndividualColor = db.oUF.Pet.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.Pet.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.Pet.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.Pet.Power.IndividualColor.b
		Power_ColorType = db.oUF.Pet.Power.ColorType
		Power_ColorHappy = db.oUF.Pet.Power.ColorHappy
		
		Power_Value_Enable = db.oUF.Pet.Texts.Power.Enable
		Power_Value_Format = db.oUF.Pet.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.Pet.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.Pet.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.Pet.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.Pet.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.Pet.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.Pet.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.Pet.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.Pet.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.Pet.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.Pet.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.Pet.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.Pet.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.Pet.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.Pet.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.Pet.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.Pet.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.Pet.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.Pet.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.Pet.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.Pet.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.Pet.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.Pet.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.Pet.Texts.PowerMissing.IndividualColor.b
	elseif unit == "pettarget" then
		Power_ColorClass = db.oUF.PetTarget.Power.ColorClass
		Power_IndividualColor = db.oUF.PetTarget.Power.IndividualColor.Enable
		Power_IndividualColor_r = db.oUF.PetTarget.Power.IndividualColor.r
		Power_IndividualColor_g = db.oUF.PetTarget.Power.IndividualColor.g
		Power_IndividualColor_b = db.oUF.PetTarget.Power.IndividualColor.b
		Power_ColorType = db.oUF.PetTarget.Power.ColorType
		
		Power_Value_Enable = db.oUF.PetTarget.Texts.Power.Enable
		Power_Value_Format = db.oUF.PetTarget.Texts.Power.Format
		Power_Value_ColorClass = db.oUF.PetTarget.Texts.Power.ColorClass
		Power_Value_ColorType = db.oUF.PetTarget.Texts.Power.ColorType
		Power_Value_IndividualColor_Enable = db.oUF.PetTarget.Texts.Power.IndividualColor.Enable
		Power_Value_IndividualColor_r = db.oUF.PetTarget.Texts.Power.IndividualColor.r
		Power_Value_IndividualColor_g = db.oUF.PetTarget.Texts.Power.IndividualColor.g
		Power_Value_IndividualColor_b = db.oUF.PetTarget.Texts.Power.IndividualColor.b
		
		Power_Percent_Enable = db.oUF.PetTarget.Texts.PowerPercent.Enable
		Power_Percent_ShowAlways = db.oUF.PetTarget.Texts.PowerPercent.ShowAlways
		Power_Percent_ColorClass = db.oUF.PetTarget.Texts.PowerPercent.ColorClass
		Power_Percent_ColorType = db.oUF.PetTarget.Texts.PowerPercent.ColorType
		Power_Percent_IndividualColor_Enable = db.oUF.PetTarget.Texts.PowerPercent.IndividualColor.Enable
		Power_Percent_IndividualColor_r = db.oUF.PetTarget.Texts.PowerPercent.IndividualColor.r
		Power_Percent_IndividualColor_g = db.oUF.PetTarget.Texts.PowerPercent.IndividualColor.g
		Power_Percent_IndividualColor_b = db.oUF.PetTarget.Texts.PowerPercent.IndividualColor.b
		
		Power_Missing_Enable = db.oUF.PetTarget.Texts.PowerMissing.Enable
		Power_Missing_ShortValue = db.oUF.PetTarget.Texts.PowerMissing.ShortValue
		Power_Missing_ShowAlways = db.oUF.PetTarget.Texts.PowerMissing.ShowAlways
		Power_Missing_ColorClass = db.oUF.PetTarget.Texts.PowerMissing.ColorClass
		Power_Missing_ColorType = db.oUF.PetTarget.Texts.PowerMissing.ColorType
		Power_Missing_IndividualColor_Enable = db.oUF.PetTarget.Texts.PowerMissing.IndividualColor.Enable
		Power_Missing_IndividualColor_r = db.oUF.PetTarget.Texts.PowerMissing.IndividualColor.r
		Power_Missing_IndividualColor_g = db.oUF.PetTarget.Texts.PowerMissing.IndividualColor.g
		Power_Missing_IndividualColor_b = db.oUF.PetTarget.Texts.PowerMissing.IndividualColor.b
	end
	
	if Power_ColorClass == true then
		if color then
			self.Power:SetStatusBarColor(color[1], color[2], color[3])
			local bg = self.Power.bg
			local mu = bg.multiplier or 1
			bg:SetVertexColor(color[1]*mu, color[2]*mu, color[3]*mu)
		else
			if color2 then
				self.Power:SetStatusBarColor(color2[1], color2[2], color2[3])
				local bg = self.Power.bg
				local mu = bg.multiplier or 1
				bg:SetVertexColor(color2[1]*mu, color2[2]*mu, color2[3]*mu)
			else
				self.Power:SetStatusBarColor(0.5, 0.5, 0.5)
				local bg = self.Power.bg
				local mu = bg.multiplier or 1
				bg:SetVertexColor(0.5*mu, 0.5*mu, 0.5*mu)
			end
		end
	elseif Power_ColorHappy == true then
		if(playerClass == "HUNTER") and self.unit == "pet" then
			local pHappy = GetPetHappiness()
			
			if pHappy then
				local color3 = colors.happiness[pHappy]
				if color3 then
					self.Power:SetStatusBarColor(color3[1], color3[2], color3[3])
					local bg = self.Power.bg
					local mu = bg.multiplier or 1
					bg:SetVertexColor(color3[1]*mu, color3[2]*mu, color3[3]*mu)
				else
					self.Power:SetStatusBarColor(0.5, 0.5, 0.5)
					local bg = self.Power.bg
					local mu = bg.multiplier or 1
					bg:SetVertexColor(0.5*mu, 0.5*mu, 0.5*mu)
				end
			end
		end
	elseif Power_IndividualColor == true then
		self.Power:SetStatusBarColor(Power_IndividualColor_r, Power_IndividualColor_g, Power_IndividualColor_b)
		local bg = self.Power.bg
		local mu = bg.multiplier or 1
		bg:SetVertexColor(Power_IndividualColor_r*mu, Power_IndividualColor_g*mu, Power_IndividualColor_b*mu)
	elseif Power_ColorType == true then
		if color2 then
			self.Power:SetStatusBarColor(color2[1], color2[2], color2[3])
			local bg = self.Power.bg
			local mu = bg.multiplier or 1
			bg:SetVertexColor(color2[1]*mu, color2[2]*mu, color2[3]*mu)
		else
			if color then
				self.Power:SetStatusBarColor(color[1], color[2], color[3])
				local bg = self.Power.bg
				local mu = bg.multiplier or 1
				bg:SetVertexColor(color[1]*mu, color[2]*mu, color[3]*mu)
			else
				self.Power:SetStatusBarColor(0.5, 0.5, 0.5)
				local bg = self.Power.bg
				local mu = bg.multiplier or 1
				bg:SetVertexColor(0.5*mu, 0.5*mu, 0.5*mu)
			end
		end
	end
	
	if not UnitIsConnected(unit) then
		bar:SetValue(0)
		bar.valuePercent:SetText()
		bar.valueMissing:SetText()
		bar.value:SetText()
	elseif UnitIsDead(unit) then
		bar:SetValue(0)
		bar.valuePercent:SetText()
		bar.valueMissing:SetText()
		bar.value:SetText()
	elseif UnitIsGhost(unit) then
		bar:SetValue(0)
		bar.valuePercent:SetText()
		bar.valueMissing:SetText()
		bar.value:SetText()
	else
		local powerPercent = 100 * min / max
		powerPercent = string.format("%.1f", powerPercent)
		powerPercent = powerPercent.."%"
	
		
		if Power_Value_Enable == true and min >= 1 then
			bar.value:Show()
			
			if Power_Value_Format == "Absolut" then
				bar.value:SetFormattedText("%s/%s",min,max)
			elseif Power_Value_Format == "Absolut & Percent" then
				bar.value:SetFormattedText("%s/%s | %s",min,max,powerPercent)
			elseif Power_Value_Format == "Absolut Short" then
				bar.value:SetFormattedText("%s/%s",ShortValue(min),ShortValue(max))
			elseif Power_Value_Format == "Absolut Short & Percent" then
				bar.value:SetFormattedText("%s/%s | %s",ShortValue(min),ShortValue(max),powerPercent)
			elseif Power_Value_Format == "Standard" then
				bar.value:SetText(min)
			elseif Power_Value_Format == "Standard Short" then
				bar.value:SetText(ShortValue(min))
			else
				bar.value:SetText(min)
			end
			
			if Power_Value_ColorClass == true then
				if color then
					bar.value:SetTextColor(color[1],color[2],color[3])
				else
					if color2 then
						bar.value:SetTextColor(color2[1],color2[2],color2[3])
					else
						bar.value:SetTextColor(0, 0, 0)
					end
				end
			elseif Power_Value_ColorType == true then
				if color2 then
					bar.value:SetTextColor(color2[1],color2[2],color2[3])
				else
					if color then
						bar.value:SetTextColor(color[1],color[2],color[3])
					else
						bar.value:SetTextColor(0, 0, 0)
					end
				end
			elseif Power_Value_IndividualColor_Enable == true then
				bar.value:SetTextColor(Power_Value_IndividualColor_r, Power_Value_IndividualColor_g, Power_Value_IndividualColor_b)
			end
		else
			bar.value:SetText()
			bar.value:Hide()
		end
		
		if Power_Percent_Enable == true then
			bar.valuePercent:SetText(powerPercent)
			
			if Power_Percent_ShowAlways == true then
				bar.valuePercent:Show()
			else
				if min ~= max then
					bar.valuePercent:Show()
				else
					bar.valuePercent:Hide()
				end
			end
			
			if Power_Percent_ColorClass == true then
				if color then
					bar.valuePercent:SetTextColor(color[1],color[2],color[3])
				else
					if color2 then
						bar.valuePercent:SetTextColor(color2[1],color2[2],color2[3])
					else
						bar.valuePercent:SetTextColor(0, 0, 0)
					end
				end
			elseif Power_Percent_ColorType == true then
				if color2 then
					bar.valuePercent:SetTextColor(color2[1],color2[2],color2[3])
				else
					if color then
						bar.valuePercent:SetTextColor(color[1],color[2],color[3])
					else
						bar.valuePercent:SetTextColor(0, 0, 0)
					end
				end
			elseif Power_Percent_IndividualColor_Enable == true then
				bar.valuePercent:SetTextColor(Power_Percent_IndividualColor_r, Power_Percent_IndividualColor_g, Power_Percent_IndividualColor_b)
			end
		else
			bar.valuePercent:SetText()
			bar.valuePercent:Hide()
		end
		
		if Power_Missing_Enable == true then
			local powerMissing = max-min
			
			if Power_Missing_ShortValue == true then
				bar.valueMissing:SetText("-"..ShortValue(powerMissing))
			else
				bar.valueMissing:SetText("-"..powerMissing)
			end
			
			if Power_Missing_ShowAlways == true then
				bar.valueMissing:Show()
			else
				if powerMissing > 0 then
					bar.valueMissing:Show()
				else
					bar.valueMissing:Hide()
				end
			end

			if Power_Missing_ColorClass == true then
				if color then
					bar.valueMissing:SetTextColor(color[1],color[2],color[3])
				else
					if color2 then
						bar.valueMissing:SetTextColor(color2[1],color2[2],color2[3])
					else
						bar.valueMissing:SetTextColor(0, 0, 0)
					end
				end
			elseif Power_Missing_ColorType == true then
				if color2 then
					bar.valueMissing:SetTextColor(color2[1],color2[2],color2[3])
				else
					if color then
						bar.valueMissing:SetTextColor(color[1],color[2],color[3])
					else
						bar.valueMissing:SetTextColor(0, 0, 0)
					end
				end
			elseif Power_Missing_IndividualColor_Enable == true then
				bar.valueMissing:SetTextColor(Power_Missing_IndividualColor_r, Power_Missing_IndividualColor_g, Power_Missing_IndividualColor_b)
			end
		else
			bar.valueMissing:SetText()
			bar.valueMissing:Hide()
		end
	end
end

local delay = 0
local viperAspectName = GetSpellInfo(34074)
local UpdateManaLevel = function(self, elapsed)
	delay = delay + elapsed
	if self.parent.unit ~= "player" or delay < 0.2 or UnitIsDeadOrGhost("player") or UnitPowerType("player") ~= 0 then return end
	delay = 0

	local percMana = UnitMana("player") / UnitManaMax("player") * 100

	if AotV then
		local viper = UnitBuff("player", viperAspectName)
		if percMana >= highThreshold and viper then
			self.ManaLevel:SetText("|cffaf5050GO HAWK|r")
			Flash(self, 0.3)
		elseif percMana <= lowThreshold and not viper then
			self.ManaLevel:SetText("|cffaf5050GO VIPER|r")
			Flash(self, 0.3)
		else
			self.ManaLevel:SetText()
			StopFlash(self)
		end
	else
		if percMana <= lowThreshold then
			self.ManaLevel:SetText("|cffaf5050"..ouf_lowmana.."|r")
			Flash(self, 0.3)
		else
			self.ManaLevel:SetText()
			StopFlash(self)
		end
	end
end

local UpdateDruidMana = function(self)
	if self.unit ~= "player" then return end

	local num, str = UnitPowerType("player")
	if num ~= 0 then
		local min = UnitPower("player", 0)
		local max = UnitPowerMax("player", 0)

		local percMana = min / max * 100
		if percMana <= lowThreshold then
			self.FlashInfo.ManaLevel:SetText("|cffaf5050"..ouf_lowmana.."|r")
			Flash(self.FlashInfo, 0.3)
		else
			self.FlashInfo.ManaLevel:SetText()
			StopFlash(self.FlashInfo)
		end

		if min ~= max then
			if self.Power.value:GetText() then
				if DruidMana_ShowIndicator == true then
					if DruidMana_ShowPercent == true then
						self.DruidMana:SetFormattedText("|cffD7BEA5-|r %s%%|r", floor(min / max * 100))
					else
						if DruidMana_ShowShortValue == true then
							self.DruidMana:SetFormattedText("|cffD7BEA5-|r %s|r", ShortValue(min))
						else
							self.DruidMana:SetFormattedText("|cffD7BEA5-|r %s|r", min)
						end
					end
				else
					if DruidMana_ShowPercent == true then
						self.DruidMana:SetFormattedText("%s%%", floor(min / max * 100))
					else
						if DruidMana_ShowShortValue == true then
							self.DruidMana:SetFormattedText("%s", ShortValue(min))
						else
							self.DruidMana:SetFormattedText("%s", min)
						end
					end
				end
			else
				if DruidMana_HideIfNoPower == true then
					self.DruidMana:SetText()
				else
					if DruidMana_ShowIndicator == true then
						if DruidMana_ShowPercent == true then
							self.DruidMana:SetFormattedText("|cffD7BEA5-|r %s%%|r", floor(min / max * 100))
						else
							if DruidMana_ShowShortValue == true then
								self.DruidMana:SetFormattedText("|cffD7BEA5-|r %s|r", ShortValue(min))
							else
								self.DruidMana:SetFormattedText("|cffD7BEA5-|r %s|r", min)
							end
						end
					else
						if DruidMana_ShowPercent == true then
							self.DruidMana:SetFormattedText("%s%%", floor(min / max * 100))
						else
							if DruidMana_ShowShortValue == true then
								self.DruidMana:SetFormattedText("%s", ShortValue(min))
							else
								self.DruidMana:SetFormattedText("%s", min)
							end
						end
					end
				end
			end
		else
			self.DruidMana:SetText()
		end
		
		self.DruidMana:SetAlpha(1)
	else
		self.DruidMana:SetAlpha(0)
	end
end

local FormatPlayerCastbarTime = function(self, duration)
	if self.channeling then
		if db.Castbar.Player.Text.Time.ShowMax == true then
			self.Time:SetFormattedText("%.1f / %.1f", duration, self.max)
		else
			self.Time:SetFormattedText("%.1f", duration)
		end
	elseif self.casting then
		if db.Castbar.Player.Text.Time.ShowMax== true then
			self.Time:SetFormattedText("%.1f / %.1f", self.max - duration, self.max)
		else
			self.Time:SetFormattedText("%.1f ", self.max - duration)
		end
	end
end

local FormatTargetCastbarTime = function(self, duration)
	if self.channeling then
		if db.Castbar.Target.Text.Time.ShowMax == true then
			self.Time:SetFormattedText("%.1f / %.1f", duration, self.max)
		else
			self.Time:SetFormattedText("%.1f", duration)
		end
	elseif self.casting then
		if db.Castbar.Target.Text.Time.ShowMax== true then
			self.Time:SetFormattedText("%.1f / %.1f", self.max - duration, self.max)
		else
			self.Time:SetFormattedText("%.1f ", self.max - duration)
		end
	end
end

local FormatFocusCastbarTime = function(self, duration)
	if self.channeling then
		if db.Castbar.Focus.Text.Time.ShowMax == true then
			self.Time:SetFormattedText("%.1f / %.1f", duration, self.max)
		else
			self.Time:SetFormattedText("%.1f", duration)
		end
	elseif self.casting then
		if db.Castbar.Focus.Text.Time.ShowMax== true then
			self.Time:SetFormattedText("%.1f / %.1f", self.max - duration, self.max)
		else
			self.Time:SetFormattedText("%.1f ", self.max - duration)
		end
	end
end

local UpdateReputationColor = function(self, event, unit, bar)
	local name, id = GetWatchedFactionInfo()
	bar:SetStatusBarColor(FACTION_BAR_COLORS[id].r, FACTION_BAR_COLORS[id].g, FACTION_BAR_COLORS[id].b)
end

local FormatTime = function(s)
	local day, hour, minute = 86400, 3600, 60
	if s >= day then
		return format("%dd", floor(s/day + 1)), s % day
	elseif s >= hour then
		return format("%dh", floor(s/hour + 1)), s % hour
	elseif s >= minute then
		if s <= minute * 1 then
			return format('%d:%02d', floor(s/60), s % minute), s - floor(s)
		end
		return format("%dm", floor(s/minute + 1)), s % minute
	end
	return format("%.1f", s), (s * 100 - floor(s * 100))/100
end

local CreateAuraTimer = function(self,elapsed)
	if self.timeLeft then
		self.elapsed = (self.elapsed or 0) + elapsed
		if self.elapsed >= 0.1 then
			if not self.first then
				self.timeLeft = self.timeLeft - self.elapsed
			else
				self.timeLeft = self.timeLeft - GetTime()
				self.first = false
			end
			if self.timeLeft > 0 then
				local time = FormatTime(self.timeLeft)
--				if type(time) == "string" or time >= 10 then
					self.remaining:SetText(time)
--				else
--					self.remaining:SetFormattedText("%.1f", time)
--				end
				self.remaining:SetTextColor(1, 1, 1)
			else
				self.remaining:Hide()
				self:SetScript("OnUpdate", nil)
			end
			self.elapsed = 0
		end
	end
end

local CancelAura = function(self, button)
	if button == "RightButton" and not self.debuff then
		CancelUnitBuff("player", self:GetID())
	end
end

local CreateAura = function(self, button, icons)
	button.backdrop = CreateFrame("Frame", nil, button)
	button.backdrop:SetPoint("TOPLEFT", button, "TOPLEFT", -3.5, 3)
	button.backdrop:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 4, -3.5)
	button.backdrop:SetFrameStrata("BACKGROUND")
	button.backdrop:SetBackdrop {
		edgeFile = glowTex, edgeSize = 5,
		insets = {left = 3, right = 3, top = 3, bottom = 3}
	}
	button.backdrop:SetBackdropColor(0, 0, 0, 0)
	button.backdrop:SetBackdropBorderColor(0, 0, 0)

	button.count:SetPoint("BOTTOMRIGHT", -1, 2)
	button.count:SetJustifyH("RIGHT")
	--button.count:SetFont(fontn, 10, "OUTLINE")
	button.count:SetFont(font3, 16, "OUTLINE")
	button.count:SetTextColor(0.84, 0.75, 0.65)
	
	button.cd.noOCC = true
	button.cd.noCooldownCount = true
	icons.disableCooldown = true
	icons.showDebuffType = true

	button.overlay:SetTexture(buttonTex)
	button.overlay:SetPoint("TOPLEFT", button, "TOPLEFT", -2, 2)
	button.overlay:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
	button.overlay:SetTexCoord(0, 1, 0.02, 1)
	button.overlay.Hide = function(self) end

	if icons ~= self.Enchant then
		button.remaining = SetFontString(button, LSM:Fetch("font", db.oUF.auras.auratimer_font), db.oUF.auras.auratimer_size, db.oUF.auras.auratimer_flag)
		if self.unit == "player" then
			button:SetScript("OnMouseUp", CancelAura)
		end
	else
		button.remaining = SetFontString(button, LSM:Fetch("font", db.oUF.auras.auratimer_font), db.oUF.auras.auratimer_size, db.oUF.auras.auratimer_flag)
		button.overlay:SetVertexColor(0.33, 0.59, 0.33)
	end
	button.remaining:SetPoint("TOPLEFT", 1, -1)
	
	if self.unit == "target" then
		if db.oUF.auras.target.buffs_auratimer == true then
			button.remaining:Show()
		else
			button.remaining:Hide()
		end
	elseif self.unit == "player" then
		if db.oUF.auras.player2.buffs_auratimer == true then
			button.remaining:Show()
		else
			button.remaining:Hide()
		end
	elseif self.unit == "focus" then
		if db.oUF.auras.focus.buffs_auratimer == true then
			button.remaining:Show()
		else
			button.remaining:Hide()
		end
	elseif self.unit == "pet" then
		if db.oUF.auras.pet.buffs_auratimer == true then
			button.remaining:Show()
		else
			button.remaining:Hide()
		end
	elseif self.unit == "targettarget" then
		if db.oUF.auras.tot.buffs_auratimer == true then
			button.remaining:Show()
		else
			button.remaining:Hide()
		end
	end
end

local CreateEnchantTimer = function(self, icons)
	for i = 1, 2 do
		local icon = icons[i]
		if icon.expTime then
			icon.timeLeft = icon.expTime - GetTime()
			icon.remaining:Show()
		else
			icon.remaining:Hide()
		end
		icon:SetScript("OnUpdate", CreateAuraTimer)
	end
end

local UpdateAura = function(self, icons, unit, icon, index)
	local _, _, _, _, _, duration, expirationTime, unitCaster, _ = UnitAura(unit, index, icon.filter)
	if unitCaster == "player" or unitCaster == "pet" or unitCaster == "vehicle" then
		if unit == "target" then
			if icon.debuff and db.oUF.auras.target.debuffs_colorbytype == false then
				icon.overlay:SetVertexColor(0.69, 0.31, 0.31)
			elseif icon.debuff and db.oUF.auras.target.debuffs_colorbytype == true then
				-- do nothing, color by type
			else
				icon.overlay:SetVertexColor(1, 1, 1)
			end
		elseif unit == "player" then
			if icon.debuff and db.oUF.auras.player2.debuffs_colorbytype == false then
				icon.overlay:SetVertexColor(0.69, 0.31, 0.31)
			elseif icon.debuff and db.oUF.auras.player2.debuffs_colorbytype == true then
				-- do nothing, color by type
			else
				icon.overlay:SetVertexColor(1, 1, 1)
			end
		elseif unit == "focus" then
			if icon.debuff and db.oUF.auras.focus.debuffs_colorbytype == false then
				icon.overlay:SetVertexColor(0.69, 0.31, 0.31)
			elseif icon.debuff and db.oUF.auras.focus.debuffs_colorbytype == true then
				-- do nothing, color by type
			else
				icon.overlay:SetVertexColor(1, 1, 1)
			end
		elseif unit == "pet" then
			if icon.debuff and db.oUF.auras.pet.debuffs_colorbytype == false then
				icon.overlay:SetVertexColor(0.69, 0.31, 0.31)
			elseif icon.debuff and db.oUF.auras.pet.debuffs_colorbytype == true then
				-- do nothing, color by type
			else
				icon.overlay:SetVertexColor(1, 1, 1)
			end
		elseif unit == "targettarget" then
			if icon.debuff and db.oUF.auras.tot.debuffs_colorbytype == false then
				icon.overlay:SetVertexColor(0.69, 0.31, 0.31)
			elseif icon.debuff and db.oUF.auras.tot.debuffs_colorbytype == true then
				-- do nothing, color by type
			else
				icon.overlay:SetVertexColor(1, 1, 1)
			end
		end
	else
		if UnitIsEnemy("player", unit) then
			if icon.debuff then
				icon.icon:SetDesaturated(true)
			end
		else
			if unit == "target" then
				if icon.debuff and db.oUF.auras.target.debuffs_colorbytype == false then
					icon.overlay:SetVertexColor(0.69, 0.31, 0.31)
				elseif icon.debuff and db.oUF.auras.target.debuffs_colorbytype == true then
					-- do nothing, color by type
				else
					icon.overlay:SetVertexColor(1, 1, 1)
				end
			elseif unit == "player" then
				if icon.debuff and db.oUF.auras.player2.debuffs_colorbytype == false then
					icon.overlay:SetVertexColor(0.69, 0.31, 0.31)
				elseif icon.debuff and db.oUF.auras.player2.debuffs_colorbytype == true then
					-- do nothing, color by type
				else
					icon.overlay:SetVertexColor(1, 1, 1)
				end
			elseif unit == "focus" then
				if icon.debuff and db.oUF.auras.focus.debuffs_colorbytype == false then
					icon.overlay:SetVertexColor(0.69, 0.31, 0.31)
				elseif icon.debuff and db.oUF.auras.focus.debuffs_colorbytype == true then
					-- do nothing, color by type
				else
					icon.overlay:SetVertexColor(1, 1, 1)
				end
			elseif unit == "pet" then
				if icon.debuff and db.oUF.auras.pet.debuffs_colorbytype == false then
					icon.overlay:SetVertexColor(0.69, 0.31, 0.31)
				elseif icon.debuff and db.oUF.auras.pet.debuffs_colorbytype == true then
					-- do nothing, color by type
				else
					icon.overlay:SetVertexColor(1, 1, 1)
				end
			elseif unit == "targettarget" then
				if icon.debuff and db.oUF.auras.tot.debuffs_colorbytype == false then
					icon.overlay:SetVertexColor(0.69, 0.31, 0.31)
				elseif icon.debuff and db.oUF.auras.tot.debuffs_colorbytype == true then
					-- do nothing, color by type
				else
					icon.overlay:SetVertexColor(1, 1, 1)
				end
			end
		end
		--icon.overlay:SetVertexColor(1, 1, 1)
	end

	if duration and duration > 0 then
		if unit == "target" then
			if icon.buff then
				if db.oUF.auras.target.buffs_auratimer == true then
					icon.remaining:Show()
				else
					icon.remaining:Hide()
				end
			elseif icon.debuff then
				if db.oUF.auras.target.debuffs_auratimer == true then
					icon.remaining:Show()
				else
					icon.remaining:Hide()
				end
			end
		elseif unit == "player" then
			if icon.buff then
				if db.oUF.auras.player2.buffs_auratimer == true then
					icon.remaining:Show()
				else
					icon.remaining:Hide()
				end
			elseif icon.debuff then
				if db.oUF.auras.player2.debuffs_auratimer == true then
					icon.remaining:Show()
				else
					icon.remaining:Hide()
				end
			end
		elseif unit == "focus" then
			if icon.buff then
				if db.oUF.auras.focus.buffs_auratimer == true then
					icon.remaining:Show()
				else
					icon.remaining:Hide()
				end
			elseif icon.debuff then
				if db.oUF.auras.focus.debuffs_auratimer == true then
					icon.remaining:Show()
				else
					icon.remaining:Hide()
				end
			end
		elseif unit == "pet" then
			if icon.buff then
				if db.oUF.auras.pet.buffs_auratimer == true then
					icon.remaining:Show()
				else
					icon.remaining:Hide()
				end
			elseif icon.debuff then
				if db.oUF.auras.pet.debuffs_auratimer == true then
					icon.remaining:Show()
				else
					icon.remaining:Hide()
				end
			end
		elseif unit == "targettarget" then
			if icon.buff then
				if db.oUF.auras.tot.buffs_auratimer == true then
					icon.remaining:Show()
				else
					icon.remaining:Hide()
				end
			elseif icon.debuff then
				if db.oUF.auras.tot.debuffs_auratimer == true then
					icon.remaining:Show()
				else
					icon.remaining:Hide()
				end
			end
		end
	else
		icon.remaining:Hide()
	end

	icon.duration = duration
	icon.timeLeft = expirationTime
	icon.first = true
	icon:SetScript("OnUpdate", CreateAuraTimer)
end

local HidePortrait = function(self, unit)
	if self.unit == "target" then
		if not UnitExists(self.unit) or not UnitIsConnected(self.unit) or not UnitIsVisible(self.unit) then
			self.Portrait:SetAlpha(0)
		else
			self.Portrait:SetAlpha(1)
		end
	end
end

local PostUpdateThreat = function(self, event, unit, status)
	if not status or status == 0 then
		self.ThreatFeedbackFrame:SetBackdropBorderColor(0, 0, 0)
		self.ThreatFeedbackFrame:Show()
	end
end

------------------------------------------------------------------------
--	Layout Style
------------------------------------------------------------------------

local SetStyle = function(self, unit)
	self.menu = Menu
	self.colors = colors
	self:RegisterForClicks("AnyUp")
	self:SetAttribute("type2", "menu")

	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	
	self.MoveableFrames = true
	
	self.Health = CreateFrame("StatusBar", self:GetName().."_Health", self)
	self.Power = CreateFrame("StatusBar", self:GetName().."_Power", self)
	self.Full = CreateFrame("StatusBar", self:GetName().."_Full", self)
	
	if unit then
		self.Health:SetFrameLevel(2)
	elseif self:GetAttribute("unitsuffix") then
		self.Health:SetFrameLevel(2)
	elseif not unit then
		self.Health:SetFrameLevel(2)
	end
	
------------------------------------------------------------------------
--	BOSS
------------------------------------------------------------------------
	if((unit and unit:find("boss%d")) or (strsub(SecureButton_GetUnit(self), 0, 4) == "boss")) then
		Fullbar_Enable = db.oUF.Boss.Full.Enable
		Fullbar_Height = tonumber(db.oUF.Boss.Full.Height)
		Fullbar_Texture = LSM:Fetch("statusbar", db.oUF.Boss.Full.Texture)
		Fullbar_Padding = tonumber(db.oUF.Boss.Full.Padding)
		Fullbar_Alpha = db.oUF.Boss.Full.Alpha
		Fullbar_Color_r = tonumber(db.oUF.Boss.Full.Color.r)
		Fullbar_Color_g = tonumber(db.oUF.Boss.Full.Color.g)
		Fullbar_Color_b = tonumber(db.oUF.Boss.Full.Color.b)
		Fullbar_Color_a = tonumber(db.oUF.Boss.Full.Color.a)
	
		FrameHeight = tonumber(db.oUF.Boss.Height)
		FrameWidth = tonumber(db.oUF.Boss.Width)
		HealthHeight = tonumber(db.oUF.Boss.Health.Height)
		PowerHeight = tonumber(db.oUF.Boss.Power.Height)
		ShowPower = db.oUF.Boss.Power.Enable
		
		HealthPadding =  tonumber(db.oUF.Boss.Health.Padding)
		PowerPadding = tonumber(db.oUF.Boss.Power.Padding)
		
		HealthTexture = LSM:Fetch("statusbar", db.oUF.Boss.Health.Texture)
		HealthTextureBG = LSM:Fetch("statusbar", db.oUF.Boss.Health.TextureBG)
		HealthTextureBGAlpha = tonumber(db.oUF.Boss.Health.BGAlpha)
		HealthTextureBGMP = tonumber(db.oUF.Boss.Health.BGMultiplier)
		
		PowerTexture = LSM:Fetch("statusbar", db.oUF.Boss.Power.Texture)
		PowerTextureBG = LSM:Fetch("statusbar", db.oUF.Boss.Power.TextureBG)
		PowerTextureBGAlpha = tonumber(db.oUF.Boss.Power.BGAlpha)
		PowerTextureBGMP = tonumber(db.oUF.Boss.Power.BGMultiplier)
		
		Health_colorClass = db.oUF.Boss.Health.ColorClass
		Health_colorTapping = false
		Health_colorDisconnected = false
		Health_colorSmooth = db.oUF.Boss.Health.ColorGradient
		Health_Smooth = db.oUF.Boss.Health.Smooth
		Health_colorReaction = false
		Health_frequentUpdates = false
		Health_OverrideUpdateHealth = true
		
		Power_colorDisconnected = false
		Power_colorType = db.oUF.Boss.Power.ColorType
		Power_colorClass = db.oUF.Boss.Power.ColorClass
		Power_Smooth = db.oUF.Boss.Power.Smooth
		Power_colorSmooth = false
		Power_OverrideUpdatePower = true
		Power_colorReaction = false
		Power_frequentUpdates = true
		
		Info_Font = LSM:Fetch("font", db.oUF.Boss.Texts.Name.Font)
		Info_Size = tonumber(db.oUF.Boss.Texts.Name.Size)
		Info_Style = db.oUF.Boss.Texts.Name.Outline
		Info_Point = db.oUF.Boss.Texts.Name.Point
		Info_RelativePoint = db.oUF.Boss.Texts.Name.RelativePoint
		Info_X = tonumber(db.oUF.Boss.Texts.Name.X)
		Info_Y = tonumber(db.oUF.Boss.Texts.Name.Y)
		Info_Format = db.oUF.Boss.Texts.Name.Format
		Info_NameLength = db.oUF.Boss.Texts.Name.Length
		Info_ColorNameByClass = db.oUF.Boss.Texts.Name.ColorNameByClass
		Info_ColorClassByClass = db.oUF.Boss.Texts.Name.ColorClassByClass
		Info_ColorLevelByDifficulty = db.oUF.Boss.Texts.Name.ColorLevelByDifficulty
		Info_ShowClassification = db.oUF.Boss.Texts.Name.ShowClassification
		Info_ShortClassification = db.oUF.Boss.Texts.Name.ShortClassification
		
		Health_Value_Font = LSM:Fetch("font", db.oUF.Boss.Texts.Health.Font)
		Health_Value_Size = tonumber(db.oUF.Boss.Texts.Health.Size)
		Health_Value_Style = db.oUF.Boss.Texts.Health.Outline
		Health_Value_Point = db.oUF.Boss.Texts.Health.Point
		Health_Value_RelativePoint = db.oUF.Boss.Texts.Health.RelativePoint
		Health_Value_X = tonumber(db.oUF.Boss.Texts.Health.X)
		Health_Value_Y = tonumber(db.oUF.Boss.Texts.Health.Y)
		
		Health_Percent_Font = LSM:Fetch("font", db.oUF.Boss.Texts.HealthPercent.Font)
		Health_Percent_Size = tonumber(db.oUF.Boss.Texts.HealthPercent.Size)
		Health_Percent_Style = db.oUF.Boss.Texts.HealthPercent.Outline
		Health_Percent_Point = db.oUF.Boss.Texts.HealthPercent.Point
		Health_Percent_RelativePoint = db.oUF.Boss.Texts.HealthPercent.RelativePoint
		Health_Percent_X = tonumber(db.oUF.Boss.Texts.HealthPercent.X)
		Health_Percent_Y = tonumber(db.oUF.Boss.Texts.HealthPercent.Y)
		
		Health_Missing_Font = LSM:Fetch("font", db.oUF.Boss.Texts.HealthMissing.Font)
		Health_Missing_Size = tonumber(db.oUF.Boss.Texts.HealthMissing.Size)
		Health_Missing_Style = db.oUF.Boss.Texts.HealthMissing.Outline
		Health_Missing_Point = db.oUF.Boss.Texts.HealthMissing.Point
		Health_Missing_RelativePoint = db.oUF.Boss.Texts.HealthMissing.RelativePoint
		Health_Missing_X = tonumber(db.oUF.Boss.Texts.HealthMissing.X)
		Health_Missing_Y = tonumber(db.oUF.Boss.Texts.HealthMissing.Y)
		
		Power_Value_Font = LSM:Fetch("font", db.oUF.Boss.Texts.Power.Font)
		Power_Value_Size = tonumber(db.oUF.Boss.Texts.Power.Size)
		Power_Value_Style = db.oUF.Boss.Texts.Power.Outline
		Power_Value_Point = db.oUF.Boss.Texts.Power.Point
		Power_Value_RelativePoint = db.oUF.Boss.Texts.Power.RelativePoint
		Power_Value_X = tonumber(db.oUF.Boss.Texts.Power.X)
		Power_Value_Y = tonumber(db.oUF.Boss.Texts.Power.Y)
		
		Power_Percent_Font = LSM:Fetch("font", db.oUF.Boss.Texts.PowerPercent.Font)
		Power_Percent_Size = tonumber(db.oUF.Boss.Texts.PowerPercent.Size)
		Power_Percent_Style = db.oUF.Boss.Texts.PowerPercent.Outline
		Power_Percent_Point = db.oUF.Boss.Texts.PowerPercent.Point
		Power_Percent_RelativePoint = db.oUF.Boss.Texts.PowerPercent.RelativePoint
		Power_Percent_X = tonumber(db.oUF.Boss.Texts.PowerPercent.X)
		Power_Percent_Y = tonumber(db.oUF.Boss.Texts.PowerPercent.Y)
		
		Power_Missing_Font = LSM:Fetch("font", db.oUF.Boss.Texts.PowerMissing.Font)
		Power_Missing_Size = tonumber(db.oUF.Boss.Texts.PowerMissing.Size)
		Power_Missing_Style = db.oUF.Boss.Texts.PowerMissing.Outline
		Power_Missing_Point = db.oUF.Boss.Texts.PowerMissing.Point
		Power_Missing_RelativePoint = db.oUF.Boss.Texts.PowerMissing.RelativePoint
		Power_Missing_X = tonumber(db.oUF.Boss.Texts.PowerMissing.X)
		Power_Missing_Y = tonumber(db.oUF.Boss.Texts.PowerMissing.Y)
		
		ShowInfo = db.oUF.Boss.Texts.Name.Enable
		
		ShowHealthValue = db.oUF.Boss.Texts.Health.Enable
		ShowHealthPercent = db.oUF.Boss.Texts.HealthPercent.Enable
		ShowHealthMissing = db.oUF.Boss.Texts.HealthMissing.Enable
		
		ShowPowerValue = db.oUF.Boss.Texts.Power.Enable
		ShowPowerPercent = db.oUF.Boss.Texts.PowerPercent.Enable
		ShowPowerMissing = db.oUF.Boss.Texts.PowerMissing.Enable
		
		Icon_Leader_Enable = false
		Icon_Lootmaster_Enable = false
		Icon_Role_Enable = false
		Icon_Resting_Enable = false
		Icon_Combat_Enable = false
		Icon_PvP_Enable = false
		
		Icon_Raid_Enable = db.oUF.Boss.Icons.Raid.Enable == true
		Icon_Raid_Size = db.oUF.Boss.Icons.Raid.Size
		Icon_Raid_Point = db.oUF.Boss.Icons.Raid.Point
		Icon_Raid_X = db.oUF.Boss.Icons.Raid.X
		Icon_Raid_Y = db.oUF.Boss.Icons.Raid.Y
		
		Portrait_Enable = db.oUF.Boss.Portrait.Enable
		Portrait_Width = db.oUF.Boss.Portrait.Width
		Portrait_Height = db.oUF.Boss.Portrait.Height
		Portrait_X = db.oUF.Boss.Portrait.X
		Portrait_Y = db.oUF.Boss.Portrait.Y
	
------------------------------------------------------------------------
--	PLAYER
------------------------------------------------------------------------
	elseif unit == "player" then
		
		Fullbar_Enable = db.oUF.Player.Full.Enable
		Fullbar_Height = tonumber(db.oUF.Player.Full.Height)
		Fullbar_Texture = LSM:Fetch("statusbar", db.oUF.Player.Full.Texture)
		Fullbar_Padding = tonumber(db.oUF.Player.Full.Padding)
		Fullbar_Alpha = db.oUF.Player.Full.Alpha
		Fullbar_Color_r = tonumber(db.oUF.Player.Full.Color.r)
		Fullbar_Color_g = tonumber(db.oUF.Player.Full.Color.g)
		Fullbar_Color_b = tonumber(db.oUF.Player.Full.Color.b)
		Fullbar_Color_a = tonumber(db.oUF.Player.Full.Color.a)
		
		FrameHeight = tonumber(db.oUF.Player.Height)
		FrameWidth = tonumber(db.oUF.Player.Width)
		HealthHeight = tonumber(db.oUF.Player.Health.Height)
		PowerHeight = tonumber(db.oUF.Player.Power.Height)
		ShowPower = db.oUF.Player.Power.Enable
		
		HealthPadding =  tonumber(db.oUF.Player.Health.Padding)
		PowerPadding = tonumber(db.oUF.Player.Power.Padding)
		
		HealthTexture = LSM:Fetch("statusbar", db.oUF.Player.Health.Texture)
		HealthTextureBG = LSM:Fetch("statusbar", db.oUF.Player.Health.TextureBG)
		HealthTextureBGAlpha = tonumber(db.oUF.Player.Health.BGAlpha)
		HealthTextureBGMP = tonumber(db.oUF.Player.Health.BGMultiplier)
		
		PowerTexture = LSM:Fetch("statusbar", db.oUF.Player.Power.Texture)
		PowerTextureBG = LSM:Fetch("statusbar", db.oUF.Player.Power.TextureBG)
		PowerTextureBGAlpha = tonumber(db.oUF.Player.Power.BGAlpha)
		PowerTextureBGMP = tonumber(db.oUF.Player.Power.BGMultiplier)
		
		Health_colorClass = db.oUF.Player.Health.ColorClass
		Health_colorTapping = false
		Health_colorDisconnected = false
		Health_colorSmooth = db.oUF.Player.Health.ColorGradient
		Health_Smooth = db.oUF.Player.Health.Smooth
		Health_colorReaction = false
		Health_frequentUpdates = false
		Health_OverrideUpdateHealth = true
		
		Power_colorDisconnected = false
		Power_colorType = db.oUF.Player.Power.ColorType
		Power_colorClass = db.oUF.Player.Power.ColorClass
		Power_Smooth = db.oUF.Player.Power.Smooth
		Power_colorSmooth = false
		Power_OverrideUpdatePower = true
		Power_colorReaction = false
		Power_frequentUpdates = true
		
		Info_Font = LSM:Fetch("font", db.oUF.Player.Texts.Name.Font)
		Info_Size = tonumber(db.oUF.Player.Texts.Name.Size)
		Info_Style = db.oUF.Player.Texts.Name.Outline
		Info_Point = db.oUF.Player.Texts.Name.Point
		Info_RelativePoint = db.oUF.Player.Texts.Name.RelativePoint
		Info_X = tonumber(db.oUF.Player.Texts.Name.X)
		Info_Y = tonumber(db.oUF.Player.Texts.Name.Y)
		Info_Format = db.oUF.Player.Texts.Name.Format
		Info_NameLength = db.oUF.Player.Texts.Name.Length
		Info_ColorNameByClass = db.oUF.Player.Texts.Name.ColorNameByClass
		Info_ColorClassByClass = db.oUF.Player.Texts.Name.ColorClassByClass
		Info_ColorLevelByDifficulty = db.oUF.Player.Texts.Name.ColorLevelByDifficulty
		Info_ShowClassification = db.oUF.Player.Texts.Name.ShowClassification
		Info_ShortClassification = db.oUF.Player.Texts.Name.ShortClassification
		
		Health_Value_Font = LSM:Fetch("font", db.oUF.Player.Texts.Health.Font)
		Health_Value_Size = tonumber(db.oUF.Player.Texts.Health.Size)
		Health_Value_Style = db.oUF.Player.Texts.Health.Outline
		Health_Value_Point = db.oUF.Player.Texts.Health.Point
		Health_Value_RelativePoint = db.oUF.Player.Texts.Health.RelativePoint
		Health_Value_X = tonumber(db.oUF.Player.Texts.Health.X)
		Health_Value_Y = tonumber(db.oUF.Player.Texts.Health.Y)
		
		Health_Percent_Font = LSM:Fetch("font", db.oUF.Player.Texts.HealthPercent.Font)
		Health_Percent_Size = tonumber(db.oUF.Player.Texts.HealthPercent.Size)
		Health_Percent_Style = db.oUF.Player.Texts.HealthPercent.Outline
		Health_Percent_Point = db.oUF.Player.Texts.HealthPercent.Point
		Health_Percent_RelativePoint = db.oUF.Player.Texts.HealthPercent.RelativePoint
		Health_Percent_X = tonumber(db.oUF.Player.Texts.HealthPercent.X)
		Health_Percent_Y = tonumber(db.oUF.Player.Texts.HealthPercent.Y)
		
		Health_Missing_Font = LSM:Fetch("font", db.oUF.Player.Texts.HealthMissing.Font)
		Health_Missing_Size = tonumber(db.oUF.Player.Texts.HealthMissing.Size)
		Health_Missing_Style = db.oUF.Player.Texts.HealthMissing.Outline
		Health_Missing_Point = db.oUF.Player.Texts.HealthMissing.Point
		Health_Missing_RelativePoint = db.oUF.Player.Texts.HealthMissing.RelativePoint
		Health_Missing_X = tonumber(db.oUF.Player.Texts.HealthMissing.X)
		Health_Missing_Y = tonumber(db.oUF.Player.Texts.HealthMissing.Y)
		
		Power_Value_Font = LSM:Fetch("font", db.oUF.Player.Texts.Power.Font)
		Power_Value_Size = tonumber(db.oUF.Player.Texts.Power.Size)
		Power_Value_Style = db.oUF.Player.Texts.Power.Outline
		Power_Value_Point = db.oUF.Player.Texts.Power.Point
		Power_Value_RelativePoint = db.oUF.Player.Texts.Power.RelativePoint
		Power_Value_X = tonumber(db.oUF.Player.Texts.Power.X)
		Power_Value_Y = tonumber(db.oUF.Player.Texts.Power.Y)
		
		Power_Percent_Font = LSM:Fetch("font", db.oUF.Player.Texts.PowerPercent.Font)
		Power_Percent_Size = tonumber(db.oUF.Player.Texts.PowerPercent.Size)
		Power_Percent_Style = db.oUF.Player.Texts.PowerPercent.Outline
		Power_Percent_Point = db.oUF.Player.Texts.PowerPercent.Point
		Power_Percent_RelativePoint = db.oUF.Player.Texts.PowerPercent.RelativePoint
		Power_Percent_X = tonumber(db.oUF.Player.Texts.PowerPercent.X)
		Power_Percent_Y = tonumber(db.oUF.Player.Texts.PowerPercent.Y)
		
		Power_Missing_Font = LSM:Fetch("font", db.oUF.Player.Texts.PowerMissing.Font)
		Power_Missing_Size = tonumber(db.oUF.Player.Texts.PowerMissing.Size)
		Power_Missing_Style = db.oUF.Player.Texts.PowerMissing.Outline
		Power_Missing_Point = db.oUF.Player.Texts.PowerMissing.Point
		Power_Missing_RelativePoint = db.oUF.Player.Texts.PowerMissing.RelativePoint
		Power_Missing_X = tonumber(db.oUF.Player.Texts.PowerMissing.X)
		Power_Missing_Y = tonumber(db.oUF.Player.Texts.PowerMissing.Y)
		
		ShowInfo = db.oUF.Player.Texts.Name.Enable
		
		ShowHealthValue = db.oUF.Player.Texts.Health.Enable
		ShowHealthPercent = db.oUF.Player.Texts.HealthPercent.Enable
		ShowHealthMissing = db.oUF.Player.Texts.HealthMissing.Enable
		
		ShowPowerValue = db.oUF.Player.Texts.Power.Enable
		ShowPowerPercent = db.oUF.Player.Texts.PowerPercent.Enable
		ShowPowerMissing = db.oUF.Player.Texts.PowerMissing.Enable
		
		Icon_Leader_Enable = db.oUF.Player.Icons.Leader.Enable
		Icon_Leader_Size = db.oUF.Player.Icons.Leader.Size
		Icon_Leader_Point = db.oUF.Player.Icons.Leader.Point
		Icon_Leader_X = db.oUF.Player.Icons.Leader.X
		Icon_Leader_Y = db.oUF.Player.Icons.Leader.Y
		
		Icon_Lootmaster_Enable = db.oUF.Player.Icons.Lootmaster.Enable
		Icon_Lootmaster_Size = db.oUF.Player.Icons.Lootmaster.Size
		Icon_Lootmaster_Point = db.oUF.Player.Icons.Lootmaster.Point
		Icon_Lootmaster_X = db.oUF.Player.Icons.Lootmaster.X
		Icon_Lootmaster_Y = db.oUF.Player.Icons.Lootmaster.Y
		
		Icon_Raid_Enable = db.oUF.Player.Icons.Raid.Enable == true
		Icon_Raid_Size = db.oUF.Player.Icons.Raid.Size
		Icon_Raid_Point = db.oUF.Player.Icons.Raid.Point
		Icon_Raid_X = db.oUF.Player.Icons.Raid.X
		Icon_Raid_Y = db.oUF.Player.Icons.Raid.Y
		
		Icon_Role_Enable = db.oUF.Player.Icons.Role.Enable
		Icon_Role_Size = db.oUF.Player.Icons.Role.Size
		Icon_Role_Point = db.oUF.Player.Icons.Role.Point
		Icon_Role_X = db.oUF.Player.Icons.Role.X
		Icon_Role_Y = db.oUF.Player.Icons.Role.Y
		
		Icon_Resting_Enable = db.oUF.Player.Icons.Resting.Enable
		Icon_Resting_Size = db.oUF.Player.Icons.Resting.Size
		Icon_Resting_Point = db.oUF.Player.Icons.Resting.Point
		Icon_Resting_X = db.oUF.Player.Icons.Resting.X
		Icon_Resting_Y = db.oUF.Player.Icons.Resting.Y
		
		Icon_Combat_Enable = db.oUF.Player.Icons.Combat.Enable
		Icon_Combat_Size = db.oUF.Player.Icons.Combat.Size
		Icon_Combat_Point = db.oUF.Player.Icons.Combat.Point
		Icon_Combat_X = db.oUF.Player.Icons.Combat.X
		Icon_Combat_Y = db.oUF.Player.Icons.Combat.Y
		
		Icon_PvP_Enable = db.oUF.Player.Icons.PvP.Enable
		Icon_PvP_Size = db.oUF.Player.Icons.PvP.Size
		Icon_PvP_Point = db.oUF.Player.Icons.PvP.Point
		Icon_PvP_X = db.oUF.Player.Icons.PvP.X
		Icon_PvP_Y = db.oUF.Player.Icons.PvP.Y
		
		Portrait_Enable = db.oUF.Player.Portrait.Enable
		Portrait_Width = db.oUF.Player.Portrait.Width
		Portrait_Height = db.oUF.Player.Portrait.Height
		Portrait_X = db.oUF.Player.Portrait.X
		Portrait_Y = db.oUF.Player.Portrait.Y

------------------------------------------------------------------------
--	TARGET
------------------------------------------------------------------------	
	elseif unit == "target" then
	
		Fullbar_Enable = db.oUF.Target.Full.Enable
		Fullbar_Height = tonumber(db.oUF.Target.Full.Height)
		Fullbar_Texture = LSM:Fetch("statusbar", db.oUF.Target.Full.Texture)
		Fullbar_Padding = tonumber(db.oUF.Target.Full.Padding)
		Fullbar_Alpha = db.oUF.Target.Full.Alpha
		Fullbar_Color_r = tonumber(db.oUF.Target.Full.Color.r)
		Fullbar_Color_g = tonumber(db.oUF.Target.Full.Color.g)
		Fullbar_Color_b = tonumber(db.oUF.Target.Full.Color.b)
		Fullbar_Color_a = tonumber(db.oUF.Target.Full.Color.a)

		FrameHeight = tonumber(db.oUF.Target.Height)
		FrameWidth = tonumber(db.oUF.Target.Width)
		HealthHeight = tonumber(db.oUF.Target.Health.Height)
		PowerHeight = tonumber(db.oUF.Target.Power.Height)
		ShowPower = db.oUF.Target.Power.Enable
		
		HealthPadding =  tonumber(db.oUF.Target.Health.Padding)
		PowerPadding = tonumber(db.oUF.Target.Power.Padding)
		
		HealthTexture = LSM:Fetch("statusbar", db.oUF.Target.Health.Texture)
		HealthTextureBG = LSM:Fetch("statusbar", db.oUF.Target.Health.TextureBG)
		HealthTextureBGAlpha = tonumber(db.oUF.Target.Health.BGAlpha)
		HealthTextureBGMP = tonumber(db.oUF.Target.Health.BGMultiplier)
		
		PowerTexture = LSM:Fetch("statusbar", db.oUF.Target.Power.Texture)
		PowerTextureBG = LSM:Fetch("statusbar", db.oUF.Target.Power.TextureBG)
		PowerTextureBGAlpha = tonumber(db.oUF.Target.Power.BGAlpha)
		PowerTextureBGMP = tonumber(db.oUF.Target.Power.BGMultiplier)
		
		Health_colorClass = db.oUF.Target.Health.ColorClass
		Health_colorTapping = db.oUF.Target.Health.Tapping
		Health_colorDisconnected = false
		Health_colorSmooth = db.oUF.Target.Health.ColorGradient
		Health_Smooth = db.oUF.Target.Health.Smooth
		Health_colorReaction = false
		Health_frequentUpdates = false
		Health_OverrideUpdateHealth = true
		
		Power_colorDisconnected = false
		Power_colorType = db.oUF.Target.Power.ColorType
		Power_colorClass = db.oUF.Target.Power.ColorClass
		Power_Smooth = db.oUF.Target.Power.Smooth
		Power_colorSmooth = false
		Power_OverrideUpdatePower = true
		Power_colorReaction = false
		Power_frequentUpdates = true
		
		Info_Font = LSM:Fetch("font", db.oUF.Target.Texts.Name.Font)
		Info_Size = tonumber(db.oUF.Target.Texts.Name.Size)
		Info_Style = db.oUF.Target.Texts.Name.Outline
		Info_Point = db.oUF.Target.Texts.Name.Point
		Info_RelativePoint = db.oUF.Target.Texts.Name.RelativePoint
		Info_X = tonumber(db.oUF.Target.Texts.Name.X)
		Info_Y = tonumber(db.oUF.Target.Texts.Name.Y)
		Info_Format = db.oUF.Target.Texts.Name.Format
		Info_NameLength = db.oUF.Target.Texts.Name.Length
		Info_ColorNameByClass = db.oUF.Target.Texts.Name.ColorNameByClass
		Info_ColorClassByClass = db.oUF.Target.Texts.Name.ColorClassByClass
		Info_ColorLevelByDifficulty = db.oUF.Target.Texts.Name.ColorLevelByDifficulty
		Info_ShowClassification = db.oUF.Target.Texts.Name.ShowClassification
		Info_ShortClassification = db.oUF.Target.Texts.Name.ShortClassification
		
		Health_Value_Font = LSM:Fetch("font", db.oUF.Target.Texts.Health.Font)
		Health_Value_Size = tonumber(db.oUF.Target.Texts.Health.Size)
		Health_Value_Style = db.oUF.Target.Texts.Health.Outline
		Health_Value_Point = db.oUF.Target.Texts.Health.Point
		Health_Value_RelativePoint = db.oUF.Target.Texts.Health.RelativePoint
		Health_Value_X = tonumber(db.oUF.Target.Texts.Health.X)
		Health_Value_Y = tonumber(db.oUF.Target.Texts.Health.Y)
		
		Health_Percent_Font = LSM:Fetch("font", db.oUF.Target.Texts.HealthPercent.Font)
		Health_Percent_Size = tonumber(db.oUF.Target.Texts.HealthPercent.Size)
		Health_Percent_Style = db.oUF.Target.Texts.HealthPercent.Outline
		Health_Percent_Point = db.oUF.Target.Texts.HealthPercent.Point
		Health_Percent_RelativePoint = db.oUF.Target.Texts.HealthPercent.RelativePoint
		Health_Percent_X = tonumber(db.oUF.Target.Texts.HealthPercent.X)
		Health_Percent_Y = tonumber(db.oUF.Target.Texts.HealthPercent.Y)
		
		Health_Missing_Font = LSM:Fetch("font", db.oUF.Target.Texts.HealthMissing.Font)
		Health_Missing_Size = tonumber(db.oUF.Target.Texts.HealthMissing.Size)
		Health_Missing_Style = db.oUF.Target.Texts.HealthMissing.Outline
		Health_Missing_Point = db.oUF.Target.Texts.HealthMissing.Point
		Health_Missing_RelativePoint = db.oUF.Target.Texts.HealthMissing.RelativePoint
		Health_Missing_X = tonumber(db.oUF.Target.Texts.HealthMissing.X)
		Health_Missing_Y = tonumber(db.oUF.Target.Texts.HealthMissing.Y)
		
		Power_Value_Font = LSM:Fetch("font", db.oUF.Target.Texts.Power.Font)
		Power_Value_Size = tonumber(db.oUF.Target.Texts.Power.Size)
		Power_Value_Style = db.oUF.Target.Texts.Power.Outline
		Power_Value_Point = db.oUF.Target.Texts.Power.Point
		Power_Value_RelativePoint = db.oUF.Target.Texts.Power.RelativePoint
		Power_Value_X = tonumber(db.oUF.Target.Texts.Power.X)
		Power_Value_Y = tonumber(db.oUF.Target.Texts.Power.Y)
		
		Power_Percent_Font = LSM:Fetch("font", db.oUF.Target.Texts.PowerPercent.Font)
		Power_Percent_Size = tonumber(db.oUF.Target.Texts.PowerPercent.Size)
		Power_Percent_Style = db.oUF.Target.Texts.PowerPercent.Outline
		Power_Percent_Point = db.oUF.Target.Texts.PowerPercent.Point
		Power_Percent_RelativePoint = db.oUF.Target.Texts.PowerPercent.RelativePoint
		Power_Percent_X = tonumber(db.oUF.Target.Texts.PowerPercent.X)
		Power_Percent_Y = tonumber(db.oUF.Target.Texts.PowerPercent.Y)
		
		Power_Missing_Font = LSM:Fetch("font", db.oUF.Target.Texts.PowerMissing.Font)
		Power_Missing_Size = tonumber(db.oUF.Target.Texts.PowerMissing.Size)
		Power_Missing_Style = db.oUF.Target.Texts.PowerMissing.Outline
		Power_Missing_Point = db.oUF.Target.Texts.PowerMissing.Point
		Power_Missing_RelativePoint = db.oUF.Target.Texts.PowerMissing.RelativePoint
		Power_Missing_X = tonumber(db.oUF.Target.Texts.PowerMissing.X)
		Power_Missing_Y = tonumber(db.oUF.Target.Texts.PowerMissing.Y)
		
		ShowInfo = db.oUF.Target.Texts.Name.Enable
		
		ShowHealthValue = db.oUF.Target.Texts.Health.Enable
		ShowHealthPercent = db.oUF.Target.Texts.HealthPercent.Enable
		ShowHealthMissing = db.oUF.Target.Texts.HealthMissing.Enable
		
		ShowPowerValue = db.oUF.Target.Texts.Power.Enable
		ShowPowerPercent = db.oUF.Target.Texts.PowerPercent.Enable
		ShowPowerMissing = db.oUF.Target.Texts.PowerMissing.Enable
		
		Icon_Leader_Enable = db.oUF.Target.Icons.Leader.Enable
		Icon_Leader_Size = db.oUF.Target.Icons.Leader.Size
		Icon_Leader_Point = db.oUF.Target.Icons.Leader.Point
		Icon_Leader_X = db.oUF.Target.Icons.Leader.X
		Icon_Leader_Y = db.oUF.Target.Icons.Leader.Y
		
		Icon_Lootmaster_Enable = db.oUF.Target.Icons.Lootmaster.Enable
		Icon_Lootmaster_Size = db.oUF.Target.Icons.Lootmaster.Size
		Icon_Lootmaster_Point = db.oUF.Target.Icons.Lootmaster.Point
		Icon_Lootmaster_X = db.oUF.Target.Icons.Lootmaster.X
		Icon_Lootmaster_Y = db.oUF.Target.Icons.Lootmaster.Y
		
		Icon_Raid_Enable = db.oUF.Target.Icons.Raid.Enable == true
		Icon_Raid_Size = db.oUF.Target.Icons.Raid.Size
		Icon_Raid_Point = db.oUF.Target.Icons.Raid.Point
		Icon_Raid_X = db.oUF.Target.Icons.Raid.X
		Icon_Raid_Y = db.oUF.Target.Icons.Raid.Y
		
		Icon_Role_Enable = db.oUF.Target.Icons.Role.Enable
		Icon_Role_Size = db.oUF.Target.Icons.Role.Size
		Icon_Role_Point = db.oUF.Target.Icons.Role.Point
		Icon_Role_X = db.oUF.Target.Icons.Role.X
		Icon_Role_Y = db.oUF.Target.Icons.Role.Y
		
		Icon_Resting_Enable = db.oUF.Target.Icons.Resting.Enable
		Icon_Resting_Size = db.oUF.Target.Icons.Resting.Size
		Icon_Resting_Point = db.oUF.Target.Icons.Resting.Point
		Icon_Resting_X = db.oUF.Target.Icons.Resting.X
		Icon_Resting_Y = db.oUF.Target.Icons.Resting.Y
		
		Icon_Combat_Enable = db.oUF.Target.Icons.Combat.Enable
		Icon_Combat_Size = db.oUF.Target.Icons.Combat.Size
		Icon_Combat_Point = db.oUF.Target.Icons.Combat.Point
		Icon_Combat_X = db.oUF.Target.Icons.Combat.X
		Icon_Combat_Y = db.oUF.Target.Icons.Combat.Y
		
		Icon_PvP_Enable = db.oUF.Target.Icons.PvP.Enable
		Icon_PvP_Size = db.oUF.Target.Icons.PvP.Size
		Icon_PvP_Point = db.oUF.Target.Icons.PvP.Point
		Icon_PvP_X = db.oUF.Target.Icons.PvP.X
		Icon_PvP_Y = db.oUF.Target.Icons.PvP.Y
		
		Portrait_Enable = db.oUF.Target.Portrait.Enable
		Portrait_Width = db.oUF.Target.Portrait.Width
		Portrait_Height = db.oUF.Target.Portrait.Height
		Portrait_X = db.oUF.Target.Portrait.X
		Portrait_Y = db.oUF.Target.Portrait.Y
		
------------------------------------------------------------------------
--	TARGET TARGET
------------------------------------------------------------------------
	elseif unit == "targettarget" then
		
		Fullbar_Enable = db.oUF.ToT.Full.Enable
		Fullbar_Height = tonumber(db.oUF.ToT.Full.Height)
		Fullbar_Texture = LSM:Fetch("statusbar", db.oUF.ToT.Full.Texture)
		Fullbar_Padding = tonumber(db.oUF.ToT.Full.Padding)
		Fullbar_Alpha = db.oUF.ToT.Full.Alpha
		Fullbar_Color_r = tonumber(db.oUF.ToT.Full.Color.r)
		Fullbar_Color_g = tonumber(db.oUF.ToT.Full.Color.g)
		Fullbar_Color_b = tonumber(db.oUF.ToT.Full.Color.b)
		Fullbar_Color_a = tonumber(db.oUF.ToT.Full.Color.a)
		
		FrameHeight = tonumber(db.oUF.ToT.Height)
		FrameWidth = tonumber(db.oUF.ToT.Width)
		HealthHeight = tonumber(db.oUF.ToT.Health.Height)
		PowerHeight = tonumber(db.oUF.ToT.Power.Height)
		ShowPower = db.oUF.ToT.Power.Enable
		
		HealthPadding =  tonumber(db.oUF.ToT.Health.Padding)
		PowerPadding = tonumber(db.oUF.ToT.Power.Padding)
		
		HealthTexture = LSM:Fetch("statusbar", db.oUF.ToT.Health.Texture)
		HealthTextureBG = LSM:Fetch("statusbar", db.oUF.ToT.Health.TextureBG)
		HealthTextureBGAlpha = tonumber(db.oUF.ToT.Health.BGAlpha)
		HealthTextureBGMP = tonumber(db.oUF.ToT.Health.BGMultiplier)
		
		PowerTexture = LSM:Fetch("statusbar", db.oUF.ToT.Power.Texture)
		PowerTextureBG = LSM:Fetch("statusbar", db.oUF.ToT.Power.TextureBG)
		PowerTextureBGAlpha = tonumber(db.oUF.ToT.Power.BGAlpha)
		PowerTextureBGMP = tonumber(db.oUF.ToT.Power.BGMultiplier)
		
		Health_colorClass = db.oUF.ToT.Health.ColorClass
		Health_colorTapping = false
		Health_colorDisconnected = false
		Health_colorSmooth = db.oUF.ToT.Health.ColorGradient
		Health_Smooth = db.oUF.ToT.Health.Smooth
		Health_colorReaction = false
		Health_frequentUpdates = false
		Health_OverrideUpdateHealth = true
		
		Power_colorDisconnected = false
		Power_colorType = db.oUF.ToT.Power.ColorType
		Power_colorClass = db.oUF.ToT.Power.ColorClass
		Power_Smooth = db.oUF.ToT.Power.Smooth
		Power_colorSmooth = false
		Power_OverrideUpdatePower = true
		Power_colorReaction = false
		Power_frequentUpdates = true
		
		Info_Font = LSM:Fetch("font", db.oUF.ToT.Texts.Name.Font)
		Info_Size = tonumber(db.oUF.ToT.Texts.Name.Size)
		Info_Style = db.oUF.ToT.Texts.Name.Outline
		Info_Point = db.oUF.ToT.Texts.Name.Point
		Info_RelativePoint = db.oUF.ToT.Texts.Name.RelativePoint
		Info_X = tonumber(db.oUF.ToT.Texts.Name.X)
		Info_Y = tonumber(db.oUF.ToT.Texts.Name.Y)
		Info_Format = db.oUF.ToT.Texts.Name.Format
		Info_NameLength = db.oUF.ToT.Texts.Name.Length
		Info_ColorNameByClass = db.oUF.ToT.Texts.Name.ColorNameByClass
		Info_ColorClassByClass = db.oUF.ToT.Texts.Name.ColorClassByClass
		Info_ColorLevelByDifficulty = db.oUF.ToT.Texts.Name.ColorLevelByDifficulty
		Info_ShowClassification = db.oUF.ToT.Texts.Name.ShowClassification
		Info_ShortClassification = db.oUF.ToT.Texts.Name.ShortClassification
		
		Health_Value_Font = LSM:Fetch("font", db.oUF.ToT.Texts.Health.Font)
		Health_Value_Size = tonumber(db.oUF.ToT.Texts.Health.Size)
		Health_Value_Style = db.oUF.ToT.Texts.Health.Outline
		Health_Value_Point = db.oUF.ToT.Texts.Health.Point
		Health_Value_RelativePoint = db.oUF.ToT.Texts.Health.RelativePoint
		Health_Value_X = tonumber(db.oUF.ToT.Texts.Health.X)
		Health_Value_Y = tonumber(db.oUF.ToT.Texts.Health.Y)
		
		Health_Percent_Font = LSM:Fetch("font", db.oUF.ToT.Texts.HealthPercent.Font)
		Health_Percent_Size = tonumber(db.oUF.ToT.Texts.HealthPercent.Size)
		Health_Percent_Style = db.oUF.ToT.Texts.HealthPercent.Outline
		Health_Percent_Point = db.oUF.ToT.Texts.HealthPercent.Point
		Health_Percent_RelativePoint = db.oUF.ToT.Texts.HealthPercent.RelativePoint
		Health_Percent_X = tonumber(db.oUF.ToT.Texts.HealthPercent.X)
		Health_Percent_Y = tonumber(db.oUF.ToT.Texts.HealthPercent.Y)
		
		Health_Missing_Font = LSM:Fetch("font", db.oUF.ToT.Texts.HealthMissing.Font)
		Health_Missing_Size = tonumber(db.oUF.ToT.Texts.HealthMissing.Size)
		Health_Missing_Style = db.oUF.ToT.Texts.HealthMissing.Outline
		Health_Missing_Point = db.oUF.ToT.Texts.HealthMissing.Point
		Health_Missing_RelativePoint = db.oUF.ToT.Texts.HealthMissing.RelativePoint
		Health_Missing_X = tonumber(db.oUF.ToT.Texts.HealthMissing.X)
		Health_Missing_Y = tonumber(db.oUF.ToT.Texts.HealthMissing.Y)
		
		Power_Value_Font = LSM:Fetch("font", db.oUF.ToT.Texts.Power.Font)
		Power_Value_Size = tonumber(db.oUF.ToT.Texts.Power.Size)
		Power_Value_Style = db.oUF.ToT.Texts.Power.Outline
		Power_Value_Point = db.oUF.ToT.Texts.Power.Point
		Power_Value_RelativePoint = db.oUF.ToT.Texts.Power.RelativePoint
		Power_Value_X = tonumber(db.oUF.ToT.Texts.Power.X)
		Power_Value_Y = tonumber(db.oUF.ToT.Texts.Power.Y)
		
		Power_Percent_Font = LSM:Fetch("font", db.oUF.ToT.Texts.PowerPercent.Font)
		Power_Percent_Size = tonumber(db.oUF.ToT.Texts.PowerPercent.Size)
		Power_Percent_Style = db.oUF.ToT.Texts.PowerPercent.Outline
		Power_Percent_Point = db.oUF.ToT.Texts.PowerPercent.Point
		Power_Percent_RelativePoint = db.oUF.ToT.Texts.PowerPercent.RelativePoint
		Power_Percent_X = tonumber(db.oUF.ToT.Texts.PowerPercent.X)
		Power_Percent_Y = tonumber(db.oUF.ToT.Texts.PowerPercent.Y)
		
		Power_Missing_Font = LSM:Fetch("font", db.oUF.ToT.Texts.PowerMissing.Font)
		Power_Missing_Size = tonumber(db.oUF.ToT.Texts.PowerMissing.Size)
		Power_Missing_Style = db.oUF.ToT.Texts.PowerMissing.Outline
		Power_Missing_Point = db.oUF.ToT.Texts.PowerMissing.Point
		Power_Missing_RelativePoint = db.oUF.ToT.Texts.PowerMissing.RelativePoint
		Power_Missing_X = tonumber(db.oUF.ToT.Texts.PowerMissing.X)
		Power_Missing_Y = tonumber(db.oUF.ToT.Texts.PowerMissing.Y)
		
		ShowInfo = db.oUF.ToT.Texts.Name.Enable
		
		ShowHealthValue = db.oUF.ToT.Texts.Health.Enable
		ShowHealthPercent = db.oUF.ToT.Texts.HealthPercent.Enable
		ShowHealthMissing = db.oUF.ToT.Texts.HealthMissing.Enable
		
		ShowPowerValue = db.oUF.ToT.Texts.Power.Enable
		ShowPowerPercent = db.oUF.ToT.Texts.PowerPercent.Enable
		ShowPowerMissing = db.oUF.ToT.Texts.PowerMissing.Enable
		
		Icon_Leader_Enable = db.oUF.ToT.Icons.Leader.Enable
		Icon_Leader_Size = db.oUF.ToT.Icons.Leader.Size
		Icon_Leader_Point = db.oUF.ToT.Icons.Leader.Point
		Icon_Leader_X = db.oUF.ToT.Icons.Leader.X
		Icon_Leader_Y = db.oUF.ToT.Icons.Leader.Y
		
		Icon_Lootmaster_Enable = db.oUF.ToT.Icons.Lootmaster.Enable
		Icon_Lootmaster_Size = db.oUF.ToT.Icons.Lootmaster.Size
		Icon_Lootmaster_Point = db.oUF.ToT.Icons.Lootmaster.Point
		Icon_Lootmaster_X = db.oUF.ToT.Icons.Lootmaster.X
		Icon_Lootmaster_Y = db.oUF.ToT.Icons.Lootmaster.Y
		
		Icon_Raid_Enable = db.oUF.ToT.Icons.Raid.Enable == true
		Icon_Raid_Size = db.oUF.ToT.Icons.Raid.Size
		Icon_Raid_Point = db.oUF.ToT.Icons.Raid.Point
		Icon_Raid_X = db.oUF.ToT.Icons.Raid.X
		Icon_Raid_Y = db.oUF.ToT.Icons.Raid.Y
		
		Icon_Role_Enable = db.oUF.ToT.Icons.Role.Enable
		Icon_Role_Size = db.oUF.ToT.Icons.Role.Size
		Icon_Role_Point = db.oUF.ToT.Icons.Role.Point
		Icon_Role_X = db.oUF.ToT.Icons.Role.X
		Icon_Role_Y = db.oUF.ToT.Icons.Role.Y
		
		Icon_Resting_Enable = db.oUF.ToT.Icons.Resting.Enable
		Icon_Resting_Size = db.oUF.ToT.Icons.Resting.Size
		Icon_Resting_Point = db.oUF.ToT.Icons.Resting.Point
		Icon_Resting_X = db.oUF.ToT.Icons.Resting.X
		Icon_Resting_Y = db.oUF.ToT.Icons.Resting.Y
		
		Icon_Combat_Enable = db.oUF.ToT.Icons.Combat.Enable
		Icon_Combat_Size = db.oUF.ToT.Icons.Combat.Size
		Icon_Combat_Point = db.oUF.ToT.Icons.Combat.Point
		Icon_Combat_X = db.oUF.ToT.Icons.Combat.X
		Icon_Combat_Y = db.oUF.ToT.Icons.Combat.Y
		
		Icon_PvP_Enable = db.oUF.ToT.Icons.PvP.Enable
		Icon_PvP_Size = db.oUF.ToT.Icons.PvP.Size
		Icon_PvP_Point = db.oUF.ToT.Icons.PvP.Point
		Icon_PvP_X = db.oUF.ToT.Icons.PvP.X
		Icon_PvP_Y = db.oUF.ToT.Icons.PvP.Y
		
		Portrait_Enable = db.oUF.ToT.Portrait.Enable
		Portrait_Width = db.oUF.ToT.Portrait.Width
		Portrait_Height = db.oUF.ToT.Portrait.Height
		Portrait_X = db.oUF.ToT.Portrait.X
		Portrait_Y = db.oUF.ToT.Portrait.Y
		
------------------------------------------------------------------------
--	TARGETTARGETTARGET
------------------------------------------------------------------------
	elseif unit == "targettargettarget" then
	
		Fullbar_Enable = db.oUF.ToToT.Full.Enable
		Fullbar_Height = tonumber(db.oUF.ToToT.Full.Height)
		Fullbar_Texture = LSM:Fetch("statusbar", db.oUF.ToToT.Full.Texture)
		Fullbar_Padding = tonumber(db.oUF.ToToT.Full.Padding)
		Fullbar_Alpha = db.oUF.ToToT.Full.Alpha
		Fullbar_Color_r = tonumber(db.oUF.ToToT.Full.Color.r)
		Fullbar_Color_g = tonumber(db.oUF.ToToT.Full.Color.g)
		Fullbar_Color_b = tonumber(db.oUF.ToToT.Full.Color.b)
		Fullbar_Color_a = tonumber(db.oUF.ToToT.Full.Color.a)
	
		FrameHeight = tonumber(db.oUF.ToToT.Height)
		FrameWidth = tonumber(db.oUF.ToToT.Width)
		HealthHeight = tonumber(db.oUF.ToToT.Health.Height)
		PowerHeight = tonumber(db.oUF.ToToT.Power.Height)
		ShowPower = db.oUF.ToToT.Power.Enable
		
		HealthPadding =  tonumber(db.oUF.ToToT.Health.Padding)
		PowerPadding = tonumber(db.oUF.ToToT.Power.Padding)
		
		HealthTexture = LSM:Fetch("statusbar", db.oUF.ToToT.Health.Texture)
		HealthTextureBG = LSM:Fetch("statusbar", db.oUF.ToToT.Health.TextureBG)
		HealthTextureBGAlpha = tonumber(db.oUF.ToToT.Health.BGAlpha)
		HealthTextureBGMP = tonumber(db.oUF.ToToT.Health.BGMultiplier)
		
		PowerTexture = LSM:Fetch("statusbar", db.oUF.ToToT.Power.Texture)
		PowerTextureBG = LSM:Fetch("statusbar", db.oUF.ToToT.Power.TextureBG)
		PowerTextureBGAlpha = tonumber(db.oUF.ToToT.Power.BGAlpha)
		PowerTextureBGMP = tonumber(db.oUF.ToToT.Power.BGMultiplier)
		
		Health_colorClass = db.oUF.ToToT.Health.ColorClass
		Health_colorTapping = false
		Health_colorDisconnected = false
		Health_colorSmooth = db.oUF.ToToT.Health.ColorGradient
		Health_Smooth = db.oUF.ToToT.Health.Smooth
		Health_colorReaction = false
		Health_frequentUpdates = false
		Health_OverrideUpdateHealth = true
		
		Power_colorDisconnected = false
		Power_colorType = db.oUF.ToToT.Power.ColorType
		Power_colorClass = db.oUF.ToToT.Power.ColorClass
		Power_Smooth = db.oUF.ToToT.Power.Smooth
		Power_colorSmooth = false
		Power_OverrideUpdatePower = true
		Power_colorReaction = false
		Power_frequentUpdates = true
		
		Info_Font = LSM:Fetch("font", db.oUF.ToToT.Texts.Name.Font)
		Info_Size = tonumber(db.oUF.ToToT.Texts.Name.Size)
		Info_Style = db.oUF.ToToT.Texts.Name.Outline
		Info_Point = db.oUF.ToToT.Texts.Name.Point
		Info_RelativePoint = db.oUF.ToToT.Texts.Name.RelativePoint
		Info_X = tonumber(db.oUF.ToToT.Texts.Name.X)
		Info_Y = tonumber(db.oUF.ToToT.Texts.Name.Y)
		Info_Format = db.oUF.ToToT.Texts.Name.Format
		Info_NameLength = db.oUF.ToToT.Texts.Name.Length
		Info_ColorNameByClass = db.oUF.ToToT.Texts.Name.ColorNameByClass
		Info_ColorClassByClass = db.oUF.ToToT.Texts.Name.ColorClassByClass
		Info_ColorLevelByDifficulty = db.oUF.ToToT.Texts.Name.ColorLevelByDifficulty
		Info_ShowClassification = db.oUF.ToToT.Texts.Name.ShowClassification
		Info_ShortClassification = db.oUF.ToToT.Texts.Name.ShortClassification
		
		Health_Value_Font = LSM:Fetch("font", db.oUF.ToToT.Texts.Health.Font)
		Health_Value_Size = tonumber(db.oUF.ToToT.Texts.Health.Size)
		Health_Value_Style = db.oUF.ToToT.Texts.Health.Outline
		Health_Value_Point = db.oUF.ToToT.Texts.Health.Point
		Health_Value_RelativePoint = db.oUF.ToToT.Texts.Health.RelativePoint
		Health_Value_X = tonumber(db.oUF.ToToT.Texts.Health.X)
		Health_Value_Y = tonumber(db.oUF.ToToT.Texts.Health.Y)
		
		Health_Percent_Font = LSM:Fetch("font", db.oUF.ToToT.Texts.HealthPercent.Font)
		Health_Percent_Size = tonumber(db.oUF.ToToT.Texts.HealthPercent.Size)
		Health_Percent_Style = db.oUF.ToToT.Texts.HealthPercent.Outline
		Health_Percent_Point = db.oUF.ToToT.Texts.HealthPercent.Point
		Health_Percent_RelativePoint = db.oUF.ToToT.Texts.HealthPercent.RelativePoint
		Health_Percent_X = tonumber(db.oUF.ToToT.Texts.HealthPercent.X)
		Health_Percent_Y = tonumber(db.oUF.ToToT.Texts.HealthPercent.Y)
		
		Health_Missing_Font = LSM:Fetch("font", db.oUF.ToToT.Texts.HealthMissing.Font)
		Health_Missing_Size = tonumber(db.oUF.ToToT.Texts.HealthMissing.Size)
		Health_Missing_Style = db.oUF.ToToT.Texts.HealthMissing.Outline
		Health_Missing_Point = db.oUF.ToToT.Texts.HealthMissing.Point
		Health_Missing_RelativePoint = db.oUF.ToToT.Texts.HealthMissing.RelativePoint
		Health_Missing_X = tonumber(db.oUF.ToToT.Texts.HealthMissing.X)
		Health_Missing_Y = tonumber(db.oUF.ToToT.Texts.HealthMissing.Y)
		
		Power_Value_Font = LSM:Fetch("font", db.oUF.ToToT.Texts.Power.Font)
		Power_Value_Size = tonumber(db.oUF.ToToT.Texts.Power.Size)
		Power_Value_Style = db.oUF.ToToT.Texts.Power.Outline
		Power_Value_Point = db.oUF.ToToT.Texts.Power.Point
		Power_Value_RelativePoint = db.oUF.ToToT.Texts.Power.RelativePoint
		Power_Value_X = tonumber(db.oUF.ToToT.Texts.Power.X)
		Power_Value_Y = tonumber(db.oUF.ToToT.Texts.Power.Y)
		
		Power_Percent_Font = LSM:Fetch("font", db.oUF.ToToT.Texts.PowerPercent.Font)
		Power_Percent_Size = tonumber(db.oUF.ToToT.Texts.PowerPercent.Size)
		Power_Percent_Style = db.oUF.ToToT.Texts.PowerPercent.Outline
		Power_Percent_Point = db.oUF.ToToT.Texts.PowerPercent.Point
		Power_Percent_RelativePoint = db.oUF.ToToT.Texts.PowerPercent.RelativePoint
		Power_Percent_X = tonumber(db.oUF.ToToT.Texts.PowerPercent.X)
		Power_Percent_Y = tonumber(db.oUF.ToToT.Texts.PowerPercent.Y)
		
		Power_Missing_Font = LSM:Fetch("font", db.oUF.ToToT.Texts.PowerMissing.Font)
		Power_Missing_Size = tonumber(db.oUF.ToToT.Texts.PowerMissing.Size)
		Power_Missing_Style = db.oUF.ToToT.Texts.PowerMissing.Outline
		Power_Missing_Point = db.oUF.ToToT.Texts.PowerMissing.Point
		Power_Missing_RelativePoint = db.oUF.ToToT.Texts.PowerMissing.RelativePoint
		Power_Missing_X = tonumber(db.oUF.ToToT.Texts.PowerMissing.X)
		Power_Missing_Y = tonumber(db.oUF.ToToT.Texts.PowerMissing.Y)
		
		ShowInfo = db.oUF.ToToT.Texts.Name.Enable
		
		ShowHealthValue = db.oUF.ToToT.Texts.Health.Enable
		ShowHealthPercent = db.oUF.ToToT.Texts.HealthPercent.Enable
		ShowHealthMissing = db.oUF.ToToT.Texts.HealthMissing.Enable
		
		ShowPowerValue = db.oUF.ToToT.Texts.Power.Enable
		ShowPowerPercent = db.oUF.ToToT.Texts.PowerPercent.Enable
		ShowPowerMissing = db.oUF.ToToT.Texts.PowerMissing.Enable
		
		Icon_Leader_Enable = db.oUF.ToToT.Icons.Leader.Enable
		Icon_Leader_Size = db.oUF.ToToT.Icons.Leader.Size
		Icon_Leader_Point = db.oUF.ToToT.Icons.Leader.Point
		Icon_Leader_X = db.oUF.ToToT.Icons.Leader.X
		Icon_Leader_Y = db.oUF.ToToT.Icons.Leader.Y
		
		Icon_Lootmaster_Enable = db.oUF.ToToT.Icons.Lootmaster.Enable
		Icon_Lootmaster_Size = db.oUF.ToToT.Icons.Lootmaster.Size
		Icon_Lootmaster_Point = db.oUF.ToToT.Icons.Lootmaster.Point
		Icon_Lootmaster_X = db.oUF.ToToT.Icons.Lootmaster.X
		Icon_Lootmaster_Y = db.oUF.ToToT.Icons.Lootmaster.Y
		
		Icon_Raid_Enable = db.oUF.ToToT.Icons.Raid.Enable == true
		Icon_Raid_Size = db.oUF.ToToT.Icons.Raid.Size
		Icon_Raid_Point = db.oUF.ToToT.Icons.Raid.Point
		Icon_Raid_X = db.oUF.ToToT.Icons.Raid.X
		Icon_Raid_Y = db.oUF.ToToT.Icons.Raid.Y
		
		Icon_Role_Enable = db.oUF.ToToT.Icons.Role.Enable
		Icon_Role_Size = db.oUF.ToToT.Icons.Role.Size
		Icon_Role_Point = db.oUF.ToToT.Icons.Role.Point
		Icon_Role_X = db.oUF.ToToT.Icons.Role.X
		Icon_Role_Y = db.oUF.ToToT.Icons.Role.Y
		
		Icon_Resting_Enable = db.oUF.ToToT.Icons.Resting.Enable
		Icon_Resting_Size = db.oUF.ToToT.Icons.Resting.Size
		Icon_Resting_Point = db.oUF.ToToT.Icons.Resting.Point
		Icon_Resting_X = db.oUF.ToToT.Icons.Resting.X
		Icon_Resting_Y = db.oUF.ToToT.Icons.Resting.Y
		
		Icon_Combat_Enable = db.oUF.ToToT.Icons.Combat.Enable
		Icon_Combat_Size = db.oUF.ToToT.Icons.Combat.Size
		Icon_Combat_Point = db.oUF.ToToT.Icons.Combat.Point
		Icon_Combat_X = db.oUF.ToToT.Icons.Combat.X
		Icon_Combat_Y = db.oUF.ToToT.Icons.Combat.Y
		
		Icon_PvP_Enable = db.oUF.ToToT.Icons.PvP.Enable
		Icon_PvP_Size = db.oUF.ToToT.Icons.PvP.Size
		Icon_PvP_Point = db.oUF.ToToT.Icons.PvP.Point
		Icon_PvP_X = db.oUF.ToToT.Icons.PvP.X
		Icon_PvP_Y = db.oUF.ToToT.Icons.PvP.Y
		
		Portrait_Enable = db.oUF.ToToT.Portrait.Enable
		Portrait_Width = db.oUF.ToToT.Portrait.Width
		Portrait_Height = db.oUF.ToToT.Portrait.Height
		Portrait_X = db.oUF.ToToT.Portrait.X
		Portrait_Y = db.oUF.ToToT.Portrait.Y

------------------------------------------------------------------------
--	FOCUS
------------------------------------------------------------------------
	elseif unit == "focus" then
		
		Fullbar_Enable = db.oUF.Focus.Full.Enable
		Fullbar_Height = tonumber(db.oUF.Focus.Full.Height)
		Fullbar_Texture = LSM:Fetch("statusbar", db.oUF.Focus.Full.Texture)
		Fullbar_Padding = tonumber(db.oUF.Focus.Full.Padding)
		Fullbar_Alpha = db.oUF.Focus.Full.Alpha
		Fullbar_Color_r = tonumber(db.oUF.Focus.Full.Color.r)
		Fullbar_Color_g = tonumber(db.oUF.Focus.Full.Color.g)
		Fullbar_Color_b = tonumber(db.oUF.Focus.Full.Color.b)
		Fullbar_Color_a = tonumber(db.oUF.Focus.Full.Color.a)
		
		FrameHeight = tonumber(db.oUF.Focus.Height)
		FrameWidth = tonumber(db.oUF.Focus.Width)
		HealthHeight = tonumber(db.oUF.Focus.Health.Height)
		PowerHeight = tonumber(db.oUF.Focus.Power.Height)
		ShowPower = db.oUF.Focus.Power.Enable
		
		HealthPadding =  tonumber(db.oUF.Focus.Health.Padding)
		PowerPadding = tonumber(db.oUF.Focus.Power.Padding)
		
		HealthTexture = LSM:Fetch("statusbar", db.oUF.Focus.Health.Texture)
		HealthTextureBG = LSM:Fetch("statusbar", db.oUF.Focus.Health.TextureBG)
		HealthTextureBGAlpha = tonumber(db.oUF.Focus.Health.BGAlpha)
		HealthTextureBGMP = tonumber(db.oUF.Focus.Health.BGMultiplier)
		
		PowerTexture = LSM:Fetch("statusbar", db.oUF.Focus.Power.Texture)
		PowerTextureBG = LSM:Fetch("statusbar", db.oUF.Focus.Power.TextureBG)
		PowerTextureBGAlpha = tonumber(db.oUF.Focus.Power.BGAlpha)
		PowerTextureBGMP = tonumber(db.oUF.Focus.Power.BGMultiplier)
		
		Health_colorClass = db.oUF.Focus.Health.ColorClass
		Health_colorTapping = false
		Health_colorDisconnected = false
		Health_colorSmooth = db.oUF.Focus.Health.ColorGradient
		Health_Smooth = db.oUF.Focus.Health.Smooth
		Health_colorReaction = false
		Health_frequentUpdates = false
		Health_OverrideUpdateHealth = true
		
		Power_colorDisconnected = false
		Power_colorType = db.oUF.Focus.Power.ColorType
		Power_colorClass = db.oUF.Focus.Power.ColorClass
		Power_Smooth = db.oUF.Focus.Power.Smooth
		Power_colorSmooth = false
		Power_OverrideUpdatePower = true
		Power_colorReaction = false
		Power_frequentUpdates = true
		
		Info_Font = LSM:Fetch("font", db.oUF.Focus.Texts.Name.Font)
		Info_Size = tonumber(db.oUF.Focus.Texts.Name.Size)
		Info_Style = db.oUF.Focus.Texts.Name.Outline
		Info_Point = db.oUF.Focus.Texts.Name.Point
		Info_RelativePoint = db.oUF.Focus.Texts.Name.RelativePoint
		Info_X = tonumber(db.oUF.Focus.Texts.Name.X)
		Info_Y = tonumber(db.oUF.Focus.Texts.Name.Y)
		Info_Format = db.oUF.Focus.Texts.Name.Format
		Info_NameLength = db.oUF.Focus.Texts.Name.Length
		Info_ColorNameByClass = db.oUF.Focus.Texts.Name.ColorNameByClass
		Info_ColorClassByClass = db.oUF.Focus.Texts.Name.ColorClassByClass
		Info_ColorLevelByDifficulty = db.oUF.Focus.Texts.Name.ColorLevelByDifficulty
		Info_ShowClassification = db.oUF.Focus.Texts.Name.ShowClassification
		Info_ShortClassification = db.oUF.Focus.Texts.Name.ShortClassification
		
		Health_Value_Font = LSM:Fetch("font", db.oUF.Focus.Texts.Health.Font)
		Health_Value_Size = tonumber(db.oUF.Focus.Texts.Health.Size)
		Health_Value_Style = db.oUF.Focus.Texts.Health.Outline
		Health_Value_Point = db.oUF.Focus.Texts.Health.Point
		Health_Value_RelativePoint = db.oUF.Focus.Texts.Health.RelativePoint
		Health_Value_X = tonumber(db.oUF.Focus.Texts.Health.X)
		Health_Value_Y = tonumber(db.oUF.Focus.Texts.Health.Y)
		
		Health_Percent_Font = LSM:Fetch("font", db.oUF.Focus.Texts.HealthPercent.Font)
		Health_Percent_Size = tonumber(db.oUF.Focus.Texts.HealthPercent.Size)
		Health_Percent_Style = db.oUF.Focus.Texts.HealthPercent.Outline
		Health_Percent_Point = db.oUF.Focus.Texts.HealthPercent.Point
		Health_Percent_RelativePoint = db.oUF.Focus.Texts.HealthPercent.RelativePoint
		Health_Percent_X = tonumber(db.oUF.Focus.Texts.HealthPercent.X)
		Health_Percent_Y = tonumber(db.oUF.Focus.Texts.HealthPercent.Y)
		
		Health_Missing_Font = LSM:Fetch("font", db.oUF.Focus.Texts.HealthMissing.Font)
		Health_Missing_Size = tonumber(db.oUF.Focus.Texts.HealthMissing.Size)
		Health_Missing_Style = db.oUF.Focus.Texts.HealthMissing.Outline
		Health_Missing_Point = db.oUF.Focus.Texts.HealthMissing.Point
		Health_Missing_RelativePoint = db.oUF.Focus.Texts.HealthMissing.RelativePoint
		Health_Missing_X = tonumber(db.oUF.Focus.Texts.HealthMissing.X)
		Health_Missing_Y = tonumber(db.oUF.Focus.Texts.HealthMissing.Y)
		
		Power_Value_Font = LSM:Fetch("font", db.oUF.Focus.Texts.Power.Font)
		Power_Value_Size = tonumber(db.oUF.Focus.Texts.Power.Size)
		Power_Value_Style = db.oUF.Focus.Texts.Power.Outline
		Power_Value_Point = db.oUF.Focus.Texts.Power.Point
		Power_Value_RelativePoint = db.oUF.Focus.Texts.Power.RelativePoint
		Power_Value_X = tonumber(db.oUF.Focus.Texts.Power.X)
		Power_Value_Y = tonumber(db.oUF.Focus.Texts.Power.Y)
		
		Power_Percent_Font = LSM:Fetch("font", db.oUF.Focus.Texts.PowerPercent.Font)
		Power_Percent_Size = tonumber(db.oUF.Focus.Texts.PowerPercent.Size)
		Power_Percent_Style = db.oUF.Focus.Texts.PowerPercent.Outline
		Power_Percent_Point = db.oUF.Focus.Texts.PowerPercent.Point
		Power_Percent_RelativePoint = db.oUF.Focus.Texts.PowerPercent.RelativePoint
		Power_Percent_X = tonumber(db.oUF.Focus.Texts.PowerPercent.X)
		Power_Percent_Y = tonumber(db.oUF.Focus.Texts.PowerPercent.Y)
		
		Power_Missing_Font = LSM:Fetch("font", db.oUF.Focus.Texts.PowerMissing.Font)
		Power_Missing_Size = tonumber(db.oUF.Focus.Texts.PowerMissing.Size)
		Power_Missing_Style = db.oUF.Focus.Texts.PowerMissing.Outline
		Power_Missing_Point = db.oUF.Focus.Texts.PowerMissing.Point
		Power_Missing_RelativePoint = db.oUF.Focus.Texts.PowerMissing.RelativePoint
		Power_Missing_X = tonumber(db.oUF.Focus.Texts.PowerMissing.X)
		Power_Missing_Y = tonumber(db.oUF.Focus.Texts.PowerMissing.Y)
		
		ShowInfo = db.oUF.Focus.Texts.Name.Enable
		
		ShowHealthValue = db.oUF.Focus.Texts.Health.Enable
		ShowHealthPercent = db.oUF.Focus.Texts.HealthPercent.Enable
		ShowHealthMissing = db.oUF.Focus.Texts.HealthMissing.Enable
		
		ShowPowerValue = db.oUF.Focus.Texts.Power.Enable
		ShowPowerPercent = db.oUF.Focus.Texts.PowerPercent.Enable
		ShowPowerMissing = db.oUF.Focus.Texts.PowerMissing.Enable
		
		Icon_Leader_Enable = db.oUF.Focus.Icons.Leader.Enable
		Icon_Leader_Size = db.oUF.Focus.Icons.Leader.Size
		Icon_Leader_Point = db.oUF.Focus.Icons.Leader.Point
		Icon_Leader_X = db.oUF.Focus.Icons.Leader.X
		Icon_Leader_Y = db.oUF.Focus.Icons.Leader.Y
		
		Icon_Lootmaster_Enable = db.oUF.Focus.Icons.Lootmaster.Enable
		Icon_Lootmaster_Size = db.oUF.Focus.Icons.Lootmaster.Size
		Icon_Lootmaster_Point = db.oUF.Focus.Icons.Lootmaster.Point
		Icon_Lootmaster_X = db.oUF.Focus.Icons.Lootmaster.X
		Icon_Lootmaster_Y = db.oUF.Focus.Icons.Lootmaster.Y
		
		Icon_Raid_Enable = db.oUF.Focus.Icons.Raid.Enable == true
		Icon_Raid_Size = db.oUF.Focus.Icons.Raid.Size
		Icon_Raid_Point = db.oUF.Focus.Icons.Raid.Point
		Icon_Raid_X = db.oUF.Focus.Icons.Raid.X
		Icon_Raid_Y = db.oUF.Focus.Icons.Raid.Y
		
		Icon_Role_Enable = db.oUF.Focus.Icons.Role.Enable
		Icon_Role_Size = db.oUF.Focus.Icons.Role.Size
		Icon_Role_Point = db.oUF.Focus.Icons.Role.Point
		Icon_Role_X = db.oUF.Focus.Icons.Role.X
		Icon_Role_Y = db.oUF.Focus.Icons.Role.Y
		
		Icon_Resting_Enable = db.oUF.Focus.Icons.Resting.Enable
		Icon_Resting_Size = db.oUF.Focus.Icons.Resting.Size
		Icon_Resting_Point = db.oUF.Focus.Icons.Resting.Point
		Icon_Resting_X = db.oUF.Focus.Icons.Resting.X
		Icon_Resting_Y = db.oUF.Focus.Icons.Resting.Y
		
		Icon_Combat_Enable = db.oUF.Focus.Icons.Combat.Enable
		Icon_Combat_Size = db.oUF.Focus.Icons.Combat.Size
		Icon_Combat_Point = db.oUF.Focus.Icons.Combat.Point
		Icon_Combat_X = db.oUF.Focus.Icons.Combat.X
		Icon_Combat_Y = db.oUF.Focus.Icons.Combat.Y
		
		Icon_PvP_Enable = db.oUF.Focus.Icons.PvP.Enable
		Icon_PvP_Size = db.oUF.Focus.Icons.PvP.Size
		Icon_PvP_Point = db.oUF.Focus.Icons.PvP.Point
		Icon_PvP_X = db.oUF.Focus.Icons.PvP.X
		Icon_PvP_Y = db.oUF.Focus.Icons.PvP.Y
		
		Portrait_Enable = db.oUF.Focus.Portrait.Enable
		Portrait_Width = db.oUF.Focus.Portrait.Width
		Portrait_Height = db.oUF.Focus.Portrait.Height
		Portrait_X = db.oUF.Focus.Portrait.X
		Portrait_Y = db.oUF.Focus.Portrait.Y
		
------------------------------------------------------------------------
--	FOCUSTARGET
------------------------------------------------------------------------
	elseif unit == "focustarget" then
	
		Fullbar_Enable = db.oUF.FocusTarget.Full.Enable
		Fullbar_Height = tonumber(db.oUF.FocusTarget.Full.Height)
		Fullbar_Texture = LSM:Fetch("statusbar", db.oUF.FocusTarget.Full.Texture)
		Fullbar_Padding = tonumber(db.oUF.FocusTarget.Full.Padding)
		Fullbar_Alpha = db.oUF.FocusTarget.Full.Alpha
		Fullbar_Color_r = tonumber(db.oUF.FocusTarget.Full.Color.r)
		Fullbar_Color_g = tonumber(db.oUF.FocusTarget.Full.Color.g)
		Fullbar_Color_b = tonumber(db.oUF.FocusTarget.Full.Color.b)
		Fullbar_Color_a = tonumber(db.oUF.FocusTarget.Full.Color.a)
		
		FrameHeight = tonumber(db.oUF.FocusTarget.Height)
		FrameWidth = tonumber(db.oUF.FocusTarget.Width)
		HealthHeight = tonumber(db.oUF.FocusTarget.Health.Height)
		PowerHeight = tonumber(db.oUF.FocusTarget.Power.Height)
		ShowPower = db.oUF.FocusTarget.Power.Enable
		
		HealthPadding =  tonumber(db.oUF.FocusTarget.Health.Padding)
		PowerPadding = tonumber(db.oUF.FocusTarget.Power.Padding)
		
		HealthTexture = LSM:Fetch("statusbar", db.oUF.FocusTarget.Health.Texture)
		HealthTextureBG = LSM:Fetch("statusbar", db.oUF.FocusTarget.Health.TextureBG)
		HealthTextureBGAlpha = tonumber(db.oUF.FocusTarget.Health.BGAlpha)
		HealthTextureBGMP = tonumber(db.oUF.FocusTarget.Health.BGMultiplier)
		
		PowerTexture = LSM:Fetch("statusbar", db.oUF.FocusTarget.Power.Texture)
		PowerTextureBG = LSM:Fetch("statusbar", db.oUF.FocusTarget.Power.TextureBG)
		PowerTextureBGAlpha = tonumber(db.oUF.FocusTarget.Power.BGAlpha)
		PowerTextureBGMP = tonumber(db.oUF.FocusTarget.Power.BGMultiplier)
		
		Health_colorClass = db.oUF.FocusTarget.Health.ColorClass
		Health_colorTapping = false
		Health_colorDisconnected = false
		Health_colorSmooth = db.oUF.FocusTarget.Health.ColorGradient
		Health_Smooth = db.oUF.FocusTarget.Health.Smooth
		Health_colorReaction = false
		Health_frequentUpdates = false
		Health_OverrideUpdateHealth = true
		
		Power_colorDisconnected = false
		Power_colorType = db.oUF.FocusTarget.Power.ColorType
		Power_colorClass = db.oUF.FocusTarget.Power.ColorClass
		Power_Smooth = db.oUF.FocusTarget.Power.Smooth
		Power_colorSmooth = false
		Power_OverrideUpdatePower = true
		Power_colorReaction = false
		Power_frequentUpdates = true
		
		Info_Font = LSM:Fetch("font", db.oUF.FocusTarget.Texts.Name.Font)
		Info_Size = tonumber(db.oUF.FocusTarget.Texts.Name.Size)
		Info_Style = db.oUF.FocusTarget.Texts.Name.Outline
		Info_Point = db.oUF.FocusTarget.Texts.Name.Point
		Info_RelativePoint = db.oUF.FocusTarget.Texts.Name.RelativePoint
		Info_X = tonumber(db.oUF.FocusTarget.Texts.Name.X)
		Info_Y = tonumber(db.oUF.FocusTarget.Texts.Name.Y)
		Info_Format = db.oUF.FocusTarget.Texts.Name.Format
		Info_NameLength = db.oUF.FocusTarget.Texts.Name.Length
		Info_ColorNameByClass = db.oUF.FocusTarget.Texts.Name.ColorNameByClass
		Info_ColorClassByClass = db.oUF.FocusTarget.Texts.Name.ColorClassByClass
		Info_ColorLevelByDifficulty = db.oUF.FocusTarget.Texts.Name.ColorLevelByDifficulty
		Info_ShowClassification = db.oUF.FocusTarget.Texts.Name.ShowClassification
		Info_ShortClassification = db.oUF.FocusTarget.Texts.Name.ShortClassification
		
		Health_Value_Font = LSM:Fetch("font", db.oUF.FocusTarget.Texts.Health.Font)
		Health_Value_Size = tonumber(db.oUF.FocusTarget.Texts.Health.Size)
		Health_Value_Style = db.oUF.FocusTarget.Texts.Health.Outline
		Health_Value_Point = db.oUF.FocusTarget.Texts.Health.Point
		Health_Value_RelativePoint = db.oUF.FocusTarget.Texts.Health.RelativePoint
		Health_Value_X = tonumber(db.oUF.FocusTarget.Texts.Health.X)
		Health_Value_Y = tonumber(db.oUF.FocusTarget.Texts.Health.Y)
		
		Health_Percent_Font = LSM:Fetch("font", db.oUF.FocusTarget.Texts.HealthPercent.Font)
		Health_Percent_Size = tonumber(db.oUF.FocusTarget.Texts.HealthPercent.Size)
		Health_Percent_Style = db.oUF.FocusTarget.Texts.HealthPercent.Outline
		Health_Percent_Point = db.oUF.FocusTarget.Texts.HealthPercent.Point
		Health_Percent_RelativePoint = db.oUF.FocusTarget.Texts.HealthPercent.RelativePoint
		Health_Percent_X = tonumber(db.oUF.FocusTarget.Texts.HealthPercent.X)
		Health_Percent_Y = tonumber(db.oUF.FocusTarget.Texts.HealthPercent.Y)
		
		Health_Missing_Font = LSM:Fetch("font", db.oUF.FocusTarget.Texts.HealthMissing.Font)
		Health_Missing_Size = tonumber(db.oUF.FocusTarget.Texts.HealthMissing.Size)
		Health_Missing_Style = db.oUF.FocusTarget.Texts.HealthMissing.Outline
		Health_Missing_Point = db.oUF.FocusTarget.Texts.HealthMissing.Point
		Health_Missing_RelativePoint = db.oUF.FocusTarget.Texts.HealthMissing.RelativePoint
		Health_Missing_X = tonumber(db.oUF.FocusTarget.Texts.HealthMissing.X)
		Health_Missing_Y = tonumber(db.oUF.FocusTarget.Texts.HealthMissing.Y)
		
		Power_Value_Font = LSM:Fetch("font", db.oUF.FocusTarget.Texts.Power.Font)
		Power_Value_Size = tonumber(db.oUF.FocusTarget.Texts.Power.Size)
		Power_Value_Style = db.oUF.FocusTarget.Texts.Power.Outline
		Power_Value_Point = db.oUF.FocusTarget.Texts.Power.Point
		Power_Value_RelativePoint = db.oUF.FocusTarget.Texts.Power.RelativePoint
		Power_Value_X = tonumber(db.oUF.FocusTarget.Texts.Power.X)
		Power_Value_Y = tonumber(db.oUF.FocusTarget.Texts.Power.Y)
		
		Power_Percent_Font = LSM:Fetch("font", db.oUF.FocusTarget.Texts.PowerPercent.Font)
		Power_Percent_Size = tonumber(db.oUF.FocusTarget.Texts.PowerPercent.Size)
		Power_Percent_Style = db.oUF.FocusTarget.Texts.PowerPercent.Outline
		Power_Percent_Point = db.oUF.FocusTarget.Texts.PowerPercent.Point
		Power_Percent_RelativePoint = db.oUF.FocusTarget.Texts.PowerPercent.RelativePoint
		Power_Percent_X = tonumber(db.oUF.FocusTarget.Texts.PowerPercent.X)
		Power_Percent_Y = tonumber(db.oUF.FocusTarget.Texts.PowerPercent.Y)
		
		Power_Missing_Font = LSM:Fetch("font", db.oUF.FocusTarget.Texts.PowerMissing.Font)
		Power_Missing_Size = tonumber(db.oUF.FocusTarget.Texts.PowerMissing.Size)
		Power_Missing_Style = db.oUF.FocusTarget.Texts.PowerMissing.Outline
		Power_Missing_Point = db.oUF.FocusTarget.Texts.PowerMissing.Point
		Power_Missing_RelativePoint = db.oUF.FocusTarget.Texts.PowerMissing.RelativePoint
		Power_Missing_X = tonumber(db.oUF.FocusTarget.Texts.PowerMissing.X)
		Power_Missing_Y = tonumber(db.oUF.FocusTarget.Texts.PowerMissing.Y)
		
		ShowInfo = db.oUF.FocusTarget.Texts.Name.Enable
		
		ShowHealthValue = db.oUF.FocusTarget.Texts.Health.Enable
		ShowHealthPercent = db.oUF.FocusTarget.Texts.HealthPercent.Enable
		ShowHealthMissing = db.oUF.FocusTarget.Texts.HealthMissing.Enable
		
		ShowPowerValue = db.oUF.FocusTarget.Texts.Power.Enable
		ShowPowerPercent = db.oUF.FocusTarget.Texts.PowerPercent.Enable
		ShowPowerMissing = db.oUF.FocusTarget.Texts.PowerMissing.Enable
		
		Icon_Leader_Enable = db.oUF.FocusTarget.Icons.Leader.Enable
		Icon_Leader_Size = db.oUF.FocusTarget.Icons.Leader.Size
		Icon_Leader_Point = db.oUF.FocusTarget.Icons.Leader.Point
		Icon_Leader_X = db.oUF.FocusTarget.Icons.Leader.X
		Icon_Leader_Y = db.oUF.FocusTarget.Icons.Leader.Y
		
		Icon_Lootmaster_Enable = db.oUF.FocusTarget.Icons.Lootmaster.Enable
		Icon_Lootmaster_Size = db.oUF.FocusTarget.Icons.Lootmaster.Size
		Icon_Lootmaster_Point = db.oUF.FocusTarget.Icons.Lootmaster.Point
		Icon_Lootmaster_X = db.oUF.FocusTarget.Icons.Lootmaster.X
		Icon_Lootmaster_Y = db.oUF.FocusTarget.Icons.Lootmaster.Y
		
		Icon_Raid_Enable = db.oUF.FocusTarget.Icons.Raid.Enable == true
		Icon_Raid_Size = db.oUF.FocusTarget.Icons.Raid.Size
		Icon_Raid_Point = db.oUF.FocusTarget.Icons.Raid.Point
		Icon_Raid_X = db.oUF.FocusTarget.Icons.Raid.X
		Icon_Raid_Y = db.oUF.FocusTarget.Icons.Raid.Y
		
		Icon_Role_Enable = db.oUF.FocusTarget.Icons.Role.Enable
		Icon_Role_Size = db.oUF.FocusTarget.Icons.Role.Size
		Icon_Role_Point = db.oUF.FocusTarget.Icons.Role.Point
		Icon_Role_X = db.oUF.FocusTarget.Icons.Role.X
		Icon_Role_Y = db.oUF.FocusTarget.Icons.Role.Y
		
		Icon_Resting_Enable = db.oUF.FocusTarget.Icons.Resting.Enable
		Icon_Resting_Size = db.oUF.FocusTarget.Icons.Resting.Size
		Icon_Resting_Point = db.oUF.FocusTarget.Icons.Resting.Point
		Icon_Resting_X = db.oUF.FocusTarget.Icons.Resting.X
		Icon_Resting_Y = db.oUF.FocusTarget.Icons.Resting.Y
		
		Icon_Combat_Enable = db.oUF.FocusTarget.Icons.Combat.Enable
		Icon_Combat_Size = db.oUF.FocusTarget.Icons.Combat.Size
		Icon_Combat_Point = db.oUF.FocusTarget.Icons.Combat.Point
		Icon_Combat_X = db.oUF.FocusTarget.Icons.Combat.X
		Icon_Combat_Y = db.oUF.FocusTarget.Icons.Combat.Y
		
		Icon_PvP_Enable = db.oUF.FocusTarget.Icons.PvP.Enable
		Icon_PvP_Size = db.oUF.FocusTarget.Icons.PvP.Size
		Icon_PvP_Point = db.oUF.FocusTarget.Icons.PvP.Point
		Icon_PvP_X = db.oUF.FocusTarget.Icons.PvP.X
		Icon_PvP_Y = db.oUF.FocusTarget.Icons.PvP.Y
		
		Portrait_Enable = db.oUF.FocusTarget.Portrait.Enable
		Portrait_Width = db.oUF.FocusTarget.Portrait.Width
		Portrait_Height = db.oUF.FocusTarget.Portrait.Height
		Portrait_X = db.oUF.FocusTarget.Portrait.X
		Portrait_Y = db.oUF.FocusTarget.Portrait.Y
	
------------------------------------------------------------------------
--	PET
------------------------------------------------------------------------
	elseif unit == "pet" then
	
		Fullbar_Enable = db.oUF.Pet.Full.Enable
		Fullbar_Height = tonumber(db.oUF.Pet.Full.Height)
		Fullbar_Texture = LSM:Fetch("statusbar", db.oUF.Pet.Full.Texture)
		Fullbar_Padding = tonumber(db.oUF.Pet.Full.Padding)
		Fullbar_Alpha = db.oUF.Pet.Full.Alpha
		Fullbar_Color_r = tonumber(db.oUF.Pet.Full.Color.r)
		Fullbar_Color_g = tonumber(db.oUF.Pet.Full.Color.g)
		Fullbar_Color_b = tonumber(db.oUF.Pet.Full.Color.b)
		Fullbar_Color_a = tonumber(db.oUF.Pet.Full.Color.a)
	
		FrameHeight = tonumber(db.oUF.Pet.Height)
		FrameWidth = tonumber(db.oUF.Pet.Width)
		HealthHeight = tonumber(db.oUF.Pet.Health.Height)
		PowerHeight = tonumber(db.oUF.Pet.Power.Height)
		ShowPower = db.oUF.Pet.Power.Enable
		
		HealthPadding =  tonumber(db.oUF.Pet.Health.Padding)
		PowerPadding = tonumber(db.oUF.Pet.Power.Padding)
		
		HealthTexture = LSM:Fetch("statusbar", db.oUF.Pet.Health.Texture)
		HealthTextureBG = LSM:Fetch("statusbar", db.oUF.Pet.Health.TextureBG)
		HealthTextureBGAlpha = tonumber(db.oUF.Pet.Health.BGAlpha)
		HealthTextureBGMP = tonumber(db.oUF.Pet.Health.BGMultiplier)
		
		PowerTexture = LSM:Fetch("statusbar", db.oUF.Pet.Power.Texture)
		PowerTextureBG = LSM:Fetch("statusbar", db.oUF.Pet.Power.TextureBG)
		PowerTextureBGAlpha = tonumber(db.oUF.Pet.Power.BGAlpha)
		PowerTextureBGMP = tonumber(db.oUF.Pet.Power.BGMultiplier)
		
		Health_colorClass = db.oUF.Pet.Health.ColorClass
		Health_colorTapping = false
		Health_colorDisconnected = false
		Health_colorSmooth = db.oUF.Pet.Health.ColorGradient
		Health_Smooth = db.oUF.Pet.Health.Smooth
		Health_colorReaction = false
		Health_frequentUpdates = false
		Health_OverrideUpdateHealth = true
		
		Power_colorDisconnected = false
		Power_colorType = db.oUF.Pet.Power.ColorType
		Power_colorClass = db.oUF.Pet.Power.ColorClass
		Power_Smooth = db.oUF.Pet.Power.Smooth
		Power_colorSmooth = false
		Power_OverrideUpdatePower = true
		Power_colorReaction = false
		Power_frequentUpdates = true
		
		Info_Font = LSM:Fetch("font", db.oUF.Pet.Texts.Name.Font)
		Info_Size = tonumber(db.oUF.Pet.Texts.Name.Size)
		Info_Style = db.oUF.Pet.Texts.Name.Outline
		Info_Point = db.oUF.Pet.Texts.Name.Point
		Info_RelativePoint = db.oUF.Pet.Texts.Name.RelativePoint
		Info_X = tonumber(db.oUF.Pet.Texts.Name.X)
		Info_Y = tonumber(db.oUF.Pet.Texts.Name.Y)
		Info_Format = db.oUF.Pet.Texts.Name.Format
		Info_NameLength = db.oUF.Pet.Texts.Name.Length
		Info_ColorNameByClass = db.oUF.Pet.Texts.Name.ColorNameByClass
		Info_ColorClassByClass = db.oUF.Pet.Texts.Name.ColorClassByClass
		Info_ColorLevelByDifficulty = db.oUF.Pet.Texts.Name.ColorLevelByDifficulty
		Info_ShowClassification = db.oUF.Pet.Texts.Name.ShowClassification
		Info_ShortClassification = db.oUF.Pet.Texts.Name.ShortClassification
		
		Health_Value_Font = LSM:Fetch("font", db.oUF.Pet.Texts.Health.Font)
		Health_Value_Size = tonumber(db.oUF.Pet.Texts.Health.Size)
		Health_Value_Style = db.oUF.Pet.Texts.Health.Outline
		Health_Value_Point = db.oUF.Pet.Texts.Health.Point
		Health_Value_RelativePoint = db.oUF.Pet.Texts.Health.RelativePoint
		Health_Value_X = tonumber(db.oUF.Pet.Texts.Health.X)
		Health_Value_Y = tonumber(db.oUF.Pet.Texts.Health.Y)
		
		Health_Percent_Font = LSM:Fetch("font", db.oUF.Pet.Texts.HealthPercent.Font)
		Health_Percent_Size = tonumber(db.oUF.Pet.Texts.HealthPercent.Size)
		Health_Percent_Style = db.oUF.Pet.Texts.HealthPercent.Outline
		Health_Percent_Point = db.oUF.Pet.Texts.HealthPercent.Point
		Health_Percent_RelativePoint = db.oUF.Pet.Texts.HealthPercent.RelativePoint
		Health_Percent_X = tonumber(db.oUF.Pet.Texts.HealthPercent.X)
		Health_Percent_Y = tonumber(db.oUF.Pet.Texts.HealthPercent.Y)
		
		Health_Missing_Font = LSM:Fetch("font", db.oUF.Pet.Texts.HealthMissing.Font)
		Health_Missing_Size = tonumber(db.oUF.Pet.Texts.HealthMissing.Size)
		Health_Missing_Style = db.oUF.Pet.Texts.HealthMissing.Outline
		Health_Missing_Point = db.oUF.Pet.Texts.HealthMissing.Point
		Health_Missing_RelativePoint = db.oUF.Pet.Texts.HealthMissing.RelativePoint
		Health_Missing_X = tonumber(db.oUF.Pet.Texts.HealthMissing.X)
		Health_Missing_Y = tonumber(db.oUF.Pet.Texts.HealthMissing.Y)
		
		Power_Value_Font = LSM:Fetch("font", db.oUF.Pet.Texts.Power.Font)
		Power_Value_Size = tonumber(db.oUF.Pet.Texts.Power.Size)
		Power_Value_Style = db.oUF.Pet.Texts.Power.Outline
		Power_Value_Point = db.oUF.Pet.Texts.Power.Point
		Power_Value_RelativePoint = db.oUF.Pet.Texts.Power.RelativePoint
		Power_Value_X = tonumber(db.oUF.Pet.Texts.Power.X)
		Power_Value_Y = tonumber(db.oUF.Pet.Texts.Power.Y)
		
		Power_Percent_Font = LSM:Fetch("font", db.oUF.Pet.Texts.PowerPercent.Font)
		Power_Percent_Size = tonumber(db.oUF.Pet.Texts.PowerPercent.Size)
		Power_Percent_Style = db.oUF.Pet.Texts.PowerPercent.Outline
		Power_Percent_Point = db.oUF.Pet.Texts.PowerPercent.Point
		Power_Percent_RelativePoint = db.oUF.Pet.Texts.PowerPercent.RelativePoint
		Power_Percent_X = tonumber(db.oUF.Pet.Texts.PowerPercent.X)
		Power_Percent_Y = tonumber(db.oUF.Pet.Texts.PowerPercent.Y)
		
		Power_Missing_Font = LSM:Fetch("font", db.oUF.Pet.Texts.PowerMissing.Font)
		Power_Missing_Size = tonumber(db.oUF.Pet.Texts.PowerMissing.Size)
		Power_Missing_Style = db.oUF.Pet.Texts.PowerMissing.Outline
		Power_Missing_Point = db.oUF.Pet.Texts.PowerMissing.Point
		Power_Missing_RelativePoint = db.oUF.Pet.Texts.PowerMissing.RelativePoint
		Power_Missing_X = tonumber(db.oUF.Pet.Texts.PowerMissing.X)
		Power_Missing_Y = tonumber(db.oUF.Pet.Texts.PowerMissing.Y)
		
		ShowInfo = db.oUF.Pet.Texts.Name.Enable
		
		ShowHealthValue = db.oUF.Pet.Texts.Health.Enable
		ShowHealthPercent = db.oUF.Pet.Texts.HealthPercent.Enable
		ShowHealthMissing = db.oUF.Pet.Texts.HealthMissing.Enable
		
		ShowPowerValue = db.oUF.Pet.Texts.Power.Enable
		ShowPowerPercent = db.oUF.Pet.Texts.PowerPercent.Enable
		ShowPowerMissing = db.oUF.Pet.Texts.PowerMissing.Enable
		
		Icon_Leader_Enable = db.oUF.Pet.Icons.Leader.Enable
		Icon_Leader_Size = db.oUF.Pet.Icons.Leader.Size
		Icon_Leader_Point = db.oUF.Pet.Icons.Leader.Point
		Icon_Leader_X = db.oUF.Pet.Icons.Leader.X
		Icon_Leader_Y = db.oUF.Pet.Icons.Leader.Y
		
		Icon_Lootmaster_Enable = db.oUF.Pet.Icons.Lootmaster.Enable
		Icon_Lootmaster_Size = db.oUF.Pet.Icons.Lootmaster.Size
		Icon_Lootmaster_Point = db.oUF.Pet.Icons.Lootmaster.Point
		Icon_Lootmaster_X = db.oUF.Pet.Icons.Lootmaster.X
		Icon_Lootmaster_Y = db.oUF.Pet.Icons.Lootmaster.Y
		
		Icon_Raid_Enable = db.oUF.Pet.Icons.Raid.Enable == true
		Icon_Raid_Size = db.oUF.Pet.Icons.Raid.Size
		Icon_Raid_Point = db.oUF.Pet.Icons.Raid.Point
		Icon_Raid_X = db.oUF.Pet.Icons.Raid.X
		Icon_Raid_Y = db.oUF.Pet.Icons.Raid.Y
		
		Icon_Role_Enable = db.oUF.Pet.Icons.Role.Enable
		Icon_Role_Size = db.oUF.Pet.Icons.Role.Size
		Icon_Role_Point = db.oUF.Pet.Icons.Role.Point
		Icon_Role_X = db.oUF.Pet.Icons.Role.X
		Icon_Role_Y = db.oUF.Pet.Icons.Role.Y
		
		Icon_Resting_Enable = db.oUF.Pet.Icons.Resting.Enable
		Icon_Resting_Size = db.oUF.Pet.Icons.Resting.Size
		Icon_Resting_Point = db.oUF.Pet.Icons.Resting.Point
		Icon_Resting_X = db.oUF.Pet.Icons.Resting.X
		Icon_Resting_Y = db.oUF.Pet.Icons.Resting.Y
		
		Icon_Combat_Enable = db.oUF.Pet.Icons.Combat.Enable
		Icon_Combat_Size = db.oUF.Pet.Icons.Combat.Size
		Icon_Combat_Point = db.oUF.Pet.Icons.Combat.Point
		Icon_Combat_X = db.oUF.Pet.Icons.Combat.X
		Icon_Combat_Y = db.oUF.Pet.Icons.Combat.Y
		
		Icon_PvP_Enable = db.oUF.Pet.Icons.PvP.Enable
		Icon_PvP_Size = db.oUF.Pet.Icons.PvP.Size
		Icon_PvP_Point = db.oUF.Pet.Icons.PvP.Point
		Icon_PvP_X = db.oUF.Pet.Icons.PvP.X
		Icon_PvP_Y = db.oUF.Pet.Icons.PvP.Y
		
		Portrait_Enable = db.oUF.Pet.Portrait.Enable
		Portrait_Width = db.oUF.Pet.Portrait.Width
		Portrait_Height = db.oUF.Pet.Portrait.Height
		Portrait_X = db.oUF.Pet.Portrait.X
		Portrait_Y = db.oUF.Pet.Portrait.Y
		
------------------------------------------------------------------------
--	PETTARGET
------------------------------------------------------------------------
	elseif unit == "pettarget" then
	
		Fullbar_Enable = db.oUF.PetTarget.Full.Enable
		Fullbar_Height = tonumber(db.oUF.PetTarget.Full.Height)
		Fullbar_Texture = LSM:Fetch("statusbar", db.oUF.PetTarget.Full.Texture)
		Fullbar_Padding = tonumber(db.oUF.PetTarget.Full.Padding)
		Fullbar_Alpha = db.oUF.PetTarget.Full.Alpha
		Fullbar_Color_r = tonumber(db.oUF.PetTarget.Full.Color.r)
		Fullbar_Color_g = tonumber(db.oUF.PetTarget.Full.Color.g)
		Fullbar_Color_b = tonumber(db.oUF.PetTarget.Full.Color.b)
		Fullbar_Color_a = tonumber(db.oUF.PetTarget.Full.Color.a)
	
		FrameHeight = tonumber(db.oUF.PetTarget.Height)
		FrameWidth = tonumber(db.oUF.PetTarget.Width)
		HealthHeight = tonumber(db.oUF.PetTarget.Health.Height)
		PowerHeight = tonumber(db.oUF.PetTarget.Power.Height)
		ShowPower = db.oUF.PetTarget.Power.Enable
		
		HealthPadding =  tonumber(db.oUF.PetTarget.Health.Padding)
		PowerPadding = tonumber(db.oUF.PetTarget.Power.Padding)
		
		HealthTexture = LSM:Fetch("statusbar", db.oUF.PetTarget.Health.Texture)
		HealthTextureBG = LSM:Fetch("statusbar", db.oUF.PetTarget.Health.TextureBG)
		HealthTextureBGAlpha = tonumber(db.oUF.PetTarget.Health.BGAlpha)
		HealthTextureBGMP = tonumber(db.oUF.PetTarget.Health.BGMultiplier)
		
		PowerTexture = LSM:Fetch("statusbar", db.oUF.PetTarget.Power.Texture)
		PowerTextureBG = LSM:Fetch("statusbar", db.oUF.PetTarget.Power.TextureBG)
		PowerTextureBGAlpha = tonumber(db.oUF.PetTarget.Power.BGAlpha)
		PowerTextureBGMP = tonumber(db.oUF.PetTarget.Power.BGMultiplier)
		
		Health_colorClass = db.oUF.PetTarget.Health.ColorClass
		Health_colorTapping = false
		Health_colorDisconnected = false
		Health_colorSmooth = db.oUF.PetTarget.Health.ColorGradient
		Health_Smooth = db.oUF.PetTarget.Health.Smooth
		Health_colorReaction = false
		Health_frequentUpdates = false
		Health_OverrideUpdateHealth = true
		
		Power_colorDisconnected = false
		Power_colorType = db.oUF.PetTarget.Power.ColorType
		Power_colorClass = db.oUF.PetTarget.Power.ColorClass
		Power_Smooth = db.oUF.PetTarget.Power.Smooth
		Power_colorSmooth = false
		Power_OverrideUpdatePower = true
		Power_colorReaction = false
		Power_frequentUpdates = true
		
		Info_Font = LSM:Fetch("font", db.oUF.PetTarget.Texts.Name.Font)
		Info_Size = tonumber(db.oUF.PetTarget.Texts.Name.Size)
		Info_Style = db.oUF.PetTarget.Texts.Name.Outline
		Info_Point = db.oUF.PetTarget.Texts.Name.Point
		Info_RelativePoint = db.oUF.PetTarget.Texts.Name.RelativePoint
		Info_X = tonumber(db.oUF.PetTarget.Texts.Name.X)
		Info_Y = tonumber(db.oUF.PetTarget.Texts.Name.Y)
		Info_Format = db.oUF.PetTarget.Texts.Name.Format
		Info_NameLength = db.oUF.PetTarget.Texts.Name.Length
		Info_ColorNameByClass = db.oUF.PetTarget.Texts.Name.ColorNameByClass
		Info_ColorClassByClass = db.oUF.PetTarget.Texts.Name.ColorClassByClass
		Info_ColorLevelByDifficulty = db.oUF.PetTarget.Texts.Name.ColorLevelByDifficulty
		Info_ShowClassification = db.oUF.PetTarget.Texts.Name.ShowClassification
		Info_ShortClassification = db.oUF.PetTarget.Texts.Name.ShortClassification
		
		Health_Value_Font = LSM:Fetch("font", db.oUF.PetTarget.Texts.Health.Font)
		Health_Value_Size = tonumber(db.oUF.PetTarget.Texts.Health.Size)
		Health_Value_Style = db.oUF.PetTarget.Texts.Health.Outline
		Health_Value_Point = db.oUF.PetTarget.Texts.Health.Point
		Health_Value_RelativePoint = db.oUF.PetTarget.Texts.Health.RelativePoint
		Health_Value_X = tonumber(db.oUF.PetTarget.Texts.Health.X)
		Health_Value_Y = tonumber(db.oUF.PetTarget.Texts.Health.Y)
		
		Health_Percent_Font = LSM:Fetch("font", db.oUF.PetTarget.Texts.HealthPercent.Font)
		Health_Percent_Size = tonumber(db.oUF.PetTarget.Texts.HealthPercent.Size)
		Health_Percent_Style = db.oUF.PetTarget.Texts.HealthPercent.Outline
		Health_Percent_Point = db.oUF.PetTarget.Texts.HealthPercent.Point
		Health_Percent_RelativePoint = db.oUF.PetTarget.Texts.HealthPercent.RelativePoint
		Health_Percent_X = tonumber(db.oUF.PetTarget.Texts.HealthPercent.X)
		Health_Percent_Y = tonumber(db.oUF.PetTarget.Texts.HealthPercent.Y)
		
		Health_Missing_Font = LSM:Fetch("font", db.oUF.PetTarget.Texts.HealthMissing.Font)
		Health_Missing_Size = tonumber(db.oUF.PetTarget.Texts.HealthMissing.Size)
		Health_Missing_Style = db.oUF.PetTarget.Texts.HealthMissing.Outline
		Health_Missing_Point = db.oUF.PetTarget.Texts.HealthMissing.Point
		Health_Missing_RelativePoint = db.oUF.PetTarget.Texts.HealthMissing.RelativePoint
		Health_Missing_X = tonumber(db.oUF.PetTarget.Texts.HealthMissing.X)
		Health_Missing_Y = tonumber(db.oUF.PetTarget.Texts.HealthMissing.Y)
		
		Power_Value_Font = LSM:Fetch("font", db.oUF.PetTarget.Texts.Power.Font)
		Power_Value_Size = tonumber(db.oUF.PetTarget.Texts.Power.Size)
		Power_Value_Style = db.oUF.PetTarget.Texts.Power.Outline
		Power_Value_Point = db.oUF.PetTarget.Texts.Power.Point
		Power_Value_RelativePoint = db.oUF.PetTarget.Texts.Power.RelativePoint
		Power_Value_X = tonumber(db.oUF.PetTarget.Texts.Power.X)
		Power_Value_Y = tonumber(db.oUF.PetTarget.Texts.Power.Y)
		
		Power_Percent_Font = LSM:Fetch("font", db.oUF.PetTarget.Texts.PowerPercent.Font)
		Power_Percent_Size = tonumber(db.oUF.PetTarget.Texts.PowerPercent.Size)
		Power_Percent_Style = db.oUF.PetTarget.Texts.PowerPercent.Outline
		Power_Percent_Point = db.oUF.PetTarget.Texts.PowerPercent.Point
		Power_Percent_RelativePoint = db.oUF.PetTarget.Texts.PowerPercent.RelativePoint
		Power_Percent_X = tonumber(db.oUF.PetTarget.Texts.PowerPercent.X)
		Power_Percent_Y = tonumber(db.oUF.PetTarget.Texts.PowerPercent.Y)
		
		Power_Missing_Font = LSM:Fetch("font", db.oUF.PetTarget.Texts.PowerMissing.Font)
		Power_Missing_Size = tonumber(db.oUF.PetTarget.Texts.PowerMissing.Size)
		Power_Missing_Style = db.oUF.PetTarget.Texts.PowerMissing.Outline
		Power_Missing_Point = db.oUF.PetTarget.Texts.PowerMissing.Point
		Power_Missing_RelativePoint = db.oUF.PetTarget.Texts.PowerMissing.RelativePoint
		Power_Missing_X = tonumber(db.oUF.PetTarget.Texts.PowerMissing.X)
		Power_Missing_Y = tonumber(db.oUF.PetTarget.Texts.PowerMissing.Y)
		
		ShowInfo = db.oUF.PetTarget.Texts.Name.Enable
		
		ShowHealthValue = db.oUF.PetTarget.Texts.Health.Enable
		ShowHealthPercent = db.oUF.PetTarget.Texts.HealthPercent.Enable
		ShowHealthMissing = db.oUF.PetTarget.Texts.HealthMissing.Enable
		
		ShowPowerValue = db.oUF.PetTarget.Texts.Power.Enable
		ShowPowerPercent = db.oUF.PetTarget.Texts.PowerPercent.Enable
		ShowPowerMissing = db.oUF.PetTarget.Texts.PowerMissing.Enable
		
		Icon_Leader_Enable = db.oUF.PetTarget.Icons.Leader.Enable
		Icon_Leader_Size = db.oUF.PetTarget.Icons.Leader.Size
		Icon_Leader_Point = db.oUF.PetTarget.Icons.Leader.Point
		Icon_Leader_X = db.oUF.PetTarget.Icons.Leader.X
		Icon_Leader_Y = db.oUF.PetTarget.Icons.Leader.Y
		
		Icon_Lootmaster_Enable = db.oUF.PetTarget.Icons.Lootmaster.Enable
		Icon_Lootmaster_Size = db.oUF.PetTarget.Icons.Lootmaster.Size
		Icon_Lootmaster_Point = db.oUF.PetTarget.Icons.Lootmaster.Point
		Icon_Lootmaster_X = db.oUF.PetTarget.Icons.Lootmaster.X
		Icon_Lootmaster_Y = db.oUF.PetTarget.Icons.Lootmaster.Y
		
		Icon_Raid_Enable = db.oUF.PetTarget.Icons.Raid.Enable == true
		Icon_Raid_Size = db.oUF.PetTarget.Icons.Raid.Size
		Icon_Raid_Point = db.oUF.PetTarget.Icons.Raid.Point
		Icon_Raid_X = db.oUF.PetTarget.Icons.Raid.X
		Icon_Raid_Y = db.oUF.PetTarget.Icons.Raid.Y
		
		Icon_Role_Enable = db.oUF.PetTarget.Icons.Role.Enable
		Icon_Role_Size = db.oUF.PetTarget.Icons.Role.Size
		Icon_Role_Point = db.oUF.PetTarget.Icons.Role.Point
		Icon_Role_X = db.oUF.PetTarget.Icons.Role.X
		Icon_Role_Y = db.oUF.PetTarget.Icons.Role.Y
		
		Icon_Resting_Enable = db.oUF.PetTarget.Icons.Resting.Enable
		Icon_Resting_Size = db.oUF.PetTarget.Icons.Resting.Size
		Icon_Resting_Point = db.oUF.PetTarget.Icons.Resting.Point
		Icon_Resting_X = db.oUF.PetTarget.Icons.Resting.X
		Icon_Resting_Y = db.oUF.PetTarget.Icons.Resting.Y
		
		Icon_Combat_Enable = db.oUF.PetTarget.Icons.Combat.Enable
		Icon_Combat_Size = db.oUF.PetTarget.Icons.Combat.Size
		Icon_Combat_Point = db.oUF.PetTarget.Icons.Combat.Point
		Icon_Combat_X = db.oUF.PetTarget.Icons.Combat.X
		Icon_Combat_Y = db.oUF.PetTarget.Icons.Combat.Y
		
		Icon_PvP_Enable = db.oUF.PetTarget.Icons.PvP.Enable
		Icon_PvP_Size = db.oUF.PetTarget.Icons.PvP.Size
		Icon_PvP_Point = db.oUF.PetTarget.Icons.PvP.Point
		Icon_PvP_X = db.oUF.PetTarget.Icons.PvP.X
		Icon_PvP_Y = db.oUF.PetTarget.Icons.PvP.Y
		
		Portrait_Enable = db.oUF.PetTarget.Portrait.Enable
		Portrait_Width = db.oUF.PetTarget.Portrait.Width
		Portrait_Height = db.oUF.PetTarget.Portrait.Height
		Portrait_X = db.oUF.PetTarget.Portrait.X
		Portrait_Y = db.oUF.PetTarget.Portrait.Y

	end
	
	------------------------------------------------------------------------
	--	Width/Height
	------------------------------------------------------------------------
	
	self:SetAttribute("initial-height", FrameHeight)
	self:SetAttribute("initial-width", FrameWidth)
	
	self.Health:SetHeight(HealthHeight)
	self.Power:SetHeight(PowerHeight)
	self.Full:SetHeight(Fullbar_Height)
	
	if ShowPower == false then
		self.Power:Hide()
	end
	
	if Fullbar_Enable == false then
		self.Full:Hide()
	end
	
	------------------------------------------------------------------------
	--	Position
	------------------------------------------------------------------------
	
	self.Health:SetPoint("TOPLEFT", 0, HealthPadding)
	self.Health:SetPoint("TOPRIGHT", 0, HealthPadding)
	
	self.Power:SetPoint("TOPLEFT", self.Health, "BOTTOMLEFT", 0, PowerPadding)
	self.Power:SetPoint("TOPRIGHT", self.Health, "BOTTOMRIGHT", 0, PowerPadding)
	
	self.Full:SetPoint("TOPLEFT", self.Health, "BOTTOMLEFT", 0, Fullbar_Padding)
	self.Full:SetPoint("TOPRIGHT", self.Health, "BOTTOMRIGHT", 0, Fullbar_Padding)

	------------------------------------------------------------------------
	--	Textures
	------------------------------------------------------------------------
	
	self.Health:SetStatusBarTexture(HealthTexture)
	self.Power:SetStatusBarTexture(PowerTexture)
	
	self.Full:SetStatusBarTexture(Fullbar_Texture)
	self.Full:SetStatusBarColor(Fullbar_Color_r, Fullbar_Color_g, Fullbar_Color_b, Fullbar_Color_a)
	self.Full:SetValue(100)
	self.Full:SetAlpha(Fullbar_Alpha)
	
	self.Health.bg = self.Health:CreateTexture(nil, "BORDER")
	self.Health.bg:SetAllPoints(self.Health)
	self.Health.bg:SetTexture(HealthTextureBG)
	self.Health.bg:SetAlpha(HealthTextureBGAlpha)
	self.Health.bg.multiplier = HealthTextureBGMP
	
	self.Power.bg = self.Power:CreateTexture(nil, "BORDER")
	self.Power.bg:SetAllPoints(self.Power)
	self.Power.bg:SetTexture(PowerTextureBG)
	self.Power.bg:SetAlpha(PowerTextureBGAlpha)
	self.Power.bg.multiplier = PowerTextureBGMP
		
	------------------------------------------------------------------------
	--	Colors / Settings
	------------------------------------------------------------------------
	
	self.Health.colorClass = Health_colorClass
	self.Health.colorTapping = Health_colorTapping
	self.Health.colorDisconnected = Health_colorDisconnected
	self.Health.colorSmooth = Health_colorSmooth
	self.Health.Smooth = Health_Smooth
	self.Health.colorReaction = Health_colorReaction
	self.Health.frequentUpdates = Health_frequentUpdates
	self.Health.OverrideUpdateHealth = Health_OverrideUpdateHealth
	
	self.Power.colorTapping = false
	self.Power.colorDisconnected = Power_colorDisconnected
	self.Power.colorType = Power_colorType
	self.Power.colorClass = Power_colorClass
	self.Power.Smooth = Power_Smooth
	self.Power.colorSmooth = Power_colorSmooth
	self.Power.OverrideUpdatePower = Power_OverrideUpdatePower
	self.Power.colorReaction = Power_colorReaction
	self.Power.frequentUpdates = Power_frequentUpdates
		
	------------------------------------------------------------------------
	--	Texts
	------------------------------------------------------------------------
	
	self.Info = SetFontString(self.Health, Info_Font, Info_Size, Info_Style)
	self.Info:SetPoint(Info_Point, self, Info_RelativePoint, Info_X, Info_Y)
	
	if Info_Format == "Name" then
		if Info_ColorNameByClass == true then
			if Info_NameLength == "Long" then
				self:Tag(self.Info,"[GetNameColor][NameLong]")
			elseif Info_NameLength == "Medium" then
				self:Tag(self.Info,"[GetNameColor][NameMedium]")
			elseif Info_NameLength == "Short" then
				self:Tag(self.Info,"[GetNameColor][NameShort]")
			end
		else
			if Info_NameLength == "Long" then
				self:Tag(self.Info,"[NameLong]")
			elseif Info_NameLength == "Medium" then
				self:Tag(self.Info,"[NameMedium]")
			elseif Info_NameLength == "Short" then
				self:Tag(self.Info,"[NameShort]")
			end
		end
	elseif Info_Format == "Name + Level" then
		if Info_ColorNameByClass == true then
			if Info_NameLength == "Long" then
				if Info_ShowClassification == true then
					if Info_ColorLevelByDifficulty == true then
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[GetNameColor][NameLong]|r [DiffColor][level2]|r[shortclassification]")
						else
							self:Tag(self.Info,"[GetNameColor][NameLong]|r [DiffColor][level2]|r[classification]")
						end
					else
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[GetNameColor][NameLong]|r [level2][shortclassification]")
						else
							self:Tag(self.Info,"[GetNameColor][NameLong]|r [DiffColor][level2]|r[classification]")
						end
					end
				else
					if Info_ColorLevelByDifficulty == true then
						self:Tag(self.Info,"[GetNameColor][NameLong]|r [DiffColor][level2]|r")
					else
						self:Tag(self.Info,"[GetNameColor][NameLong]|r [level2]")
					end
				end
			elseif Info_NameLength == "Medium" then
				if Info_ShowClassification == true then
					if Info_ColorLevelByDifficulty == true then
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[GetNameColor][NameMedium]|r [DiffColor][level2]|r[shortclassification]")
						else
							self:Tag(self.Info,"[GetNameColor][NameMedium]|r [DiffColor][level2]|r[classification]")
						end
					else
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[GetNameColor][NameMedium]|r [level2][shortclassification]")
						else
							self:Tag(self.Info,"[GetNameColor][NameMedium]|r [level2][classification]")
						end
					end
				else
					if Info_ColorLevelByDifficulty == true then
						self:Tag(self.Info,"[GetNameColor][NameMedium]|r [DiffColor][level2]|r")
					else
						self:Tag(self.Info,"[GetNameColor][NameMedium]|r [level2]")
					end
				end
			elseif Info_NameLength == "Short" then
				if Info_ShowClassification == true then
					if Info_ColorLevelByDifficulty == true then
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[GetNameColor][NameShort]|r [DiffColor][level2]|r[shortclassification]")
						else
							self:Tag(self.Info,"[GetNameColor][NameShort]|r [DiffColor][level2]|r[classification]")
						end
					else
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[GetNameColor][NameShort]|r [level2][shortclassification]")
						else
							self:Tag(self.Info,"[GetNameColor][NameShort]|r [level2][classification]")
						end
					end
				else
					if Info_ColorLevelByDifficulty == true then
						self:Tag(self.Info,"[GetNameColor][NameShort]|r [DiffColor][level2]|r")
					else
						self:Tag(self.Info,"[GetNameColor][NameShort]|r [level2]")
					end
				end
			end
		else
			if Info_NameLength == "Long" then
				if Info_ShowClassification == true then
					if Info_ColorLevelByDifficulty == true then
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[NameLong] [DiffColor][level2]|r[shortclassification]")
						else
							self:Tag(self.Info,"[NameLong] [DiffColor][level2]|r[classification]")
						end
					else
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[NameLong] [level2][shortclassification]")
						else
							self:Tag(self.Info,"[NameLong] [level2][classification]")
						end
					end
				else
					if Info_ColorLevelByDifficulty == true then
						self:Tag(self.Info,"[NameLong] [DiffColor][level2]|r")
					else
						self:Tag(self.Info,"[NameLong] [level2]")
					end
				end
			elseif Info_NameLength == "Medium" then
				if Info_ShowClassification == true then
					if Info_ColorLevelByDifficulty == true then
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[NameMedium] [DiffColor][level2]|r[shortclassification]")
						else
							self:Tag(self.Info,"[NameMedium] [DiffColor][level2]|r[classification]")
						end
					else
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[NameMedium] [level2][shortclassification]")
						else
							self:Tag(self.Info,"[NameMedium] [level2][classification]")
						end
					end
				else
					if Info_ColorLevelByDifficulty == true then
						self:Tag(self.Info,"[NameMedium] [DiffColor][level2]|r")
					else
						self:Tag(self.Info,"[NameMedium] [level2]")
					end
				end
			elseif Info_NameLength == "Short" then
				if Info_ShowClassification == true then
					if Info_ColorLevelByDifficulty == true then
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[NameShort] [DiffColor][level2]|r[shortclassification]")
						else
							self:Tag(self.Info,"[NameShort] [DiffColor][level2]|r[classification]")
						end
					else
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[NameShort] [level2][shortclassification]")
						else
							self:Tag(self.Info,"[NameShort] [level2][classification]")
						end
					end	
				else
					if Info_ColorLevelByDifficulty == true then
						self:Tag(self.Info,"[NameShort] [DiffColor][level2]|r")
					else
						self:Tag(self.Info,"[NameShort] [level2]")
					end
				end
			end
		end
	elseif Info_Format == "Name + Level + Class" then
		if Info_ColorClassByClass == true then
			if Info_ColorNameByClass == true then
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameLong]|r [DiffColor][level2]|r[shortclassification] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[GetNameColor][NameLong]|r [DiffColor][level2]|r[classification] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameLong]|r [level2][shortclassification] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[GetNameColor][NameLong]|r [level2][classification] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[GetNameColor][NameLong]|r [DiffColor][level2]|r [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[GetNameColor][NameLong]|r [level2] [GetNameColor][smartclass]|r")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameMedium]|r [DiffColor][level2]|r[shortclassification] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[GetNameColor][NameMedium]|r [DiffColor][level2]|r[classification] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameMedium]|r [level2][shortclassification] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[GetNameColor][NameMedium]|r [level2][classification] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[GetNameColor][NameMedium]|r [DiffColor][level2]|r [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[GetNameColor][NameMedium]|r [level2] [GetNameColor][smartclass]|r")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameShort]|r [DiffColor][level2]|r[shortclassification] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[GetNameColor][NameShort]|r [DiffColor][level2]|r[classification] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameShort]|r [level2][shortclassification] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[GetNameColor][NameShort]|r [level2][classification] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[GetNameColor][NameShort]|r [DiffColor][level2]|r [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[GetNameColor][NameShort]|r [level2] [GetNameColor][smartclass]|r")
						end
					end
				end
			else
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameLong] [DiffColor][level2]|r[shortclassification] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[NameLong] [DiffColor][level2]|r[classification] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameLong] [level2][shortclassification] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[NameLong] [level2][classification] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[NameLong] [DiffColor][level2]|r [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[NameLong] [level2] [GetNameColor][smartclass]|r")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameMedium] [DiffColor][level2]|r[shortclassification] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[NameMedium] [DiffColor][level2]|r[classification] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameMedium] [level2][shortclassification] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[NameMedium] [level2][classification] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[NameMedium] [DiffColor][level2]|r [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[NameMedium] [level2] [GetNameColor][smartclass]|r")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameShort] [DiffColor][level2]|r[shortclassification] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[NameShort] [DiffColor][level2]|r[classification] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameShort] [level2][shortclassification] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[NameShort] [level2][classification] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[NameShort] [DiffColor][level2]|r [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[NameShort] [level2] [GetNameColor][smartclass]|r")
						end
					end
				end
			end
		else
			if Info_ColorNameByClass == true then
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameLong]|r [DiffColor][level2]|r[shortclassification] [smartclass]")
							else
								self:Tag(self.Info,"[GetNameColor][NameLong]|r [DiffColor][level2]|r[classification] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameLong]|r [level2][shortclassification] [smartclass]")
							else
								self:Tag(self.Info,"[GetNameColor][NameLong]|r [level2][classification] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[GetNameColor][NameLong]|r [DiffColor][level2]|r [smartclass]")
						else
							self:Tag(self.Info,"[GetNameColor][NameLong]|r [level2] [smartclass]")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameMedium]|r [DiffColor][level2]|r[shortclassification] [smartclass]")
							else
								self:Tag(self.Info,"[GetNameColor][NameMedium]|r [DiffColor][level2]|r[classification] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameMedium]|r [level2][shortclassification] [smartclass]")
							else
								self:Tag(self.Info,"[GetNameColor][NameMedium]|r [level2][classification] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[GetNameColor][NameMedium]|r [DiffColor][level2]|r [smartclass]")
						else
							self:Tag(self.Info,"[GetNameColor][NameMedium]|r [level2] [smartclass]")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameShort]|r [DiffColor][level2]|r[shortclassification] [smartclass]")
							else
								self:Tag(self.Info,"[GetNameColor][NameShort]|r [DiffColor][level2]|r[classification] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameShort]|r [level2][shortclassification] [smartclass]")
							else
								self:Tag(self.Info,"[GetNameColor][NameShort]|r [level2][classification] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[GetNameColor][NameShort]|r [DiffColor][level2]|r [smartclass]")
						else
							self:Tag(self.Info,"[GetNameColor][NameShort]|r [level2] [smartclass]")
						end
					end
				end
			else
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameLong] [DiffColor][level2]|r[shortclassification] [smartclass]")
							else
								self:Tag(self.Info,"[NameLong] [DiffColor][level2]|r[classification] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameLong] [level2][shortclassification] [smartclass]")
							else
								self:Tag(self.Info,"[NameLong] [level2][classification] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[NameLong] [DiffColor][level2]|r [smartclass]")
						else
							self:Tag(self.Info,"[NameLong] [level2] [smartclass]")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameMedium] [DiffColor][level2]|r[shortclassification] [smartclass]")
							else
								self:Tag(self.Info,"[NameMedium] [DiffColor][level2]|r[classification] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameMedium] [level2][shortclassification] [smartclass]")
							else
								self:Tag(self.Info,"[NameMedium] [level2][classification] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[NameMedium] [DiffColor][level2]|r [smartclass]")
						else
							self:Tag(self.Info,"[NameMedium] [level2] [smartclass]")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameShort] [DiffColor][level2]|r[shortclassification] [smartclass]")
							else
								self:Tag(self.Info,"[NameShort] [DiffColor][level2]|r[classification] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameShort] [level2][shortclassification] [smartclass]")
							else
								self:Tag(self.Info,"[NameShort] [level2][classification] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[NameShort] [DiffColor][level2]|r [smartclass]")
						else
							self:Tag(self.Info,"[NameShort] [level2] [smartclass]")
						end
					end
				end
			end
		end
	elseif Info_Format == "Name + Level + Race + Class" then
		if Info_ColorClassByClass == true then
			if Info_ColorNameByClass == true then
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameLong]|r [DiffColor][level2]|r[shortclassification] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[GetNameColor][NameLong]|r [DiffColor][level2]|r[classification] [race] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameLong]|r [level2][shortclassification] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[GetNameColor][NameLong]|r [level2][classification] [race] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[GetNameColor][NameLong]|r [DiffColor][level2]|r [race] [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[GetNameColor][NameLong]|r [level2] [race] [GetNameColor][smartclass]|r")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameMedium]|r [DiffColor][level2]|r[shortclassification] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[GetNameColor][NameMedium]|r [DiffColor][level2]|r[classification] [race] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameMedium]|r [level2][shortclassification] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[GetNameColor][NameMedium]|r [level2][classification] [race] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[GetNameColor][NameMedium]|r [DiffColor][level2]|r [race] [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[GetNameColor][NameMedium]|r [level2] [race] [GetNameColor][smartclass]|r")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameShort]|r [DiffColor][level2]|r[shortclassification] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[GetNameColor][NameShort]|r [DiffColor][level2]|r[classification] [race] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameShort]|r [level2][shortclassification] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[GetNameColor][NameShort]|r [level2][classification] [race] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[GetNameColor][NameShort]|r [DiffColor][level2]|r [race] [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[GetNameColor][NameShort]|r [level2] [race] [GetNameColor][smartclass]|r")
						end
					end
				end
			else
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameLong] [DiffColor][level2]|r[shortclassification] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[NameLong] [DiffColor][level2]|r[classification] [race] [GetNameColor][smartclass]|r")
							end
						else	
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameLong] [level2][shortclassification] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[NameLong] [level2][classification] [race] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[NameLong] [DiffColor][level2]|r [race] [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[NameLong] [level2] [race] [GetNameColor][smartclass]|r")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameMedium] [DiffColor][level2]|r[shortclassification] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[NameMedium] [DiffColor][level2]|r[classification] [race] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameMedium] [level2][shortclassification] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[NameMedium] [level2][classification] [race] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[NameMedium] [DiffColor][level2]|r [race] [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[NameMedium] [level2] [race] [GetNameColor][smartclass]|r")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameShort] [DiffColor][level2]|r[shortclassification] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[NameShort] [DiffColor][level2]|r[classification] [race] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameShort] [level2][shortclassification] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[NameShort] [level2][classification] [race] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[NameShort] [DiffColor][level2]|r [race] [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[NameShort] [level2] [race] [GetNameColor][smartclass]|r")
						end
					end
				end
			end
		else
			if Info_ColorNameByClass == true then
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameLong]|r [DiffColor][level2]|r[shortclassification] [race] [smartclass]")
							else
								self:Tag(self.Info,"[GetNameColor][NameLong]|r [DiffColor][level2]|r[classification] [race] [smartclass]")
							end
						else	
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameLong]|r [level2][shortclassification] [race] [smartclass]")
							else
								self:Tag(self.Info,"[GetNameColor][NameLong]|r [level2][classification] [race] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[GetNameColor][NameLong]|r [DiffColor][level2]|r [race] [smartclass]")
						else
							self:Tag(self.Info,"[GetNameColor][NameLong]|r [level2] [race] [smartclass]")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameMedium]|r [DiffColor][level2]|r[shortclassification] [race] [smartclass]")
							else
								self:Tag(self.Info,"[GetNameColor][NameMedium]|r [DiffColor][level2]|r[classification] [race] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameMedium]|r [level2][shortclassification] [race] [smartclass]")
							else
								self:Tag(self.Info,"[GetNameColor][NameMedium]|r [level2][classification] [race] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[GetNameColor][NameMedium]|r [DiffColor][level2]|r [race] [smartclass]")
						else
							self:Tag(self.Info,"[GetNameColor][NameMedium]|r [level2] [race] [smartclass]")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameShort]|r [DiffColor][level2]|r[shortclassification] [race] [smartclass]")
							else
								self:Tag(self.Info,"[GetNameColor][NameShort]|r [DiffColor][level2]|r[classification] [race] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[GetNameColor][NameShort]|r [level2][shortclassification] [race] [smartclass]")
							else
								self:Tag(self.Info,"[GetNameColor][NameShort]|r [level2][classification] [race] [smartclass]")
							end	
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[GetNameColor][NameShort]|r [DiffColor][level2]|r [race] [smartclass]")
						else
							self:Tag(self.Info,"[GetNameColor][NameShort]|r [level2] [race] [smartclass]")
						end
					end
				end
			else
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameLong] [DiffColor][level2]|r[shortclassification] [race] [smartclass]")
							else
								self:Tag(self.Info,"[NameLong] [DiffColor][level2]|r[classification] [race] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameLong] [level2][shortclassification] [race] [smartclass]")
							else
								self:Tag(self.Info,"[NameLong] [level2][classification] [race] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[NameLong] [DiffColor][level2]|r [race] [smartclass]")
						else
							self:Tag(self.Info,"[NameLong] [level2] [race] [smartclass]")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameMedium] [DiffColor][level2]|r[shortclassification] [race] [smartclass]")
							else
								self:Tag(self.Info,"[NameMedium] [DiffColor][level2]|r[classification] [race] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameMedium] [level2][shortclassification] [race] [smartclass]")
							else
								self:Tag(self.Info,"[NameMedium] [level2][classification] [race] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[NameMedium] [DiffColor][level2]|r [race] [smartclass]")
						else
							self:Tag(self.Info,"[NameMedium] [level2] [race] [smartclass]")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameShort] [DiffColor][level2]|r[shortclassification] [race] [smartclass]")
							else
								self:Tag(self.Info,"[NameShort] [DiffColor][level2]|r[classification] [race] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[NameShort] [level2][shortclassification] [race] [smartclass]")
							else
								self:Tag(self.Info,"[NameShort] [level2][classification] [race] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[NameShort] [DiffColor][level2]|r [race] [smartclass]")
						else
							self:Tag(self.Info,"[NameShort] [level2] [race] [smartclass]")
						end
					end
				end
			end
		end
	elseif Info_Format == "Level + Name" then
		if Info_ColorNameByClass == true then
			if Info_NameLength == "Long" then
				if Info_ShowClassification == true then
					if Info_ColorLevelByDifficulty == true then
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][NameLong]|r")
						else	
							self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][NameLong]|r")
						end
					else
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][NameLong]|r")
						else
							self:Tag(self.Info,"[level2][classification] [GetNameColor][NameLong]|r")
						end
					end
				else
					if Info_ColorLevelByDifficulty == true then
						self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][NameLong]|r")
					else
						self:Tag(self.Info,"[level2] [GetNameColor][NameLong]|r")
					end
				end
			elseif Info_NameLength == "Medium" then
				if Info_ShowClassification == true then
					if Info_ColorLevelByDifficulty == true then
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][NameMedium]|r")
						else	
							self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][NameMedium]|r")
						end
					else
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][NameMedium]|r")
						else
							self:Tag(self.Info,"[level2][classification] [GetNameColor][NameMedium]|r")
						end
					end
				else
					if Info_ColorLevelByDifficulty == true then
						self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][NameMedium]|r")
					else
						self:Tag(self.Info,"[level2] [GetNameColor][NameMedium]|r")
					end
				end
			elseif Info_NameLength == "Short" then
				if Info_ShowClassification == true then
					if Info_ColorLevelByDifficulty == true then
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][NameShort]|r")
						else
							self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][NameShort]|r")
						end
					else
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][NameShort]|r")
						else
							self:Tag(self.Info,"[level2][classification] [GetNameColor][NameShort]|r")
						end
					end
				else
					if Info_ColorLevelByDifficulty == true then
						self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][NameShort]|r")
					else
						self:Tag(self.Info,"[level2] [GetNameColor][NameShort]|r")
					end
				end
			end
		else
			if Info_NameLength == "Long" then
				if Info_ShowClassification == true then
					if Info_ColorLevelByDifficulty == true then
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [NameLong]")
						else
							self:Tag(self.Info,"[DiffColor][level2]|r[classification] [NameLong]")
						end
					else
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[level2][shortclassification] [NameLong]")
						else
							self:Tag(self.Info,"[level2][classification] [NameLong]")
						end
					end
				else
					if Info_ColorLevelByDifficulty == true then
						self:Tag(self.Info,"[DiffColor][level2]|r [NameLong]")
					else
						self:Tag(self.Info,"[level2] [NameLong]")
					end
				end
			elseif Info_NameLength == "Medium" then
				if Info_ShowClassification == true then
					if Info_ColorLevelByDifficulty == true then
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [NameMedium]")
						else
							self:Tag(self.Info,"[DiffColor][level2]|r[classification] [NameMedium]")
						end
					else
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[level2][shortclassification] [NameMedium]")
						else
							self:Tag(self.Info,"[level2][classification] [NameMedium]")
						end
					end
				else
					if Info_ColorLevelByDifficulty == true then
						self:Tag(self.Info,"[DiffColor][level2]|r [NameMedium]")
					else
						self:Tag(self.Info,"[level2] [NameMedium]")
					end
				end
			elseif Info_NameLength == "Short" then
				if Info_ShowClassification == true then
					if Info_ColorLevelByDifficulty == true then
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [NameShort]")
						else
							self:Tag(self.Info,"[DiffColor][level2]|r[classification] [NameShort]")
						end
					else
						if Info_ShortClassification == true then
							self:Tag(self.Info,"[level2][shortclassification] [NameShort]")
						else
							self:Tag(self.Info,"[level2][classification] [NameShort]")
						end
					end
				else
					if Info_ColorLevelByDifficulty == true then
						self:Tag(self.Info,"[DiffColor][level2]|r [NameShort]")
					else 
						self:Tag(self.Info,"[level2] [NameShort]")
					end
				end
			end
		end
	elseif Info_Format == "Level + Name + Class" then
		if Info_ColorClassByClass == true then
			if Info_ColorNameByClass == true then
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][NameLong]|r [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][NameLong]|r [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][NameLong]|r [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][NameLong]|r [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][NameLong]|r [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][NameLong]|r [GetNameColor][smartclass]|r")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][NameMedium]|r [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][NameMedium]|r [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][NameMedium]|r [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][NameMedium]|r [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][NameMedium]|r [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][NameMedium]|r [GetNameColor][smartclass]|r")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][NameShort]|r [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][NameShort]|r [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][NameShort]|r [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][NameShort]|r [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][NameShort]|r [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][NameShort]|r [GetNameColor][smartclass]|r")
						end
					end
				end
			else
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [NameLong] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [NameLong] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [NameLong] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[level2][classification] [NameLong] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [NameLong] [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[level2] [NameLong] [GetNameColor][smartclass]|r")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [NameMedium] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [NameMedium] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [NameMedium] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[level2][classification] [NameMedium] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [NameMedium] [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[level2] [NameMedium] [GetNameColor][smartclass]|r")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [NameShort] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [NameShort] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [NameShort] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[level2][classification] [NameShort] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [NameShort] [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[level2] [NameShort] [GetNameColor][smartclass]|r")
						end
					end
				end
			end
		else
			if Info_ColorNameByClass == true then
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][NameLong]|r [smartclass]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][NameLong]|r [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][NameLong]|r [smartclass]")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][NameLong]|r [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][NameLong]|r [smartclass]")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][NameLong]|r [smartclass]")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][NameMedium]|r [smartclass]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][NameMedium]|r [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][NameMedium]|r [smartclass]")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][NameMedium]|r [smartclass]")
							end	
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][NameMedium]|r [smartclass]")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][NameMedium]|r [smartclass]")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][NameShort]|r [smartclass]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][NameShort]|r [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][NameShort]|r [smartclass]")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][NameShort]|r [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][NameShort]|r [smartclass]")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][NameShort]|r [smartclass]")
						end
					end
				end
			else
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [NameLong] [smartclass]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [NameLong] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [NameLong] [smartclass]")
							else
								self:Tag(self.Info,"[level2][classification] [NameLong] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [NameLong] [smartclass]")
						else
							self:Tag(self.Info,"[level2] [NameLong] [smartclass]")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [NameMedium] [smartclass]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [NameMedium] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [NameMedium] [smartclass]")
							else
								self:Tag(self.Info,"[level2][classification] [NameMedium] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [NameMedium] [smartclass]")
						else
							self:Tag(self.Info,"[level2] [NameMedium] [smartclass]")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [NameShort] [smartclass]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [NameShort] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [NameShort] [smartclass]")
							else
								self:Tag(self.Info,"[level2][classification] [NameShort] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [NameShort] [smartclass]")
						else
							self:Tag(self.Info,"[level2] [NameShort] [smartclass]")
						end
					end
				end
			end
		end
	elseif Info_Format == "Level + Class + Name" then
		if Info_ColorClassByClass == true then
			if Info_ColorNameByClass == true then
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][smartclass]|r [GetNameColor][NameLong]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][smartclass]|r [GetNameColor][NameLong]|r")
							end	
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][smartclass]|r [GetNameColor][NameLong]|r")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][smartclass]|r [GetNameColor][NameLong]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][smartclass]|r [GetNameColor][NameLong]|r")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][smartclass]|r [GetNameColor][NameLong]|r")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][smartclass]|r [GetNameColor][NameMedium]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][smartclass]|r [GetNameColor][NameMedium]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][smartclass]|r [GetNameColor][NameMedium]|r")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][smartclass]|r [GetNameColor][NameMedium]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][smartclass]|r [GetNameColor][NameMedium]|r")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][smartclass]|r [GetNameColor][NameMedium]|r")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][smartclass]|r [GetNameColor][NameShort]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][smartclass]|r [GetNameColor][NameShort]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][smartclass]|r [GetNameColor][NameShort]|r")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][smartclass]|r [GetNameColor][NameShort]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][smartclass]|r [GetNameColor][NameShort]|r")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][smartclass]|r [GetNameColor][NameShort]|r")
						end
					end
				end
			else
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][smartclass]|r [NameLong]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][smartclass]|r [NameLong]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][smartclass]|r [NameLong]")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][smartclass]|r [NameLong]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][smartclass]|r [NameLong]")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][smartclass]|r [NameLong]")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][smartclass]|r [NameMedium]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][smartclass]|r [NameMedium]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][smartclass]|r [NameMedium]")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][smartclass]|r [NameMedium]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][smartclass]|r [NameMedium]")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][smartclass]|r [NameMedium]")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][smartclass]|r [NameShort]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][smartclass]|r [NameShort]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][smartclass]|r [NameShort]")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][smartclass]|r [NameShort]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][smartclass]|r [NameShort]")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][smartclass]|r [NameShort]")
						end	
					end
				end
			end
		else
			if Info_ColorNameByClass == true then
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [smartclass] [GetNameColor][NameLong]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [smartclass] [GetNameColor][NameLong]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [smartclass] [GetNameColor][NameLong]|r")
							else
								self:Tag(self.Info,"[level2][classification] [smartclass] [GetNameColor][NameLong]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [smartclass] [GetNameColor][NameLong]|r")
						else
							self:Tag(self.Info,"[level2] [smartclass] [GetNameColor][NameLong]|r")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [smartclass] [GetNameColor][NameMedium]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [smartclass] [GetNameColor][NameMedium]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [smartclass] [GetNameColor][NameMedium]|r")
							else
								self:Tag(self.Info,"[level2][classification] [smartclass] [GetNameColor][NameMedium]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [smartclass] [GetNameColor][NameMedium]|r")
						else
							self:Tag(self.Info,"[level2] [smartclass] [GetNameColor][NameMedium]|r")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [smartclass] [GetNameColor][NameShort]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [smartclass] [GetNameColor][NameShort]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [smartclass] [GetNameColor][NameShort]|r")
							else
								self:Tag(self.Info,"[level2][classification] [smartclass] [GetNameColor][NameShort]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [smartclass] [GetNameColor][NameShort]|r")
						else
							self:Tag(self.Info,"[level2] [smartclass] [GetNameColor][NameShort]|r")
						end
					end
				end
			else
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [smartclass] [NameLong]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [smartclass] [NameLong]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [smartclass] [NameLong]")
							else
								self:Tag(self.Info,"[level2][classification] [smartclass] [NameLong]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [smartclass] [NameLong]")
						else
							self:Tag(self.Info,"[level2] [smartclass] [NameLong]")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [smartclass] [NameMedium]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [smartclass] [NameMedium]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [smartclass] [NameMedium]")
							else
								self:Tag(self.Info,"[level2][classification] [smartclass] [NameMedium]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [smartclass] [NameMedium]")
						else
							self:Tag(self.Info,"[level2] [smartclass] [NameMedium]")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [smartclass] [NameShort]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [smartclass] [NameShort]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [smartclass] [NameShort]")
							else
								self:Tag(self.Info,"[level2][classification] [smartclass] [NameShort]")
							end	
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [smartclass] [NameShort]")
						else
							self:Tag(self.Info,"[level2] [smartclass] [NameShort]")
						end
					end
				end
			end
		end
	elseif Info_Format == "Level + Name + Race + Class" then
		if Info_ColorClassByClass == true then
			if Info_ColorNameByClass == true then
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][NameLong]|r [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][NameLong]|r [race] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][NameLong]|r [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][NameLong]|r [race] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][NameLong]|r [race] [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][NameLong]|r [race] [GetNameColor][smartclass]|r")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][NameMedium]|r [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][NameMedium]|r [race] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][NameMedium]|r [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][NameMedium]|r [race] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][NameMedium]|r [race] [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][NameMedium]|r [race] [GetNameColor][smartclass]|r")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][NameShort]|r [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][NameShort]|r [race] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][NameShort]|r [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][NameShort]|r [race] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][NameShort]|r [race] [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][NameShort]|r [race] [GetNameColor][smartclass]|r")
						end
					end
				end
			else
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [NameLong] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [NameLong] [race] [GetNameColor][smartclass]|r")
							end
						else	
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [NameLong] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[level2][classification] [NameLong] [race] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [NameLong] [race] [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[level2] [NameLong] [race] [GetNameColor][smartclass]|r")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [NameMedium] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [NameMedium] [race] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [NameMedium] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[level2][classification] [NameMedium] [race] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [NameMedium] [race] [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[level2] [NameMedium] [race] [GetNameColor][smartclass]|r")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [NameShort] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [NameShort] [race] [GetNameColor][smartclass]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [NameShort] [race] [GetNameColor][smartclass]|r")
							else
								self:Tag(self.Info,"[level2][classification] [NameShort] [race] [GetNameColor][smartclass]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [NameShort] [race] [GetNameColor][smartclass]|r")
						else
							self:Tag(self.Info,"[level2] [NameShort] [race] [GetNameColor][smartclass]|r")
						end
					end
				end
			end
		else
			if Info_ColorNameByClass == true then
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][NameLong]|r [race] [smartclass]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][NameLong]|r [race] [smartclass]")
							end
						else	
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][NameLong]|r [race] [smartclass]")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][NameLong]|r [race] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][NameLong]|r [race] [smartclass]")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][NameLong]|r [race] [smartclass]")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][NameMedium]|r [race] [smartclass]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][NameMedium]|r [race] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][NameMedium]|r [race] [smartclass]")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][NameMedium]|r [race] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][NameMedium]|r [race] [smartclass]")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][NameMedium]|r [race] [smartclass]")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [GetNameColor][NameShort]|r [race] [smartclass]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][NameShort]|r [race] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [GetNameColor][NameShort]|r [race] [smartclass]")
							else
								self:Tag(self.Info,"[level2][classification] [GetNameColor][NameShort]|r [race] [smartclass]")
							end	
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [GetNameColor][NameShort]|r [race] [smartclass]")
						else
							self:Tag(self.Info,"[level2] [GetNameColor][NameShort]|r [race] [smartclass]")
						end
					end
				end
			else
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [NameLong] [race] [smartclass]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [NameLong] [race] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [NameLong] [race] [smartclass]")
							else
								self:Tag(self.Info,"[level2][classification] [NameLong] [race] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [NameLong] [race] [smartclass]")
						else
							self:Tag(self.Info,"[level2] [NameLong] [race] [smartclass]")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [NameMedium] [race] [smartclass]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [NameMedium] [race] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [NameMedium] [race] [smartclass]")
							else
								self:Tag(self.Info,"[level2][classification] [NameMedium] [race] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [NameMedium] [race] [smartclass]")
						else
							self:Tag(self.Info,"[level2] [NameMedium] [race] [smartclass]")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [NameShort] [race] [smartclass]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [NameShort] [race] [smartclass]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [NameShort] [race] [smartclass]")
							else
								self:Tag(self.Info,"[level2][classification] [NameShort] [race] [smartclass]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [NameShort] [race] [smartclass]")
						else
							self:Tag(self.Info,"[level2] [NameShort] [race] [smartclass]")
						end
					end
				end
			end
		end
	elseif Info_Format == "Level + Race + Class + Name" then
		if Info_ColorClassByClass == true then
			if Info_ColorNameByClass == true then
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [race] [GetNameColor][smartclass]|r [GetNameColor][NameLong]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [race] [GetNameColor][smartclass]|r [GetNameColor][NameLong]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [race] [GetNameColor][smartclass]|r [GetNameColor][NameLong]|r")
							else
								self:Tag(self.Info,"[level2][classification] [race] [GetNameColor][smartclass]|r [GetNameColor][NameLong]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [race] [GetNameColor][smartclass]|r [GetNameColor][NameLong]|r")
						else
							self:Tag(self.Info,"[level2] [race] [GetNameColor][smartclass]|r [GetNameColor][NameLong]|r")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [race] [GetNameColor][smartclass]|r [GetNameColor][NameMedium]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [race] [GetNameColor][smartclass]|r [GetNameColor][NameMedium]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [race] [GetNameColor][smartclass]|r [GetNameColor][NameMedium]|r")
							else
								self:Tag(self.Info,"[level2][classification] [race] [GetNameColor][smartclass]|r [GetNameColor][NameMedium]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [race] [GetNameColor][smartclass]|r [GetNameColor][NameMedium]|r")
						else
							self:Tag(self.Info,"[level2] [race] [GetNameColor][smartclass]|r [GetNameColor][NameMedium]|r")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [race] [GetNameColor][smartclass]|r [GetNameColor][NameShort]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [race] [GetNameColor][smartclass]|r [GetNameColor][NameShort]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [race] [GetNameColor][smartclass]|r [GetNameColor][NameShort]|r")
							else
								self:Tag(self.Info,"[level2][classification] [race] [GetNameColor][smartclass]|r [GetNameColor][NameShort]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [race] [GetNameColor][smartclass]|r [GetNameColor][NameShort]|r")
						else
							self:Tag(self.Info,"[level2] [race] [GetNameColor][smartclass]|r [GetNameColor][NameShort]|r")
						end
					end
				end
			else
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [race] [GetNameColor][smartclass]|r [NameLong]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [race] [GetNameColor][smartclass]|r [NameLong]")
							end
						else	
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [race] [GetNameColor][smartclass]|r [NameLong]")
							else
								self:Tag(self.Info,"[level2][classification] [race] [GetNameColor][smartclass]|r [NameLong]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [race] [GetNameColor][smartclass]|r [NameLong]")
						else
							self:Tag(self.Info,"[level2] [race] [GetNameColor][smartclass]|r [NameLong]")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [race] [GetNameColor][smartclass]|r [NameMedium]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [race] [GetNameColor][smartclass]|r [NameMedium]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [race] [GetNameColor][smartclass]|r [NameMedium]")
							else
								self:Tag(self.Info,"[level2][classification] [race] [GetNameColor][smartclass]|r [NameMedium]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [race] [GetNameColor][smartclass]|r [NameMedium]")
						else
							self:Tag(self.Info,"[level2] [race] [GetNameColor][smartclass]|r [NameMedium]")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [race] [GetNameColor][smartclass]|r [NameShort]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [race] [GetNameColor][smartclass]|r [NameShort]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [race] [GetNameColor][smartclass]|r [NameShort]")
							else
								self:Tag(self.Info,"[level2][classification] [race] [GetNameColor][smartclass]|r [NameShort]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [race] [GetNameColor][smartclass]|r [NameShort]")
						else
							self:Tag(self.Info,"[level2] [race] [GetNameColor][smartclass]|r [NameShort]")
						end
					end
				end
			end
		else
			if Info_ColorNameByClass == true then
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [race] [smartclass] [GetNameColor][NameLong]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [race] [smartclass] [GetNameColor][NameLong]|r")
							end
						else	
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [race] [smartclass] [GetNameColor][NameLong]|r")
							else
								self:Tag(self.Info,"[level2][classification] [race] [smartclass] [GetNameColor][NameLong]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [race] [smartclass] [GetNameColor][NameLong]|r")
						else
							self:Tag(self.Info,"[level2] [race] [smartclass] [GetNameColor][NameLong]|r")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [race] [smartclass] [GetNameColor][NameMedium]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [race] [smartclass] [GetNameColor][NameMedium]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [race] [smartclass] [GetNameColor][NameMedium]|r")
							else
								self:Tag(self.Info,"[level2][classification] [race] [smartclass] [GetNameColor][NameMedium]|r")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [race] [smartclass] [GetNameColor][NameMedium]|r")
						else
							self:Tag(self.Info,"[level2] [race] [smartclass] [GetNameColor][NameMedium]|r")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [race] [smartclass] [GetNameColor][NameShort]|r")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [race] [smartclass] [GetNameColor][NameShort]|r")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [race] [smartclass] [GetNameColor][NameShort]|r")
							else
								self:Tag(self.Info,"[level2][classification] [race] [smartclass] [GetNameColor][NameShort]|r")
							end	
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [race] [smartclass] [GetNameColor][NameShort]|r")
						else
							self:Tag(self.Info,"[level2] [race] [smartclass] [GetNameColor][NameShort]|r")
						end
					end
				end
			else
				if Info_NameLength == "Long" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [race] [smartclass] [NameLong]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [race] [smartclass] [NameLong]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [race] [smartclass] [NameLong]")
							else
								self:Tag(self.Info,"[level2][classification] [race] [smartclass] [NameLong]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [race] [smartclass] [NameLong]")
						else
							self:Tag(self.Info,"[level2] [race] [smartclass] [NameLong]")
						end
					end
				elseif Info_NameLength == "Medium" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [race] [smartclass] [NameMedium]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [race] [smartclass] [NameMedium]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [race] [smartclass] [NameMedium]")
							else
								self:Tag(self.Info,"[level2][classification] [race] [smartclass] [NameMedium]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [race] [smartclass] [NameMedium]")
						else
							self:Tag(self.Info,"[level2] [race] [smartclass] [NameMedium]")
						end
					end
				elseif Info_NameLength == "Short" then
					if Info_ShowClassification == true then
						if Info_ColorLevelByDifficulty == true then
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[DiffColor][level2]|r[shortclassification] [race] [smartclass] [NameShort]")
							else
								self:Tag(self.Info,"[DiffColor][level2]|r[classification] [race] [smartclass] [NameShort]")
							end
						else
							if Info_ShortClassification == true then
								self:Tag(self.Info,"[level2][shortclassification] [race] [smartclass] [NameShort]")
							else
								self:Tag(self.Info,"[level2][classification] [race] [smartclass] [NameShort]")
							end
						end
					else
						if Info_ColorLevelByDifficulty == true then
							self:Tag(self.Info,"[DiffColor][level2]|r [race] [smartclass] [NameShort]")
						else
							self:Tag(self.Info,"[level2] [race] [smartclass] [NameShort]")
						end
					end
				end
			end
		end
	else
		self:Tag(self.Info,"[DiffColor][level2]|r[classification] [GetNameColor][NameMedium]|r")
	end
	
	self.Health.value = SetFontString(self.Health, Health_Value_Font, Health_Value_Size, Health_Value_Style)
	self.Health.value:SetPoint(Health_Value_Point, self, Health_Value_RelativePoint, Health_Value_X, Health_Value_Y)
	
	self.Health.valuePercent = SetFontString(self.Health, Health_Percent_Font, Health_Percent_Size, Health_Percent_Style)
	self.Health.valuePercent:SetPoint(Health_Percent_Point, self, Health_Percent_RelativePoint, Health_Percent_X, Health_Percent_Y)
	
	self.Health.valueMissing = SetFontString(self.Health, Health_Missing_Font, Health_Missing_Size, Health_Missing_Style)
	self.Health.valueMissing:SetPoint(Health_Missing_Point, self, Health_Missing_RelativePoint, Health_Missing_X, Health_Missing_Y)
	
	self.Power.value = SetFontString(self.Power, Power_Value_Font, Power_Value_Size, Power_Value_Style)
	self.Power.value:SetPoint(Power_Value_Point, self, Power_Value_RelativePoint, Power_Value_X, Power_Value_Y)
	
	self.Power.valuePercent = SetFontString(self.Power, Power_Percent_Font, Power_Percent_Size, Power_Percent_Style)
	self.Power.valuePercent:SetPoint(Power_Percent_Point, self, Power_Percent_RelativePoint, Power_Percent_X, Power_Percent_Y)
	
	self.Power.valueMissing = SetFontString(self.Power, Power_Missing_Font, Power_Missing_Size, Power_Missing_Style)
	self.Power.valueMissing:SetPoint(Power_Missing_Point, self, Power_Missing_RelativePoint, Power_Missing_X, Power_Missing_Y)
	
	if ShowInfo == false then
		self.Info:Hide()
	end
	
	if ShowHealthValue == false then
		self.Health.value:Hide()
	end
	
	if ShowHealthPercent == false then
		self.Health.valuePercent:Hide()
	end
	
	if ShowHealthMissing == false then
		self.Health.valueMissing:Hide()
	end
	
	if ShowPowerValue == false then
		self.Power.value:Hide()
	end
	
	if ShowPowerPercent == false then
		self.Power.valuePercent:Hide()
	end
	
	if ShowPowerMissing == false then
		self.Power.valueMissing:Hide()
	end
		
	------------------------------------------------------------------------
	--	Icons
	------------------------------------------------------------------------
	
	if Icon_Leader_Enable == true then
		self.Leader = self.Health:CreateTexture(nil, "OVERLAY")
		self.Leader:SetHeight(Icon_Leader_Size)
		self.Leader:SetWidth(Icon_Leader_Size)
		self.Leader:SetPoint(Icon_Leader_Point, self, Icon_Leader_Point, Icon_Leader_X, Icon_Leader_Y)
	end
	
	if Icon_Lootmaster_Enable == true then
		self.MasterLooter = self.Health:CreateTexture(nil, "OVERLAY")
		self.MasterLooter:SetHeight(Icon_Lootmaster_Size)
		self.MasterLooter:SetWidth(Icon_Lootmaster_Size)
		self.MasterLooter:SetPoint(Icon_Lootmaster_Point, self, Icon_Lootmaster_Point, Icon_Lootmaster_X, Icon_Lootmaster_Y)
	end
	
	if Icon_Raid_Enable == true then
		self.RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidIcon:SetHeight(Icon_Raid_Size)
		self.RaidIcon:SetWidth(Icon_Raid_Size)
		self.RaidIcon:SetPoint(Icon_Raid_Point, self, Icon_Raid_Point, Icon_Raid_X, Icon_Raid_Y)
	end
	
	if Icon_Role_Enable == true then
		self.LFDRole = self.Health:CreateTexture(nil, "OVERLAY")
		self.LFDRole:SetHeight(Icon_Role_Size)
		self.LFDRole:SetWidth(Icon_Role_Size)
		self.LFDRole:SetPoint(Icon_Role_Point, self, Icon_Role_Point, Icon_Role_X, Icon_Role_Y)
	end
	
	if Icon_Resting_Enable == true then
		self.Resting = self.Health:CreateTexture(nil, "OVERLAY")
		self.Resting:SetHeight(Icon_Resting_Size)
		self.Resting:SetWidth(Icon_Resting_Size)
		self.Resting:SetPoint(Icon_Resting_Point, self, Icon_Resting_Point, Icon_Resting_X, Icon_Resting_Y)
	end
	
	if Icon_Combat_Enable == true then
		self.Combat = self.Health:CreateTexture(nil, "OVERLAY")
		self.Combat:SetHeight(Icon_Combat_Size)
		self.Combat:SetWidth(Icon_Combat_Size)
		self.Combat:SetPoint(Icon_Combat_Point, self, Icon_Combat_Point, Icon_Combat_X, Icon_Combat_Y)
	end
	
	if Icon_PvP_Enable == true then
		self.PvP = self.Health:CreateTexture(nil, "OVERLAY")
		self.PvP:SetHeight(Icon_PvP_Size)
		self.PvP:SetWidth(Icon_PvP_Size)
		self.PvP:SetPoint(Icon_PvP_Point, self, Icon_PvP_Point, Icon_PvP_X, Icon_PvP_Y)
	end
		
	------------------------------------------------------------------------
	--	Portrait
	------------------------------------------------------------------------
	
	if Portrait_Enable == true then
		self.Portrait = CreateFrame("PlayerModel", nil, self)
		self.Portrait:SetFrameLevel(8)
		self.Portrait:SetHeight(Portrait_Height)
		self.Portrait:SetWidth(Portrait_Width)
		self.Portrait:SetAlpha(1)
		self.Portrait:SetPoint("TOPLEFT", self.Health, "TOPLEFT", Portrait_X, Portrait_Y)
	end


	-- Highlight
	if(highlight)then
	  local hl = self.Health:CreateTexture(nil, "OVERLAY")
	  hl:SetAllPoints(self)
	  hl:SetTexture(highlightTex)
	  hl:SetVertexColor(1,1,1,.1)
	  hl:SetBlendMode("ADD")
	  hl:Hide()

	  self.Highlight = hl
	end

	if unit == "player" then
	
		self.FlashInfo = CreateFrame("Frame", "FlashInfo", self)
		self.FlashInfo:SetScript("OnUpdate", UpdateManaLevel)
		self.FlashInfo.parent = self
		self.FlashInfo:SetToplevel(true)
		self.FlashInfo:SetAllPoints(self.Health)

		self.FlashInfo.ManaLevel = SetFontString(self.FlashInfo, font, 12)
		self.FlashInfo.ManaLevel:SetPoint("CENTER", 0, -32.5)
		
		------------------------------------------------------------------------
		--	Experience
		------------------------------------------------------------------------	

		if IsAddOnLoaded("oUF_Experience") then
			self.Experience = CreateFrame("StatusBar", self:GetName().."_Experience", self)
			self.Experience:SetStatusBarTexture(normTex)
			self.Experience:SetStatusBarColor(0.55, 0.57, 0.61)
			self.Experience:SetBackdrop(backdrop)
			self.Experience:SetBackdropColor(0, 0, 0)
			self.Experience:SetHeight(17)
			self.Experience:SetPoint("TOPLEFT", self.Power, "BOTTOMLEFT", 2, -3)
			self.Experience:SetPoint("TOPRIGHT", self.Power, "BOTTOMRIGHT", -2, -3)
			self.Experience:SetAlpha(0)

			self.Experience:HookScript("OnEnter", function(self) self:SetAlpha(1) end)
			self.Experience:HookScript("OnLeave", function(self) self:SetAlpha(0) end)

			self.Experience.bg = self.Experience:CreateTexture(nil, "BORDER")
			self.Experience.bg:SetAllPoints(self.Experience)
			self.Experience.bg:SetTexture(normTex)
			self.Experience.bg:SetVertexColor(0.15, 0.15, 0.15)

			self.Experience.Tooltip = true
		end
		
		------------------------------------------------------------------------
		--	Reputation
		------------------------------------------------------------------------	

		if IsAddOnLoaded("oUF_Reputation") and UnitLevel("player") == MAX_PLAYER_LEVEL then
			self.Reputation = CreateFrame("StatusBar", self:GetName().."_Reputation", self.Power)
			self.Reputation:SetHeight(17)
			self.Reputation:SetPoint("TOPLEFT", self.Power, "BOTTOMLEFT", 2, -3)
			self.Reputation:SetPoint("TOPRIGHT", self.Health, "BOTTOMRIGHT", -2, -3)
			self.Reputation:SetStatusBarTexture(normTex)
			self.Reputation:SetBackdrop(backdrop)
			self.Reputation:SetBackdropColor(0, 0, 0)
			self.Reputation:SetAlpha(0)

			self.Reputation:HookScript("OnEnter", function(self) self:SetAlpha(1) end)
			self.Reputation:HookScript("OnLeave", function(self) self:SetAlpha(0) end)

			self.Reputation.bg = self.Reputation:CreateTexture(nil, "BORDER")
			self.Reputation.bg:SetAllPoints(self.Reputation)
			self.Reputation.bg:SetTexture(normTex)
			self.Reputation.bg:SetVertexColor(0.15, 0.15, 0.15)

			self.Reputation.PostUpdate = UpdateReputationColor
			self.Reputation.Tooltip = true
		end
		
		------------------------------------------------------------------------
		--   Totems
		------------------------------------------------------------------------   
	
		if class == "SHAMAN" and db.oUF.Player.Totems.Enable == true then
			self.TotemBar = {}
			self.TotemBar.Destroy = true

			for i = 1, 4 do
				self.TotemBar[i] = CreateFrame("StatusBar", self:GetName().."_TotemBar"..i, self)
				if (i == 1) then
				   self.TotemBar[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", db.oUF.Player.Totems.X, db.oUF.Player.Totems.Y)
				else
				   self.TotemBar[i]:SetPoint("TOPLEFT", self.TotemBar[i-1], "TOPRIGHT", 1, 0)
				end
				self.TotemBar[i]:SetStatusBarTexture(LSM:Fetch("statusbar", db.oUF.Player.Totems.Texture))
				self.TotemBar[i]:SetHeight(db.oUF.Player.Totems.Height)
				self.TotemBar[i]:SetWidth((tonumber(db.oUF.Player.Totems.Width) -3) / 4)
				self.TotemBar[i]:SetBackdrop(backdrop)
				self.TotemBar[i]:SetBackdropColor(0, 0, 0)
				self.TotemBar[i]:SetMinMaxValues(0, 1)

				self.TotemBar[i].bg = self.TotemBar[i]:CreateTexture(nil, "BORDER")
				self.TotemBar[i].bg:SetAllPoints(self.TotemBar[i])
				self.TotemBar[i].bg:SetTexture(normTex)
				self.TotemBar[i].bg.multiplier = tonumber(db.oUF.Player.Totems.Multiplier)
								
				self.TotemBar[i].FrameBackdrop = CreateFrame("Frame", nil, self.TotemBar[i])
				self.TotemBar[i].FrameBackdrop:SetPoint("TOPLEFT", self.TotemBar[i], "TOPLEFT", -3, 3)
				self.TotemBar[i].FrameBackdrop:SetPoint("BOTTOMRIGHT", self.TotemBar[i], "BOTTOMRIGHT", 3, -3)
				self.TotemBar[i].FrameBackdrop:SetFrameStrata("BACKGROUND")
				self.TotemBar[i].FrameBackdrop:SetBackdrop {
					edgeFile = glowTex, edgeSize = 4,
					insets = {left = 3, right = 3, top = 3, bottom = 3}
				}
				self.TotemBar[i].FrameBackdrop:SetBackdropColor(0, 0, 0, 0)
				self.TotemBar[i].FrameBackdrop:SetBackdropBorderColor(0, 0, 0)
			end
		end

		------------------------------------------------------------------------
		--	Runes 
		------------------------------------------------------------------------	
	
		if class == "DEATHKNIGHT" then
			if db.oUF.Player.Runes.Enable == true then
				self.Runes = CreateFrame('Frame', nil, self)
				self.Runes:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', db.oUF.Player.Runes.X, db.oUF.Player.Runes.Y)
				self.Runes:SetHeight(db.oUF.Player.Runes.Height)
				self.Runes:SetWidth(db.oUF.Player.Runes.Width)
				self.Runes:SetBackdrop(backdrop)
				self.Runes:SetBackdropColor(0.08, 0.08, 0.08)
				self.Runes.anchor = "TOPLEFT"
				self.Runes.growth = "RIGHT"
				self.Runes.height = tonumber(db.oUF.Player.Runes.Height)
				self.Runes.spacing = tonumber(db.oUF.Player.Runes.Padding)
				self.Runes.width = (tonumber(db.oUF.Player.Runes.Width) / 6) - ((self.Runes.spacing / 6) * 5.1)
	
				for i = 1, 6 do
					self.Runes[i] = CreateFrame('StatusBar', nil, self.Runes)
					self.Runes[i]:SetStatusBarTexture(LSM:Fetch("statusbar", db.oUF.Player.Runes.Texture))
					self.Runes[i]:SetStatusBarColor(unpack(runeloadcolors[i]))	
				end
	
				self.Runes.FrameBackdrop = CreateFrame("Frame", nil, self.Runes)
				self.Runes.FrameBackdrop:SetPoint("TOPLEFT", self.Runes, "TOPLEFT", -3.5, 3)
				self.Runes.FrameBackdrop:SetPoint("BOTTOMRIGHT", self.Runes, "BOTTOMRIGHT", 3.5, -3)
				self.Runes.FrameBackdrop:SetFrameStrata("BACKGROUND")
				self.Runes.FrameBackdrop:SetBackdrop {
					edgeFile = glowTex, edgeSize = 5,
					insets = {left = 3, right = 3, top = 3, bottom = 3}
				}
				self.Runes.FrameBackdrop:SetBackdropColor(0, 0, 0, 0)
				self.Runes.FrameBackdrop:SetBackdropBorderColor(0, 0, 0)
			else
				RuneFrame:Hide()
			end
		end
		
		------------------------------------------------------------------------
		--	Extra condition (druid mana in cat and bear form)
		------------------------------------------------------------------------

		if class == "DRUID" then
			DruidMana_Enable = db.oUF.Player.Texts.DruidMana.Enable
		
			if DruidMana_Enable == true then
				DruidMana_ShowIndicator = db.oUF.Player.Texts.DruidMana.ShowIndicator
				DruidMana_ShowPercent = db.oUF.Player.Texts.DruidMana.ShowPercent
				DruidMana_ShowShortValue = db.oUF.Player.Texts.DruidMana.ShowShortValue
				DruidMana_HideIfNoPower = db.oUF.Player.Texts.DruidMana.HideIfNoPower
				DruidMana_Font = db.oUF.Player.Texts.DruidMana.Font
				DruidMana_Size = db.oUF.Player.Texts.DruidMana.Size
				DruidMana_Outline = db.oUF.Player.Texts.DruidMana.Outline
				DruidMana_X = tonumber(db.oUF.Player.Texts.DruidMana.X)
				DruidMana_Y = tonumber(db.oUF.Player.Texts.DruidMana.Y)
				DruidMana_r = tonumber(db.oUF.Player.Texts.DruidMana.Color.r)
				DruidMana_g = tonumber(db.oUF.Player.Texts.DruidMana.Color.g)
				DruidMana_b = tonumber(db.oUF.Player.Texts.DruidMana.Color.b)
				
				CreateFrame("Frame"):SetScript("OnUpdate", function() UpdateDruidMana(self) end)
				self.DruidMana = SetFontString(self.Health, LSM:Fetch("font", DruidMana_Font), DruidMana_Size, DruidMana_Outline)
				self.DruidMana:SetTextColor(DruidMana_r, DruidMana_g, DruidMana_b)
				self.DruidMana:SetPoint("LEFT", self.Power.value, "RIGHT", DruidMana_X, DruidMana_Y)
			end
		end
	end
	
	if unit == "target" then
		------------------------------------------------------------------------
		--	Combo Points
		------------------------------------------------------------------------	
	
		--if class == "ROGUE" or UnitBuff("player", "Cat Form") then
			if db.oUF.Target.ComboPoints.Enable == true then
				self.ComboPoints = {}
				CPShowAlways = db.oUF.Target.ComboPoints.ShowAlways
	
				for i = 1, 5 do
					self.ComboPoints[i] = CreateFrame("StatusBar", self:GetName().."_ComboPoints"..i, self)
					if (i == 1) then
					   self.ComboPoints[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", db.oUF.Target.ComboPoints.X, db.oUF.Target.ComboPoints.Y)
					else
					   self.ComboPoints[i]:SetPoint("TOPLEFT", self.ComboPoints[i-1], "TOPRIGHT", 1, 0)
					end
					self.ComboPoints[i]:SetStatusBarTexture(LSM:Fetch("statusbar", db.oUF.Target.ComboPoints.Texture))
					self.ComboPoints[i]:SetStatusBarColor(unpack(combopointcolors[i]))	
					self.ComboPoints[i]:SetHeight(db.oUF.Target.ComboPoints.Height)
					self.ComboPoints[i]:SetWidth((tonumber(db.oUF.Target.ComboPoints.Width) -3) / 5)
					self.ComboPoints[i]:SetBackdrop(backdrop)
					self.ComboPoints[i]:SetFrameLevel(3)
					self.ComboPoints[i]:SetBackdropColor(0, 0, 0)
					self.ComboPoints[i]:SetMinMaxValues(0, 1)
					
					if CPShowAlways == true then
						self.ComboPoints[i]:SetValue(0)
					else
						self.ComboPoints[i]:SetValue(1)
					end
	
					self.ComboPoints[i].bg = self.ComboPoints[i]:CreateTexture(nil, "BORDER")
					self.ComboPoints[i].bg:SetAllPoints(self.ComboPoints[i])
					self.ComboPoints[i].bg:SetTexture(LSM:Fetch("statusbar", db.oUF.Target.ComboPoints.Texture))
					self.ComboPoints[i].bg.multiplier = tonumber(db.oUF.Target.ComboPoints.Multiplier)
					
					if db.oUF.Target.ComboPoints.BackgroundColor.Enable == true then
						r = db.oUF.Target.ComboPoints.BackgroundColor.r
						g = db.oUF.Target.ComboPoints.BackgroundColor.g
						b = db.oUF.Target.ComboPoints.BackgroundColor.b
						
						self.ComboPoints[i].bg:SetVertexColor(r, g, b) 
					else
						local mu = self.ComboPoints[i].bg.multiplier
						local r, g, b = self.ComboPoints[i]:GetStatusBarColor()
						r, g, b = r*mu, g*mu, b*mu
						self.ComboPoints[i].bg:SetVertexColor(r, g, b) 
					end
							
					self.ComboPoints[i].FrameBackdrop = CreateFrame("Frame", nil, self.ComboPoints[i])
					self.ComboPoints[i].FrameBackdrop:SetPoint("TOPLEFT", self.ComboPoints[i], "TOPLEFT", -3, 3)
					self.ComboPoints[i].FrameBackdrop:SetPoint("BOTTOMRIGHT", self.ComboPoints[i], "BOTTOMRIGHT", 3, -3)
					self.ComboPoints[i].FrameBackdrop:SetFrameStrata("BACKGROUND")
					self.ComboPoints[i].FrameBackdrop:SetBackdrop {
						edgeFile = glowTex, edgeSize = 4,
						insets = {left = 3, right = 3, top = 3, bottom = 3}
					}
					self.ComboPoints[i].FrameBackdrop:SetBackdropColor(0, 0, 0, 0)
					self.ComboPoints[i].FrameBackdrop:SetBackdropBorderColor(0, 0, 0)
				end
			end
		--end
	end

------------------------------------------------------------------------
--	Vehicule Swap
------------------------------------------------------------------------

	if unit == "pet" then
		self.PostEnterVehicle = EnterVehicle
		self.PostExitVehicle = ExitVehicle
	end

------------------------------------------------------------------------
--	Auras
------------------------------------------------------------------------	

	if unit == "player" or unit == "target" or unit == "focus" or unit == "pet" or unit == "targettarget" then
		
		if unit == "player" then
			if db.oUF.auras.player2.debuffs_enable then
				self.Debuffs = CreateFrame("Frame", nil, self)
				self.Debuffs:SetHeight(tonumber(db.oUF.auras.player2.debuffs_size))
				self.Debuffs:SetWidth(tonumber(db.oUF.Player.Width))
				self.Debuffs.size = tonumber(db.oUF.auras.player2.debuffs_size)
				self.Debuffs.spacing = tonumber(db.oUF.auras.player2.debuffs_spacing)
				self.Debuffs.num = tonumber(db.oUF.auras.player2.debuffs_num)
				self.Debuffs.numDebuffs = tonumber(db.oUF.auras.player2.debuffs_num)
				
				self.Debuffs:SetPoint(db.oUF.auras.player2.debuffs_initialAnchor, self, db.oUF.auras.player2.debuffs_initialAnchor, tonumber(db.oUF.auras.player2.debuffsX), tonumber(db.oUF.auras.player2.debuffsY))
				self.Debuffs.initialAnchor = db.oUF.auras.player2.debuffs_initialAnchor
				self.Debuffs["growth-y"] = db.oUF.auras.player2.debuffs_growthY
				self.Debuffs["growth-x"] = db.oUF.auras.player2.debuffs_growthX
				self.Debuffs.onlyShowPlayer = db.oUF.auras.player2.debuffs_playeronly
			end
			
			if db.oUF.auras.player2.buffs_enable then
				self.Buffs = CreateFrame("Frame", nil, self)
				self.Buffs:SetHeight(tonumber(db.oUF.auras.player2.buffs_size))
				self.Buffs:SetWidth(tonumber(db.oUF.Player.Width))
				self.Buffs.size = tonumber(db.oUF.auras.player2.buffs_size)
				self.Buffs.spacing = tonumber(db.oUF.auras.player2.buffs_spacing)
				self.Buffs.num = tonumber(db.oUF.auras.player2.buffs_num)
				self.Buffs.numDebuffs = tonumber(db.oUF.auras.player2.buffs_num)
				
				self.Buffs:SetPoint(db.oUF.auras.player2.buffs_initialAnchor, self, db.oUF.auras.player2.buffs_initialAnchor, tonumber(db.oUF.auras.player2.buffsX), tonumber(db.oUF.auras.player2.buffsY))
				self.Buffs.initialAnchor = db.oUF.auras.player2.buffs_initialAnchor
				self.Buffs["growth-y"] = db.oUF.auras.player2.buffs_growthY
				self.Buffs["growth-x"] = db.oUF.auras.player2.buffs_growthX
				self.Buffs.onlyShowPlayer = db.oUF.auras.player2.buffs_playeronly
			end
		end
		
		if unit == "pet" then
			if db.oUF.auras.pet.debuffs_enable then
				self.Debuffs = CreateFrame("Frame", nil, self)
				self.Debuffs:SetHeight(tonumber(db.oUF.auras.pet.debuffs_size))
				self.Debuffs:SetWidth(tonumber(db.oUF.Pet.Width))
				self.Debuffs.size = tonumber(db.oUF.auras.pet.debuffs_size)
				self.Debuffs.spacing = tonumber(db.oUF.auras.pet.debuffs_spacing)
				self.Debuffs.num = tonumber(db.oUF.auras.pet.debuffs_num)
				self.Debuffs.numDebuffs = tonumber(db.oUF.auras.pet.debuffs_num)
				
				self.Debuffs:SetPoint(db.oUF.auras.pet.debuffs_initialAnchor, self, db.oUF.auras.pet.debuffs_initialAnchor, tonumber(db.oUF.auras.pet.debuffsX), tonumber(db.oUF.auras.pet.debuffsY))
				self.Debuffs.initialAnchor = db.oUF.auras.pet.debuffs_initialAnchor
				self.Debuffs["growth-y"] = db.oUF.auras.pet.debuffs_growthY
				self.Debuffs["growth-x"] = db.oUF.auras.pet.debuffs_growthX
			end
			
			if db.oUF.auras.pet.buffs_enable then
				self.Buffs = CreateFrame("Frame", nil, self)
				self.Buffs:SetHeight(tonumber(db.oUF.auras.pet.buffs_size))
				self.Buffs:SetWidth(tonumber(db.oUF.Pet.Width))
				self.Buffs.size = tonumber(db.oUF.auras.pet.buffs_size)
				self.Buffs.spacing = tonumber(db.oUF.auras.pet.buffs_spacing)
				self.Buffs.num = tonumber(db.oUF.auras.pet.buffs_num)
				self.Buffs.numDebuffs = tonumber(db.oUF.auras.pet.buffs_num)
				
				self.Buffs:SetPoint(db.oUF.auras.pet.buffs_initialAnchor, self, db.oUF.auras.pet.buffs_initialAnchor, tonumber(db.oUF.auras.pet.buffsX), tonumber(db.oUF.auras.pet.buffsY))
				self.Buffs.initialAnchor = db.oUF.auras.pet.buffs_initialAnchor
				self.Buffs["growth-y"] = db.oUF.auras.pet.buffs_growthY
				self.Buffs["growth-x"] = db.oUF.auras.pet.buffs_growthX
				self.Buffs.onlyShowPlayer = db.oUF.auras.pet.buffs_playeronly
			end
		end
		
		if unit == "targettarget" then
			if db.oUF.auras.tot.debuffs_enable then
				self.Debuffs = CreateFrame("Frame", nil, self)
				self.Debuffs:SetHeight(tonumber(db.oUF.auras.tot.debuffs_size))
				self.Debuffs:SetWidth(tonumber(db.oUF.ToT.Width))
				self.Debuffs.size = tonumber(db.oUF.auras.tot.debuffs_size)
				self.Debuffs.spacing = tonumber(db.oUF.auras.tot.debuffs_spacing)
				self.Debuffs.num = tonumber(db.oUF.auras.tot.debuffs_num)
				self.Debuffs.numDebuffs = tonumber(db.oUF.auras.tot.debuffs_num)
				
				self.Debuffs:SetPoint(db.oUF.auras.tot.debuffs_initialAnchor, self, db.oUF.auras.tot.debuffs_initialAnchor, tonumber(db.oUF.auras.tot.debuffsX), tonumber(db.oUF.auras.tot.debuffsY))
				self.Debuffs.initialAnchor = db.oUF.auras.tot.debuffs_initialAnchor
				self.Debuffs["growth-y"] = db.oUF.auras.tot.debuffs_growthY
				self.Debuffs["growth-x"] = db.oUF.auras.tot.debuffs_growthX
			end
			
			if db.oUF.auras.tot.buffs_enable then
				self.Buffs = CreateFrame("Frame", nil, self)
				self.Buffs:SetHeight(tonumber(db.oUF.auras.tot.buffs_size))
				self.Buffs:SetWidth(tonumber(db.oUF.ToT.Width))
				self.Buffs.size = tonumber(db.oUF.auras.tot.buffs_size)
				self.Buffs.spacing = tonumber(db.oUF.auras.tot.buffs_spacing)
				self.Buffs.num = tonumber(db.oUF.auras.tot.buffs_num)
				self.Buffs.numDebuffs = tonumber(db.oUF.auras.tot.buffs_num)
				
				self.Buffs:SetPoint(db.oUF.auras.tot.buffs_initialAnchor, self, db.oUF.auras.tot.buffs_initialAnchor, tonumber(db.oUF.auras.tot.buffsX), tonumber(db.oUF.auras.tot.buffsY))
				self.Buffs.initialAnchor = db.oUF.auras.tot.buffs_initialAnchor
				self.Buffs["growth-y"] = db.oUF.auras.tot.buffs_growthY
				self.Buffs["growth-x"] = db.oUF.auras.tot.buffs_growthX
				self.Buffs.onlyShowPlayer = db.oUF.auras.tot.buffs_playeronly
			end
		end
		
		if unit == "focus" then
			if db.oUF.auras.focus.debuffs_enable then
				self.Debuffs = CreateFrame("Frame", nil, self)
				self.Debuffs:SetHeight(tonumber(db.oUF.auras.focus.debuffs_size))
				self.Debuffs:SetWidth(tonumber(db.oUF.Focus.Width))
				self.Debuffs.size = tonumber(db.oUF.auras.focus.debuffs_size)
				self.Debuffs.spacing = tonumber(db.oUF.auras.focus.debuffs_spacing)
				self.Debuffs.num = tonumber(db.oUF.auras.focus.debuffs_num)
				self.Debuffs.numDebuffs = tonumber(db.oUF.auras.focus.debuffs_num)
				
				self.Debuffs:SetPoint(db.oUF.auras.focus.debuffs_initialAnchor, self, db.oUF.auras.focus.debuffs_initialAnchor, tonumber(db.oUF.auras.focus.debuffsX), tonumber(db.oUF.auras.focus.debuffsY))
				self.Debuffs.initialAnchor = db.oUF.auras.focus.debuffs_initialAnchor
				self.Debuffs["growth-y"] = db.oUF.auras.focus.debuffs_growthY
				self.Debuffs["growth-x"] = db.oUF.auras.focus.debuffs_growthX
				self.Debuffs.onlyShowPlayer = db.oUF.auras.focus.debuffs_playeronly
			end
			
			if db.oUF.auras.focus.buffs_enable then
				self.Buffs = CreateFrame("Frame", nil, self)
				self.Buffs:SetHeight(tonumber(db.oUF.auras.focus.buffs_size))
				self.Buffs:SetWidth(tonumber(db.oUF.Focus.Width))
				self.Buffs.size = tonumber(db.oUF.auras.focus.buffs_size)
				self.Buffs.spacing = tonumber(db.oUF.auras.focus.buffs_spacing)
				self.Buffs.num = tonumber(db.oUF.auras.focus.buffs_num)
				self.Buffs.numDebuffs = tonumber(db.oUF.auras.focus.buffs_num)
				
				self.Buffs:SetPoint(db.oUF.auras.focus.buffs_initialAnchor, self, db.oUF.auras.focus.buffs_initialAnchor, tonumber(db.oUF.auras.focus.buffsX), tonumber(db.oUF.auras.focus.buffsY))
				self.Buffs.initialAnchor = db.oUF.auras.focus.buffs_initialAnchor
				self.Buffs["growth-y"] = db.oUF.auras.focus.buffs_growthY
				self.Buffs["growth-x"] = db.oUF.auras.focus.buffs_growthX
				self.Buffs.onlyShowPlayer = db.oUF.auras.focus.buffs_playeronly
			end
		end
		
		if unit == "target" then
			if db.oUF.auras.target.debuffs_enable then
				self.Debuffs = CreateFrame("Frame", nil, self)
				self.Debuffs:SetHeight(tonumber(db.oUF.auras.target.debuffs_size))
				self.Debuffs:SetWidth(tonumber(db.oUF.Target.Width))
				self.Debuffs.size = tonumber(db.oUF.auras.target.debuffs_size)
				self.Debuffs.spacing = tonumber(db.oUF.auras.target.debuffs_spacing)
				self.Debuffs.num = tonumber(db.oUF.auras.target.debuffs_num)
				self.Debuffs.numDebuffs = tonumber(db.oUF.auras.target.debuffs_num)
				
				if db.oUF.Target.ComboPoints.Enable == true then
					debuffsY = tonumber(db.oUF.auras.target.debuffsY) + 6
				else
					debuffsY = tonumber(db.oUF.auras.target.debuffsY)
				end
				
				self.Debuffs:SetPoint(db.oUF.auras.target.debuffs_initialAnchor, self, db.oUF.auras.target.debuffs_initialAnchor, tonumber(db.oUF.auras.target.debuffsX), debuffsY)
				self.Debuffs.initialAnchor = db.oUF.auras.target.debuffs_initialAnchor
				self.Debuffs["growth-y"] = db.oUF.auras.target.debuffs_growthY
				self.Debuffs["growth-x"] = db.oUF.auras.target.debuffs_growthX
				self.Debuffs.onlyShowPlayer = db.oUF.auras.target.debuffs_playeronly
			end
			
			if db.oUF.auras.target.buffs_enable then
				self.Buffs = CreateFrame("Frame", nil, self)
				self.Buffs:SetHeight(tonumber(db.oUF.auras.target.buffs_size))
				self.Buffs:SetWidth(tonumber(db.oUF.Target.Width))
				self.Buffs.size = tonumber(db.oUF.auras.target.buffs_size)
				self.Buffs.spacing = tonumber(db.oUF.auras.target.buffs_spacing)
				self.Buffs.num = tonumber(db.oUF.auras.target.buffs_num)
				self.Buffs.numDebuffs = tonumber(db.oUF.auras.target.buffs_num)
				
				if db.oUF.Target.ComboPoints.Enable == true then
					buffsY = tonumber(db.oUF.auras.target.buffsY) + 6
				else
					buffsY = tonumber(db.oUF.auras.target.buffsY)
				end
				
				self.Buffs:SetPoint(db.oUF.auras.target.buffs_initialAnchor, self, db.oUF.auras.target.buffs_initialAnchor, tonumber(db.oUF.auras.target.buffsX), buffsY)
				self.Buffs.initialAnchor = db.oUF.auras.target.buffs_initialAnchor
				self.Buffs["growth-y"] = db.oUF.auras.target.buffs_growthY
				self.Buffs["growth-x"] = db.oUF.auras.target.buffs_growthX
				self.Buffs.onlyShowPlayer = db.oUF.auras.target.buffs_playeronly
			end
		end		
		
------------------------------------------------------------------------
--	Combat text over HealthBar
------------------------------------------------------------------------	

		self.CombatFeedbackText = SetFontString(self.Health, font, 18, "OUTLINE")
		self.CombatFeedbackText:SetPoint("CENTER", 0, 1)
		self.CombatFeedbackText.colors = {
			DAMAGE = {0.69, 0.31, 0.31},
			CRUSHING = {0.69, 0.31, 0.31},
			CRITICAL = {0.69, 0.31, 0.31},
			GLANCING = {0.69, 0.31, 0.31},
			STANDARD = {0.84, 0.75, 0.65},
			IMMUNE = {0.84, 0.75, 0.65},
			ABSORB = {0.84, 0.75, 0.65},
			BLOCK = {0.84, 0.75, 0.65},
			RESIST = {0.84, 0.75, 0.65},
			MISS = {0.84, 0.75, 0.65},
			HEAL = {0.33, 0.59, 0.33},
			CRITHEAL = {0.33, 0.59, 0.33},
			ENERGIZE = {0.31, 0.45, 0.63},
			CRITENERGIZE = {0.31, 0.45, 0.63},
		}

	end

------------------------------------------------------------------------
--	Castbar
------------------------------------------------------------------------	

	if not (self:GetAttribute("unitsuffix") == "pet") and (db.Castbar.Enable == true) then
		local pClass, pToken = UnitClass("player")
		local color = colors.class[pToken]
		
		self.Castbar = CreateFrame("StatusBar", self:GetName().."_Castbar", self)
		self.Castbar.bg = self.Castbar:CreateTexture(nil, "BORDER")
		self.Castbar.bg:SetAllPoints(self.Castbar)
		
		self.CastbarBackdrop = CreateFrame("Frame", nil, self)
		self.CastbarBackdrop:SetPoint("TOPLEFT", self.Castbar, "TOPLEFT", -4, 3)
		self.CastbarBackdrop:SetPoint("BOTTOMRIGHT", self.Castbar, "BOTTOMRIGHT", 3, -3.5)
		self.CastbarBackdrop:SetParent(self.Castbar)
		
		------------------------------------------------------------------------
		--	PLAYER CASTBAR
		------------------------------------------------------------------------	
		
		if unit == "player" then
			if db.Castbar.Player.Enable == true then
				self.Castbar:SetStatusBarTexture(LSM:Fetch("statusbar", db.Castbar.Player.Texture))
				self.Castbar.bg:SetTexture(LSM:Fetch("statusbar", db.Castbar.Player.TextureBG ))
				
				if db.Castbar.Player.IndividualColor == true then  
					self.Castbar:SetStatusBarColor(db.Castbar.Player.Colors.Bar.r,db.Castbar.Player.Colors.Bar.g,db.Castbar.Player.Colors.Bar.b,db.Castbar.Player.Colors.Bar.a)
					self.Castbar.bg:SetVertexColor(db.Castbar.Player.Colors.Background.r,db.Castbar.Player.Colors.Background.g,db.Castbar.Player.Colors.Background.b,db.Castbar.Player.Colors.Background.a)
					
					self.CastbarBackdrop:SetBackdrop({
					edgeFile = LSM:Fetch("border", db.Castbar.Player.Border.Texture), edgeSize = db.Castbar.Player.Border.Thickness,
						insets = {left = db.Castbar.Player.Border.Inset.left, right = db.Castbar.Player.Border.Inset.right, top = db.Castbar.Player.Border.Inset.top, bottom = db.Castbar.Player.Border.Inset.bottom}
					})
					self.CastbarBackdrop:SetBackdropColor(0, 0, 0, 0)
					self.CastbarBackdrop:SetBackdropBorderColor(db.Castbar.Player.Colors.Border.r,db.Castbar.Player.Colors.Border.g,db.Castbar.Player.Colors.Border.b,db.Castbar.Player.Colors.Border.a)
				else
					self.Castbar.bg:SetVertexColor(0.15, 0.15, 0.15, 0.75)
					if db.Theme.IndividualColor == true then
						self.Castbar:SetStatusBarColor(oUF.colors.LUI[1]-0.2,oUF.colors.LUI[2]-0.2,oUF.colors.LUI[3]-0.2,0.5)
					else
						self.Castbar:SetStatusBarColor(color[1],color[2],color[3],0.68)
					end
					
					self.CastbarBackdrop:SetBackdrop({
					edgeFile = LSM:Fetch("border", db.Castbar.Player.Border.Texture), edgeSize = db.Castbar.Player.Border.Thickness,
						insets = {left = db.Castbar.Player.Border.Inset.left, right = db.Castbar.Player.Border.Inset.right, top = db.Castbar.Player.Border.Inset.top, bottom = db.Castbar.Player.Border.Inset.bottom}
					})
					self.CastbarBackdrop:SetBackdropColor(0, 0, 0, 0)
					self.CastbarBackdrop:SetBackdropBorderColor(0, 0, 0, 0.7)
				end
				
				self.Castbar:SetFrameLevel(6)
				self.Castbar:SetHeight(db.Castbar.Player.Height)
				self.Castbar:SetWidth(db.Castbar.Player.Width)
				self.Castbar:SetPoint("BOTTOM", UIParent, "BOTTOM", db.Castbar.Player.X, db.Castbar.Player.Y)
				
				self.Castbar.Time = SetFontString(self.Castbar, LSM:Fetch("font", db.Castbar.Player.Text.Time.Font), db.Castbar.Player.Text.Time.Size)
				self.Castbar.Time:SetPoint("RIGHT", self.Castbar, "RIGHT", db.Castbar.Player.Text.Time.OffsetX, db.Castbar.Player.Text.Time.OffsetY)
				self.Castbar.Time:SetTextColor(db.Castbar.Player.Colors.Time.r, db.Castbar.Player.Colors.Time.g, db.Castbar.Player.Colors.Time.b)
				self.Castbar.Time:SetJustifyH("RIGHT")
				self.Castbar.CustomTimeText = FormatPlayerCastbarTime
				
				if db.Castbar.Player.Text.Time.Enable == false then
					self.Castbar.Time:Hide()
				end
				
				self.Castbar.Text = SetFontString(self.Castbar, LSM:Fetch("font", db.Castbar.Player.Text.Name.Font), db.Castbar.Player.Text.Name.Size)
				self.Castbar.Text:SetPoint("LEFT", self.Castbar, "LEFT", db.Castbar.Player.Text.Name.OffsetX, db.Castbar.Player.Text.Name.OffsetY)
				self.Castbar.Text:SetTextColor(db.Castbar.Player.Colors.Name.r, db.Castbar.Player.Colors.Name.r, db.Castbar.Player.Colors.Name.r)
				
				if db.Castbar.Player.Text.Name.Enable == false then
					self.Castbar.Text:Hide()
				end
				
				if db.Castbar.Player.Icon == true then
					self.Castbar.Icon = self.Castbar:CreateTexture(nil, "ARTWORK")
					self.Castbar.Icon:SetHeight(28.5)
					self.Castbar.Icon:SetWidth(28.5)
					self.Castbar.Icon:SetTexCoord(0, 1, 0, 1)
					self.Castbar.Icon:SetPoint("LEFT", -41.5, 0)
	
					self.IconOverlay = self.Castbar:CreateTexture(nil, "OVERLAY")
					self.IconOverlay:SetPoint("TOPLEFT", self.Castbar.Icon, "TOPLEFT", -1.5, 1)
					self.IconOverlay:SetPoint("BOTTOMRIGHT", self.Castbar.Icon, "BOTTOMRIGHT", 1, -1)
					self.IconOverlay:SetTexture(buttonTex)
					self.IconOverlay:SetVertexColor(1, 1, 1)
	
					self.IconBackdrop = CreateFrame("Frame", nil, self)
					self.IconBackdrop:SetPoint("TOPLEFT", self.Castbar.Icon, "TOPLEFT", -4, 3)
					self.IconBackdrop:SetPoint("BOTTOMRIGHT", self.Castbar.Icon, "BOTTOMRIGHT", 3, -3.5)
					self.IconBackdrop:SetParent(self.Castbar)
					self.IconBackdrop:SetBackdrop({
					  edgeFile = glowTex, edgeSize = 4,
					  insets = {left = 3, right = 3, top = 3, bottom = 3}
					})
					self.IconBackdrop:SetBackdropColor(0, 0, 0, 0)
					self.IconBackdrop:SetBackdropBorderColor(0, 0, 0, 0.7)
				end
				
				if db.Castbar.Player.Latency == true then
					self.Castbar.SafeZone = self.Castbar:CreateTexture(nil, "ARTWORK")
					self.Castbar.SafeZone:SetTexture(normTex)
					
					if db.Castbar.Player.IndividualColor == true then  
						self.Castbar.SafeZone:SetVertexColor(db.Castbar.Player.Colors.Latency.r,db.Castbar.Player.Colors.Latency.g,db.Castbar.Player.Colors.Latency.b,db.Castbar.Player.Colors.Latency.a)
					else
						self.Castbar.SafeZone:SetVertexColor(0.11,0.11,0.11,0.6)
					end
				end
			else
				self.Castbar:Hide()
			end
			
		------------------------------------------------------------------------
		--	TARGET CASTBAR
		------------------------------------------------------------------------	
		
		elseif unit == "target" then
		
			if db.Castbar.Target.Enable == true then
				self.Castbar:SetStatusBarTexture(LSM:Fetch("statusbar", db.Castbar.Target.Texture))
				self.Castbar.bg:SetTexture(LSM:Fetch("statusbar", db.Castbar.Target.TextureBG ))
				
				if db.Castbar.Target.IndividualColor == true then  
					self.Castbar:SetStatusBarColor(db.Castbar.Target.Colors.Bar.r,db.Castbar.Target.Colors.Bar.g,db.Castbar.Target.Colors.Bar.b,db.Castbar.Target.Colors.Bar.a)
					self.Castbar.bg:SetVertexColor(db.Castbar.Target.Colors.Background.r,db.Castbar.Target.Colors.Background.g,db.Castbar.Target.Colors.Background.b,db.Castbar.Target.Colors.Background.a)
					
					self.CastbarBackdrop:SetBackdrop({
					edgeFile = LSM:Fetch("border", db.Castbar.Target.Border.Texture), edgeSize = db.Castbar.Target.Border.Thickness,
						insets = {left = db.Castbar.Target.Border.Inset.left, right = db.Castbar.Target.Border.Inset.right, top = db.Castbar.Target.Border.Inset.top, bottom = db.Castbar.Target.Border.Inset.bottom}
					})
					self.CastbarBackdrop:SetBackdropColor(0, 0, 0, 0)
					self.CastbarBackdrop:SetBackdropBorderColor(db.Castbar.Target.Colors.Border.r,db.Castbar.Target.Colors.Border.g,db.Castbar.Target.Colors.Border.b,db.Castbar.Target.Colors.Border.a)
				else
					self.Castbar.bg:SetVertexColor(0.15, 0.15, 0.15)
					if db.Theme.IndividualColor == true then
						self.Castbar:SetStatusBarColor(oUF.colors.LUI[1]-0.2,oUF.colors.LUI[2]-0.2,oUF.colors.LUI[3]-0.2,0.5)
					else
						self.Castbar:SetStatusBarColor(color[1]-0.15,color[2]-0.15,color[3]-0.15,0.6)
					end
					
					self.CastbarBackdrop:SetBackdrop({
					edgeFile = LSM:Fetch("border", db.Castbar.Target.Border.Texture), edgeSize = db.Castbar.Target.Border.Thickness,
						insets = {left = db.Castbar.Target.Border.Inset.left, right = db.Castbar.Target.Border.Inset.right, top = db.Castbar.Target.Border.Inset.top, bottom = db.Castbar.Target.Border.Inset.bottom}
					})
					self.CastbarBackdrop:SetBackdropColor(0, 0, 0, 0)
					self.CastbarBackdrop:SetBackdropBorderColor(0, 0, 0, 0.7)
				end
				
				self.Castbar:SetFrameLevel(6)
				self.Castbar:SetHeight(db.Castbar.Target.Height)
				self.Castbar:SetWidth(db.Castbar.Target.Width)
				self.Castbar:SetPoint("BOTTOM", UIParent, "BOTTOM", db.Castbar.Target.X, db.Castbar.Target.Y)
				
				self.Castbar.Time = SetFontString(self.Castbar, LSM:Fetch("font", db.Castbar.Target.Text.Time.Font), db.Castbar.Target.Text.Time.Size)
				self.Castbar.Time:SetPoint("RIGHT", self.Castbar, "RIGHT", db.Castbar.Target.Text.Time.OffsetX, db.Castbar.Target.Text.Time.OffsetY)
				self.Castbar.Time:SetTextColor(db.Castbar.Target.Colors.Time.r, db.Castbar.Target.Colors.Time.g, db.Castbar.Target.Colors.Time.b)
				self.Castbar.Time:SetJustifyH("RIGHT")
				self.Castbar.CustomTimeText = FormatTargetCastbarTime
				
				if db.Castbar.Target.Text.Time.Enable == false then
					self.Castbar.Time:Hide()
				end
				
				self.Castbar.Text = SetFontString(self.Castbar, LSM:Fetch("font", db.Castbar.Target.Text.Name.Font), db.Castbar.Target.Text.Name.Size)
				self.Castbar.Text:SetPoint("LEFT", self.Castbar, "LEFT", db.Castbar.Target.Text.Name.OffsetX, db.Castbar.Target.Text.Name.OffsetY)
				self.Castbar.Text:SetTextColor(db.Castbar.Target.Colors.Name.r, db.Castbar.Target.Colors.Name.r, db.Castbar.Target.Colors.Name.r)
				
				if db.Castbar.Target.Text.Name.Enable == false then
					self.Castbar.Text:Hide()
				end
				
				if db.Castbar.Target.Icon == true then
					self.Castbar.Icon = self.Castbar:CreateTexture(nil, "ARTWORK")
					self.Castbar.Icon:SetHeight(28.5)
					self.Castbar.Icon:SetWidth(28.5)
					self.Castbar.Icon:SetTexCoord(0, 1, 0, 1)
					self.Castbar.Icon:SetPoint("LEFT", -41.5, 0)
	
					self.IconOverlay = self.Castbar:CreateTexture(nil, "OVERLAY")
					self.IconOverlay:SetPoint("TOPLEFT", self.Castbar.Icon, "TOPLEFT", -1.5, 1)
					self.IconOverlay:SetPoint("BOTTOMRIGHT", self.Castbar.Icon, "BOTTOMRIGHT", 1, -1)
					self.IconOverlay:SetTexture(buttonTex)
					self.IconOverlay:SetVertexColor(1, 1, 1)
	
					self.IconBackdrop = CreateFrame("Frame", nil, self)
					self.IconBackdrop:SetPoint("TOPLEFT", self.Castbar.Icon, "TOPLEFT", -4, 3)
					self.IconBackdrop:SetPoint("BOTTOMRIGHT", self.Castbar.Icon, "BOTTOMRIGHT", 3, -3.5)
					self.IconBackdrop:SetParent(self.Castbar)
					self.IconBackdrop:SetBackdrop({
					  edgeFile = glowTex, edgeSize = 4,
					  insets = {left = 3, right = 3, top = 3, bottom = 3}
					})
					self.IconBackdrop:SetBackdropColor(0, 0, 0, 0)
					self.IconBackdrop:SetBackdropBorderColor(0, 0, 0, 0.7)
				end
			else
				self.Castbar:Hide()
			end
		
		------------------------------------------------------------------------
		--	FOCUS CASTBAR
		------------------------------------------------------------------------	
		
		elseif unit == "focus" then
			
			if db.Castbar.Focus.Enable == true then
				self.Castbar:SetStatusBarTexture(LSM:Fetch("statusbar", db.Castbar.Focus.Texture))
				self.Castbar.bg:SetTexture(LSM:Fetch("statusbar", db.Castbar.Focus.TextureBG ))
				
				if db.Castbar.Focus.IndividualColor == true then  
					self.Castbar:SetStatusBarColor(db.Castbar.Focus.Colors.Bar.r,db.Castbar.Focus.Colors.Bar.g,db.Castbar.Focus.Colors.Bar.b,db.Castbar.Focus.Colors.Bar.a)
					self.Castbar.bg:SetVertexColor(db.Castbar.Focus.Colors.Background.r,db.Castbar.Focus.Colors.Background.g,db.Castbar.Focus.Colors.Background.b,db.Castbar.Focus.Colors.Background.a)
					
					self.CastbarBackdrop:SetBackdrop({
					edgeFile = LSM:Fetch("border", db.Castbar.Focus.Border.Texture), edgeSize = db.Castbar.Focus.Border.Thickness,
						insets = {left = db.Castbar.Focus.Border.Inset.left, right = db.Castbar.Focus.Border.Inset.right, top = db.Castbar.Focus.Border.Inset.top, bottom = db.Castbar.Focus.Border.Inset.bottom}
					})
					self.CastbarBackdrop:SetBackdropColor(0, 0, 0, 0)
					self.CastbarBackdrop:SetBackdropBorderColor(db.Castbar.Focus.Colors.Border.r,db.Castbar.Focus.Colors.Border.g,db.Castbar.Focus.Colors.Border.b,db.Castbar.Focus.Colors.Border.a)
				else
					self.Castbar.bg:SetVertexColor(0.15, 0.15, 0.15)
					if db.Theme.IndividualColor == true then
						self.Castbar:SetStatusBarColor(oUF.colors.LUI[1]-0.2,oUF.colors.LUI[2]-0.2,oUF.colors.LUI[3]-0.2,0.5)
					else
						self.Castbar:SetStatusBarColor(color[1]-0.15,color[2]-0.15,color[3]-0.15,0.6)
					end
					
					self.CastbarBackdrop:SetBackdrop({
					edgeFile = LSM:Fetch("border", db.Castbar.Focus.Border.Texture), edgeSize = db.Castbar.Focus.Border.Thickness,
						insets = {left = db.Castbar.Focus.Border.Inset.left, right = db.Castbar.Focus.Border.Inset.right, top = db.Castbar.Focus.Border.Inset.top, bottom = db.Castbar.Focus.Border.Inset.bottom}
					})
					self.CastbarBackdrop:SetBackdropColor(0, 0, 0, 0)
					self.CastbarBackdrop:SetBackdropBorderColor(0, 0, 0, 0.7)
				end
				
				self.Castbar:SetFrameLevel(6)
				self.Castbar:SetHeight(db.Castbar.Focus.Height)
				self.Castbar:SetWidth(db.Castbar.Focus.Width)
				self.Castbar:SetPoint("TOPRIGHT", self.Power, "BOTTOMRIGHT", db.Castbar.Focus.X, db.Castbar.Focus.Y)
				
				self.Castbar.Time = SetFontString(self.Castbar, LSM:Fetch("font", db.Castbar.Focus.Text.Time.Font), db.Castbar.Focus.Text.Time.Size)
				self.Castbar.Time:SetPoint("RIGHT", self.Castbar, "RIGHT", db.Castbar.Focus.Text.Time.OffsetX, db.Castbar.Focus.Text.Time.OffsetY)
				self.Castbar.Time:SetTextColor(db.Castbar.Focus.Colors.Time.r, db.Castbar.Focus.Colors.Time.g, db.Castbar.Focus.Colors.Time.b)
				self.Castbar.Time:SetJustifyH("RIGHT")
				self.Castbar.CustomTimeText = FormatFocusCastbarTime
				
				if db.Castbar.Focus.Text.Time.Enable == false then
					self.Castbar.Time:Hide()
				end
				
				self.Castbar.Text = SetFontString(self.Castbar, LSM:Fetch("font", db.Castbar.Focus.Text.Name.Font), db.Castbar.Focus.Text.Name.Size)
				self.Castbar.Text:SetPoint("LEFT", self.Castbar, "LEFT", db.Castbar.Focus.Text.Name.OffsetX, db.Castbar.Focus.Text.Name.OffsetY)
				self.Castbar.Text:SetTextColor(db.Castbar.Focus.Colors.Name.r, db.Castbar.Focus.Colors.Name.r, db.Castbar.Focus.Colors.Name.r)
				
				if db.Castbar.Focus.Text.Name.Enable == false then
					self.Castbar.Text:Hide()
				end
				
				if db.Castbar.Focus.Icon == true then
					self.Castbar.Icon = self.Castbar:CreateTexture(nil, "ARTWORK")
					self.Castbar.Icon:SetHeight(30)
					self.Castbar.Icon:SetWidth(30)
					self.Castbar.Icon:SetTexCoord(0, 1, 0, 1)
					self.Castbar.Icon:SetPoint("LEFT", -35, 0)
					
					self.IconOverlay = self.Castbar:CreateTexture(nil, "OVERLAY")
					self.IconOverlay:SetPoint("TOPLEFT", self.Castbar.Icon, "TOPLEFT", -1.5, 1)
					self.IconOverlay:SetPoint("BOTTOMRIGHT", self.Castbar.Icon, "BOTTOMRIGHT", 1, -1)
					self.IconOverlay:SetTexture(buttonTex)
					self.IconOverlay:SetVertexColor(1, 1, 1)
	
					self.IconBackdrop = CreateFrame("Frame", nil, self)
					self.IconBackdrop:SetPoint("TOPLEFT", self.Castbar.Icon, "TOPLEFT", -4, 3)
					self.IconBackdrop:SetPoint("BOTTOMRIGHT", self.Castbar.Icon, "BOTTOMRIGHT", 3, -3.5)
					self.IconBackdrop:SetParent(self.Castbar)
					self.IconBackdrop:SetBackdrop({
					  edgeFile = glowTex, edgeSize = 4,
					  insets = {left = 3, right = 3, top = 3, bottom = 3}
					})
					self.IconBackdrop:SetBackdropColor(0, 0, 0, 0)
					self.IconBackdrop:SetBackdropBorderColor(0, 0, 0, 0.7)
				end
			else
				self.Castbar:Hide()
			end
		else	
			self.Castbar:Hide()
		end
	end
	
------------------------------------------------------------------------
--	Background texture and textures border
------------------------------------------------------------------------

	if((unit and unit:find("boss%d")) or (strsub(SecureButton_GetUnit(self), 0, 4) == "boss")) then
	
		self.FrameBackdrop = CreateFrame("Frame", nil, self)
		self.FrameBackdrop:SetPoint("TOPLEFT", self, "TOPLEFT", tonumber(db.oUF.Boss.Backdrop.Padding.Left), tonumber(db.oUF.Boss.Backdrop.Padding.Top))
		self.FrameBackdrop:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", tonumber(db.oUF.Boss.Backdrop.Padding.Right), tonumber(db.oUF.Boss.Backdrop.Padding.Bottom))
		self.FrameBackdrop:SetFrameStrata("BACKGROUND")
		self.FrameBackdrop:SetBackdrop({
			bgFile = LSM:Fetch("background", db.oUF.Boss.Backdrop.Texture),
			edgeFile = LSM:Fetch("border", db.oUF.Boss.Border.EdgeFile),
		  	edgeSize = tonumber(db.oUF.Boss.Border.EdgeSize),
		  	insets = {
		  		left = tonumber(db.oUF.Boss.Border.Insets.Left),
				right = tonumber(db.oUF.Boss.Border.Insets.Right),
				top = tonumber(db.oUF.Boss.Border.Insets.Top),
				bottom = tonumber(db.oUF.Boss.Border.Insets.Bottom)
		  	}
		})
		self.FrameBackdrop:SetBackdropColor(tonumber(db.oUF.Boss.Backdrop.Color.r),tonumber(db.oUF.Boss.Backdrop.Color.g),tonumber(db.oUF.Boss.Backdrop.Color.b),tonumber(db.oUF.Boss.Backdrop.Color.a))
		self.FrameBackdrop:SetBackdropBorderColor(tonumber(db.oUF.Boss.Border.Color.r), tonumber(db.oUF.Boss.Border.Color.g), tonumber(db.oUF.Boss.Border.Color.b), tonumber(db.oUF.Boss.Border.Color.a))

	elseif unit == "player" then
		
		self.FrameBackdrop = CreateFrame("Frame", nil, self)
		self.FrameBackdrop:SetPoint("TOPLEFT", self, "TOPLEFT", tonumber(db.oUF.Player.Backdrop.Padding.Left), tonumber(db.oUF.Player.Backdrop.Padding.Top))
		self.FrameBackdrop:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", tonumber(db.oUF.Player.Backdrop.Padding.Right), tonumber(db.oUF.Player.Backdrop.Padding.Bottom))
		self.FrameBackdrop:SetFrameStrata("BACKGROUND")
		self.FrameBackdrop:SetBackdrop({
			bgFile = LSM:Fetch("background", db.oUF.Player.Backdrop.Texture),
			edgeFile = LSM:Fetch("border", db.oUF.Player.Border.EdgeFile),
		  	edgeSize = tonumber(db.oUF.Player.Border.EdgeSize),
		  	insets = {
		  		left = tonumber(db.oUF.Player.Border.Insets.Left),
				right = tonumber(db.oUF.Player.Border.Insets.Right),
				top = tonumber(db.oUF.Player.Border.Insets.Top),
				bottom = tonumber(db.oUF.Player.Border.Insets.Bottom)
		  	}
		})
		self.FrameBackdrop:SetBackdropColor(tonumber(db.oUF.Player.Backdrop.Color.r),tonumber(db.oUF.Player.Backdrop.Color.g),tonumber(db.oUF.Player.Backdrop.Color.b),tonumber(db.oUF.Player.Backdrop.Color.a))
		self.FrameBackdrop:SetBackdropBorderColor(tonumber(db.oUF.Player.Border.Color.r), tonumber(db.oUF.Player.Border.Color.g), tonumber(db.oUF.Player.Border.Color.b), tonumber(db.oUF.Player.Border.Color.a))
		
	elseif unit == "target" then
	
		self.FrameBackdrop = CreateFrame("Frame", nil, self)
		self.FrameBackdrop:SetPoint("TOPLEFT", self, "TOPLEFT", tonumber(db.oUF.Target.Backdrop.Padding.Left), tonumber(db.oUF.Target.Backdrop.Padding.Top))
		self.FrameBackdrop:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", tonumber(db.oUF.Target.Backdrop.Padding.Right), tonumber(db.oUF.Target.Backdrop.Padding.Bottom))
		self.FrameBackdrop:SetFrameStrata("BACKGROUND")
		self.FrameBackdrop:SetBackdrop({
			bgFile = LSM:Fetch("background", db.oUF.Target.Backdrop.Texture),
			edgeFile = LSM:Fetch("border", db.oUF.Target.Border.EdgeFile),
		  	edgeSize = tonumber(db.oUF.Target.Border.EdgeSize),
		  	insets = {
		  		left = tonumber(db.oUF.Target.Border.Insets.Left),
				right = tonumber(db.oUF.Target.Border.Insets.Right),
				top = tonumber(db.oUF.Target.Border.Insets.Top),
				bottom = tonumber(db.oUF.Target.Border.Insets.Bottom)
		  	}
		})
		self.FrameBackdrop:SetBackdropColor(tonumber(db.oUF.Target.Backdrop.Color.r),tonumber(db.oUF.Target.Backdrop.Color.g),tonumber(db.oUF.Target.Backdrop.Color.b),tonumber(db.oUF.Target.Backdrop.Color.a))
		self.FrameBackdrop:SetBackdropBorderColor(tonumber(db.oUF.Target.Border.Color.r), tonumber(db.oUF.Target.Border.Color.g), tonumber(db.oUF.Target.Border.Color.b), tonumber(db.oUF.Target.Border.Color.a))
		
	elseif unit == "targettarget" then
	
		self.FrameBackdrop = CreateFrame("Frame", nil, self)
		self.FrameBackdrop:SetPoint("TOPLEFT", self, "TOPLEFT", tonumber(db.oUF.ToT.Backdrop.Padding.Left), tonumber(db.oUF.ToT.Backdrop.Padding.Top))
		self.FrameBackdrop:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", tonumber(db.oUF.ToT.Backdrop.Padding.Right), tonumber(db.oUF.ToT.Backdrop.Padding.Bottom))
		self.FrameBackdrop:SetFrameStrata("BACKGROUND")
		self.FrameBackdrop:SetBackdrop({
			bgFile = LSM:Fetch("background", db.oUF.ToT.Backdrop.Texture),
			edgeFile = LSM:Fetch("border", db.oUF.ToT.Border.EdgeFile),
		  	edgeSize = tonumber(db.oUF.ToT.Border.EdgeSize),
		  	insets = {
		  		left = tonumber(db.oUF.ToT.Border.Insets.Left),
				right = tonumber(db.oUF.ToT.Border.Insets.Right),
				top = tonumber(db.oUF.ToT.Border.Insets.Top),
				bottom = tonumber(db.oUF.ToT.Border.Insets.Bottom)
		  	}
		})
		self.FrameBackdrop:SetBackdropColor(tonumber(db.oUF.ToT.Backdrop.Color.r),tonumber(db.oUF.ToT.Backdrop.Color.g),tonumber(db.oUF.ToT.Backdrop.Color.b),tonumber(db.oUF.ToT.Backdrop.Color.a))
		self.FrameBackdrop:SetBackdropBorderColor(tonumber(db.oUF.ToT.Border.Color.r), tonumber(db.oUF.ToT.Border.Color.g), tonumber(db.oUF.ToT.Border.Color.b), tonumber(db.oUF.ToT.Border.Color.a))
		
		if db.oUF.Settings.show_v2_textures == true then
			local Panel2 = CreateFrame("Frame", nil, self)
			Panel2:SetFrameLevel(20)
			Panel2:SetFrameStrata("BACKGROUND")
			Panel2:SetHeight(2)
			Panel2:SetWidth(60)
			Panel2:SetPoint("LEFT", self.Health, "LEFT", -50, -1)
			Panel2:SetScale(1)
			Panel2:SetBackdrop(backdrop2)
			Panel2:SetBackdropColor(0,0,0,1)
			Panel2:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel2:Show()
			
			local Panel3 = CreateFrame("Frame", nil, self)
			Panel3:SetFrameLevel(20)
			Panel3:SetFrameStrata("BACKGROUND")
			Panel3:SetHeight(50)
			Panel3:SetWidth(2)
			Panel3:SetPoint("LEFT", self.Health, "LEFT", -50, 23)
			Panel3:SetScale(1)
			Panel3:SetBackdrop(backdrop2)
			Panel3:SetBackdropColor(0,0,0,1)
			Panel3:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel3:Show()
			
			local Panel4 = CreateFrame("Frame", nil, self)
			Panel4:SetFrameLevel(20)
			Panel4:SetFrameStrata("BACKGROUND")
			Panel4:SetHeight(2)
			Panel4:SetWidth(60)
			Panel4:SetPoint("RIGHT", self.Health, "RIGHT", 50, -1)
			Panel4:SetScale(1)
			Panel4:SetBackdrop(backdrop2)
			Panel4:SetBackdropColor(0,0,0,1)
			Panel4:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel4:Show()
			
			local Panel5 = CreateFrame("Frame", nil, self)
			Panel5:SetFrameLevel(20)
			Panel5:SetFrameStrata("BACKGROUND")
			Panel5:SetHeight(6)
			Panel5:SetWidth(6)
			Panel5:SetPoint("RIGHT", self.Health, "RIGHT", 52, -1)
			Panel5:SetScale(1)
			Panel5:SetBackdrop(backdrop2)
			Panel5:SetBackdropColor(0,0,0,1)
			Panel5:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel5:Show()
		end
		
	elseif unit == "targettargettarget" then
	
		self.FrameBackdrop = CreateFrame("Frame", nil, self)
		self.FrameBackdrop:SetPoint("TOPLEFT", self, "TOPLEFT", tonumber(db.oUF.ToToT.Backdrop.Padding.Left), tonumber(db.oUF.ToToT.Backdrop.Padding.Top))
		self.FrameBackdrop:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", tonumber(db.oUF.ToToT.Backdrop.Padding.Right), tonumber(db.oUF.ToToT.Backdrop.Padding.Bottom))
		self.FrameBackdrop:SetFrameStrata("BACKGROUND")
		self.FrameBackdrop:SetBackdrop({
			bgFile = LSM:Fetch("background", db.oUF.ToToT.Backdrop.Texture),
			edgeFile = LSM:Fetch("border", db.oUF.ToToT.Border.EdgeFile),
		  	edgeSize = tonumber(db.oUF.ToToT.Border.EdgeSize),
		  	insets = {
		  		left = tonumber(db.oUF.ToToT.Border.Insets.Left),
				right = tonumber(db.oUF.ToToT.Border.Insets.Right),
				top = tonumber(db.oUF.ToToT.Border.Insets.Top),
				bottom = tonumber(db.oUF.ToToT.Border.Insets.Bottom)
		  	}
		})
		self.FrameBackdrop:SetBackdropColor(tonumber(db.oUF.ToToT.Backdrop.Color.r),tonumber(db.oUF.ToToT.Backdrop.Color.g),tonumber(db.oUF.ToToT.Backdrop.Color.b),tonumber(db.oUF.ToToT.Backdrop.Color.a))
		self.FrameBackdrop:SetBackdropBorderColor(tonumber(db.oUF.ToToT.Border.Color.r), tonumber(db.oUF.ToToT.Border.Color.g), tonumber(db.oUF.ToToT.Border.Color.b), tonumber(db.oUF.ToToT.Border.Color.a))
		
		if db.oUF.Settings.show_v2_textures == true then
			local Panel2 = CreateFrame("Frame", nil, self)
			Panel2:SetFrameLevel(20)
			Panel2:SetFrameStrata("BACKGROUND")
			Panel2:SetHeight(2)
			Panel2:SetWidth(60)
			Panel2:SetPoint("LEFT", self.Health, "LEFT", -50, -1)
			Panel2:SetScale(1)
			Panel2:SetBackdrop(backdrop2)
			Panel2:SetBackdropColor(0,0,0,1)
			Panel2:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel2:Show()
			
			local Panel3 = CreateFrame("Frame", nil, self)
			Panel3:SetFrameLevel(20)
			Panel3:SetFrameStrata("BACKGROUND")
			Panel3:SetHeight(35)
			Panel3:SetWidth(2)
			Panel3:SetPoint("LEFT", self.Health, "LEFT", -50, 16)
			Panel3:SetScale(1)
			Panel3:SetBackdrop(backdrop2)
			Panel3:SetBackdropColor(0,0,0,1)
			Panel3:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel3:Show()
			
			local Panel4 = CreateFrame("Frame", nil, self)
			Panel4:SetFrameLevel(20)
			Panel4:SetFrameStrata("BACKGROUND")
			Panel4:SetHeight(2)
			Panel4:SetWidth(60)
			Panel4:SetPoint("RIGHT", self.Health, "RIGHT", 50, -1)
			Panel4:SetScale(1)
			Panel4:SetBackdrop(backdrop2)
			Panel4:SetBackdropColor(0,0,0,1)
			Panel4:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel4:Show()
			
			local Panel5 = CreateFrame("Frame", nil, self)
			Panel5:SetFrameLevel(20)
			Panel5:SetFrameStrata("BACKGROUND")
			Panel5:SetHeight(6)
			Panel5:SetWidth(6)
			Panel5:SetPoint("RIGHT", self.Health, "RIGHT", 52, -1)
			Panel5:SetScale(1)
			Panel5:SetBackdrop(backdrop2)
			Panel5:SetBackdropColor(0,0,0,1)
			Panel5:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel5:Show()
			
			local Panel6 = CreateFrame("Frame", nil, self)
			Panel6:SetFrameLevel(20)
			Panel6:SetFrameStrata("BACKGROUND")
			Panel6:SetHeight(6)
			Panel6:SetWidth(6)
			Panel6:SetPoint("LEFT", self.Health, "LEFT", -52, 34)
			Panel6:SetScale(1)
			Panel6:SetBackdrop(backdrop2)
			Panel6:SetBackdropColor(0,0,0,1)
			Panel6:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel6:Show()
		end
		
	elseif unit == "focustarget" then
	
		self.FrameBackdrop = CreateFrame("Frame", nil, self)
		self.FrameBackdrop:SetPoint("TOPLEFT", self, "TOPLEFT", tonumber(db.oUF.FocusTarget.Backdrop.Padding.Left), tonumber(db.oUF.FocusTarget.Backdrop.Padding.Top))
		self.FrameBackdrop:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", tonumber(db.oUF.FocusTarget.Backdrop.Padding.Right), tonumber(db.oUF.FocusTarget.Backdrop.Padding.Bottom))
		self.FrameBackdrop:SetFrameStrata("BACKGROUND")
		self.FrameBackdrop:SetBackdrop({
			bgFile = LSM:Fetch("background", db.oUF.FocusTarget.Backdrop.Texture),
			edgeFile = LSM:Fetch("border", db.oUF.FocusTarget.Border.EdgeFile),
		  	edgeSize = tonumber(db.oUF.FocusTarget.Border.EdgeSize),
		  	insets = {
		  		left = tonumber(db.oUF.FocusTarget.Border.Insets.Left),
				right = tonumber(db.oUF.FocusTarget.Border.Insets.Right),
				top = tonumber(db.oUF.FocusTarget.Border.Insets.Top),
				bottom = tonumber(db.oUF.FocusTarget.Border.Insets.Bottom)
		  	}
		})
		self.FrameBackdrop:SetBackdropColor(tonumber(db.oUF.FocusTarget.Backdrop.Color.r),tonumber(db.oUF.FocusTarget.Backdrop.Color.g),tonumber(db.oUF.FocusTarget.Backdrop.Color.b),tonumber(db.oUF.FocusTarget.Backdrop.Color.a))
		self.FrameBackdrop:SetBackdropBorderColor(tonumber(db.oUF.FocusTarget.Border.Color.r), tonumber(db.oUF.FocusTarget.Border.Color.g), tonumber(db.oUF.FocusTarget.Border.Color.b), tonumber(db.oUF.FocusTarget.Border.Color.a))

		if db.oUF.Settings.show_v2_textures == true then
			local Panel2 = CreateFrame("Frame", nil, self)
			Panel2:SetFrameLevel(20)
			Panel2:SetFrameStrata("BACKGROUND")
			Panel2:SetHeight(2)
			Panel2:SetWidth(60)
			Panel2:SetPoint("LEFT", self.Health, "LEFT", -50, -1)
			Panel2:SetScale(1)
			Panel2:SetBackdrop(backdrop2)
			Panel2:SetBackdropColor(0,0,0,1)
			Panel2:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel2:Show()
			
			local Panel3 = CreateFrame("Frame", nil, self)
			Panel3:SetFrameLevel(20)
			Panel3:SetFrameStrata("BACKGROUND")
			Panel3:SetHeight(35)
			Panel3:SetWidth(2)
			Panel3:SetPoint("RIGHT", self.Health, "RIGHT", 50, 16)
			Panel3:SetScale(1)
			Panel3:SetBackdrop(backdrop2)
			Panel3:SetBackdropColor(0,0,0,1)
			Panel3:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel3:Show()
			
			local Panel4 = CreateFrame("Frame", nil, self)
			Panel4:SetFrameLevel(20)
			Panel4:SetFrameStrata("BACKGROUND")
			Panel4:SetHeight(2)
			Panel4:SetWidth(60)
			Panel4:SetPoint("RIGHT", self.Health, "RIGHT", 50, -1)
			Panel4:SetScale(1)
			Panel4:SetBackdrop(backdrop2)
			Panel4:SetBackdropColor(0,0,0,1)
			Panel4:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel4:Show()
			
			local Panel5 = CreateFrame("Frame", nil, self)
			Panel5:SetFrameLevel(20)
			Panel5:SetFrameStrata("BACKGROUND")
			Panel5:SetHeight(6)
			Panel5:SetWidth(6)
			Panel5:SetPoint("LEFT", self.Health, "LEFT", -52, -1)
			Panel5:SetScale(1)
			Panel5:SetBackdrop(backdrop2)
			Panel5:SetBackdropColor(0,0,0,1)
			Panel5:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel5:Show()
			
			local Panel6 = CreateFrame("Frame", nil, self)
			Panel6:SetFrameLevel(20)
			Panel6:SetFrameStrata("BACKGROUND")
			Panel6:SetHeight(6)
			Panel6:SetWidth(6)
			Panel6:SetPoint("RIGHT", self.Health, "RIGHT", 52, 34)
			Panel6:SetScale(1)
			Panel6:SetBackdrop(backdrop2)
			Panel6:SetBackdropColor(0,0,0,1)
			Panel6:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel6:Show()
		end
	
	elseif unit == "pet" then
	
		self.FrameBackdrop = CreateFrame("Frame", nil, self)
		self.FrameBackdrop:SetPoint("TOPLEFT", self, "TOPLEFT", tonumber(db.oUF.Pet.Backdrop.Padding.Left), tonumber(db.oUF.Pet.Backdrop.Padding.Top))
		self.FrameBackdrop:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", tonumber(db.oUF.Pet.Backdrop.Padding.Right), tonumber(db.oUF.Pet.Backdrop.Padding.Bottom))
		self.FrameBackdrop:SetFrameStrata("BACKGROUND")
		self.FrameBackdrop:SetBackdrop({
			bgFile = LSM:Fetch("background", db.oUF.Pet.Backdrop.Texture),
			edgeFile = LSM:Fetch("border", db.oUF.Pet.Border.EdgeFile),
		  	edgeSize = tonumber(db.oUF.Pet.Border.EdgeSize),
		  	insets = {
		  		left = tonumber(db.oUF.Pet.Border.Insets.Left),
				right = tonumber(db.oUF.Pet.Border.Insets.Right),
				top = tonumber(db.oUF.Pet.Border.Insets.Top),
				bottom = tonumber(db.oUF.Pet.Border.Insets.Bottom)
		  	}
		})
		self.FrameBackdrop:SetBackdropColor(tonumber(db.oUF.Pet.Backdrop.Color.r),tonumber(db.oUF.Pet.Backdrop.Color.g),tonumber(db.oUF.Pet.Backdrop.Color.b),tonumber(db.oUF.Pet.Backdrop.Color.a))
		self.FrameBackdrop:SetBackdropBorderColor(tonumber(db.oUF.Pet.Border.Color.r), tonumber(db.oUF.Pet.Border.Color.g), tonumber(db.oUF.Pet.Border.Color.b), tonumber(db.oUF.Pet.Border.Color.a))
		
	elseif unit == "pettarget" then
	
		self.FrameBackdrop = CreateFrame("Frame", nil, self)
		self.FrameBackdrop:SetPoint("TOPLEFT", self, "TOPLEFT", tonumber(db.oUF.PetTarget.Backdrop.Padding.Left), tonumber(db.oUF.PetTarget.Backdrop.Padding.Top))
		self.FrameBackdrop:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", tonumber(db.oUF.PetTarget.Backdrop.Padding.Right), tonumber(db.oUF.PetTarget.Backdrop.Padding.Bottom))
		self.FrameBackdrop:SetFrameStrata("BACKGROUND")
		self.FrameBackdrop:SetBackdrop({
			bgFile = LSM:Fetch("background", db.oUF.PetTarget.Backdrop.Texture),
			edgeFile = LSM:Fetch("border", db.oUF.PetTarget.Border.EdgeFile),
		  	edgeSize = tonumber(db.oUF.PetTarget.Border.EdgeSize),
		  	insets = {
		  		left = tonumber(db.oUF.PetTarget.Border.Insets.Left),
				right = tonumber(db.oUF.PetTarget.Border.Insets.Right),
				top = tonumber(db.oUF.PetTarget.Border.Insets.Top),
				bottom = tonumber(db.oUF.PetTarget.Border.Insets.Bottom)
		  	}
		})
		self.FrameBackdrop:SetBackdropColor(tonumber(db.oUF.PetTarget.Backdrop.Color.r),tonumber(db.oUF.PetTarget.Backdrop.Color.g),tonumber(db.oUF.PetTarget.Backdrop.Color.b),tonumber(db.oUF.PetTarget.Backdrop.Color.a))
		self.FrameBackdrop:SetBackdropBorderColor(tonumber(db.oUF.PetTarget.Border.Color.r), tonumber(db.oUF.PetTarget.Border.Color.g), tonumber(db.oUF.PetTarget.Border.Color.b), tonumber(db.oUF.PetTarget.Border.Color.a))
	
	elseif unit =="focus" then
	
		self.FrameBackdrop = CreateFrame("Frame", nil, self)
		self.FrameBackdrop:SetPoint("TOPLEFT", self, "TOPLEFT", tonumber(db.oUF.Focus.Backdrop.Padding.Left), tonumber(db.oUF.Focus.Backdrop.Padding.Top))
		self.FrameBackdrop:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", tonumber(db.oUF.Focus.Backdrop.Padding.Right), tonumber(db.oUF.Focus.Backdrop.Padding.Bottom))
		self.FrameBackdrop:SetFrameStrata("BACKGROUND")
		self.FrameBackdrop:SetBackdrop({
			bgFile = LSM:Fetch("background", db.oUF.Focus.Backdrop.Texture),
			edgeFile = LSM:Fetch("border", db.oUF.Focus.Border.EdgeFile),
		  	edgeSize = tonumber(db.oUF.Focus.Border.EdgeSize),
		  	insets = {
		  		left = tonumber(db.oUF.Focus.Border.Insets.Left),
				right = tonumber(db.oUF.Focus.Border.Insets.Right),
				top = tonumber(db.oUF.Focus.Border.Insets.Top),
				bottom = tonumber(db.oUF.Focus.Border.Insets.Bottom)
		  	}
		})
		self.FrameBackdrop:SetBackdropColor(tonumber(db.oUF.Focus.Backdrop.Color.r),tonumber(db.oUF.Focus.Backdrop.Color.g),tonumber(db.oUF.Focus.Backdrop.Color.b),tonumber(db.oUF.Focus.Backdrop.Color.a))
		self.FrameBackdrop:SetBackdropBorderColor(tonumber(db.oUF.Focus.Border.Color.r), tonumber(db.oUF.Focus.Border.Color.g), tonumber(db.oUF.Focus.Border.Color.b), tonumber(db.oUF.Focus.Border.Color.a))
		
		if db.oUF.Settings.show_v2_textures == true then
			local Panel2 = CreateFrame("Frame", nil, self)
			Panel2:SetFrameLevel(20)
			Panel2:SetFrameStrata("BACKGROUND")
			Panel2:SetHeight(2)
			Panel2:SetWidth(60)
			Panel2:SetPoint("RIGHT", self.Health, "RIGHT", 50, -1)
			Panel2:SetScale(1)
			Panel2:SetBackdrop(backdrop2)
			Panel2:SetBackdropColor(0,0,0,1)
			Panel2:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel2:Show()
			
			local Panel3 = CreateFrame("Frame", nil, self)
			Panel3:SetFrameLevel(20)
			Panel3:SetFrameStrata("BACKGROUND")
			Panel3:SetHeight(50)
			Panel3:SetWidth(2)
			Panel3:SetPoint("RIGHT", self.Health, "RIGHT", 50, 23)
			Panel3:SetScale(1)
			Panel3:SetBackdrop(backdrop2)
			Panel3:SetBackdropColor(0,0,0,1)
			Panel3:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel3:Show()
			
			local Panel4 = CreateFrame("Frame", nil, self)
			Panel4:SetFrameLevel(20)
			Panel4:SetFrameStrata("BACKGROUND")
			Panel4:SetHeight(2)
			Panel4:SetWidth(50)
			Panel4:SetPoint("LEFT", self.Health, "LEFT", -50, -1)
			Panel4:SetScale(1)
			Panel4:SetBackdrop(backdrop2)
			Panel4:SetBackdropColor(0,0,0,1)
			Panel4:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel4:Show()
			
			local Panel5 = CreateFrame("Frame", nil, self)
			Panel5:SetFrameLevel(20)
			Panel5:SetFrameStrata("BACKGROUND")
			Panel5:SetHeight(6)
			Panel5:SetWidth(6)
			Panel5:SetPoint("LEFT", self.Health, "LEFT", -52, -1)
			Panel5:SetScale(1)
			Panel5:SetBackdrop(backdrop2)
			Panel5:SetBackdropColor(0,0,0,1)
			Panel5:SetBackdropBorderColor(0.1,0.1,0.1,1)
			Panel5:Show()
		end
	else
		self.FrameBackdrop = CreateFrame("Frame", nil, self)
		self.FrameBackdrop:SetPoint("TOPLEFT", self, "TOPLEFT", -4.5, 4)
		self.FrameBackdrop:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 4.5, -4.5)
		self.FrameBackdrop:SetFrameStrata("BACKGROUND")
		self.FrameBackdrop:SetBackdrop {
		  bgFile = blankTex,
		  edgeFile = glowTex, edgeSize = 5,
		  insets = {left = 3, right = 3, top = 3, bottom = 3}
		}
		self.FrameBackdrop:SetBackdropColor(0, 0, 0, 0)
		self.FrameBackdrop:SetBackdropBorderColor(0, 0, 0)
	end
	self.ThreatFeedbackFrame = self.FrameBackdrop

	self.outsideRangeAlpha = 0.3
	self.inRangeAlpha = 1
	self.SpellRange = true

	self.BarFade = false

	self.PostUpdateHealth = PostUpdateHealth
	self.PreUpdatePower = PreUpdatePower
	self.PostUpdatePower = PostUpdatePower
	self.OverrideUpdatePower = OverrideUpdatePower
	self.PostCreateAuraIcon = CreateAura
	self.PostCreateEnchantIcon = CreateAura
	self.PostUpdateAuraIcon = UpdateAura
	self.PostUpdateEnchantIcons = CreateEnchantTimer
	self.PostUpdateThreat = PostUpdateThreat

	self:SetScale(settings.scale)
	if self.Auras then self.Auras:SetScale(settings.scale) end
	if self.Buffs then self.Buffs:SetScale(settings.scale) end
	if self.Debuffs then self.Debuffs:SetScale(settings.scale) end

	return self
end

oUF:RegisterStyle("LUI", SetStyle)
oUF:SetActiveStyle("LUI")

local cfg = settings.coords

oUF:Spawn("player", "oUF_LUI_player"):SetPoint("CENTER", UIParent, "CENTER", cfg.playerX, cfg.playerY)
oUF:Spawn("target", "oUF_LUI_target"):SetPoint("CENTER", UIParent, "CENTER", cfg.targetX, cfg.targetY)

if db.oUF.Focus.Enable == true then oUF:Spawn("focus", "oUF_LUI_focus"):SetPoint("CENTER", UIParent, "CENTER", cfg.focusX, cfg.focusY) end
if db.oUF.FocusTarget.Enable == true then oUF:Spawn("focustarget", "oUF_LUI_focustarget"):SetPoint("CENTER", UIParent, "CENTER", cfg.foctarX, cfg.foctarY) end

if db.oUF.ToT.Enable == true then oUF:Spawn("targettarget", "oUF_LUI_targettarget"):SetPoint("CENTER", UIParent, "CENTER", cfg.totX, cfg.totY) end
if db.oUF.ToToT.Enable == true then oUF:Spawn("targettargettarget", "oUF_LUI_targettargettarget"):SetPoint("CENTER", UIParent, "CENTER", cfg.tototX, cfg.tototY) end

if db.oUF.Pet.Enable == true then oUF:Spawn("pet", "oUF_LUI_pet"):SetPoint("CENTER", UIParent, "CENTER", cfg.petX, cfg.petY) end
if db.oUF.PetTarget.Enable == true then oUF:Spawn("pettarget", "oUF_LUI_pettarget"):SetPoint("CENTER", UIParent, "CENTER", cfg.pettarX, cfg.pettarY) end


for i = 1,MAX_BOSS_FRAMES do
   local t_boss = _G["Boss"..i.."TargetFrame"]
   t_boss:UnregisterAllEvents()
   t_boss.Show = dummy
   t_boss:Hide()
   _G["Boss"..i.."TargetFrame".."HealthBar"]:UnregisterAllEvents()
   _G["Boss"..i.."TargetFrame".."ManaBar"]:UnregisterAllEvents()
end

if db.oUF.Boss.Enable == true then
	local boss = {}
	for i = 1, MAX_BOSS_FRAMES do
	   boss[i] = oUF:Spawn("boss"..i, "oUF_Boss"..i)
	   if i == 1 then
		  boss[i]:SetPoint("RIGHT", UIParent, "RIGHT", cfg.bossX, cfg.bossY)
	   else
		  boss[i]:SetPoint('RIGHT', boss[i-1], 'RIGHT', 0, -tonumber(db.oUF.Boss.Padding))             
	   end
	end
end

function ShowBossFrames()
	for k, v in next, oUF.objects do
		if v.unit == "boss1" or v.unit == "boss2" or v.unit == "boss3" or v.unit == "boss4" then
			v.unit = "player"
			v.Hide = function() return end
			v.Range = false
			v:PLAYER_ENTERING_WORLD('PLAYER_ENTERING_WORLD')
			v:Show()
		end
	end
end





