--[[
-- Buu.lua - based on the Buu layout from aUF_Layouts
-- Contributed by PProvost <peter@provost.org>
--
-- NOTE: This layout looks best with the following settings:
-- 			Height=110
-- 			Width=80
-- 			Portrait=Enabled
-- 			ClassText=Custom "[classification][difficultycolor][level][white] [classcolor][smartclass]"
--
-- TODO:
-- 	* Option for aura positioning
-- 	* Option for combo point positioning
--
--]]

local VERSION = tonumber(('$Revision: 35217 $'):match('%d+'))

local PitBull = PitBull
if PitBull.revision < VERSION then
	PitBull.version = 'r' .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ('$Date: 2007-05-12 09:27:43 -0400 (Sat, 12 May 2007) $'):match('%d%d%d%d%-%d%d%-%d%d')
end

-- Todo: Make this a user setting?
local margins = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0
}

PitBull:RegisterLayout("Buu", {
	healthBar = function(unit,frame)
		local vunit = (frame:GetHeight() -10) / 10

		if not frame.powerBar then
			frame.healthBar:SetPoint("BOTTOM", frame, "BOTTOM", 0, margins.bottom)
		else
			frame.healthBar:SetPoint("BOTTOM", frame.powerBar, "TOP", 0, 0)
		end
		frame.healthBar:SetPoint("LEFT", frame, "LEFT", margins.left, 0)
		frame.healthBar:SetPoint("RIGHT", frame, "RIGHT", margins.right, 0)

		frame.healthBar:SetHeight(1*vunit)
	end,

	powerBar = function(unit,frame)
		local vunit = (frame:GetHeight() -10) / 10

		frame.powerBar:SetPoint("BOTTOM", frame, "BOTTOM", 0, margins.bottom)
		frame.powerBar:SetPoint("LEFT", frame, "LEFT", margins.left, 0)
		frame.powerBar:SetPoint("RIGHT", frame, "RIGHT", margins.right, 0)
		
		frame.powerBar:SetHeight(1*vunit)
	end,

	healthText = function(unit,frame)
		if frame.healthBar then
			frame.healthText:SetPoint("CENTER", frame.healthBar, "CENTER", -3, 0)
		end
	end,

	powerText = function(unit,frame)
		if frame.powerBar then
			frame.powerText:SetPoint("CENTER", frame.powerBar, "CENTER", -3, 0)
		end
	end,

	nameText = function(unit,frame)
		local vunit = (frame:GetHeight() -10) / 10
		frame.nameText:SetFontObject(GameFontHighlight)
		frame.nameText:SetPoint("TOPLEFT", frame, "TOPLEFT", 3, -3)
		frame.nameText:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -3, -2*vunit)
		frame.nameText:SetJustifyV("TOP")
	end,

	classText = function(unit,frame)
		local vunit = (frame:GetHeight() -10) / 10
		if frame.portrait then
			frame.classText:SetPoint("BOTTOMLEFT", frame.portrait, "BOTTOMLEFT", 3, 3)
			frame.classText:SetPoint("TOPRIGHT", frame.portrait, "BOTTOMRIGHT", -3, 2*vunit)
			frame.classText:SetJustifyV("BOTTOM")
		end
	end,

	auraFrame = function(unit,frame)
		local vunit = (frame:GetHeight() -10) / 10
		frame.auraFrame:SetPoint("BOTTOM", frame.auraFrame2, "TOP", 0, margins.top)
		frame.auraFrame:SetPoint("LEFT", frame, "LEFT", 0, 0)
		frame.auraFrame:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
		frame.auraFrame:SetHeight(1*vunit)
	end,

	auraFrame2 = function(unit,frame)
		local vunit = (frame:GetHeight() -10) / 10
		frame.auraFrame2:SetPoint("BOTTOM", frame, "TOP", 0, 0)
		frame.auraFrame2:SetPoint("LEFT", frame, "LEFT", 0, 0)
		frame.auraFrame2:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
		frame.auraFrame2:SetHeight(1*vunit)
	end,
	
	auraFrame_options = function() 
		-- Bogus
	end,

	portrait = function(unit,frame)
		frame.portrait:SetPoint("TOP", frame, "TOP", 0, margins.top)
		frame.portrait:SetPoint("LEFT", frame, "LEFT", margins.left, 0)
		frame.portrait:SetPoint("RIGHT", frame, "RIGHT", margins.right, 0)
		frame.portrait:SetPoint("BOTTOM", frame.healthBar, "TOP", 0, 0)
	end,

})


