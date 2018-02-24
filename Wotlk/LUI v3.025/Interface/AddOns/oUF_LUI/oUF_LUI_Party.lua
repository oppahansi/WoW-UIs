LUI = LibStub("AceAddon-3.0"):GetAddon("LUI")
db = LUI.db.profile

if db == nil then return end
if db.oUF.Settings.Enable ~= true then return end

local LSM = LibStub("LibSharedMedia-3.0")
local highlight = true

------------------------------------------------------------------------
--	Textures and Medias
------------------------------------------------------------------------

local fontn = [=[Interface\AddOns\SharedMedia_MyMedia\font\Russel Square LT.ttf]=]
local fontlol = [=[Interface\Addons\SharedMedia_MyMedia\font\vibrocen.ttf]=]
local font3 = [=[Interface\Addons\SharedMedia_MyMedia\font\Prototype.ttf]=]

local mediaPath = [=[Interface\Addons\oUF_LUI\media\]=]

local floor = math.floor
local format = string.format

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

------------------------------------------------------------------------
--	Don't edit this if you don't know what you are doing!
------------------------------------------------------------------------

local function menu(self)
	if(self.unit:match('party')) then
		ToggleDropDownMenu(1, nil, _G['PartyMemberFrame'..self.id..'DropDown'], 'cursor')
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

