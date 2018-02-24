local MINOR_VERSION = tonumber(("$Revision: 79486 $"):match("%d+"))
if MINOR_VERSION > Omen.MINOR_VERSION then Omen.MINOR_VERSION = MINOR_VERSION end

local Threat = LibStub("Threat-2.0")
local AOE = Omen:GetModule("AOE")
local Media = LibStub("LibSharedMedia-3.0")
local GUID = LibStub("LibGUIDRegistry-0.1")
local UnitGUID = _G.UnitGUID

local pullout_cls = setmetatable({}, {__index=Omen.PulloutBase})
local pullout_mt = {__index=pullout_cls}
local playerGUID

local pullouts = {}

local NORMAL_BASE = math.log(0.25)
local NORMAL_MAX = math.log(2.0)
local NORMAL_SCALE = 1/(NORMAL_MAX-NORMAL_BASE)
local TANK_BASE = math.log(0.25)
local TANK_MAX = math.log(4.0)
local TANK_SCALE = 1/(TANK_MAX-TANK_BASE)

function pullout_cls:New(guid)
	playerGUID = UnitGUID("player")
	local pullout = setmetatable({}, pullout_mt)
	pullout:MakeFrame()
	Omen:_SetFrameBackdrop(pullout.frame, "AOEPullout")
	Threat.RegisterCallback(pullout, "ThreatUpdated")

	pullout.raidTargets = {}
	pullout.raidTargetsReverse = {}
	GUID.RegisterCallback(pullout, "RaidTargetGUIDSet")

	pullout.frame:RegisterEvent("PLAYER_TARGET", function(self) self.parent:UpdateLayout() end)

	pullout.targetBar = pullout:NewBar()
	pullout.targetBar.frame:SetFrameLevel(10)

	pullout.rtFrame = CreateFrame("frame", nil, pullout.frame)
	pullout.rtFrame:SetFrameLevel(20)

	pullout.markerTexture = pullout:NewTexture(pullout.frame)
	pullout.markerTexture:SetTexture("Interface\\AddOns\\Omen\\Media\\Textures\\PulloutMarker.tga")
	pullout.markerTexture:SetVertexColor(1,0.8,0,0.8)

	pullout.iconTextures = {}
	for i = 1,8 do
		local tex = pullout:NewTexture(pullout.rtFrame)
		tex:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
		SetRaidTargetIconTexture(tex, i)
		local h = pullout:GetBarHeight()
		tex:SetWidth(h)
		tex:SetHeight(h)
		tex:SetVertexColor(1,1,1,1)
		pullout.iconTextures[i] = tex
	end

	pullout:UpdateLayout()
	return pullout
end

function pullout_cls:ThreatUpdated(event, srcGUID, dstGUID, threat)
	self:UpdateLayout()
end

function pullout_cls:RaidTargetGUIDSet(event, guid, name, target, unitID)
	local rt = self.raidTargets
	local rtrev = self.raidTargetsReverse
	if rt[guid] then
		rtrev[rt[guid]] = nil
	end
	rt[guid] = target
	rtrev[target] = guid
	self:UpdateLayout()
end


local function getTankThreat(targetGUID)
	local tankThreat = Threat:GetMaxThreatOnTarget(targetGUID)
	if AOE:GetOption("TankMode") and Threat:GetModule("Player").isTanking then
		local playerThreat = Threat:GetThreat(playerGUID, targetGUID)
		local secondGUID, secondThreat = Threat:GetPlayerAtPosition(targetGUID, 2)
		if secondThreat and secondThreat < playerThreat and secondThreat > 0 then
			tankThreat = secondThreat
		end
	end
	return tankThreat
end


