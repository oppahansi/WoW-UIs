if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 62995 $"):match("%d+"))

local PitBull = PitBull
local PitBull_Aura = PitBull:GetModule("Aura")
local self = PitBull_Aura
PitBull:ProvideVersion("$Revision: 62995 $", "$Date: 2008-02-26 15:54:22 -0500 (Tue, 26 Feb 2008) $")

local _G = _G
local pairs = _G.pairs
local math_floor = _G.math.floor
local math_max = _G.math.max
local math_ceil = _G.math.ceil

local setDirectionPoint = {
	["Left then Up"] = function(buff, anchor, x, y)
		buff:SetPoint("TOPRIGHT", anchor, "TOPRIGHT", -x, y)
	end,
	["Left then Down"] = function(buff, anchor, x, y)
		buff:SetPoint("TOPRIGHT", anchor, "TOPRIGHT", -x, -y)
	end,
	["Right then Up"] = function(buff, anchor, x, y)
		buff:SetPoint("TOPLEFT", anchor, "TOPLEFT", x, y)
	end,
	["Right then Down"] = function(buff, anchor, x, y)
		buff:SetPoint("TOPLEFT", anchor, "TOPLEFT", x, -y)
	end,
	["Up then Left"] = function(buff, anchor, x, y)
		buff:SetPoint("TOPRIGHT", anchor, "TOPRIGHT", -y, x)
	end,
	["Up then Right"] = function(buff, anchor, x, y)
		buff:SetPoint("TOPLEFT", anchor, "TOPLEFT", y, x)
	end,
	["Down then Left"] = function(buff, anchor, x, y)
		buff:SetPoint("TOPRIGHT", anchor, "TOPRIGHT", -y, -x)
	end,
	["Down then Right"] = function(buff, anchor, x, y)
		buff:SetPoint("TOPLEFT", anchor, "TOPLEFT", y, -x)
	end,
	["flip"] = function(buff, anchor, x, y)
		buff:SetPoint("TOPRIGHT", anchor, "TOPRIGHT", -x, y)
	end,
	["noflip"] = function(buff, anchor, x, y)
		buff:SetPoint("TOPLEFT", anchor, "TOPLEFT", x, y)
	end,
}