local PostUpdateHealth = function(self, event, unit, bar, min, max)
	local pClass, pToken = UnitClass(unit)
	local color = colors.class[pToken]
	local r, g, b
	
	r, g, b = oUF.ColorGradient(min/max, tonumber(db.oUF.Colors.Smooth.Smooth1.r),tonumber(db.oUF.Colors.Smooth.Smooth1.g), tonumber(db.oUF.Colors.Smooth.Smooth1.b),tonumber(db.oUF.Colors.Smooth.Smooth2.r),tonumber(db.oUF.Colors.Smooth.Smooth2.g),tonumber(db.oUF.Colors.Smooth.Smooth2.b),tonumber(db.oUF.Colors.Smooth.Smooth3.r),tonumber(db.oUF.Colors.Smooth.Smooth3.g),tonumber(db.oUF.Colors.Smooth.Smooth3.b))
	
	Party_Health_ColorClass = db.oUF.Party.Health.ColorClass
	Party_Health_IndividualColor = db.oUF.Party.Health.IndividualColor.Enable
	Party_Health_IndividualColor_r = db.oUF.Party.Health.IndividualColor.r
	Party_Health_IndividualColor_g = db.oUF.Party.Health.IndividualColor.g
	Party_Health_IndividualColor_b = db.oUF.Party.Health.IndividualColor.b
	Party_Health_ColorGradient = db.oUF.Party.Health.ColorGradient
	
	Party_Health_Value_Enable = db.oUF.Party.Texts.Health.Enable
	Party_Health_Value_Format = db.oUF.Party.Texts.Health.Format
	Party_Health_Value_ColorClass = db.oUF.Party.Texts.Health.ColorClass
	Party_Health_Value_ColorGradient = db.oUF.Party.Texts.Health.ColorGradient
	Party_Health_Value_IndividualColor_Enable = db.oUF.Party.Texts.Health.IndividualColor.Enable
	Party_Health_Value_IndividualColor_r = db.oUF.Party.Texts.Health.IndividualColor.r
	Party_Health_Value_IndividualColor_g = db.oUF.Party.Texts.Health.IndividualColor.g
	Party_Health_Value_IndividualColor_b = db.oUF.Party.Texts.Health.IndividualColor.b
	Party_Health_Value_ShowDead = db.oUF.Party.Texts.Health.ShowDead
	
	Party_Health_Percent_Enable = db.oUF.Party.Texts.HealthPercent.Enable
	Party_Health_Percent_ShowAlways = db.oUF.Party.Texts.HealthPercent.ShowAlways
	Party_Health_Percent_ColorClass = db.oUF.Party.Texts.HealthPercent.ColorClass
	Party_Health_Percent_ColorGradient = db.oUF.Party.Texts.HealthPercent.ColorGradient
	Party_Health_Percent_IndividualColor_Enable = db.oUF.Party.Texts.HealthPercent.IndividualColor.Enable
	Party_Health_Percent_IndividualColor_r = db.oUF.Party.Texts.HealthPercent.IndividualColor.r
	Party_Health_Percent_IndividualColor_g = db.oUF.Party.Texts.HealthPercent.IndividualColor.g
	Party_Health_Percent_IndividualColor_b = db.oUF.Party.Texts.HealthPercent.IndividualColor.b
	Party_Health_Percent_ShowDead = db.oUF.Party.Texts.HealthPercent.ShowDead
	
	Party_Health_Missing_Enable = db.oUF.Party.Texts.HealthMissing.Enable
	Party_Health_Missing_ShortValue = db.oUF.Party.Texts.HealthMissing.ShortValue
	Party_Health_Missing_ShowAlways = db.oUF.Party.Texts.HealthMissing.ShowAlways
	Party_Health_Missing_ColorClass = db.oUF.Party.Texts.HealthMissing.ColorClass
	Party_Health_Missing_ColorGradient = db.oUF.Party.Texts.HealthMissing.ColorGradient
	Party_Health_Missing_IndividualColor_Enable = db.oUF.Party.Texts.HealthMissing.IndividualColor.Enable
	Party_Health_Missing_IndividualColor_r = db.oUF.Party.Texts.HealthMissing.IndividualColor.r
	Party_Health_Missing_IndividualColor_g = db.oUF.Party.Texts.HealthMissing.IndividualColor.g
	Party_Health_Missing_IndividualColor_b = db.oUF.Party.Texts.HealthMissing.IndividualColor.b
	
	if Party_Health_ColorClass == true then
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
	elseif Party_Health_IndividualColor == true then
		self.Health:SetStatusBarColor(Party_Health_IndividualColor_r, Party_Health_IndividualColor_g, Party_Health_IndividualColor_b)
		local bg = self.Health.bg
		local mu = bg.multiplier or 1
		bg:SetVertexColor(Party_Health_IndividualColor_r*mu, Party_Health_IndividualColor_g*mu, Party_Health_IndividualColor_b*mu)
	elseif Party_Health_ColorGradient == true then
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
		
		if Party_Health_Value_ShowDead == true then
			bar.value:SetText("|cffD7BEA5Offline|r")
		else
			bar.value:SetText()
		end
		
		if Party_Health_Percent_ShowDead == true then
			bar.valuePercent:SetText("|cffD7BEA5Offline|r")
		else
			bar.valuePercent:SetText()
		end
	elseif UnitIsDead(unit) then
		bar:SetValue(0)
		bar.valueMissing:SetText()
		
		if Party_Health_Value_ShowDead == true then
			bar.value:SetText("|cffD7BEA5Dead|r")
		else
			bar.value:SetText()
		end
		
		if Party_Health_Percent_ShowDead == true then
			bar.valuePercent:SetText("|cffD7BEA5Dead|r")
		else
			bar.valuePercent:SetText()
		end
	elseif UnitIsGhost(unit) then
		bar:SetValue(0)
		bar.valueMissing:SetText()
		
		if Party_Health_Value_ShowDead == true then
			bar.value:SetText("|cffD7BEA5Ghost|r")
		else
			bar.value:SetText()
		end
		
		if Party_Health_Percent_ShowDead == true then
			bar.valuePercent:SetText("|cffD7BEA5Ghost|r")
		else
			bar.valuePercent:SetText()
		end
	else
		local healthPercent = 100 * min / max
		healthPercent = string.format("%.1f", healthPercent)
		healthPercent = healthPercent.."%"
	
		if Party_Health_Value_Enable == true then
			bar.value:Show()
			
			if Party_Health_Value_Format == "Absolut" then
				bar.value:SetFormattedText("%s/%s",min,max)
			elseif Party_Health_Value_Format == "Absolut & Percent" then
				bar.value:SetFormattedText("%s/%s | %s",min,max,healthPercent)
			elseif Party_Health_Value_Format == "Absolut Short" then
				bar.value:SetFormattedText("%s/%s",ShortValue(min),ShortValue(max))
			elseif Party_Health_Value_Format == "Absolut Short & Percent" then
				bar.value:SetFormattedText("%s/%s | %s",ShortValue(min),ShortValue(max),healthPercent)
			elseif Party_Health_Value_Format == "Standard" then
				bar.value:SetText(min)
			elseif Party_Health_Value_Format == "Standard Short" then
				bar.value:SetText(ShortValue(min))
			else
				bar.value:SetText(min)
			end
			
			if Party_Health_Value_ColorClass == true then
				if color then
					bar.value:SetTextColor(color[1],color[2],color[3])
				else
					bar.value:SetTextColor(0, 0, 0)
				end
			elseif Party_Health_Value_ColorGradient == true then
				bar.value:SetTextColor(r,g,b)
			elseif Party_Health_Value_IndividualColor_Enable == true then
				bar.value:SetTextColor(Party_Health_Value_IndividualColor_r, Party_Health_Value_IndividualColor_g, Party_Health_Value_IndividualColor_b)
			end
		else
			bar.value:SetText()
			bar.value:Hide()
		end
		
		if Party_Health_Percent_Enable == true then
			bar.valuePercent:SetText(healthPercent)
			
			if Party_Health_Percent_ShowAlways == true then
				bar.valuePercent:Show()
			else
				if min ~= max then
					bar.valuePercent:Show()
				else
					bar.valuePercent:Hide()
				end
			end
			
			if Party_Health_Percent_ColorClass == true then
				if color then
					bar.valuePercent:SetTextColor(color[1],color[2],color[3])
				else
					bar.valuePercent:SetTextColor(0, 0, 0)
				end
			elseif Party_Health_Percent_ColorGradient == true then
				bar.valuePercent:SetTextColor(r,g,b)
			elseif Party_Health_Percent_IndividualColor_Enable == true then
				bar.valuePercent:SetTextColor(Party_Health_Percent_IndividualColor_r, Party_Health_Percent_IndividualColor_g, Party_Health_Percent_IndividualColor_b)
			end
		else
			bar.valuePercent:SetText()
			bar.valuePercent:Hide()
		end
		
		if Party_Health_Missing_Enable == true then
			local healthMissing = max-min
			
			if Party_Health_Missing_ShortValue == true then
				bar.valueMissing:SetText("-"..ShortValue(healthMissing))
			else
				bar.valueMissing:SetText("-"..healthMissing)
			end
			
			if Party_Health_Missing_ShowAlways == true then
				bar.valueMissing:Show()
			else
				if healthMissing > 0 then
					bar.valueMissing:Show()
				else
					bar.valueMissing:Hide()
				end
			end

			if Party_Health_Missing_ColorClass == true then
				if color then
					bar.valueMissing:SetTextColor(color[1],color[2],color[3])
				else
					bar.valueMissing:SetTextColor(0, 0, 0)
				end
			elseif Party_Health_Missing_ColorGradient == true then
				bar.valueMissing:SetTextColor(r,g,b)
			elseif Party_Health_Missing_IndividualColor_Enable == true then
				bar.valueMissing:SetTextColor(Party_Health_Missing_IndividualColor_r, Party_Health_Missing_IndividualColor_g, Party_Health_Missing_IndividualColor_b)
			end
		else
			bar.valueMissing:SetText()
			bar.valueMissing:Hide()
		end
	end
