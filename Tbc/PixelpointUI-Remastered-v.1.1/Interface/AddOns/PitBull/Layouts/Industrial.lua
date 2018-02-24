local TL, TC, TR = 'TOPLEFT', 'TOP', 'TOPRIGHT'
local ML, MC, MR = 'LEFT', 'CENTER', 'RIGHT'
local BL, BC, BR = 'BOTTOMLEFT', 'BOTTOM', 'BOTTOMRIGHT'

PitBull:RegisterLayout('Industrial', {
	-- bars
	healthBar = function(unit, frame)
		frame.healthBar:SetPoint(TL, frame, TL, 5, -5)
		if not frame.powerBar then
			frame.healthBar:SetPoint(BR, frame, BR, 0, 5)
		else
			frame.healthBar:SetPoint(BR, frame, BC, 0, 5)
		end
	end,
	powerBar = function(unit, frame)
		frame.powerBar:SetPoint(TL, frame, TC, 0, -5)
		frame.powerBar:SetPoint(BR, frame, BR, -5, 5)
	end,
	castBar = function(unit, frame)
		frame.castBar:SetPoint(BL, frame, TL, 0, 0)
		frame.castBar:SetPoint(BR, frame, TR, 0, 0)
	end,

	-- other
	auraFrame = function(unit, frame)
		frame.auraFrame:SetWidth(100)
		frame.auraFrame:SetPoint(TL, frame, TR, 0, -3)
		frame.auraFrame:SetPoint(BL, frame, BR, 0, 0)
	end,
	auraFrame2 = function(unit, frame)
		frame.auraFrame2:SetWidth(100)
		frame.auraFrame2:SetPoint(TL, frame.auraFrame, TR, 0, 0)
		frame.auraFrame2:SetPoint(BL, frame.auraFrame, BR, 0, 0)
	end,
	auraFrame_options = function() 
		-- Bogus
	end,
	highlight = function(unit, frame)
		frame.highlight:Hide()
	end,
	portrait = function(unit, frame)
		frame.portrait:Hide()
	end,

	-- text
	healthText = function(unit, frame)
		if frame.healthBar then
			frame.healthText:SetPoint(MR, frame.healthBar, MR, -3, 0)
		end
	end,
	powerText = function(unit, frame)
		if frame.powerBar then
			frame.powerText:SetPoint(MR, frame.powerBar, MR, -3, 0)
		end
	end,
	nameText = function(unit, frame)
		if frame.classText then
			frame.nameText:SetPoint(MR, frame.classText, ML, -3, 0)
		else
			frame.nameText:SetPoint(MR, frame, ML, -3, 0)
		end
	end,
	classText = function(unit, frame)
		frame.classText:SetPoint(MR, frame, ML, -3, 0)
	end,
	combatText = function(unit, frame)
		frame.combatText:SetPoint(MC, frame.healthBar, MC, 0, 0)
	end,
	comboText = function(unit, frame)
		frame.comboText:SetPoint(MC, frame.healthBar, MC)
	end,

})
