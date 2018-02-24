local MINOR_VERSION = tonumber(("$Revision: 74823 $"):match("%d+"))
if MINOR_VERSION > Omen.MINOR_VERSION then Omen.MINOR_VERSION = MINOR_VERSION end

local bars
local SingleTarget = Omen:NewModule("SingleTarget", Omen.ModuleBase, "AceEvent-3.0", "AceTimer-3.0")
local Threat = LibStub("Threat-2.0")
local timers = {}
local table_sort = _G.table.sort
local math_abs = _G.math.abs
local OL = LibStub("AceLocale-3.0"):GetLocale("Omen")
local L = LibStub("AceLocale-3.0"):GetLocale("Omen_SingleTarget")
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitIsPlayer = _G.UnitIsPlayer
local UnitPlayerControlled = _G.UnitPlayerControlled
local math_floor = _G.math.floor
local lastTargetSwitchTime = 0
local pairs = _G.pairs
local unpack = _G.unpack

-- config upvalues
local WarningThreshold, ShowSelf, ShowAggroBar, ShowTitle, NormalizeTo100

local configOptions = {
	TPS = {
		UpdateFrequency = 0.1
	},
	Warnings = {
		Enable = true,
		EnableSound = true,
		EnableFlash = true,
		EnableShake = false,
		EnableMessage = true,
		Threshold = 90,
		SoundFile = "Fel Nova",
		DisableWhileTanking = true
	},
	Columns = {
		Name = true,
		Threat = true,
		TPS = true,
		Percent = true
	},
	AggroBar = {
		Enable = true,
		Color = {r = 1, g = 0, b = 0, a = 1}
	},
	MyBar = {	
		UseCustomColor = true,
		Color = {r = 1, g = 0, b = 0, a = 1}
	},
	ShowTitleBar = true,
	ShowSelf = true
}
local Media = LibStub("LibSharedMedia-3.0")
local sounds = Media:List("sound")

local function GetLSMIndex(t, value)
	for k, v in pairs(Media:List(t)) do
		if v == value then
			return k
		end
	end
	return nil
end