end

local OverrideUpdatePower = function(self, event, unit, bar, min, max)
	if(self.unit ~= unit) then return end
	local _, pType = UnitPowerType(unit)
	local pClass, pToken = UnitClass(unit)
	local color = colors.class[pToken]
	local color2 = colors.power[pType]
	
	Power_ColorClass = db.oUF.Party.Power.ColorClass
	Power_IndividualColor = db.oUF.Party.Power.IndividualColor.Enable
	Power_IndividualColor_r = db.oUF.Party.Power.IndividualColor.r
	Power_IndividualColor_g = db.oUF.Party.Power.IndividualColor.g
	Power_IndividualColor_b = db.oUF.Party.Power.IndividualColor.b
	Power_ColorType = db.oUF.Party.Power.ColorType
	
	Power_Value_Enable = db.oUF.Party.Texts.Power.Enable
	Power_Value_Format = db.oUF.Party.Texts.Power.Format
	Power_Value_ColorClass = db.oUF.Party.Texts.Power.ColorClass
	Power_Value_ColorType = db.oUF.Party.Texts.Power.ColorType
	Power_Value_IndividualColor_Enable = db.oUF.Party.Texts.Power.IndividualColor.Enable
	Power_Value_IndividualColor_r = db.oUF.Party.Texts.Power.IndividualColor.r
	Power_Value_IndividualColor_g = db.oUF.Party.Texts.Power.IndividualColor.g
	Power_Value_IndividualColor_b = db.oUF.Party.Texts.Power.IndividualColor.b
	
	Power_Percent_Enable = db.oUF.Party.Texts.PowerPercent.Enable
	Power_Percent_ShowAlways = db.oUF.Party.Texts.PowerPercent.ShowAlways
	Power_Percent_ColorClass = db.oUF.Party.Texts.PowerPercent.ColorClass
	Power_Percent_ColorType = db.oUF.Party.Texts.PowerPercent.ColorType
	Power_Percent_IndividualColor_Enable = db.oUF.Party.Texts.PowerPercent.IndividualColor.Enable
	Power_Percent_IndividualColor_r = db.oUF.Party.Texts.PowerPercent.IndividualColor.r
	Power_Percent_IndividualColor_g = db.oUF.Party.Texts.PowerPercent.IndividualColor.g
	Power_Percent_IndividualColor_b = db.oUF.Party.Texts.PowerPercent.IndividualColor.b
	
	Power_Missing_Enable = db.oUF.Party.Texts.PowerMissing.Enable
	Power_Missing_ShortValue = db.oUF.Party.Texts.PowerMissing.ShortValue
	Power_Missing_ShowAlways = db.oUF.Party.Texts.PowerMissing.ShowAlways
	Power_Missing_ColorClass = db.oUF.Party.Texts.PowerMissing.ColorClass
	Power_Missing_ColorType = db.oUF.Party.Texts.PowerMissing.ColorType
	Power_Missing_IndividualColor_Enable = db.oUF.Party.Texts.PowerMissing.IndividualColor.Enable
	Power_Missing_IndividualColor_r = db.oUF.Party.Texts.PowerMissing.IndividualColor.r
	Power_Missing_IndividualColor_g = db.oUF.Party.Texts.PowerMissing.IndividualColor.g
	Power_Missing_IndividualColor_b = db.oUF.Party.Texts.PowerMissing.IndividualColor.b
	
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
	
		
		if Power_Value_Enable == true then
			bar.value:Show()
			
			if Power_Value_Format == "Absolut" then
				bar.value:SetFormattedText("%s/%s",min,max)
			elseif Power_Value_Format == "Absolut & Percent" then
				bar.value:SetFormattedText("%s/%s | %s",min,max,healthPercent)
			elseif Power_Value_Format == "Absolut Short" then
				bar.value:SetFormattedText("%s/%s",ShortValue(min),ShortValue(max))
			elseif Power_Value_Format == "Absolut Short & Percent" then
				bar.value:SetFormattedText("%s/%s | %s",ShortValue(min),ShortValue(max),healthPercent)
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
	
	Power_ColorClass = db.oUF.Party.Power.ColorClass
	Power_IndividualColor = db.oUF.Party.Power.IndividualColor.Enable
	Power_IndividualColor_r = db.oUF.Party.Power.IndividualColor.r
	Power_IndividualColor_g = db.oUF.Party.Power.IndividualColor.g
	Power_IndividualColor_b = db.oUF.Party.Power.IndividualColor.b
	Power_ColorType = db.oUF.Party.Power.ColorType
	
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
	
	Power_ColorClass = db.oUF.Party.Power.ColorClass
	Power_IndividualColor = db.oUF.Party.Power.IndividualColor.Enable
	Power_IndividualColor_r = db.oUF.Party.Power.IndividualColor.r
	Power_IndividualColor_g = db.oUF.Party.Power.IndividualColor.g
	Power_IndividualColor_b = db.oUF.Party.Power.IndividualColor.b
	Power_ColorType = db.oUF.Party.Power.ColorType
	
	Power_Value_Enable = db.oUF.Party.Texts.Power.Enable
	Power_Value_Format = db.oUF.Party.Texts.Power.Format
	Power_Value_ColorClass = db.oUF.Party.Texts.Power.ColorClass
	Power_Value_ColorType = db.oUF.Party.Texts.Power.ColorType
	Power_Value_IndividualColor_Enable = db.oUF.Party.Texts.Power.IndividualColor.Enable
	Power_Value_IndividualColor_r = db.oUF.Party.Texts.Power.IndividualColor.r
	Power_Value_IndividualColor_g = db.oUF.Party.Texts.Power.IndividualColor.g
	Power_Value_IndividualColor_b = db.oUF.Party.Texts.Power.IndividualColor.b
	
	Power_Percent_Enable = db.oUF.Party.Texts.PowerPercent.Enable
	Power_Percent_ShowAlways = db.oUF.Party.Texts.PowerPercent.ShowAlways
	Power_Percent_ColorClass = db.oUF.Party.Texts.PowerPercent.ColorClass
	Power_Percent_ColorType = db.oUF.Party.Texts.PowerPercent.ColorType
	Power_Percent_IndividualColor_Enable = db.oUF.Party.Texts.PowerPercent.IndividualColor.Enable
	Power_Percent_IndividualColor_r = db.oUF.Party.Texts.PowerPercent.IndividualColor.r
	Power_Percent_IndividualColor_g = db.oUF.Party.Texts.PowerPercent.IndividualColor.g
	Power_Percent_IndividualColor_b = db.oUF.Party.Texts.PowerPercent.IndividualColor.b
	
	Power_Missing_Enable = db.oUF.Party.Texts.PowerMissing.Enable
	Power_Missing_ShortValue = db.oUF.Party.Texts.PowerMissing.ShortValue
	Power_Missing_ShowAlways = db.oUF.Party.Texts.PowerMissing.ShowAlways
	Power_Missing_ColorClass = db.oUF.Party.Texts.PowerMissing.ColorClass
	Power_Missing_ColorType = db.oUF.Party.Texts.PowerMissing.ColorType
	Power_Missing_IndividualColor_Enable = db.oUF.Party.Texts.PowerMissing.IndividualColor.Enable
	Power_Missing_IndividualColor_r = db.oUF.Party.Texts.PowerMissing.IndividualColor.r
	Power_Missing_IndividualColor_g = db.oUF.Party.Texts.PowerMissing.IndividualColor.g
	Power_Missing_IndividualColor_b = db.oUF.Party.Texts.PowerMissing.IndividualColor.b
	
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
	
		
		if Power_Value_Enable == true then
			bar.value:Show()
			
			if Power_Value_Format == "Absolut" then
				bar.value:SetFormattedText("%s/%s",min,max)
			elseif Power_Value_Format == "Absolut & Percent" then
				bar.value:SetFormattedText("%s/%s | %s",min,max,healthPercent)
			elseif Power_Value_Format == "Absolut Short" then
				bar.value:SetFormattedText("%s/%s",ShortValue(min),ShortValue(max))
			elseif Power_Value_Format == "Absolut Short & Percent" then
				bar.value:SetFormattedText("%s/%s | %s",ShortValue(min),ShortValue(max),healthPercent)
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
	elseif s >= minute / 12 then
		return floor(s + 1), s - floor(s)
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
				self.remaining:SetText(time)

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
	
	if db.oUF.auras.party.buffs_auratimer == false then
		button.remaining:Hide()
	end
