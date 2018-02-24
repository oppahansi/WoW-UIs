if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 63359 $"):match("%d+"))

local PitBull = PitBull
local PitBull_Aura = PitBull:GetModule("Aura")
local self = PitBull_Aura
PitBull:ProvideVersion("$Revision: 63359 $", "$Date: 2008-03-01 23:32:36 -0500 (Sat, 01 Mar 2008) $")

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

local del = Rock:GetRecyclingFunctions("PitBull", "del")

local _G = _G
local unpack = _G.unpack
local GameTooltip = _G.GameTooltip
local GetPlayerBuff = _G.GetPlayerBuff
local GetTime = _G.GetTime

local border_path
do
	local path = "Interface\\AddOns\\" .. _G.debugstack():match("[d%.][d%.][O%.]ns\\(.-)\\[A-Za-z0-9]-%.lua")
	border_path = path .. "\\border"
end

local last_auraFrame_OnUpdate = 0
local function auraFrame_OnUpdate(this)
	local currentTime = GetTime()
	if last_auraFrame_OnUpdate+0.2 > currentTime then
		return
	end
	last_auraFrame_OnUpdate = currentTime
	if this.id == 0 and not this.itemSlot then
		-- config mode
		if this.isBuff then
			GameTooltip:SetText("Test buff")
		else
			GameTooltip:SetText("Test debuff")
		end
	elseif this.isPlayer then
		if this.isBuff then
			if this.itemSlot then
				GameTooltip:SetInventoryItem("player", this.itemSlot)
			else
				local id = GetPlayerBuff(this.id, "HELPFUL")
				GameTooltip:SetPlayerBuff(id, "HELPFUL")
			end
		else
			local id = GetPlayerBuff(this.id, "HARMFUL")
			GameTooltip:SetPlayerBuff(id, "HARMFUL")
		end
	else
		if this.isBuff then
			GameTooltip:SetUnitBuff(this.unit, this.id)
		else
			GameTooltip:SetUnitDebuff(this.unit, this.id)
		end
	end
end

local function auraFrame_OnEnter(this)
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
	GameTooltip.owner = this
	last_auraFrame_OnUpdate = 0
	this:SetScript("OnUpdate", auraFrame_OnUpdate)
	auraFrame_OnUpdate(this)
end

local function auraFrame_OnLeave(this)
	GameTooltip:Hide()
	GameTooltip.owner = nil
	this:SetScript("OnUpdate", nil)
end

local function buffFrame_OnClick(this)
	if not this.isPlayer then
		return
	end
	if this.itemSlot then
		_G.CancelItemTempEnchantment(this.itemSlot - 15)
	else
		_G.CancelPlayerBuff(this.id)
	end
end

local totalAuraFrames = {}
PitBull_Aura.totalAuraFrames = totalAuraFrames
local shownAuraFrames = {}
PitBull_Aura.shownAuraFrames = shownAuraFrames

PitBull.newFrameType("AuraFrame", "Button", function(frame)
	--onCreate
	totalAuraFrames[frame] = true
	frame:SetScript("OnEnter", auraFrame_OnEnter)
	frame:SetScript("OnLeave", auraFrame_OnLeave)
	frame:RegisterForClicks("RightButtonUp")
	
	local icon = newFrame("Texture", frame, "BACKGROUND")
	frame.icon = icon
	icon:SetAllPoints(frame)
	if PitBull_Aura.db.profile.zoomAura then
		icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	end
	
	local border = newFrame("Texture", frame, "BORDER")
	frame.border = border
	border:SetAllPoints(frame)
	border:SetTexture(border_path)
	
	local applicationText = newFrame("FontString", frame, "OVERLAY")
	frame.applicationText = applicationText
	local font, fontsize = PitBull:GetFont()
	applicationText:SetFont(font, fontsize, "OUTLINE")
	applicationText:SetShadowColor(0, 0, 0, 1)
	applicationText:SetShadowOffset(0.8, -0.8)
	applicationText:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
	
	local cooldown = newFrame("Cooldown", frame)
	frame.cooldown = cooldown
	cooldown:SetReverse(true)
	cooldown:SetAllPoints(frame)
	
	local cooldownTextFrame = newFrame("Frame", frame)
	frame.cooldownTextFrame = cooldownTextFrame
	cooldownTextFrame:SetAllPoints(frame)
	
	local cooldownText = newFrame("FontString", cooldownTextFrame, "OVERLAY")
	frame.cooldownText = cooldownText
	cooldownText:SetTextColor(unpack(PitBull_Aura.db.profile.cooldownTextColor))
	cooldownText:SetFont(font, fontsize, "OUTLINE")
	cooldownText:SetShadowColor(0, 0, 0, 1)
	cooldownText:SetShadowOffset(0.8, -0.8)
	cooldownText:ClearAllPoints()
	cooldownText:SetPoint("TOP", cooldownTextFrame, "TOP", 0, 0)
end, function(frame, unit, isBuff)
	--onRetrieve
	shownAuraFrames[frame] = true
	frame.unit = unit
	frame.isBuff = isBuff
	if isBuff then
		frame:SetScript("OnClick", buffFrame_OnClick)
	end
	frame.cooldown:Hide()
	frame.cooldownTextFrame:SetFrameLevel(frame:GetFrameLevel() + 5)
	frame.cooldown:SetAlpha(1)
	frame.icon:SetAlpha(1)
	frame.border:SetAlpha(1)
	frame.applicationText:SetAlpha(1)
	frame.cooldownTextFrame:SetAlpha(1)
	frame.cooldownText:SetAlpha(PitBull_Aura.db.profile.cooldownTextColor[4])
	frame:SetAlpha(1)
end, function(frame)
	--onDelete
	shownAuraFrames[frame] = nil
	frame.id = nil
	frame.unit = nil
	frame.isBuff = nil
	frame:SetWidth(0)
	frame:SetHeight(0)
	frame.anchored = nil
	frame:SetScript("OnClick", nil)
	frame:SetScript("OnUpdate", nil)
	frame.applicationText:SetText("")
	frame.cooldownTextFrame.finishTime = nil
	frame.cooldown:SetAlpha(0)
	frame.icon:SetAlpha(0)
	frame.border:SetAlpha(0)
	frame.applicationText:SetAlpha(0)
	frame.cooldownTextFrame:SetAlpha(0)
	frame.cooldownText:SetAlpha(0)
	frame:SetAlpha(0)
end)

PitBull.newFrameType("AuraContainer", "Frame", function(frame)
	--onCreate
end, function(frame)
	--onRetrieve
end, function(frame)
	--onDelete
	frame.numBuffs = nil
	if frame.buffs then
		for i = #frame.buffs, 1, -1 do
			frame.buffs[i] = delFrame(frame.buffs[i])
		end
		frame.buffs = del(frame.buffs)
	end
	frame.numDebuffs = nil
	if frame.debuffs then
		for i = #frame.debuffs, 1, -1 do
			frame.debuffs[i] = delFrame(frame.debuffs[i])
		end
		frame.debuffs = del(frame.debuffs)
	end
	frame.offset = nil
end)