local options = {
	type = "group",
	name = L["Single Target Mode"],
	desc = L["Single Target Mode"],
	args = {
		test = {
			type = "execute",
			name = OL["Show test bars"],
			desc = OL["Show test bars"],
			func = function() Omen:EnableModule("SingleTarget"); SingleTarget:Test() end
		},	
		warnings = {
			type = "group",
			name = L["Warnings"],
			desc = L["Warnings"],
			args = {
				enable = {
					type = "toggle",
					name = L["Enable Warnings"],
					desc = L["Enable Warnings"],
					order = 1,
					get = function(info)
						return SingleTarget:GetOption("Warnings.Enable")
					end,
					set = function(info, v)
						SingleTarget:SetOption("Warnings.Enable", v)
					end
				},
				sound = {
					type = "toggle",
					name = L["Enable Sound"],
					desc = L["Enable Sound"],
					get = function(info)
						return SingleTarget:GetOption("Warnings.EnableSound")
					end,
					set = function(info, v)
						SingleTarget:SetOption("Warnings.EnableSound", v)
					end,
					disabled = function() return not SingleTarget:GetOption("Warnings.Enable") end
				},
				flash = {
					type = "toggle",
					name = L["Enable Screen Flash"],
					desc = L["Enable Screen Flash"],
					get = function(info)
						return SingleTarget:GetOption("Warnings.EnableFlash")
					end,
					set = function(info, v)
						SingleTarget:SetOption("Warnings.EnableFlash", v)
					end,
					disabled = function() return not SingleTarget:GetOption("Warnings.Enable") end
				},
				shake = {
					type = "toggle",
					name = L["Enable Screen Shake"],
					desc = L["Enable Screen Shake"],
					get = function(info)
						return SingleTarget:GetOption("Warnings.EnableShake")
					end,
					set = function(info, v)
						SingleTarget:SetOption("Warnings.EnableShake", v)
					end,
					disabled = function() return not SingleTarget:GetOption("Warnings.Enable") end
				},				
				message = {
					type = "toggle",
					name = L["Enable Warning Message"],
					desc = L["Print a message to screen when you accumulate too much threat"],
					get = function(info)
						return SingleTarget:GetOption("Warnings.EnableMessage")
					end,
					set = function(info, v)
						SingleTarget:SetOption("Warnings.EnableMessage", v)
					end,
					disabled = function() return not SingleTarget:GetOption("Warnings.Enable") end				
				},
				soundFile = {
					type = "select",
					name = L["Sound to play"],
					desc = L["Sound to play"],
					values = sounds,
					get = function(info) return GetLSMIndex("sound", SingleTarget:GetOption("Warnings.SoundFile")) end,
					set = function(info, v)
						SingleTarget:SetOption("Warnings.SoundFile", sounds[v])
						PlaySoundFile(Media:Fetch("sound", sounds[v]))
					end,
					disabled = function() return not SingleTarget:GetOption("Warnings.Enable") end
				},
				threshold = {
					type = "range",
					name = L["Warning Threshold"],
					desc = L["Warning Threshold"],
					get = function(info) return SingleTarget:GetOption("Warnings.Threshold") end,
					set = function(info, v)
						SingleTarget:SetOption("Warnings.Threshold", v)
						WarningThreshold = v
					end,
					step = 1,
					bigStep = 5,
					min = 60,
					max = 130,
					disabled = function() return not SingleTarget:GetOption("Warnings.Enable") end
				},
				test = {
					type = "execute",
					name = L["Test warnings"],
					desc = L["Test warnings"],
					func = function() SingleTarget:TestWarnings() end,
					order = 101,
					disabled = function() return not SingleTarget:GetOption("Warnings.Enable") end
				},
				disablewhiletanking = {
					type = "toggle",
					name = L["Disable while tanking"],
					desc = L["Disable warnings while you are tanking"],
					get = function(info)
						return SingleTarget:GetOption("Warnings.DisableWhileTanking")
					end,
					set = function(info, v)
						SingleTarget:SetOption("Warnings.DisableWhileTanking", v)
					end,
				}				
			}
		},
		showself = {
			type = "toggle",
			name = L["Always show self"],
			desc = L["Always show yourself on the meter"],
			get = function(info) return SingleTarget:GetOption("ShowSelf") end,
			set = function(info, v)
				SingleTarget:SetOption("ShowSelf", v)
				ShowSelf = v
				SingleTarget:ArrangeBars()
				Omen:ResizeBars()
			end
		},
		showtitle = {
			type = "toggle",
			name = L["Show title bar"],
			desc = L["Show column headers on a title bar"],
			get = function(info) return SingleTarget:GetOption("ShowTitleBar") end,
			set = function(info, v)
				SingleTarget:SetOption("ShowTitleBar", v)
				ShowTitle = v
				if not v then
					local titleBar, newTitle = SingleTarget:AcquireBar("TITLE", true)
					if titleBar then
						SingleTarget:ReleaseBar(titleBar)
					end
				end
				SingleTarget:ArrangeBars()
				Omen:ResizeBars()
			end
		},		
		threatMode = {
			type = "toggle",
			name = L["Show tank as 100%"],
			desc = L["Show tank as 100%, rather than 0%"],
			get = function(info) return SingleTarget:GetOption("NormalizeTo100") end,
			set = function(info, v)
				SingleTarget:SetOption("NormalizeTo100", v)
				NormalizeTo100 = v
				SingleTarget:ArrangeBars()
			end
		},
		columns = {
			type = "group",
			name = L["Columns"],
			desc = L["Select which columns to show"],
			args = {
				name = {
					type = "toggle",
					name = L["Name"],
					desc = L["Show the Name column"],
					get = function(info) return SingleTarget:GetOption("Columns.Name") end,
					set = function(info, v)
						SingleTarget:SetOption("Columns.Name", v)
						SingleTarget:UpdateBarLabels()
					end
				},
				tps = {
					type = "toggle",
					name = L["TPS"],
					desc = L["Show the TPS column"],
					get = function(info) return SingleTarget:GetOption("Columns.TPS") end,
					set = function(info, v)
						SingleTarget:SetOption("Columns.TPS", v)
						SingleTarget:UpdateBarLabels()
					end
				},
				tpqfreq = {
					type = "range",
					name = L["TPS Update Frequency"],
					desc = L["TPS Update Frequency"],
					min = 0.05,
					max = 5.0,
					step = 0.05,
					bigStep = 0.05,
					get = function(info) return SingleTarget:GetOption("TPS.UpdateFrequency") end,
					set = function(info, v)
						SingleTarget:SetOption("TPS.UpdateFrequency", v)
						SingleTarget:ReInitTPSTimer()
					end
				},
				threat = {
					type = "toggle",
					name = L["Threat"],
					desc = L["Show the Threat column"],
					get = function(info) return SingleTarget:GetOption("Columns.Threat") end,
					set = function(info, v)
						SingleTarget:SetOption("Columns.Threat", v)
						SingleTarget:UpdateBarLabels()
					end
				},
				pct = {
					type = "toggle",
					name = L["Percent"],
					desc = L["Show the Percent column"],
					get = function(info) return SingleTarget:GetOption("Columns.Percent") end,
					set = function(info, v)
						SingleTarget:SetOption("Columns.Percent", v)
						SingleTarget:UpdateBarLabels()
					end
				}
			}
		},
		yourbar = {
			type = "group",
			name = L["Your Bar"],
			desc = L["Your Bar"],
			args = {
				color = {
					type = "color",
					name = OL["Color"],
					desc = L["The color of your bar's background"],
					hasAlpha = true,
					get = function(info)
						local r = SingleTarget:GetOption("MyBar.Color.r")
						local g = SingleTarget:GetOption("MyBar.Color.g")
						local b = SingleTarget:GetOption("MyBar.Color.b")
						local a = SingleTarget:GetOption("MyBar.Color.a")
						return r, g, b, a
					end,
					set = function(info, r, g, b, a)
						SingleTarget:SetOption("MyBar.Color.r", r)
						SingleTarget:SetOption("MyBar.Color.g", g)
						SingleTarget:SetOption("MyBar.Color.b", b)
						SingleTarget:SetOption("MyBar.Color.a", a)
						local pguid = UnitGUID("player")
						for _, bar in pairs(bars) do
							if bar.guid == pguid then
								bar:SetColor(r, g, b, a)
								break
							end
						end
					end,
					disabled = function() return not SingleTarget:GetOption("MyBar.UseCustomColor") end
				},
				customcolor = {
					type = "toggle",
					name = L["Use custom color"],
					desc = L["Use a custom color for your bar in the display list"],
					get = function() return SingleTarget:GetOption("MyBar.UseCustomColor") end,
					set = function(info, v)
						SingleTarget:SetOption("MyBar.UseCustomColor", v)
						local pguid = UnitGUID("player")
						for _, bar in pairs(bars) do
							if bar.guid == pguid then
								if v then
									bar:SetColor(
										SingleTarget:GetOption("MyBar.Color.r"),
										SingleTarget:GetOption("MyBar.Color.g"),
										SingleTarget:GetOption("MyBar.Color.b"),
										SingleTarget:GetOption("MyBar.Color.a")									
									)
								else
									bar:SetClass()
								end
								break
							end
						end
					end
				}
			}
		},
		aggrobar = {
			type = "group",
			name = L["Aggro Bars"],
			desc = L["Aggro Bars"],
			args = {
				show = {
					type = "toggle",
					name = L["Show bar"],
					desc = L["Show bar"],
					get = function(info) return SingleTarget:GetOption("AggroBar.Enable") end,
					set = function(info, v)
						SingleTarget:SetOption("AggroBar.Enable", v)
						ShowAggroBar = v
						SingleTarget:ArrangeBars()
					end
				},
				color = {
					type = "color",
					name = L["Color"],
					desc = L["The color of the aggro gain bar"],
					get = function(info)
						local r = SingleTarget:GetOption("AggroBar.Color.r")
						local g = SingleTarget:GetOption("AggroBar.Color.g")
						local b = SingleTarget:GetOption("AggroBar.Color.b")
						local a = SingleTarget:GetOption("AggroBar.Color.a")
						return r, g, b, a
					end,
					set = function(info, r, g, b, a)
						SingleTarget:SetOption("AggroBar.Color.r", r)
						SingleTarget:SetOption("AggroBar.Color.g", g)
						SingleTarget:SetOption("AggroBar.Color.b", b)
						SingleTarget:SetOption("AggroBar.Color.a", a)
						local bar = SingleTarget:AcquireBar("AGGRO", true)
						if bar then
							bar:SetColor(r,g,b, a)
						end
					end				
				}
			}
		},
		
	}
}

