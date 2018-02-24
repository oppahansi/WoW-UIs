local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

local pairs = _G.pairs


local function OnFrameMoved(frame)
	local point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint(1)


	GhostPulse.db.profile.frames[frame.pulseName].pulse.x = xOfs
	GhostPulse.db.profile.frames[frame.pulseName].pulse.y = yOfs
	GhostPulse.db.profile.frames[frame.pulseName].pulse.point = point
	GhostPulse.db.profile.frames[frame.pulseName].pulse.relativePoint = relativePoint
end

function GhostPulse:debug(...)
	if GhostPulse.debugMode then
		GhostPulse:Print(...)
	end
end

function GhostPulse:PlayPulseSound(sound)
	if sound ~= nil and sound ~= "" then
		if sml then
			local path = sml:Fetch("sound", sound)
			
			
			if path then
				PlaySoundFile(path)
			end
		else
			if string.find(sound, "\\") then
				PlaySoundFile(sound)
			else
				PlaySound(sound)
				PlaySoundFile("Interface\\AddOns\\GhostPulse\\Sounds\\"..sound)
			end
		end
	end
end

function GhostPulse:OnInitialize()
	-- table helper
	table.isEmpty = function(this)
		local rc = true
		
		
		if this then
			for _, _ in pairs(this) do
				rc = false
				break
			end
		end
				
		return rc
	end
	
	-- libraries
	if self.db.profile.useSharedMedia then
		sml = AceLibrary:HasInstance("LibSharedMedia-2.0") and AceLibrary("LibSharedMedia-2.0") or nil
	end
	
	-- defaults
	self.locked = true
	self:InitializeWatchers()
	self:EnsureDefaults()	
	self:CreateAllFrames()
	self:KickstartWatchers()
	self:PopulateFrameConfigs()
	self:PopulateAlertConfigs()
	self:PopulateSpecificsConfigs()

	self:RegisterEvent("PARTY_MEMBERS_CHANGED")
	self:RegisterEvent("RAID_ROSTER_UPDATE")
end

function GhostPulse:OnEnable()
	self:SetWatchersEnabled(true)
	self:EnableActiveAlerts()
	self:RegisterComm(self.commPrefix, "GROUP", "ReceiveMessage")	
end

function GhostPulse:OnDisable()
	self:SetWatchersEnabled(false)
end

function GhostPulse:OnProfileEnable()
	self:EnsureDefaults()	
	self:PopulateFrameConfigs()
	self:PopulateAlertConfigs()
	self:PopulateSpecificsConfigs()
end

function GhostPulse:RAID_ROSTER_UPDATE()
	AceLibrary("Waterfall-1.0"):Refresh("GhostPulse")
end

function GhostPulse:PARTY_MEMBERS_CHANGED()
	AceLibrary("Waterfall-1.0"):Refresh("GhostPulse")
end

function GhostPulse:ReceiveMessage(prefix, sender, distribution, command, ...)
	if prefix == self.commPrefix then
		if command == "share" then
			local frameInfo = select(1, ...)
			
			
			if type(frameInfo) == "table" then
				if self.db.profile.allowSharedFrames then
					if frameInfo and frameInfo.name then
						self:Print(string.format(L["%s shared a frame with you."], sender))
						
						frameInfo.raidShared = true
						self.db.profile.frames[frameInfo.name] = frameInfo
						self:PopulateFrameConfigs()
						self:CreateAllFrames()
						AceLibrary("Waterfall-1.0"):Refresh("GhostPulse")
					end
				else
					self:Print(string.format(L["%s tried to share a frame with you, but you are not allowing shared frames."], sender))
				end
			end
		end
	end
end

function GhostPulse:EnsureDefaults()
	if self.db.profile.allowSharedFrames == nil then
		self.db.profile.allowSharedFrames = true
	end
	
	self.db.profile.frames = self.db.profile.frames or { }
	self.db.profile.alerts = self.db.profile.alerts or { }
	self.db.profile.specifics = self.db.profile.specifics or { }
	self.db.profile.overlay = self.db.profile.overlay or {
			texture = "",
			alpha = 0.4,
			scale = 1.0,
		}

	if table.isEmpty(self.db.profile.frames) then
		self.db.profile.frames["Cooldowns"] = Pulse:CreateDefaultOptions()
		self.db.profile.frames["Cooldowns"].alertTypes["playercooldown"] = true
	end
	
	
	-- set up default alert entries if needed
	local aTypes = self:GetAlertTypes()
	local defaultSettings = {
		solo = true,
		party = true,
		raid = true,
		inCombat = false,
		whileMounted = false,
		inBattlegrounds = true,
		
		earlyWarning = true,
		earlyWarningColor = { 0.75, 1, 0.75 },
		
		minCooldown = 1.5,
		maxCooldown = 3600,
	}
	
	for _, v in pairs(aTypes) do
		self.db.profile.alerts[v.key] = self.db.profile.alerts[v.key] or CopyTable(defaultSettings)
		
		if self.db.profile.alerts[v.key].inBattlegrounds == nil then
			self.db.profile.alerts[v.key].inBattlegrounds = true
		end
	end
end

function GhostPulse:CreateAllFrames()	
	for i, v in pairs(self.db.profile.frames) do
		v.overlay = self.db.profile.overlay
		v.pulse.autoFade = true
		
		Pulse:New(i, OnFrameMoved, self.PlayPulseSound, v)
	end
end

