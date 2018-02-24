
local Seerah_db = PitBull:AcquireDBNamespace("Layout-Seerah")
PitBull:RegisterDefaults("Layout-Seerah", "profile", {
	["**"] = {
		healthBarHeight = 6,
		powerBarHeight = 4,
		castBarHeight = 3,
		repBarHeight = 2,
		expBarHeight = 2,
		druidManaBarHeight = 0.5,
		
		auraSide = "bottom",
		--note, these are only used when debuffs are split
		buffSide = "bottom",
		debuffSide = "right",
	},
})

local L = PitBull:L("PitBull-Seerah")

local Seerah = {}

local heights = {
	healthBar = 'healthBarHeight',
	powerBar = 'powerBarHeight',
	castBar = 'castBarHeight',
	repBar = 'repBarHeight',
	expBar = 'expBarHeight',
}

local function figureHeight(multiplier, frame)
	local num = 0
	local db = Seerah_db.profile[frame.group]
	for k,v in pairs(heights) do
		if frame[k] and frame[k]:IsShown() then
			num = num + db[v]
		end
	end
	return db[heights[multiplier]] * frame:GetHeight() / num
end

function Seerah.nameText(unit, frame)
		frame.nameText:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 2, 5)
		frame.nameText:SetJustifyV("MIDDLE")
		frame.nameText:SetJustifyH("LEFT")
		if frame.classText then
			frame.nameText:SetPoint("RIGHT", frame.classText, "LEFT", 0, 0)
		end
end
function Seerah.classText(unit, frame)
		frame.classText:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -2, 5)
		frame.classText:SetJustifyV("MIDDLE")
		frame.classText:SetJustifyH("LEFT")
end

local function auraSide_get(group)
	return Seerah_db.profile[group].auraSide
end
local function auraSide_set(group, value)
	Seerah_db.profile[group].auraSide = value
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end
end

local function buffSide_get(group)
	return Seerah_db.profile[group].buffSide
end
local function buffSide_set(group, value)
	Seerah_db.profile[group].buffSide = value
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end
end

local function debuffSide_get(group)
	return Seerah_db.profile[group].debuffSide
end
local function debuffSide_set(group, value)
	Seerah_db.profile[group].debuffSide = value
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end
end

local function splitOptions_isHidden(group)
	return not PitBull:GetModule("Aura").db.profile[group].split
end

local function nonsplitOptions_isHidden(group)
	return PitBull:GetModule("Aura").db.profile[group].split
end

function Seerah.auraFrame_options(group)
	return {
		name = L["Side"],
		desc = L["Options to change the side which the auras are on."],
		type = "group",
		disabled = function()
			if not PitBull_Aura then PitBull_Aura = PitBull:GetModule("Aura") end
			if not PitBull_Aura or not PitBull_Aura.db or not PitBull_Aura.db.profile or not PitBull_Aura.db.profile[group] then return end
			return PitBull_Aura.db.profile[group].hidden
		end,
		args = {
			nonsplitside = {
				name = L["Side"],
				desc = L["Which side to position all aura icons at."],
				type = "text",
				validate = {
					left = "Left",
					topleft = "Top-left",
					bottomleft = "Bottom-left",
					right = "Right",
					topright = "Top-right",
					bottomright = "Bottom-right",
					top = "Top",
					bottom = "Bottom",
				},
				get = auraSide_get,
				set = auraSide_set,
				passValue = group,
				disabled = nonsplitOptions_isHidden,
			},
			buffside = {
				name = L["Buff side"],
				desc = L["Which side to position buff icons at."],
				type = "text",
				validate = {
					left = "Left",
					topleft = "Top-left",
					bottomleft = "Bottom-left",
					right = "Right",
					topright = "Top-right",
					bottomright = "Bottom-right",
					top = "Top",
					bottom = "Bottom",
				},
				get = buffSide_get,
				set = buffSide_set,
				passValue = group,
				disabled = splitOptions_isHidden,
			},
			debuffside = {
				name = L["Debuff side"],
				desc = L["Which side to position debuff icons at."],
				type = "text",
				validate = {
					left = "Left",
					topleft = "Top-left",
					bottomleft = "Bottom-left",
					right = "Right",
					topright = "Top-right",
					bottomright = "Bottom-right",
					top = "Top",
					bottom = "Bottom",
				},
				get = debuffSide_get,
				set = debuffSide_set,
				passValue = group,
				disabled = splitOptions_isHidden,
			},
		}
	}