-- sorting helper, just compare the value members
local function sortBars(a, b)
	return a.value > b.value
end

-- threat and GUID upvalues
local selfThreat, aggroThreat, aggroUnit, aggroGUID = 0, nil, "targettarget", nil
local hostileGUID, hostileUnit, playerGUID = nil, "target", nil
local threatUpdatedAt = 0

-- global OnInit function, only called once during addon loading
function SingleTarget:OnInitialize()
	self:Super("OnInitialize")
	self.icon = select(3, GetSpellInfo(53))
	self:RegisterConfigDefaults(configOptions)
	self:RegisterOptions(options)
end

-- global OnEnable, called everytime the user switches to the SingleTarget Module
function SingleTarget:OnEnable()
	self:Super("OnEnable")
	bars = self.bars
	self:ClearBars()

	-- register callbacks and events
	Threat.RegisterCallback(self, "ThreatUpdated")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("UNIT_TARGET")
	self:RegisterEvent("PLAYER_LEAVING_WORLD")
	
	-- fill upvalues with meaningful data
	playerGUID = UnitGUID("player")
	threatUpdatedAt = 0
	
	WarningThreshold = self:GetOption("Warnings.Threshold")
	ShowSelf = self:GetOption("ShowSelf")
	ShowAggroBar = self:GetOption("AggroBar.Enable")
	ShowTitle = self:GetOption("ShowTitleBar")
	NormalizeTo100 = self:GetOption("NormalizeTo100")
	
	self:PLAYER_TARGET_CHANGED()
