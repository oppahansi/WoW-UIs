local MINOR_VERSION = tonumber(("$Revision: 74806 $"):match("%d+"))
if MINOR_VERSION > Omen.MINOR_VERSION then Omen.MINOR_VERSION = MINOR_VERSION end

local bars
local Threat = LibStub("Threat-2.0")
local AOE = Omen:NewModule("AOE", Omen.ModuleBase, "AceEvent-3.0", "AceTimer-3.0")
local GUID = LibStub("LibGUIDRegistry-0.1")
local table_sort = _G.table.sort
local math_abs = _G.math.abs
local math_floor = _G.math.floor
local OL = LibStub("AceLocale-3.0"):GetLocale("Omen")
local L = LibStub("AceLocale-3.0"):GetLocale("Omen_AOE")
local GetTime = _G.GetTime
local unpack = _G.unpack

local showFocus, showTarget = false, false

local raidTargets, raidTargetsReverse = {}, {}
local playerGUID

local tankMode = false
local tankModeScale

local configOptions = {
	RaidIcons = true,
	ShowTarget = true,
	ShowFocus = true,
	TankMode = false,
	TankModeScale = 150,
}

local options = {
	type = "group",
	name = L["AOE Mode"],
	desc = L["AOE Mode"],
	args = {
		test = {
			type = "execute",
			name = OL["Show test bars"],
			desc = OL["Show test bars"],
			func = function() Omen:EnableModule("AOE"); AOE:Test() end
		},
		raidIcons = {
			type = "toggle",
			name = L["Show raid icons"],
			desc = L["Show raid icons"],
			get = function(info) return AOE:GetOption("RaidIcons") end,
			set = function(info, v)
				AOE:SetOption("RaidIcons", v)
				AOE:ReleaseBars()
			end
		},
		showTarget = {
			type = "toggle",
			name = L["Indicate target"],
			desc = L["Indicate target"],
			get = function(info) return AOE:GetOption("ShowTarget") end,
			set = function(info, v)
				AOE:SetOption("ShowTarget", v)
				showTarget = v
			end
		},
		showFocus = {
			type = "toggle",
			name = L["Indicate focus"],
			desc = L["Indicate focus"],
			get = function(info) return AOE:GetOption("ShowFocus") end,
			set = function(info, v)
				AOE:SetOption("ShowFocus", v)
				showFocus = v
			end
		},
		tankMode = {
			type = "toggle",
			name = L["Tank mode"],
			desc = L["Show threat relative to #2, and an increased maximum threat"],
			get = function(info) return AOE:GetOption("TankMode") end,
			set = function(info, v)
				AOE:SetOption("TankMode", v)
				tankMode = v
			end
		},
		tankModeScale = {
			type = "range",
			name = L["Tank mode maximum threat %"],
			desc = L["Show up to this threat value, relative to current #2"],
			min = 100,
			max = 300,
			step = 5,
			bigStep = 25,
			get = function(info) return AOE:GetOption("TankModeScale") end,
			set = function(info, v)
				AOE:SetOption("TankModeScale", v)
				tankModeScale = 100/v
			end
		}
	}
}

local function sortBars(a, b)
	return a.value > b.value
end

function AOE:OnInitialize()
	self:Super("OnInitialize")
	self.icon = select(3, GetSpellInfo(10))
	self:RegisterConfigDefaults(configOptions)
	self:RegisterOptions(options)
	self.targetIcon = select(3, GetSpellInfo(1130)) -- hunter's mark
end

function AOE:Hint()
	return L["AOE Mode\n|cffffffffShows your threat on all targets|r"]
end

function AOE:UpdateLayout()
	self:ArrangeBars()
end

function AOE:OnEnable()
	self:Super("OnEnable")
	bars = self.bars
	self:ClearBars()
	Threat.RegisterCallback(self, "ThreatUpdated")
	GUID.RegisterCallback(self, "RaidTargetGUIDSet")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")

	playerGUID = UnitGUID("player")
	Omen:SetTitle(L["AOE Mode"] .. ": " .. UnitName("player"))
	for k, v in Threat:IteratePlayerThreat(playerGUID) do
		AOE:UpdateBar(k, v)
	end	
	showFocus = self:GetOption("ShowFocus")
	showTarget = self:GetOption("ShowTarget")
	tankMode = self:GetOption("TankMode")
	tankModeScale = 100/self:GetOption("TankModeScale")
end

function AOE:OnDisable()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	GUID.UnregisterCallback(self, "RaidTargetGUIDSet")
	Threat.UnregisterCallback(self, "ThreatUpdated")
	self:Super("OnDisable")
end

function AOE.RaidTargetGUIDSet(lib, event, guid, name, target, unitID)
	if raidTargetsReverse[target] then
		raidTargets[raidTargetsReverse[target]] = nil
	end
	raidTargets[guid] = target
	raidTargetsReverse[target] = guid
