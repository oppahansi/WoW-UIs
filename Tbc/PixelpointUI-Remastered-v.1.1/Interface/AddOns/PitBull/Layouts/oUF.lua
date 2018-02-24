local TL, TC, TR = 'TOPLEFT', 'TOP', 'TOPRIGHT'
local ML, MC, MR = 'LEFT', 'CENTER', 'RIGHT'
local BL, BC, BR = 'BOTTOMLEFT', 'BOTTOM', 'BOTTOMRIGHT'

local db = PitBull:AcquireDBNamespace('Layout-oUF')
PitBull:RegisterDefaults('Layout-oUF', 'profile', {
	['**'] = {
		castingBarIcon = false,
	},
})

local function castBarIcon_get(group)
	return db.profile[group].castBarIcon
end
local function castBarIcon_set(group, value)
	db.profile[group].castBarIcon = value
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end
end

PitBull:RegisterLayout('oUF', {
	-- bars
	healthBar = function(unit, frame)
		local oneunit = (frame:GetHeight()) / 6
		local height = oneunit * 2 - 3
		if frame.powerBar and not frame.castBar then
			height = oneunit * 3 - 4
		elseif not frame.powerBar and frame.castBar then
			height = oneunit * 3 - 4
		elseif not frame.powerBar and not frame.castBar then
			height = oneunit * 6 - 4
		end
		
		frame.healthBar:SetPoint(TL, frame, TL, 2, -2)
		if not frame.powerBar and not frame.castBar then
			frame.healthBar:SetPoint(BR, frame, BR, -2, 2)
		else
			frame.healthBar:SetPoint(TR, frame, TR, -2, -2)
		end
		frame.healthBar:SetHeight(height)
	end,
	powerBar = function(unit, frame)
		local oneunit = (frame:GetHeight()) / 6
		local height = oneunit * 2 - 3
		if frame.healthBar and not frame.castBar then
			height = oneunit * 3 - 4
		elseif not frame.healthBar and frame.castBar then
			height = oneunit * 3 - 4
		elseif not frame.healthBar and not frame.castBar then
			height = oneunit * 6 - 4
		end
		
		if frame.healthBar and frame.castBar then
			frame.powerBar:SetPoint(TL, frame.healthBar, BL, 0, -3)
			frame.powerBar:SetPoint(TR, frame.healthBar, BR, 0, -3)
		elseif frame.healthBar and not frame.castBar then
			frame.powerBar:SetPoint(TL, frame.healthBar, BL, 0, -3)
			frame.powerBar:SetPoint(BR, frame, BR, -2, 2)
		elseif not frame.healthBar and frame.castBar then
			frame.powerBar:SetPoint(TL, frame, TL, 2, -2)
			frame.powerBar:SetPoint(BR, frame.castBar, TR, 0, 3)
		else
			frame.powerBar:SetPoint(TL, frame, TL, 2, -2)
			frame.powerBar:SetPoint(BR, frame, BR, -2, 2)
		end
		frame.powerBar:SetHeight(height)
	end,
	castBar = function(unit, frame)
		local oneunit = (frame:GetHeight()) / 6
		local height = oneunit * 2 - 3
		if frame.healthBar and not frame.powerBar then
			height = oneunit * 3 - 4
		elseif not frame.healthBar and frame.powerBar then
			height = oneunit * 3 - 4
		elseif not frame.healthBar and not frame.powerBar then
			height = oneunit * 6 - 4
		end
		
		-- Is the icon disabled?
		local xoffset = height
		if db.profile[frame.group].castBarIcon then
			xoffset = 0
		end
		
		frame.castBar.bg:ClearAllPoints()
		if frame.powerBar then
			frame.castBar:SetPoint(TL, frame.powerBar, BL, xoffset, -3)
			frame.castBar.bg:SetPoint(TL, frame.powerBar, BL, 0, -3)
		elseif frame.healthBar and not frame.powerBar then
			frame.castBar:SetPoint(TL, frame.healthBar, BL, xoffset, -3)
			frame.castBar.bg:SetPoint(TL, frame.healthBar, BL, 0, -3)
		elseif not frame.healthBar and not frame.powerBar then
			frame.castBar:SetPoint(TL, frame, TL, xoffset+2, -2)
			frame.castBar.bg:SetPoint(TL, frame.powerBar, TL, 2, -2)
		end
		frame.castBar:SetPoint(BR, frame, BR, -2, 2)
		frame.castBar:SetHeight(height)
		
		frame.castBar.bg:SetPoint(BC, frame.castBar, BC, 0, 0 )
		frame.castBar.bg:SetPoint(MR, frame.castBar, MR, 0, 0 )
		frame.castBar.bg:SetHeight(height)
		frame.castBar.bg:Show()
	end,

	-- other
	auraFrame = function(unit, frame)
		local width = frame:GetWidth()
		frame.auraFrame:SetWidth(width)
		frame.auraFrame:SetPoint(TL, frame, BL, 0, -4)
		frame.auraFrame:SetPoint(TR, frame, TR, 0, -4)
	end,
	auraFrame2 = function(unit, frame)
		frame.auraFrame2:Hide()
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
		if frame.healthBar then
			frame.nameText:SetPoint(ML, frame.healthBar, ML, 3, 0)
		end
	end,
	classText = function(unit, frame)
		if frame.powerBar then
			frame.classText:SetPoint(ML, frame.powerBar, ML, 3, 0)
		end
	end,
	castBarText = function(unit, frame)
		frame.castBarText:ClearAllPoints()
		frame.castBarText:SetPoint(ML, frame.castBar, ML, 3, 0)
	end,
	castBarTimeText = function(unit, frame)
		frame.castBarTimeText:ClearAllPoints()
		frame.castBarTimeText:SetPoint(MR, frame.castBar, MR, -3, 0)
	end,
	combatText = function(unit, frame)
		frame.combatText:SetPoint(MC, frame.healthBar, MC, 0, 0)
	end,
	comboText = function(unit, frame)
		frame.comboText:SetPoint(MC, frame.healthBar, MC)
	end,
		
	-- icons
	castBarIcon = function(unit, frame )
		if db.profile[frame.group].castBarIcon or not frame.castBar then
			frame.castBarIcon:Hide()
			return
		end
		
		local oneunit = (frame:GetHeight()) / 6
		local height = oneunit * 2 - 4
		if frame.healthBar and not frame.powerBar then
			height = oneunit * 3 - 4
		elseif not frame.healthBar and frame.powerBar then
			height = oneunit * 3 - 4
		elseif not frame.healthBar and not frame.powerBar then
			height = oneunit * 6 - 4
		end
		
		frame.castBarIcon:SetHeight(height)
		frame.castBarIcon:SetWidth(height)
		frame.castBarIcon:SetPoint(ML, frame.castBar.bg, ML)
		frame.castBarIcon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	end,
	raidTargetIcon = function(unit, frame)
		frame.raidTargetIcon:SetPoint(MC, frame, TC, 0, 0)
		frame.raidTargetIcon:SetHeight(20)
		frame.raidTargetIcon:SetWidth(20)
	end,
	restIcon = function(unit, frame)
		if frame.combatIcon then
			frame.restIcon:SetPoint(MC, frame, BL, 0, 0)
		else
			frame.restIcon:SetPoint(MC, frame, TR, -18, 0)
		end
		frame.restIcon:SetWidth(18)
		frame.restIcon:SetHeight(18)
	end,
	combatIcon = function(unit, frame)
		frame.combatIcon:SetPoint(MC, frame, TR, -18, 0)
		frame.combatIcon:SetWidth(20)
		frame.combatIcon:SetHeight(20)
	end,
	pvpIcon = function(unit, frame)
		frame.pvpIcon:SetPoint(MC, frame, BL, 4, -5)
		frame.pvpIcon:SetWidth(24)
		frame.pvpIcon:SetHeight(24)
	end,	
	leaderIcon = function(unit, frame)
		frame.leaderIcon:SetPoint(MC, frame, TL, 0, 0)
		frame.leaderIcon:SetWidth(14)
		frame.leaderIcon:SetHeight(14)
	end,
	
	-- options
	castBarIcon_options = function(group)
		return {
			name = 'Disable Cast Bar Icon',
			desc = 'Hide the casting bar icon from view.',
			type = 'toggle',
			get = castBarIcon_get,
			set = castBarIcon_set,
			passValue = group,
		}
	end,
})