end

-- global OnDisable
-- unregisters all events and timers in the embeds automatically
function SingleTarget:OnDisable()
	self:Super("OnDisable")
	
	-- unregister Threat callbacks
	Threat.UnregisterCallback(self, "ThreatUpdated")
	
	-- clear timer references so we end up in a clean state
	for k in pairs(timers) do
		timers[k] = nil
	end
end

local barOptions = {}
function SingleTarget:GetBarOptions()
	bars = self.bars
	local options = barOptions
	for i = 1, #options do
		tremove(options)
	end
	local used = 0
	if self:GetOption("Columns.Name") then
		tinsert(options, "Name")
		tinsert(options, "LEFT")
		tinsert(options, 40)
		used = used + 40
	end
	if self:GetOption("Columns.TPS") then
		tinsert(options, "TPS")
		tinsert(options, "LEFT")
		tinsert(options, 20)
		used = used + 20
	end
	if self:GetOption("Columns.Threat") then
		tinsert(options, "Threat")
		tinsert(options, "RIGHT")
		tinsert(options, 20)
		used = used + 20
	end
	if self:GetOption("Columns.Percent") then
		tinsert(options, "%")
		tinsert(options, "RIGHT")
		tinsert(options, 20)
		used = used + 20
	end
	for i = 3, #options, 3 do
		options[i] = options[i] * (100 / used)
	end
	return options
end

function SingleTarget:UpdateBarLabels()
	local options = self:GetBarOptions()
	for k, v in pairs(bars) do
		v:ClearLabels()
		v:SetLabels(unpack(options))
	end
end

function SingleTarget:Hint()
	return L["Single Target Mode\n|cffffffffShows raid threat on your target|r"]
end

function SingleTarget:UpdateLayout()
	self:ArrangeBars()
end

local lastUpdatedAt = 0
function SingleTarget:UpdateBar(guid, threat)
	-- grab the bar corresponding to our GUID
	local bar, isNew = self:AcquireBar(guid)
	-- if its a new bar, then set the labels and colors
	if isNew then
		bar:SetLabels(unpack(self:GetBarOptions()))
		-- this is the player, we might want to give it a special color
		if bar.guid == playerGUID and self:GetOption("MyBar.UseCustomColor") then
			bar:SetColor(
				self:GetOption("MyBar.Color.r"),
				self:GetOption("MyBar.Color.g"),
				self:GetOption("MyBar.Color.b"),
				self:GetOption("MyBar.Color.a")
			)
		else
			bar:SetClass()
		end
		bar:SetLabel("Name", Threat.GUIDNameLookup[guid])
	end
	
	-- set the threat value on the bar
	bar:SetLabel("Threat", bar:ConvertToK(threat))
	bar.value = threat
	
	-- and update all the bars in the display (throttled to 0.25 seconds)
	if GetTime() - lastUpdatedAt > 0.25 then
		aggroThreat = aggroThreat or Threat:GetMaxThreatOnTarget(guid)
		lastUpdatedAt = GetTime()
		self:ArrangeBars()
	end
