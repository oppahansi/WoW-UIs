local MINOR_VERSION = tonumber(("$Revision: 74823 $"):match("%d+"))
if MINOR_VERSION > Omen.MINOR_VERSION then Omen.MINOR_VERSION = MINOR_VERSION end

local columns = {}
local Threat = LibStub("Threat-2.0")
local table_sort = _G.table.sort
local math_abs = _G.math.abs
local OL = LibStub("AceLocale-3.0"):GetLocale("Omen")
local L = LibStub("AceLocale-3.0"):GetLocale("Omen_Healer")
local GetTime = _G.GetTime
local pairs, select = _G.pairs, _G.select
local tremove, tinsert = _G.tremove, _G.tinsert

local Healer = Omen:NewModule("Healer", Omen.ModuleBase, "AceEvent-3.0", "AceTimer-3.0")

local configOptions = {
	Column = {
		Spacing = 4
	},
	Source = "oRA2"
}

local options = {
	type = "group",
	name = L["Healer Mode"],
	desc = L["Healer Mode"],
	args = {
		test = {
			type = "execute",
			name = OL["Show test bars"],
			desc = OL["Show test bars"],
			func = function() Omen:EnableModule("Healer") Healer:Test() end
		},
		tanksource = {
			type = "group",
			name = L["Data source"],
			desc = L["Get tanks from..."],
			args = {
				ora = {
					type = "toggle",
					name = L["oRA2 Main Tanks"],
					desc = L["oRA2 Main Tanks"],
					get = function() return Healer:GetOption("Source") == "oRA2" end,
					set = function(info, v)
						if v then
							Healer:SetOption("Source", "oRA2")
							Healer:SetMTSource("oRA2")
						end
					end,
					disabled = function() return oRA == nil end
				},
				blizzard = {
					type = "toggle",
					name = L["Blizzard Main Tanks"],
					desc = L["Blizzard Main Tanks"],
					get = function() return Healer:GetOption("Source") == "Blizzard" end,
					set = function(info, v)
						if v then
							Healer:SetOption("Source", "Blizzard")
							Healer:SetMTSource("Blizzard")
						end
					end
				}
			}
		},
		spacing = {
			type = "range",
			name = L["Column Spacing"],
			desc = L["Column Spacing"],
			min = 0,
			max = 25,
			step = 1,
			bigStep = 1,
			get = function(info) return Healer:GetOption("Column.Spacing") end,
			set = function(info, v)
				Healer:SetOption("Column.Spacing", v)
				Healer:SetColumnSpacing(v)
				Omen:UpdateDisplay()
			end
		}
	}
}

local tankPositions, tankGUIDs = {}, {}
	
local function sortBars(a, b)
	if a.isTitle then return true end
	if b.isTitle then return false end
	return a.value > b.value
end

local oRA2Listener = {}

function Healer:OnInitialize()
	self:Super("OnInitialize")
	self.icon = select(3, GetSpellInfo(71))
	self:RegisterConfigDefaults(configOptions)
	self:RegisterOptions(options)
	self:SetColumnSpacing(self:GetOption("Column.Spacing"))
	
	if AceLibrary and AceLibrary:HasInstance("AceEvent-2.0") then
		AceLibrary("AceEvent-2.0"):embed(oRA2Listener)
	end
end

function Healer:Hint()
	return L["Healer Mode\n|cffffffffShows an overview of tank target threat\nTank targets come from oRA2 or the Blizzard tank settings.|r"]
end

function Healer:UpdateLayout()
	self:ArrangeBars()
end

function Healer:OnEnable()
	self:Super("OnEnable")
	Threat.RegisterCallback(self, "ThreatUpdated")
	Omen:SetTitle(L["Healer Mode"] .. ": " .. UnitName("player"))
	self:ClearBars()
	self:ClearColumns()
	self:RegisterEvent("UNIT_TARGET")
	self:SetMTSource(self:GetOption("Source"))
end

function Healer:OnDisable()
	self:Super("OnDisable")
	Threat.UnregisterCallback(self, "ThreatUpdated")
