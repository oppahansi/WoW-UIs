local MINOR_VERSION = tonumber(("$Revision: 74806 $"):match("%d+"))
if MINOR_VERSION > Omen.MINOR_VERSION then Omen.MINOR_VERSION = MINOR_VERSION end

local bars
local Threat = LibStub("Threat-2.0")
local GUID = LibStub("LibGUIDRegistry-0.1")
local table_sort = _G.table.sort
local math_abs = _G.math.abs
local OL = LibStub("AceLocale-3.0"):GetLocale("Omen")
local L = LibStub("AceLocale-3.0"):GetLocale("Omen_Overview")
local GetTime = _G.GetTime
local select = _G.select
local unpack = _G.unpack

local Overview = Omen:NewModule("Overview", Omen.ModuleBase, "AceEvent-3.0", "AceTimer-3.0")
local raidTargets, raidTargetsReverse = {}, {}

local configOptions = {
	RaidIcons = true
}
local options = {
	type = "group",
	name = L["Overview Mode"],
	desc = L["Overview Mode"],
	args = {
		test = {
			type = "execute",
			name = OL["Show test bars"],
			desc = OL["Show test bars"],
			func = function() Omen:EnableModule("Overview"); Overview:Test() end
		},
		raidIcons = {
			type = "toggle",
			name = L["Show raid icons"],
			desc = L["Show raid icons"],
			get = function(info) return Overview:GetOption("RaidIcons") end,
			set = function(info, v)
				Overview:SetOption("RaidIcons", v)
				Overview:ReleaseBars()
			end
		}
	}
}

local function sortBars(a, b)
	return a.value > b.value
end

function Overview:OnInitialize()
	self:Super("OnInitialize")
	self:RegisterConfigDefaults(configOptions)
	self:RegisterOptions(options)
	self.icon = select(3, GetSpellInfo(32272))
end

function Overview:Hint()
	return L["Overview Mode\n|cffffffffShows an overview of high-threat raid members|r"]
end

function Overview:UpdateLayout()
	self:ArrangeBars()
end

function Overview:OnEnable()
	self:Super("OnEnable")
	bars = self.bars
	self:ClearBars()
	Threat.RegisterCallback(self, "ThreatUpdated")
	Omen:SetTitle(L["Overview Mode"] .. ": " .. UnitName("player"))
	GUID.RegisterCallback(self, "RaidTargetGUIDSet")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
end

function Overview:OnDisable()
	self:Super("OnDisable")
	GUID.UnregisterCallback(self, "RaidTargetGUIDSet")
	Threat.UnregisterCallback(self, "ThreatUpdated")
end

function Overview.RaidTargetGUIDSet(lib, guid, name, target, unitID)
	if raidTargetsReverse[target] then
		raidTargets[raidTargetsReverse[target]] = nil
	end
	raidTargets[guid] = target
	raidTargetsReverse[target] = guid
end

local labelsWithIcons = {
	"Player", "LEFT", 27,
	"Icon", "LEFT", 6,
	"Enemy", "LEFT", 47,
	"%Max", "RIGHT", 20
}
local labelsNoIcons = {
	"Player", "LEFT", 30,
	"Enemy", "LEFT", 50,
	"%Max", "RIGHT", 20
}

local lastUpdateTime = 0
function Overview:UpdateBar(srcGuid, dstGuid, threat, overrideMax)
	local bar, isNew = self:AcquireBar(srcGuid .. dstGuid)
	if isNew then
		bar:SetLabels( unpack(self:GetOption("RaidIcons") and labelsWithIcons or labelsNoIcons) )
		bar:SetLabel("Enemy", Threat.GUIDNameLookup[dstGuid])
		local pName= Threat.GUIDNameLookup[srcGuid]
		bar:SetLabel("Player", pName or "<unknown>")
		if pName then
			bar:SetClass(select(2, UnitClass(pName)))
		end
	end
	if raidTargets[dstGuid] then
		bar:SetLabel("Icon", raidTargets[dstGuid])
	elseif bar.hasIcon then
		bar:SetLabel("Icon", nil)
	end
	local pct = threat / (overrideMax or Threat:GetMaxThreatOnTarget(dstGuid))
	bar.value = pct
	if GetTime() - lastUpdateTime > 0.25 then
		lastUpdateTime = GetTime()
		self:ArrangeBars()
	end
end

function Overview:ArrangeBars()
	self:ResetBars()

	-- Clean up unused bars
	for i = #bars, 1, -1 do
		local bar = bars[i]
		if bar.value ~= bar.value or bar.value <= 0 then
			self:ReleaseBar(bar)
		end
	end

	table_sort(bars, sortBars)
	local flag = true
	for i = 1, #bars do
		local bar = bars[i]
		if flag and self:AddBar(bar) then
			local pct = bar.value
			bar:SetPercent(pct)
			bar:SetLabel("%Max", ("%.0f%%"):format(pct*100))
		else
			flag = false
			bar.frame:Hide()
		end
	end
end

function Overview:ThreatUpdated(event, srcGUID, dstGUID, threat)
	if self.testing then
		self:ReleaseBars()
		self.testing = false
	end
	self:UpdateBar(srcGUID, dstGUID, threat)
end

function Overview:Test()
	self:ReleaseBars()
	self.testing = true

	local pGUID = UnitGUID("player")
	for i = 1, 25 do
		raidTargets[i] = mod(i,8) + 1
		local temp = string.format("0x%02x", i)
		if random() > 0.8 then
			self:UpdateBar(pGUID, temp, i, 25)
		else
			self:UpdateBar(temp, temp, i, 25)
		end
	end
	self:ArrangeBars()
end

function Overview:PLAYER_REGEN_ENABLED()
	self:ReleaseBars()
end