end


function SingleTarget:ArrangeBars()
	-- Remove all bars from the panel
	self:ResetBars()
	local spaceLeft, barsLeft = self:BarSpaceLeft()
	
	-- Check if we're one of the bars to be displayed
	if ShowSelf then
		for i = 1, #bars do
			if bars[i].guid == playerGUID then
				barsLeft = barsLeft - 1
			end
		end
	end
	
	-- show aggro indicator bar
	if aggroThreat and aggroThreat > 0 and ShowAggroBar and hostileUnit then
		local aggroBar, isNew = self:AcquireBar("AGGRO")
		if isNew then
			aggroBar:SetLabels(unpack(self:GetBarOptions()))
			aggroBar:SetColor(
				self:GetOption("AggroBar.Color.r"),
				self:GetOption("AggroBar.Color.g"),
				self:GetOption("AggroBar.Color.b"),
				self:GetOption("AggroBar.Color.a")
			)
			aggroBar:SetLabel("Name", ("> %s <"):format(L["Pull Aggro"]))
			aggroBar:SetLabel("TPS", "")
		end
		if Threat:UnitInMeleeRange(hostileUnit) then
			aggroBar.value = aggroThreat * 1.1
			aggroBar:SetLabel("Threat", aggroBar:ConvertToK(aggroThreat * 1.1))
		else
			aggroBar.value = aggroThreat * 1.3
			aggroBar:SetLabel("Threat", aggroBar:ConvertToK(aggroThreat * 1.3))
		end
	else
		local aggroBar = self:AcquireBar("AGGRO", true)
		if aggroBar then
			aggroBar.value = 0
		end
	end
	
	-- show title bar (if enabled)
	if ShowTitle then
		local titleBar, newTitle = self:AcquireBar("TITLE")
		if newTitle then
			titleBar.isTitle = true
			titleBar.value = 0
			titleBar:SetColor(0,0,0,0)
			titleBar:SetLabels(unpack(self:GetBarOptions()))
			titleBar:SetLabel("Name", L["Name"])
			titleBar:SetLabel("TPS", L["TPS"])
			titleBar:SetLabel("Threat", L["Threat"])
			titleBar:SetLabel("%", L["Percent"])
		end
		self:AddBar(titleBar)
		barsLeft = barsLeft - 1
	end
	
	-- sort all exisiting bars
	table_sort(bars, sortBars)
	
	-- max threat is set on first iteration with a real bar to reference the 100% mark
	local maxThreat = nil
	
	-- iterate over all our bars (maybe up to 81 for 40 hunters + 40 pets and one aggro bar)
	for i = 1, #bars do
		local bar = bars[i]
		
		-- should the bar be shown? (config settings)
		local hide = (bar.isPet and not Omen:GetOption("Classes.PET")) or (bar.class and not Omen:GetOption("Classes." .. bar.class))
		
		-- if this is our bar, then make sure to show it, nomatter which filter settings are selected
		if bar.guid == playerGUID then
			hide = false
			barsLeft = barsLeft + 1
		end
		
		-- title bars are ignored, added in earlier
		local value = bar.value
		if bar.isTitle then
			-- ignore bar
		elseif not hide and barsLeft > 0 and value > 0 and value == value and self:AddBar(bar) then
			-- value == value is a check for the value 0/0
			-- the bar actually has a threat value, is not hidden, and we have space to add it!
			barsLeft = barsLeft - 1
			
			-- if this is the first bar, then store its value in maxThreat
			if not maxThreat then
				maxThreat = value
				-- if aggroThreat was never set correctly (mob doesnt target, e.g), set it to the current bar value
				if not aggroThreat or aggroThreat == 0 then
					aggroThreat = value
				end
			end
			
			-- compute percent relative to maxThreat and set the bar width accordingly
			bar:SetPercent(value / maxThreat)
			
			-- compute relative percent to aggroThreat
			local visPct = value / aggroThreat
			
			-- update threat labels
			if NormalizeTo100 then
				bar:SetLabel("%", ("%.0f%%"):format(visPct * 100))
			else
				bar:SetLabel("%", ("%.0f%%"):format((visPct - 1) * 100))
			end
		else
			bar.frame:Hide()
		end
	end
end