end

function Healer:ClearColumns()
	for k, v in pairs(columns) do
		for k2, v2 in pairs(v) do
			v[k2] = nil
		end
	end
end

local lastUpdateTime = 0
function Healer:UpdateBar(srcGUID, tankGUID, dstGUID, threat, column, overrideMax)
	local bar, isNew = self:AcquireBar(srcGUID .. "-" .. tankGUID)
	columns[column] = columns[column] or {}

	if isNew then
		bar:SetLabels(
			"Name", "LEFT", 70,
			"%Max", "RIGHT", 30
		)
		local pName= Threat.GUIDNameLookup[srcGUID]
		bar:SetLabel("Name", pName or "<unknown>")
		if pName then
			bar:SetClass(select(2, UnitClass(pName)))
		end
		tinsert(columns[column], bar)
	end
	local tankThreat = Threat:GetThreat(tankGUID, dstGUID)
	local pct
	if tankThreat then
		pct = threat / (overrideMax or tankThreat)
	else
		pct = 0
	end

	bar.value = pct
	if GetTime() - lastUpdateTime > 0.25 then
		lastUpdateTime = GetTime()
		self:ArrangeBars()
	end
end

function Healer:SetColumnHeader(column, header)
	local bar, isNew = self:AcquireBar("HealerColumn" .. column)
	columns[column] = columns[column] or {}
	if isNew then
		bar:SetLabels(
			"Name", "CENTER", 100
		)	
		bar:SetColor(0,0,0,0)
		bar.isTitle = true
		bar.value = 0
		tinsert(columns[column], bar)
	end
	bar:SetLabel("Name", header)
	self:ArrangeBars()
end

function Healer:ArrangeBars()
	for k = 1, #columns do
		self:ArrangeColumn(k)
	end
end

function Healer:ArrangeColumn(col)
	local v = columns[col]
	self:ResetBars(col)

	-- Clean up unused bars
	for i = #v, 1, -1 do
		local bar = v[i]
		if (bar.value ~= bar.value or bar.value <= 0) and not bar.isTitle then
			tremove(v, i)
			self:ReleaseBar(bar)
		end
	end

	table_sort(v, sortBars)
	local flag = true
	for i = 1, #v do
		local bar = v[i]
		if flag and self:AddBar(bar, col) then
			if not bar.isTitle then
				local pct = bar.value
				bar:SetPercent(pct)
				bar:SetLabel("%Max", ("%.0f%%"):format(pct*100))
			end
		else
			flag = false
			bar.frame:Hide()
		end
	end
end

function Healer:ThreatUpdated(event, srcGUID, dstGUID, threat)
	if self.testing then
		self:ReleaseBars()
		self.testing = false
		local source = self:GetOption("Source")
		if source == "oRA2" then
			self:oRAUpdateMainTanks()
		elseif source == "Blizzard" then
			self:GetBlizzardTanks()
		end
	end
	for k, v in pairs(tankPositions) do
		if dstGUID == UnitGUID(tankGUIDs[k] .. "-target") then
			self:UpdateBar(srcGUID, k, dstGUID, threat, v)
		end
	end
end

function Healer:UpdateThreatOnTank(unit)
	local tankGUID = UnitGUID(unit)
	local pos = tankPositions[tankGUID]
	if not pos then return end
	
	self:SetColumnHeader(pos, UnitName(unit .. "-target") or "<none>")
	
	if not columns[pos] then return end
	
	for k, v in pairs(columns[pos]) do
		v.value = 0
	end
	
	local dstGUID = UnitGUID(unit .. "-target")
	if dstGUID then
		for k, v in Threat:IterateGroupThreatForTarget(dstGUID) do
			self:UpdateBar(k, tankGUID, dstGUID, v, pos)
		end
	end
	self:ArrangeColumn(pos)
end