end


function Seerah.auraFrame(unit, frame)
	frame.auraFrame:ClearAllPoints()
	local size = PitBull:GetModule("Aura").db.profile[frame.group].buffsize
	frame.auraFrame:SetHeight(size)
	if PitBull:GetModule("Aura").db.profile[frame.group].split then
		local buffside = Seerah_db.profile[frame.group].buffSide
		local w = frame:GetWidth()
		frame.auraFrame:SetWidth(w)
		if buffside == "bottom" then
			frame.auraFrame:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", -2, -2)
		elseif buffside == "top" then
			frame.auraFrame:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", -2, 20)
		elseif buffside == "left" then
			frame.auraFrame:SetPoint("BOTTOMRIGHT", frame, "LEFT", w-size-2, -2)
		elseif buffside == "right" then
			frame.auraFrame:SetPoint("BOTTOMLEFT", frame, "RIGHT", 2, 0)
		elseif buffside == "topleft" then
			frame.auraFrame:SetPoint("TOPRIGHT", frame, "TOPLEFT", w-size-2, 0)
		elseif buffside == "topright" then
			frame.auraFrame:SetPoint("TOPLEFT", frame, "TOPRIGHT", 2, 0)
		elseif buffside == "bottomleft" then
			frame.auraFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", w-size-2, 0)
		elseif buffside == "bottomright" then
			frame.auraFrame:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 2, 0)
		end
	else
		local side = Seerah_db.profile[frame.group].auraSide
		if side == "bottom" then
			frame.auraFrame:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", -2, -2)
			frame.auraFrame:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", 2, -2)
		elseif side == "top" then
			local split = PitBull:GetModule("Aura").db.profile[frame.group].split
			frame.auraFrame:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", -2, split and 36 or 20)
			frame.auraFrame:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 2, split and 36 or 20)
		elseif side == "left" then
			frame.auraFrame:SetWidth(160)
			frame.auraFrame:SetPoint("BOTTOMRIGHT", frame, "LEFT", -2, 0)
		elseif side == "topright" then
			frame.auraFrame:SetWidth(160)
			frame.auraFrame:SetPoint("TOPLEFT", frame, "TOPRIGHT", 2, 0)
		elseif side == "bottomright" then
			frame.auraFrame:SetWidth(160)
			frame.auraFrame:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 2, 0)
		elseif side == "bottomleft" then
			frame.auraFrame:SetWidth(160)
			frame.auraFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", -2, 0)
		elseif side == "topleft" then
			frame.auraFrame:SetWidth(160)
			frame.auraFrame:SetPoint("TOPRIGHT", frame, "TOPLEFT", -2, 0)
		elseif side == "right" then
			frame.auraFrame:SetWidth(160)
			frame.auraFrame:SetPoint("BOTTOMLEFT", frame, "RIGHT", 2, 0)
		end
	end
end
function Seerah.auraFrame2(unit, frame)
	frame.auraFrame2:ClearAllPoints()
	local size = PitBull:GetModule("Aura").db.profile[frame.group].debuffsize
	local w = frame:GetWidth()
	frame.auraFrame2:SetHeight(size)
	frame.auraFrame2:SetWidth(w)
	local debuffside = Seerah_db.profile[frame.group].debuffSide
	if debuffside == "bottom" then
		frame.auraFrame2:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", -2, -2)
	elseif debuffside == "top" then
		frame.auraFrame2:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", -2, 20)
	elseif debuffside == "left" then
		frame.auraFrame2:SetPoint("BOTTOMRIGHT", frame, "LEFT", w-size-2, -2)
	elseif debuffside == "right" then
		frame.auraFrame2:SetPoint("BOTTOMLEFT", frame, "RIGHT", 2, 0)
	elseif debuffside == "topleft" then
		frame.auraFrame2:SetPoint("TOPRIGHT", frame, "TOPLEFT", w-size-2, 0)
	elseif debuffside == "topright" then
		frame.auraFrame2:SetPoint("TOPLEFT", frame, "TOPRIGHT", 2, 0)
	elseif debuffside == "bottomleft" then
		frame.auraFrame2:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", w-size-2, 0)
	elseif debuffside == "bottomright" then
		frame.auraFrame2:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 2, 0)
	end
end

PitBull:RegisterLayout("Seerah", Seerah)