function SingleTarget:ThreatUpdated(event, srcGUID, dstGUID, threat)
	if not hostileUnit then return end
	if self.testing then
		self:ReleaseBars()
		self.testing = false
	end
	
	-- we only care about valid data for our current hostile target
	if (hostileGUID and dstGUID == hostileGUID) then
		-- grab aggroThreat and selfThreat
		aggroThreat = aggroGUID and ((srcGUID == aggroGUID) and threat or Threat:GetThreat(aggroGUID, dstGUID)) or Threat:GetMaxThreatOnTarget(dstGUID) or 1
		selfThreat = (srcGUID == playerGUID) and threat or Threat:GetThreat(playerGUID, dstGUID) or 0
		
		-- run the warning logic
		self:CheckWarn(srcGUID, dstGUID, threat)
		
		-- update the bar corresponding to this GUID
		self:UpdateBar(srcGUID, threat)
	end
	
	-- update the TPS timers
	threatUpdatedAt = GetTime()
	if not timers.OmenTPSUpdate then
		if not timers.OmenCancelTPSUpdate then
			timers.OmenCancelTPSUpdate = self:ScheduleRepeatingTimer("CancelTPSUpdate", 6)
		end
		timers.OmenTPSUpdate = self:ScheduleRepeatingTimer("UpdateTPS", self:GetOption("TPS.UpdateFrequency"))
	end
end

function SingleTarget:ReInitTPSTimer()
	if timers.OmenTPSUpdate then
		self:CancelTimer(timers.OmenTPSUpdate, true)
		timers.OmenTPSUpdate = self:ScheduleRepeatingTimer("UpdateTPS", self:GetOption("TPS.UpdateFrequency"))
	end
end

function SingleTarget:CancelTPSUpdate()
	if timers.OmenTPSUpdate and GetTime() - threatUpdatedAt > 5 then
		self:CancelTimer(timers.OmenTPSUpdate, true)
		timers.OmenTPSUpdate = nil
		
		self:CancelTimer(timers.OmenCancelTPSUpdate, true)
		timers.OmenCancelTPSUpdate = nil
	end
end

function SingleTarget:UpdateTPS()
	if not hostileUnit then return end
	local target_guid = UnitGUID(hostileUnit)
	if not target_guid then return end
	for k, bar in pairs(bars) do
		if not bar.isTitle and bar.frame:IsVisible() and bar.guid ~= "AGGRO" then
			bar:SetLabel("TPS", ("%2.0f"):format(Threat:GetTPS(bar.guid, target_guid)))
		end
	end
end

function SingleTarget:DisplayThreatForGUID(guid)
	for i = 1, #bars do
		bars[i].value = 0
	end
	for k, v in Threat:IterateGroupThreatForTarget(guid) do
		if v > 0 then
			self:UpdateBar(k, v)
		end
	end
	self:ArrangeBars()
end

local function isValidThreatTarget(unit)
	if not UnitExists(unit) or UnitIsPlayer(unit) or UnitPlayerControlled(unit) then
		return false 
	end
	return true
end

function SingleTarget:TargetTargetCheck()
	if not timers.TargetSwitch and UnitGUID(aggroUnit) ~= aggroGUID then
		self:UNIT_TARGET(nil, "target")
	end
end

function SingleTarget:PLAYER_TARGET_CHANGED()
	-- clear upvalues
	hostileGUID = nil
	hostileUnit = nil
	aggroGUID = nil
	aggroThreat = nil
	
	-- stop our whacky unit timer
	if timers.TargetTargetCheck then
		self:CancelTimer(timers.TargetTargetCheck, true)
		timers.TargetTargetCheck = nil
	end
	
	-- now check which target to track - first directly "target" 
	if isValidThreatTarget("target") then
		hostileUnit = "target"
		aggroUnit = "targettarget"
	-- or for healers "targettarget"
	elseif isValidThreatTarget("targettarget") then
		hostileUnit = "targettarget"
		aggroUnit = "targettargettarget"
		-- this is a whacky update because we dont get events when our mob changes its target
		timers.TargetTargetCheck = self:ScheduleRepeatingTimer("TargetTargetCheck", 0.5)
	end
	
	-- if we didnt find a valid threat target, then just skip everything
	if not hostileUnit then
		-- clear all display except the title if shown, but don't release bars
		for i = 1, #bars do
			bars[i].value = 0
		end
		self:ArrangeBars()
		self:SetTitle(nil)
		return
	end
	
	-- get the GUIDs of our stuff
	hostileGUID = UnitGUID(hostileUnit) 
	aggroGUID = UnitGUID(aggroUnit)
	
	-- get the threat of our new target
	aggroThreat = Threat:GetThreat(aggroGUID, hostileGUID) or 1
	selfThreat = Threat:GetThreat(UnitGUID("player"), hostileGUID) or 0
	
	-- run the display logic
	self:DisplayThreatForGUID(hostileGUID)
	self:UpdateTPS()
	self:SetTitle(UnitName(hostileUnit))
	
	self:UNIT_TARGET(nil, "target")