function Healer:AddTank(unitID)
	local ct = 0
	for k, v in pairs(tankPositions) do
		ct = ct + 1
	end
	local uid = UnitGUID(unitID)
	if not uid then return end
	-- if not tankPositions[uid] then
		tankPositions[uid] = ct + 1
	-- end
	tankGUIDs[uid] = unitID
	self:SetNumColumns(ct + 1)
	self:ClearColumns()
	self:UNIT_TARGET(nil, unitID)
	self:UpdateThreatOnTank(unitID)
	self:ArrangeBars()
end

function Healer:RemoveTank(unitID)
	local uid = UnitGUID(unitID)
	tankGUIDs[uid] = nil
	tankPositions[uid] = nil
	local ct = 0
	for k, v in pairs(tankGUIDs) do
		ct = ct + 1
	end
	self:SetNumColumns(ct)
	self:ClearColumns()
	self:ArrangeBars()
	
	-- TODO: Refresh display
end

function Healer:ClearTanks()
	for k, v in pairs(tankGUIDs) do
		tankGUIDs[k] = nil
		tankPositions[k] = nil
	end
	self:SetNumColumns(1)
	self:ClearColumns()
	self:ArrangeBars()
end

function Healer:Test()
	self.testing = true
	self:ReleaseBars()
	self:ClearColumns()
	self:SetNumColumns(4)
	local pGUID = UnitGUID("player")
	for j = 1, 4 do
		for i = 1, math.random(10) do
			local temp = string.format("0x%02x", i)
			local temp2 = string.format("0x%02x", j)
			if i == 5 then
				self:UpdateBar(pGUID, temp2, temp, i, j, 11)
			else
				self:UpdateBar(temp, temp2, temp, i, j, 11)
			end
		end
	end
	self:ArrangeBars()
end

function Healer:UNIT_TARGET(event, unit)
	if self.testing then
		self:ReleaseBars()
		self.testing = false
		local source = self:GetOption("Source")
		if source == "oRA2" then
			self:oRAUpdateMainTanks()
		elseif source == "Blizzard" then
			self:GetBlizzardTanks()
		end
	end
	if tankPositions[UnitGUID(unit)] then
		self:UpdateThreatOnTank(unit)
	end
end

function Healer:SetMTSource(source)
	if source == "oRA2" then
		self:WatchORA()
	elseif source == "Blizzard" then
		self:WatchBlizzard()
	end
end

-- blizzard compat

function Healer:WatchBlizzard()
	self:RegisterEvent("RAID_ROSTER_UPDATE")
	self:GetBlizzardTanks()
end

function Healer:RAID_ROSTER_UPDATE()
	self:GetBlizzardTanks()
end

function Healer:GetBlizzardTanks()
	self:ClearTanks()
	local numRaidMembers = GetNumRaidMembers()
	local cols = 0
	for i=1, MAX_RAID_MEMBERS do
		if i > numRaidMembers then break end
		local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, loot = GetRaidRosterInfo(i)
		if role == "MAINTANK" then
			local _, cls = UnitClass(name)
			if true or cls == "WARRIOR" or cls == "PALADIN" or cls == "DRUID" then
				self:AddTank(name)
				cols = cols + 1
			end
		end
	end
	self:SetNumColumns(cols)
end

-- oRA2 compat
function Healer:WatchORA()
	if oRA2Listener.RegisterEvent then
		oRA2Listener:RegisterEvent("oRA_MainTankUpdate")
		self:oRAUpdateMainTanks()
	end
end

function oRA2Listener:oRA_MainTankUpdate()
	Healer:oRAUpdateMainTanks()
end

function Healer:oRAUpdateMainTanks()
	if not self:IsEnabled() then return end
	if not oRA then return end
	if not oRA.maintanktable then return end

	self:ClearTanks()
	local cols = 0
	for k, v in pairs(oRA.maintanktable) do
		if v then
			local _, cls = UnitClass(v)
			if true or cls == "WARRIOR" or cls == "PALADIN" or cls == "DRUID" then
				self:AddTank(v)
				cols = cols + 1
			end
		end
	end
	self:SetNumColumns(cols)
end