end

local labelsWithIcon = {
	"Icon", "LEFT", 8,
	"Enemy", "LEFT", 52,
	"Threat", "RIGHT", 20,
	"%Max", "RIGHT", 20
}

local labelsNoIcon = {
	"Enemy", "LEFT", 60,
	"Threat", "RIGHT", 20,
	"%Max", "RIGHT", 20
}

local lastUpdatedAt = 0
function AOE:UpdateBar(guid, threat, overrideMax)
	local maxThreat = Threat:GetMaxThreatOnTarget(guid)
	if not overrideMax and maxThreat <= 0 then
		local bar = self:AcquireBar(guid, true)
		if bar then
			bar.value = 0 -- to release it on next update
		end
	else
		local bar, isNew = self:AcquireBar(guid)
		if isNew then
			bar:SetLabels( unpack(self:GetOption("RaidIcons") and labelsWithIcon or labelsNoIcon) )
			bar:SetLabel("Icon", nil)
			bar:SetLabel("Enemy", Threat.GUIDNameLookup[guid])
		end
		local scaleFactor = 1.0
		if tankMode and Threat:GetModule("Player").isTanking then
			local secondGUID, secondThreat = Threat:GetPlayerAtPosition(guid, 2)
			if secondThreat and secondThreat < threat and secondThreat > 0 then
				maxThreat = secondThreat
			end
			scaleFactor = tankModeScale
		end
		local pct = threat / (overrideMax or maxThreat)
		bar:SetLabel("Threat", bar:ConvertToK(threat))
		bar.value = pct * scaleFactor
		bar.real_pct = pct
	end
	if GetTime() - lastUpdatedAt > 0.25 then
		lastUpdatedAt = GetTime()
		self:ArrangeBars()
	end
end

function AOE:ArrangeBars()
	self:ResetBars()

	-- Clean up unused bars
	for i = #bars, 1, -1 do
		local bar = bars[i]
		if bar.value ~= bar.value or bar.value <= 0 then
			self:ReleaseBar(bar)
		end
	end

	table_sort(bars, sortBars)
	local targetGUID = UnitGUID("target")
	local focusGUID = UnitGUID("focus")
	local flag = true
	for i = 1, #bars do
		local bar = bars[i]
		if flag and self:AddBar(bar) then
			bar.isTarget = false
			if showFocus and bar.guid == focusGUID then
				bar:SetLabel("Enemy", "[F] " .. Threat.GUIDNameLookup[bar.guid])
			elseif showTarget and bar.guid == targetGUID then
				bar.isTarget = true
				if bar.hasIcon ~= raidTargets[bar.guid] then
					bar:SetLabel("Enemy", Threat.GUIDNameLookup[bar.guid])
					bar:SetLabel("Icon", self.targetIcon)
				end
			else
				bar:SetLabel("Enemy", Threat.GUIDNameLookup[bar.guid])
			end
			
			if raidTargets[bar.guid] and bar.hasIcon ~= raidTargets[bar.guid] then
				bar:SetLabel("Icon", raidTargets[bar.guid])
			elseif bar.hasIcon and not raidTargets[bar.guid] and not bar.isTarget then
				bar:SetLabel("Icon", nil)
			end

			local pct = bar.real_pct
			local r, g, b
			b = 0
			if bar.isTarget then
				r, g, b = 0.3, 0.3, 1
			elseif tankMode and Threat:GetModule("Player").isTanking then
				if pct > 1.0 then
					g = 1
					r = 3 - 2*pct
				else
					r = 1
					g = pct
				end
			else
				if pct < 0.5 then
					g = 1
					r = (pct / 0.5)
				else
					r = 1
					g = 1 - ((pct - 0.5) / 0.5)
				end
			end
			bar:SetColor(r, g, b)
			bar:SetPercent(bar.value)
			bar:SetLabel("%Max", ("%.0f%%"):format(pct*100))
		else
			flag = false
			bar.frame:Hide()
		end
	end
end

function AOE:ThreatUpdated(event, srcGUID, dstGUID, threat)
	if self.testing then
		self:ReleaseBars()
		self.testing = false
	end
	if playerGUID == srcGUID then
		self:UpdateBar(dstGUID, threat)
	else
		self:UpdateBar(dstGUID, Threat:GetThreat(playerGUID, dstGUID))
	end
end

function AOE:Test()
	self.testing = true
	self:ReleaseBars()

	for i = 1, 25 do
		raidTargets[i] = mod(i, 8) + 1
		self:UpdateBar(tostring(i), i, 25)
	end
	self:ArrangeBars()
end

function AOE:PLAYER_REGEN_ENABLED()
	self:ReleaseBars()
end