local lastUpdate = 0
function pullout_cls:UpdateLayout()
	local now = GetTime()
	if now < lastUpdate + 0.5 then
		return
	end
	self:UpdateBars()
	local targetGUID = UnitGUID("target")
	local tankThreat, ownThreat
	if targetGUID then
		tankThreat = getTankThreat(targetGUID)
		ownThreat = Threat:GetThreat(playerGUID, targetGUID)
	end
	local base, scale, maxt
	local tankmode = AOE:GetOption("TankMode") and Threat:GetModule("Player").isTanking
	if tankmode then
		base = TANK_BASE
		maxt = TANK_MAX
		scale = TANK_SCALE
	else
		base = NORMAL_BASE
		maxt = NORMAL_MAX
		scale = NORMAL_SCALE
	end
	local x = self:GetBarWidth() * (-base) * scale + 4
	self.markerTexture:ClearAllPoints()
	self.markerTexture:SetPoint("CENTER", self.frame, "LEFT", x, 0)
	self.markerTexture:SetHeight(self.frame:GetHeight())
	self.markerTexture:SetWidth(8)
	if targetGUID and tankThreat > 0 then
		local threatRatio = ownThreat/tankThreat
		local r, g, b = 0,0,0
		if tankmode then
			if threatRatio < 1/1.1 then
				r = 1
			elseif threatRatio < 1.1 then
				r = 1
				g = 0.6
			elseif threatRatio < 1.3 then
				r = 1
				g = 1
			else
				g = 1
			end
		else
			if threatRatio < 1 then
				g = 1
			elseif threatRatio < 1.1 then
				r = 1
				g = 1
			elseif threatRatio < 1.3 then
				r = 1
				g = 0.6
			else
				r = 1
			end
		end
		self.targetBar:SetPoints((min(math.log(threatRatio),maxt)-base)*scale, 0,0,0,0)
		self.targetBar.texture:SetVertexColor(r,g,b,1)
		self.targetBar.frame:Show()
	elseif targetGUID then
		local maxThreat = Threat:GetMaxThreatOnTarget(targetGUID)
		local threatRatio = ownThreat/maxThreat
		self.targetBar:SetPoints((min(math.log(threatRatio),maxt)-base)*scale, 0,0,0,0)
		self.targetBar.texture:SetVertexColor(0,0,1,0.5)
		self.targetBar.frame:Show()
	else
		self.targetBar.frame:Hide()
	end
	local rt = self.raidTargets
	local rtrev = self.raidTargetsReverse
	local width = self:GetBarWidth()
	local wscale = scale * width
	for i = 1,8 do
		if rtrev[i] then
			local guid = rtrev[i]
			local playerThreat = Threat:GetThreat(playerGUID, guid)
			local tankThreat = getTankThreat(guid)
			if tankThreat > 0 then
				local tex = self.iconTextures[i]
				local x = (math.log(playerThreat/tankThreat) - base) * wscale
				x = max(-7, min(width+7, x))
				tex:ClearAllPoints()
				tex:SetPoint("CENTER", self.frame, "LEFT", x, 0)
				tex:Show()
			else
				self.iconTextures[i]:Hide()
			end
		else
			self.iconTextures[i]:Hide()
		end
	end
	lastUpdate = now
end

function pullout_cls:OpenMenu()
	local menu = {
		{
			text = "Remove",
			func = function(self)
				       Threat.UnregisterCallback(self, "ThreatUpdated")
				       GUID.UnregisterCallback(self, "RaidTargetGUIDSet")
				       self:Release()
			       end,
			arg1 = self
		},
	}
	
	if not Omen.EasyMenuFrame then
		Omen.EasyMenuFrame = CreateFrame("Frame", "OmenEasyMenuFrame", nil, "UIDropDownMenuTemplate")
	end
	EasyMenu(menu, Omen.EasyMenuFrame, "cursor", nil, nil, "MENU")
end

function AOE:MakePullout(guid)
	local pullout = pullout_cls:New(guid)
	tinsert(pullouts, pullout)
end

function AOE:MakeBarMenu(bar)
	return {
		{
			text = "Create Pullout",
			func = function(guid)
				       Omen.activeModule:MakePullout(guid)
			       end,
			arg1 = bar.guid,
		},
	}
end


AOE.Pullout = pullout_cls