end

local UpdateAura = function(self, icons, unit, icon, index)
	local _, _, _, _, _, duration, expirationTime, unitCaster, _ = UnitAura(unit, index, icon.filter)

	if icon.debuff and db.oUF.auras.party.debuffs_colorbytype == false then
		icon.overlay:SetVertexColor(1, 1, 1)
	elseif icon.debuff and db.oUF.auras.party.debuffs_colorbytype == true then
		-- do nothing, color by type
	else
		icon.overlay:SetVertexColor(1, 1, 1)
	end

	if duration and duration > 0 then
		if db.oUF.auras.party.debuffs_auratimer == true then
			icon.remaining:Show()
		else
			icon.remaining:Hide()
		end
	else
		icon.remaining:Hide()
	end

	icon.duration = duration
	icon.timeLeft = expirationTime
	icon.first = true
	icon:SetScript("OnUpdate", CreateAuraTimer)
end

local function CreateStyle(self, unit)
	self.menu = menu
	self.colors = colors
	self:RegisterForClicks('AnyUp')
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	
	self:SetAttribute('*type2', 'menu')

	self.Health = CreateFrame("StatusBar", self:GetName().."_Health", self)
	self.Power = CreateFrame("StatusBar", self:GetName().."_Power", self)
	self.Full = CreateFrame("StatusBar", self:GetName().."_Full", self)
	
	self.Full:SetFrameLevel(2)
	self.Power:SetFrameLevel(2)
	self.Health:SetFrameLevel(2)

	Fullbar_Enable = db.oUF.Party.Full.Enable
	Fullbar_Height = tonumber(db.oUF.Party.Full.Height)
	Fullbar_Texture = LSM:Fetch("statusbar", db.oUF.Party.Full.Texture)
	Fullbar_Padding = tonumber(db.oUF.Party.Full.Padding)
	Fullbar_Alpha = db.oUF.Party.Full.Alpha
	Fullbar_Color_r = tonumber(db.oUF.Party.Full.Color.r)
	Fullbar_Color_g = tonumber(db.oUF.Party.Full.Color.g)
	Fullbar_Color_b = tonumber(db.oUF.Party.Full.Color.b)
	Fullbar_Color_a = tonumber(db.oUF.Party.Full.Color.a)

	FrameHeight = tonumber(db.oUF.Party.Height)
	FrameWidth = tonumber(db.oUF.Party.Width)
	HealthHeight = tonumber(db.oUF.Party.Health.Height)
	PowerHeight = tonumber(db.oUF.Party.Power.Height)
	ShowPower = db.oUF.Party.Power.Enable
	
	HealthPadding =  tonumber(db.oUF.Party.Health.Padding)
	PowerPadding = tonumber(db.oUF.Party.Power.Padding)
	
	HealthTexture = LSM:Fetch("statusbar", db.oUF.Party.Health.Texture)
	HealthTextureBG = LSM:Fetch("statusbar", db.oUF.Party.Health.TextureBG)
	HealthTextureBGAlpha = tonumber(db.oUF.Party.Health.BGAlpha)
	HealthTextureBGMP = tonumber(db.oUF.Party.Health.BGMultiplier)
	
	PowerTexture = LSM:Fetch("statusbar", db.oUF.Party.Power.Texture)
	PowerTextureBG = LSM:Fetch("statusbar", db.oUF.Party.Power.TextureBG)
	PowerTextureBGAlpha = tonumber(db.oUF.Party.Power.BGAlpha)
	PowerTextureBGMP = tonumber(db.oUF.Party.Power.BGMultiplier)
	
	Health_colorClass = db.oUF.Party.Health.ColorClass
	Health_colorTapping = false
	Health_colorDisconnected = false
	Health_colorSmooth = db.oUF.Party.Health.ColorGradient
	Health_Smooth = db.oUF.Party.Health.Smooth
	Health_colorReaction = false
	Health_frequentUpdates = false
	Health_OverrideUpdateHealth = true
	
	Power_colorDisconnected = false
	Power_colorType = db.oUF.Party.Power.ColorType
	Power_colorClass = db.oUF.Party.Power.ColorClass
	Power_Smooth = db.oUF.Party.Power.Smooth
	Power_colorSmooth = false
	Power_OverrideUpdatePower = true
	Power_colorReaction = false
	Power_frequentUpdates = true
	
	Info_Font = LSM:Fetch("font", db.oUF.Party.Texts.Name.Font)
	Info_Size = tonumber(db.oUF.Party.Texts.Name.Size)
	Info_Style = db.oUF.Party.Texts.Name.Outline
	Info_Point = db.oUF.Party.Texts.Name.Point
	Info_RelativePoint = db.oUF.Party.Texts.Name.RelativePoint
	Info_X = tonumber(db.oUF.Party.Texts.Name.X)
	Info_Y = tonumber(db.oUF.Party.Texts.Name.Y)
	Info_Format = db.oUF.Party.Texts.Name.Format
	Info_NameLength = db.oUF.Party.Texts.Name.Length
	Info_ColorNameByClass = db.oUF.Party.Texts.Name.ColorNameByClass
	Info_ColorClassByClass = db.oUF.Party.Texts.Name.ColorClassByClass
	Info_ColorLevelByDifficulty = db.oUF.Party.Texts.Name.ColorLevelByDifficulty
	Info_ShowClassification = db.oUF.Party.Texts.Name.ShowClassification
	Info_ShortClassification = db.oUF.Party.Texts.Name.ShortClassification
	
	Health_Value_Font = LSM:Fetch("font", db.oUF.Party.Texts.Health.Font)
	Health_Value_Size = tonumber(db.oUF.Party.Texts.Health.Size)
	Health_Value_Style = db.oUF.Party.Texts.Health.Outline
	Health_Value_Point = db.oUF.Party.Texts.Health.Point
	Health_Value_RelativePoint = db.oUF.Party.Texts.Health.RelativePoint
	Health_Value_X = tonumber(db.oUF.Party.Texts.Health.X)
	Health_Value_Y = tonumber(db.oUF.Party.Texts.Health.Y)
	
	Health_Percent_Font = LSM:Fetch("font", db.oUF.Party.Texts.HealthPercent.Font)
	Health_Percent_Size = tonumber(db.oUF.Party.Texts.HealthPercent.Size)
	Health_Percent_Style = db.oUF.Party.Texts.HealthPercent.Outline
	Health_Percent_Point = db.oUF.Party.Texts.HealthPercent.Point
	Health_Percent_RelativePoint = db.oUF.Party.Texts.HealthPercent.RelativePoint
	Health_Percent_X = tonumber(db.oUF.Party.Texts.HealthPercent.X)
	Health_Percent_Y = tonumber(db.oUF.Party.Texts.HealthPercent.Y)
	
	Health_Missing_Font = LSM:Fetch("font", db.oUF.Party.Texts.HealthMissing.Font)
	Health_Missing_Size = tonumber(db.oUF.Party.Texts.HealthMissing.Size)
	Health_Missing_Style = db.oUF.Party.Texts.HealthMissing.Outline
	Health_Missing_Point = db.oUF.Party.Texts.HealthMissing.Point
	Health_Missing_RelativePoint = db.oUF.Party.Texts.HealthMissing.RelativePoint
	Health_Missing_X = tonumber(db.oUF.Party.Texts.HealthMissing.X)
	Health_Missing_Y = tonumber(db.oUF.Party.Texts.HealthMissing.Y)
	
	Power_Value_Font = LSM:Fetch("font", db.oUF.Party.Texts.Power.Font)
	Power_Value_Size = tonumber(db.oUF.Party.Texts.Power.Size)
	Power_Value_Style = db.oUF.Party.Texts.Power.Outline
	Power_Value_Point = db.oUF.Party.Texts.Power.Point
	Power_Value_RelativePoint = db.oUF.Party.Texts.Power.RelativePoint
	Power_Value_X = tonumber(db.oUF.Party.Texts.Power.X)
	Power_Value_Y = tonumber(db.oUF.Party.Texts.Power.Y)
	
	Power_Percent_Font = LSM:Fetch("font", db.oUF.Party.Texts.PowerPercent.Font)
	Power_Percent_Size = tonumber(db.oUF.Party.Texts.PowerPercent.Size)
	Power_Percent_Style = db.oUF.Party.Texts.PowerPercent.Outline
	Power_Percent_Point = db.oUF.Party.Texts.PowerPercent.Point
	Power_Percent_RelativePoint = db.oUF.Party.Texts.PowerPercent.RelativePoint
	Power_Percent_X = tonumber(db.oUF.Party.Texts.PowerPercent.X)
	Power_Percent_Y = tonumber(db.oUF.Party.Texts.PowerPercent.Y)
	
	Power_Missing_Font = LSM:Fetch("font", db.oUF.Party.Texts.PowerMissing.Font)
	Power_Missing_Size = tonumber(db.oUF.Party.Texts.PowerMissing.Size)
	Power_Missing_Style = db.oUF.Party.Texts.PowerMissing.Outline
	Power_Missing_Point = db.oUF.Party.Texts.PowerMissing.Point
	Power_Missing_RelativePoint = db.oUF.Party.Texts.PowerMissing.RelativePoint
	Power_Missing_X = tonumber(db.oUF.Party.Texts.PowerMissing.X)
	Power_Missing_Y = tonumber(db.oUF.Party.Texts.PowerMissing.Y)
	
	ShowInfo = db.oUF.Party.Texts.Name.Enable
	
	ShowHealthValue = db.oUF.Party.Texts.Health.Enable
	ShowHealthPercent = db.oUF.Party.Texts.HealthPercent.Enable
	ShowHealthMissing = db.oUF.Party.Texts.HealthMissing.Enable
	
	ShowPowerValue = db.oUF.Party.Texts.Power.Enable
	ShowPowerPercent = db.oUF.Party.Texts.PowerPercent.Enable
	ShowPowerMissing = db.oUF.Party.Texts.PowerMissing.Enable
	
	Icon_Leader_Enable = db.oUF.Party.Icons.Leader.Enable
	Icon_Leader_Size = db.oUF.Party.Icons.Leader.Size
	Icon_Leader_Point = db.oUF.Party.Icons.Leader.Point
	Icon_Leader_X = db.oUF.Party.Icons.Leader.X
	Icon_Leader_Y = db.oUF.Party.Icons.Leader.Y
	
	Icon_Lootmaster_Enable = db.oUF.Party.Icons.Lootmaster.Enable
	Icon_Lootmaster_Size = db.oUF.Party.Icons.Lootmaster.Size
	Icon_Lootmaster_Point = db.oUF.Party.Icons.Lootmaster.Point
	Icon_Lootmaster_X = db.oUF.Party.Icons.Lootmaster.X
	Icon_Lootmaster_Y = db.oUF.Party.Icons.Lootmaster.Y
	
	Icon_Raid_Enable = db.oUF.Party.Icons.Raid.Enable == true
	Icon_Raid_Size = db.oUF.Party.Icons.Raid.Size
	Icon_Raid_Point = db.oUF.Party.Icons.Raid.Point
	Icon_Raid_X = db.oUF.Party.Icons.Raid.X
	Icon_Raid_Y = db.oUF.Party.Icons.Raid.Y
	
	Icon_Role_Enable = db.oUF.Party.Icons.Role.Enable
	Icon_Role_Size = db.oUF.Party.Icons.Role.Size
	Icon_Role_Point = db.oUF.Party.Icons.Role.Point
	Icon_Role_X = db.oUF.Party.Icons.Role.X
	Icon_Role_Y = db.oUF.Party.Icons.Role.Y
	
	Icon_Resting_Enable = db.oUF.Party.Icons.Resting.Enable
	Icon_Resting_Size = db.oUF.Party.Icons.Resting.Size
	Icon_Resting_Point = db.oUF.Party.Icons.Resting.Point
	Icon_Resting_X = db.oUF.Party.Icons.Resting.X
	Icon_Resting_Y = db.oUF.Party.Icons.Resting.Y
	
	Icon_Combat_Enable = db.oUF.Party.Icons.Combat.Enable
	Icon_Combat_Size = db.oUF.Party.Icons.Combat.Size
	Icon_Combat_Point = db.oUF.Party.Icons.Combat.Point
	Icon_Combat_X = db.oUF.Party.Icons.Combat.X
	Icon_Combat_Y = db.oUF.Party.Icons.Combat.Y
	
	Icon_PvP_Enable = db.oUF.Party.Icons.PvP.Enable
	Icon_PvP_Size = db.oUF.Party.Icons.PvP.Size
	Icon_PvP_Point = db.oUF.Party.Icons.PvP.Point
	Icon_PvP_X = db.oUF.Party.Icons.PvP.X
	Icon_PvP_Y = db.oUF.Party.Icons.PvP.Y
	
	Portrait_Enable = db.oUF.Party.Portrait.Enable
	Portrait_Width = db.oUF.Party.Portrait.Width
	Portrait_Height = db.oUF.Party.Portrait.Height
	Portrait_X = db.oUF.Party.Portrait.X
	Portrait_Y = db.oUF.Party.Portrait.Y

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
	
	------------------------------------------------------------------------
	--	Background texture and textures border
	------------------------------------------------------------------------

	self.FrameBackdrop = CreateFrame("Frame", nil, self)
	self.FrameBackdrop:SetPoint("TOPLEFT", self, "TOPLEFT", tonumber(db.oUF.Party.Backdrop.Padding.Left), tonumber(db.oUF.Party.Backdrop.Padding.Top))
	self.FrameBackdrop:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", tonumber(db.oUF.Party.Backdrop.Padding.Right), tonumber(db.oUF.Party.Backdrop.Padding.Bottom))
	self.FrameBackdrop:SetFrameStrata("BACKGROUND")
	self.FrameBackdrop:SetBackdrop({
		bgFile = LSM:Fetch("background", db.oUF.Party.Backdrop.Texture),
		edgeFile = LSM:Fetch("border", db.oUF.Party.Border.EdgeFile),
		edgeSize = tonumber(db.oUF.Party.Border.EdgeSize),
		insets = {
			left = tonumber(db.oUF.Party.Border.Insets.Left),
			right = tonumber(db.oUF.Party.Border.Insets.Right),
			top = tonumber(db.oUF.Party.Border.Insets.Top),
			bottom = tonumber(db.oUF.Party.Border.Insets.Bottom)
		}
	})
	self.FrameBackdrop:SetBackdropColor(tonumber(db.oUF.Party.Backdrop.Color.r),tonumber(db.oUF.Party.Backdrop.Color.g),tonumber(db.oUF.Party.Backdrop.Color.b),tonumber(db.oUF.Party.Backdrop.Color.a))
	self.FrameBackdrop:SetBackdropBorderColor(tonumber(db.oUF.Party.Border.Color.r), tonumber(db.oUF.Party.Border.Color.g), tonumber(db.oUF.Party.Border.Color.b), tonumber(db.oUF.Party.Border.Color.a))
	
	------------------------------------------------------------------------
	--	Auras
	------------------------------------------------------------------------
	
	if db.oUF.auras.party.debuffs_enable then
		self.Debuffs = CreateFrame("Frame", nil, self)
		self.Debuffs:SetHeight(tonumber(db.oUF.auras.party.debuffs_size))
		self.Debuffs:SetWidth(tonumber(db.oUF.Party.Width))
		self.Debuffs.size = tonumber(db.oUF.auras.party.debuffs_size)
		self.Debuffs.spacing = tonumber(db.oUF.auras.party.debuffs_spacing)
		self.Debuffs.num = tonumber(db.oUF.auras.party.debuffs_num)
		self.Debuffs.numDebuffs = tonumber(db.oUF.auras.party.debuffs_num)
		
		self.Debuffs:SetPoint(db.oUF.auras.party.debuffs_initialAnchor, self.Health, db.oUF.auras.party.debuffs_initialAnchor, tonumber(db.oUF.auras.party.debuffsX), tonumber(db.oUF.auras.party.debuffsY))
		self.Debuffs.initialAnchor = db.oUF.auras.party.debuffs_initialAnchor
		self.Debuffs["growth-y"] = db.oUF.auras.party.debuffs_growthY
		self.Debuffs["growth-x"] = db.oUF.auras.party.debuffs_growthX
	end
	
	if db.oUF.auras.party.buffs_enable then
		self.Buffs = CreateFrame("Frame", nil, self)
		self.Buffs:SetHeight(tonumber(db.oUF.auras.party.buffs_size))
		self.Buffs:SetWidth(tonumber(db.oUF.Party.Width))
		self.Buffs.size = tonumber(db.oUF.auras.party.buffs_size)
		self.Buffs.spacing = tonumber(db.oUF.auras.party.buffs_spacing)
		self.Buffs.num = tonumber(db.oUF.auras.party.buffs_num)
		self.Buffs.numDebuffs = tonumber(db.oUF.auras.party.buffs_num)
		self.Buffs.onlyShowPlayer = db.oUF.auras.party.buffs_playeronly
		
		self.Buffs:SetPoint(db.oUF.auras.party.buffs_initialAnchor, self.Health, db.oUF.auras.party.buffs_initialAnchor, tonumber(db.oUF.auras.party.buffsX), tonumber(db.oUF.auras.party.buffsY))
		self.Buffs.initialAnchor = db.oUF.auras.party.buffs_initialAnchor
		self.Buffs["growth-y"] = db.oUF.auras.party.buffs_growthY
		self.Buffs["growth-x"] = db.oUF.auras.party.buffs_growthX
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

	self.outsideRangeAlpha = 0.5
	self.inRangeAlpha = 1
	self.SpellRange = true
	self.BarFade = false
	
	self.PostCreateAuraIcon = CreateAura
	self.PostUpdateHealth = PostUpdateHealth
	self.PostUpdateAuraIcon = UpdateAura
	self.Range = true
	
	self.PreUpdatePower = PreUpdatePower
	self.PostUpdatePower = PostUpdatePower
	self.OverrideUpdatePower = OverrideUpdatePower
end

oUF:RegisterStyle('Party', CreateStyle)
oUF:SetActiveStyle('Party')

party = oUF:Spawn("header", "oUF_LUI_party")
party:SetPoint("LEFT", UIParent, "LEFT", db.oUF.Party.X, db.oUF.Party.Y)
party:SetAttribute("showParty", db.oUF.Party.Enable)
party:SetAttribute("showPlayer", db.oUF.Party.ShowPlayer)
party:SetAttribute("yOffset", -db.oUF.Party.Padding)

local partyToggle = CreateFrame("Frame")
partyToggle:RegisterEvent("PLAYER_LOGIN")
partyToggle:RegisterEvent("RAID_ROSTER_UPDATE")
partyToggle:RegisterEvent("PARTY_LEADER_CHANGED")
partyToggle:RegisterEvent("PARTY_MEMBERS_CHANGED")
partyToggle:SetScript("OnEvent", function(self)
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
	else
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
      
		if not db.oUF.Party.ShowInRaid then
			local numraid = GetNumRaidMembers()
			if numraid > 0 and (numraid > 5 or numraid ~= GetNumPartyMembers() + 1) then
				party:Hide()                  
		 	else
				party:Show()                  
		 	end
		else
		 	party:Show()
		end
	end
end)