local AuraLayoutsToUpdate = {}
local function UpdateAuraLayout(frame)
	local auraContainer = frame.auraContainer
	if not auraContainer then
		--nowhere to put our auras (can happen when the frame isn't fully initialized yet)
		return
	end

	local auraContainer_width = auraContainer:GetWidth()
	if auraContainer_width == 0 then
		-- just created the frame
		AuraLayoutsToUpdate[frame] = true
		auraContainer:Hide()
		return
	end

	local auraContainer_buffs = auraContainer.buffs
	local auraContainer2 = frame.auraContainer2 or auraContainer
	local auraContainer2_debuffs = auraContainer2.debuffs

	local numBuffs = auraContainer_buffs and #auraContainer_buffs or 0
	local numDebuffs = auraContainer2_debuffs and #auraContainer2_debuffs or 0
	local previousNumBuffs = auraContainer.numBuffs or 0
	local previousNumDebuffs = auraContainer2.numDebuffs or 0
	
	if (numBuffs == previousNumBuffs and numDebuffs == previousNumDebuffs) then
		--no layout to be done
		return
	end
	
	auraContainer.numBuffs = numBuffs
	auraContainer2.numDebuffs = numDebuffs	
	if (numBuffs == 0 and numDebuffs == 0) then
		return
	end
	auraContainer:Show()
	
	local profile = PitBull_Aura.db.profile
	local db = profile[frame.group]
	local snap = db.snap
	local grow = db.grow
	
	local split = auraContainer ~= auraContainer2
	
	local buffsize = db.buffsize
	local spacing = db.buffSpacing
	
	local maxBuffsPerRow = math_floor((auraContainer_width + spacing) / (buffsize + spacing))
	if snap then
		buffsize = buffsize * auraContainer_width / ((buffsize + spacing) * maxBuffsPerRow - spacing)
	end
	
	if numBuffs > previousNumBuffs then
		local setpoint
		if split then
			setpoint = setDirectionPoint[db.buffdirection]
		else
			setpoint = setDirectionPoint[db.flip and "flip" or "noflip"]
		end
		
		local x, y = 0, 0
		for i = 1, numBuffs do
			local buff = auraContainer_buffs[i]
			if not buff.anchored then
				buff:ClearAllPoints()
				buff:SetWidth(buffsize)
				buff:SetHeight(buffsize)
				setpoint(buff, auraContainer, x, y)
				buff.anchored = true
			end
			if i % maxBuffsPerRow == 0 then
				x, y = 0, y + buffsize * (split and 1 or grow)
			else
				x = x + buffsize + spacing
			end
		end
	end
	
	local auraContainer2_width = auraContainer2:GetWidth()
	local debuffsize = db.debuffsize
	local maxDebuffsPerRow = math_floor((auraContainer2_width + spacing) / (debuffsize + spacing))
	if snap then
		debuffsize = debuffsize * (auraContainer2_width + spacing) / ((debuffsize + spacing) * maxDebuffsPerRow - spacing)
	end

	if split then
		-- note that this is the top row that we'll be using for the first few debuffs.
		-- split mode they descend, nonsplit they ascend
		if numDebuffs > previousNumDebuffs then
			local x, y = 0, 0
			local setpoint = setDirectionPoint[db.debuffdirection]
			for i = 1, numDebuffs do
				local debuff = auraContainer2_debuffs[i]
				if not debuff.anchored then
					debuff:ClearAllPoints()
					debuff:SetWidth(debuffsize)
					debuff:SetHeight(debuffsize)
					setpoint(debuff, auraContainer2, x, y)
					debuff.anchored = true
				end
				if i % maxDebuffsPerRow == 0 then
					x, y = 0, y + debuffsize
				else
					x = x + debuffsize + spacing
				end
			end
		end
	else
		local setpoint
		local invert = db.invert
		local offset
		if invert then
			local numBuffs_bottomrow = numBuffs % maxBuffsPerRow
			local numDebuffs_toprow = numDebuffs % maxDebuffsPerRow

			-- start at the bottom full row of buffs
			offset = math_floor(numBuffs / maxBuffsPerRow) * buffsize
			if (numDebuffs_toprow * (debuffsize + spacing) + numBuffs_bottomrow * (buffsize + spacing) - spacing) > auraContainer_width then
				-- if colliding, push it down the sum of the values
				offset = offset + buffsize + debuffsize
			elseif numDebuffs_toprow > 0 then
				if numBuffs_bottomrow == 0 then
					offset = offset + debuffsize
				else
					offset = offset + math_max(buffsize, debuffsize)
				end
			elseif numBuffs_bottomrow > 0 then
				offset = offset + buffsize
			end
			
			local flip = not db.flip-- ~= not auraContainer_buffs
			setpoint = setDirectionPoint[flip and "flip" or "noflip"]
		else
			offset = math_ceil(numBuffs / maxBuffsPerRow) * buffsize
			setpoint = setDirectionPoint[db.flip and "flip" or "noflip"]
		end
		offset = grow == 1 and (offset - buffsize + debuffsize) or -offset
		
		local previousOffset = auraContainer.offset
		auraContainer.offset = offset

		if offset == previousOffset and numDebuffs <= previousNumDebuffs then
			return
		end

		if invert then
			local row = math_floor(numDebuffs / maxDebuffsPerRow)
			offset = (row - 1) * grow * debuffsize + offset
		end
		-- note that this will be the bottom row that we draw debuffs on.
		local x, y = 0, offset
		for i = 1, numDebuffs do
			local debuff = auraContainer2_debuffs[i]
			if offset ~= previousOffset or not debuff.anchored then
				debuff:ClearAllPoints()
				debuff:SetWidth(debuffsize)
				debuff:SetHeight(debuffsize)
				setpoint(debuff, auraContainer, x, y)
				debuff.anchored = true
			end
			if i % maxDebuffsPerRow == 0 then
				x, y = 0, y + (invert and -1 or 1) * debuffsize * grow
			else
				x = x + debuffsize + spacing
			end
		end
	end
end
PitBull_Aura.UpdateAuraLayout = UpdateAuraLayout

local tmp = {}
local function updateNeededAuraLayouts()
	AuraLayoutsToUpdate, tmp = tmp, AuraLayoutsToUpdate
	for frame in pairs(tmp) do
		UpdateAuraLayout(frame)
		tmp[frame] = nil
	end
end
_G.table.insert(PitBull_Aura.OnEnable_funcs, function()
	PitBull_Aura:AddRepeatingTimer(0, updateNeededAuraLayouts)
end)

local MetaLayout = PitBull.MetaLayout

local function split_layout(frame, parent, side, width, offset_x, offset_y)
	if side == "bottom" then
		frame:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", -2 + offset_x, -2 + offset_y)
	elseif side == "top" then
		frame:SetPoint("BOTTOMLEFT", parent, "TOPLEFT", -2 + offset_x, 2 + offset_y)
	elseif side == "left" then
		frame:SetPoint("BOTTOMRIGHT", parent, "LEFT", -2 + offset_x, -2 + offset_y)
	elseif side == "right" then
		frame:SetPoint("BOTTOMLEFT", parent, "RIGHT", 2 + offset_x, offset_y)
	elseif side == "topleft" then
		frame:SetPoint("TOPRIGHT", parent, "TOPLEFT", -2 + offset_x, offset_y)
	elseif side == "topright" then
		frame:SetPoint("TOPLEFT", parent, "TOPRIGHT", 2 + offset_x, offset_y)
	elseif side == "bottomleft" then
		frame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMLEFT", -2 + offset_x, offset_y)
	elseif side == "bottomright" then
		frame:SetPoint("BOTTOMLEFT", parent, "BOTTOMRIGHT", 2 + offset_x, offset_y)
	end
end

function MetaLayout.positions.auraContainer(unit, frame)
	local db = PitBull_Aura.db.profile[frame.group]
	local size = db.buffsize
	local auraContainer = frame.auraContainer
	auraContainer:ClearAllPoints()
	auraContainer:SetHeight(size)
	local w = db.frameWidth
	if db.split then
		auraContainer:SetWidth(w)
		split_layout(auraContainer, frame, db.buffSide, w - size, db.auraOffsetX, db.auraOffsetY)
	else
		local side = db.auraSide
		if side == "bottom" then
			auraContainer:SetWidth(0)
			auraContainer:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", -2 + db.auraOffsetX, -2 + db.auraOffsetY)
			auraContainer:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", 2 + db.auraOffsetX, -2 + db.auraOffsetY)
		elseif side == "top" then
			auraContainer:SetWidth(0)
			auraContainer:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", -2 + db.auraOffsetX, 2 + db.auraOffsetY)
			auraContainer:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 2 + db.auraOffsetX, 2 + db.auraOffsetY)
		elseif side == "left" then
			auraContainer:SetWidth(w)
			auraContainer:SetPoint("BOTTOMRIGHT", frame, "LEFT", -2 + db.auraOffsetX, db.auraOffsetY)
		elseif side == "topright" then
			auraContainer:SetWidth(w)
			auraContainer:SetPoint("TOPLEFT", frame, "TOPRIGHT", 2 + db.auraOffsetX, db.auraOffsetY)
		elseif side == "bottomright" then
			auraContainer:SetWidth(w)
			auraContainer:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 2 + db.auraOffsetX, db.auraOffsetY)
		elseif side == "bottomleft" then
			auraContainer:SetWidth(w)
			auraContainer:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", -2 + db.auraOffsetX, db.auraOffsetY)
		elseif side == "topleft" then
			auraContainer:SetWidth(w)
			auraContainer:SetPoint("TOPRIGHT", frame, "TOPLEFT", -2 + db.auraOffsetX, db.auraOffsetY)
		elseif side == "right" then
			auraContainer:SetWidth(w)
			auraContainer:SetPoint("BOTTOMLEFT", frame, "RIGHT", 2 + db.auraOffsetX, db.auraOffsetY)
		end
	end
end

function MetaLayout.positions.auraContainer2(unit, frame)
	local auraContainer2 = frame.auraContainer2
	auraContainer2:ClearAllPoints()
	local db = PitBull_Aura.db.profile[frame.group]
	local size = db.debuffsize
	local w = db.frame2Width
	auraContainer2:SetHeight(size)
	auraContainer2:SetWidth(w)
	split_layout(auraContainer2, frame, db.debuffSide, w - size, db.aura2OffsetX, db.aura2OffsetY)
end

function MetaLayout.positions.debuffHighlight(unit, frame)
	frame.debuffHighlight:SetAllPoints(frame)
end