end

function SingleTarget:CheckWarn(s, d, t)
	if s ~= playerGUID and s ~= aggroGUID then return end
	-- Require that tanks be tanking for at least 2.5 seconds before issuing aggro warnings. Hacky way to fix RSTS warnings.
	
	if Threat:GetModule("Player").isTanking and self:GetOption("Warnings.DisableWhileTanking") then return end
	if GetTime() - lastTargetSwitchTime < 2.5 then return end	
	if not aggroThreat then return end
	
	-- if self.playerGUID = self.aggroGUID then return end
	
	if not self:GetOption("Warnings.Enable") then return end
	
	local pct = selfThreat / aggroThreat * 100
	if pct > WarningThreshold and not self.warned and aggroGUID and playerGUID ~= aggroGUID and aggroThreat > 5 then
		local msg = nil
		if self:GetOption("Warnings.EnableMessage") then
			msg = (L["Passed %s%% of %s's threat!"]):format(WarningThreshold, Threat.GUIDNameLookup[aggroGUID])
		end
		Omen:Warn(
			self:GetOption("Warnings.EnableSound") and Media:Fetch("sound", self:GetOption("Warnings.SoundFile")),
			self:GetOption("Warnings.EnableFlash"),
			self:GetOption("Warnings.EnableShake"),
			msg
		)
		self.warned = true
	elseif pct < (WarningThreshold - 5) and self.warned then
		self.warned = false
	end
end

function SingleTarget:TestWarnings()
	Omen:Warn(
		SingleTarget:GetOption("Warnings.EnableSound") and Media:Fetch("sound", SingleTarget:GetOption("Warnings.SoundFile")),
		SingleTarget:GetOption("Warnings.EnableFlash"),
		SingleTarget:GetOption("Warnings.EnableShake"),
		SingleTarget:GetOption("Warnings.EnableMessage") and "Warning Test" or nil
	)
end

function SingleTarget:SwitchAggroTarget()
	local n = UnitName(aggroUnit)
	if n then
		aggroGUID = UnitGUID(aggroUnit)
		lastTargetSwitchTime = GetTime()
	end
	timers.TargetSwitch = nil
end

function SingleTarget:UNIT_TARGET(event, unit)
	-- we only care for data about our current target
	if unit ~= "target" then return end
	-- logic for targettarget mode
	-- we target another player that didnt have a valid target before, now he switches target 
	if (not hostileUnit and isValidThreatTarget("targettarget")) or (hostileUnit == "targettarget" and hostileGUID ~= UnitGUID(hostileUnit)) then
		self:PLAYER_TARGET_CHANGED()
		return
	end
	if not hostileUnit then return end
	
	-- stop targetswitch timer
	if timers.TargetSwitch then
		self:CancelTimer(timers.TargetSwitch, true)
		timers.TargetSwitch = nil
	end
	-- and start a new timer (only if the target is not casting some spell)
	if not UnitCastingInfo(hostileUnit) or not aggroGUID then
		timers.TargetSwitch = self:ScheduleTimer("SwitchAggroTarget", 0.5)
	end
end

function SingleTarget:PLAYER_LEAVING_WORLD()
	-- Recycle all used bars on zoning out, rather than on changing targets for CPU improvements
	self:ReleaseBars()
end

function SingleTarget:Test()
	self:ReleaseBars()
	
	aggroThreat = 0 
	self.testing = true
	for i = 1, 25 do
		local threat = random() * 10000
		aggroThreat = max(aggroThreat, threat)
		if i == 1 then
			-- Insert yourself as one of the entries
			self:UpdateBar(UnitGUID("player"), threat)
		else
			self:UpdateBar(tostring(i), threat)
		end
	end
	self:ArrangeBars()
end
