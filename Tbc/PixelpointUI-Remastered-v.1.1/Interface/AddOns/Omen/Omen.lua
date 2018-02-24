local MINOR_VERSION = tonumber(("$Revision: 72516 $"):match("%d+"))
local PlayerName = UnitName("player")
local Threat = LibStub("Threat-2.0")
local math_floor = math.floor
local timers = {}
local AceConfig = LibStub("AceConfigDialog-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Omen")

Omen = LibStub("AceAddon-3.0"):NewAddon("Omen", "AceEvent-3.0", "AceTimer-3.0", "AceBucket-3.0", "AceConsole-3.0", "LibSink-2.0")
Omen.MINOR_VERSION = MINOR_VERSION

-- Silently fail embedding if it doesn't exist
LibStub("AceAddon-3.0"):EmbedLibrary(Omen, "LibFuBarPlugin-Mod-3.0", true)

Omen:SetDefaultModuleState(false)
Omen.SkinList = {}

local optFrame
function Omen:OnInitialize()
	Omen2DefaultProfile = Omen2DefaultProfile or {false, "Modders: In your SavedVars, replace the first argument of this table with the profile you want loaded by default, like 'Default'."}
	self.db = LibStub("AceDB-3.0"):New("Omen2DB", nil, Omen2DefaultProfile[1])
	self.db:RegisterDefaults({
		global = {
			skins = {}
		},
		profile = {
			activeSkin = {},
			options = {},
			sinkOptions = {}
		}
	})
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
	self.configOptions.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)

	self:SetSinkStorage(self.db.profile.sinkOptions)
	self.configOptions.args.output = self:GetSinkAce3OptionsDataTable()
	self:CreateFrame()
	if self.Anchor:GetHeight() < 120 then
		self.Anchor:SetHeight(120)
	end
	Omen:PopulateSkinList()

	if LibStub:GetLibrary("LibFuBarPlugin-Mod-3.0", true) then
		-- Create the FuBarPlugin bits.
		self:SetFuBarOption("tooltipType", "GameTooltip")
		self:SetFuBarOption("hasNoColor", true)
		self:SetFuBarOption("cannotDetachTooltip", true)
		self:SetFuBarOption("hideWithoutStandby", true)
		self:SetFuBarOption("iconPath", [[Interface\AddOns\Omen\icon]])	
	end
		
	self.version = ("Omen r%s / Threat-2.0 r%s"):format(Omen.MINOR_VERSION, LibStub.minors["Threat-2.0"])
	
	optFrame = AceConfig:AddToBlizOptions("Omen", "Omen")
	
	if self:GetOption("Standby") then
		self:SetEnabledState(false)
		self:Disable()
	end

	-- Yes, register for it even if had called self:Disable() 3 lines up
	-- because we want to override the anchors saved in layout-cache.txt
	-- which is applied just before PLAYER_LOGIN.
	self:RegisterEvent("PLAYER_LOGIN")
end

function Omen:PLAYER_LOGIN()
	-- We set up anchors here because we only want to do it once on
	-- PLAYER_LOGIN, hence we don't do it in OnEnable() which triggers on
	-- the same event as well as on every subsequent Enable()/Disable() calls.
	self:SetAnchors(true)
	self:UpdateVisible()
	self:UnregisterEvent("PLAYER_LOGIN")
	if self.activeModule then self.activeModule:ClearBars() end
end

function Omen:OnProfileChanged(db, name)
	Omen:ResetMemoizations()
	Omen:SetAnchors(true)
	Omen:UpdateDisplay()
end

function Omen:OnUpdateFuBarTooltip()
	GameTooltip:AddLine("|cffffff00" .. L["Click|r to toggle the Omen window"])
	GameTooltip:AddLine("|cffffff00" .. L["Right-click|r to open the options menu"])
end

function Omen:OnFuBarClick(button)
	self:Toggle()
	Omen:SetOption("HardOff", not OmenAnchor:IsVisible())
end

local modIdx = {}
function Omen:CycleModule(dir)
	local ct, activeIdx = 0, 0
	for k, v in self:IterateModules() do
		ct = ct + 1
		modIdx[ct] = v
		if v:IsEnabled() then
			activeIdx = ct
		end
	end
	
	local newIdx
	if dir == -1 then		
		newIdx = activeIdx - 1
		if newIdx == 0 then
			newIdx = #modIdx
		end
		modIdx[newIdx]:Enable()
	else
		newIdx = activeIdx + 1
		if newIdx == #modIdx + 1 then
			newIdx = 1
		end
		modIdx[newIdx]:Enable()
	end
end

function Omen:EnableLastModule()
	local module = self:GetOption("Modules.LastActive")
	if module then
		-- self:DisableModule(module)
		self:EnableModule(module)
	else
		for k, v in self:IterateModules() do
			-- v:Disable()
			v:Enable()
			break
		end
	end
end

function Omen:DisableModules()
	for k, v in self:IterateModules() do
		v:Disable()
	end
end

function Omen:OnEnable()
	self:LayoutModuleIcons()
	self:EnableLastModule()

	self:Toggle(self:GetOption("Show"))
	
	Threat.RegisterCallback(self, "Activate", "UpdateVisible")
	Threat.RegisterCallback(self, "Deactivate", "UpdateVisible")
	
	if LibStub:GetLibrary("LibFuBarPlugin-Mod-3.0", true) and self:GetOption("FuBar.HideMinimapButton", false) then
		self:Hide()
	end
end

function Omen:OnDisable()
	Threat.UnregisterCallback(self, "Activate")
	Threat.UnregisterCallback(self, "Deactivate")
	self.Anchor:Hide()
end

function Omen:Test()
	self = Omen
	if self.activeModule then
		self.activeModule:Test()
	end
end

function Omen:Flash()
	if not self.FlashFrame then
		local flasher = CreateFrame("Frame", "OmenFlashFrame")
		flasher:SetToplevel(true)
		flasher:SetFrameStrata("FULLSCREEN_DIALOG")
		flasher:SetAllPoints(UIParent)
		flasher:EnableMouse(false)
		flasher:Hide()
		flasher.texture = flasher:CreateTexture(nil, "BACKGROUND")
		flasher.texture:SetTexture("Interface\\FullScreenTextures\\LowHealth")
		flasher.texture:SetAllPoints(UIParent)
		flasher.texture:SetBlendMode("ADD")
		flasher:SetScript("OnShow", function(self)
			self.elapsed = 0
			self:SetAlpha(0)
		end)
		flasher:SetScript("OnUpdate", function(self, elapsed)
			elapsed = self.elapsed + elapsed
			if elapsed < 2.6 then
				local alpha = elapsed % 1.3
				if alpha < 0.15 then
					self:SetAlpha(alpha / 0.15)
				elseif alpha < 0.9 then
					self:SetAlpha(1 - (alpha - 0.15) / 0.6)
				else
					self:SetAlpha(0)
				end
			else
				self:Hide()
			end
			self.elapsed = elapsed
		end)
		self.FlashFrame = flasher
	end

	self.FlashFrame:Show()
end

function Omen:Toggle(setting)
	if not Omen.Anchor then return end
	if setting == nil and self:GetOption("Standby") then
		self:Print("You toggled Omen during standby, so I enabled it first.")
		self:SetOption("Standby", false)
		self:Enable()
		if self.IsFuBarMinimapAttached and self:IsFuBarMinimapAttached() ~= self:GetOption("FuBar.AttachMinimap") then
			self:ToggleFuBarMinimapAttached()
		end
		return -- note: must return here. OnEnable() will call Toggle() again
	end
	if setting ~= nil then
		self:SetOption("Show", setting)
	else
		self:SetOption("Show", not Omen.Anchor:IsVisible())
	end
	if self:GetOption("Show") then
		self.Anchor:Show()
		self:EnableLastModule()
	else
		self.Anchor:Hide()
		self:DisableModules()
	end
end

--------------------------------
-- Yoinked from BigWigs
--------------------------------

-- Shake properties
local shaking = nil
local SHAKE_DURATION = 0.8
local SHAKE_X = 10
local SHAKE_Y = 10
local fail = nil
local shaker = nil

local originalPoints = nil
local function startShake()
	if not shaking then
		-- store old worldframe positions, we need them all, people have frame modifiers for it etc.
		if not originalPoints then
			originalPoints = {}
			for i = 1, WorldFrame:GetNumPoints() do
				table.insert(originalPoints, {WorldFrame:GetPoint(i)})
			end
		end
		shaking = SHAKE_DURATION -- don't think we want to make this a setting.
		shaker:Show()
	end
end

local function shakeOnUpdate(frame, elapsed)
	shaking = shaking - elapsed
	local x, y = 0, 0 -- Resets to original position if we're supposed to stop.
	if shaking <= 0 then -- stop shaking
		shaking = nil
		shaker:Hide()
	else
		x = math.random(-SHAKE_X,SHAKE_X)
		y = math.random(-SHAKE_Y,SHAKE_Y)
	end
	WorldFrame:ClearAllPoints()
	for i, v in ipairs(originalPoints) do
		WorldFrame:SetPoint(v[1], v[2], v[3], v[4] + x, v[5] + y)
	end
end

--------------------------------
-- End yoink
--------------------------------

function Omen:Shake()
	if not shaker then
		shaker = CreateFrame("Frame", "OmenShaker", UIParent)
		shaker:Hide()
		shaker:SetScript("OnUpdate", shakeOnUpdate)
	end
	local check = WorldFrame:IsProtected()
	if not check then
		startShake()
	elseif check and not fail then
		Omen:Print(("|cffff0000%s:|r %s"):format(L["Error"], L["Unable to use shake warning. If you have nameplates turned on, turn them off to enable shake warnings."]))
		fail = true
	end
end

function Omen:Warn(sound, flash, shake, message)
	if sound then
		PlaySoundFile(sound)
	end
	if flash then self:Flash() end
	if shake then self:Shake() end
	if message then self:Pour(message, 1, 0, 0, nil, 24, "OUTLINE", true) end
end

local setupUIFrame = false
function Omen:ShowConfig()
	if IsModifierKeyDown() then
		InterfaceOptionsFrame:SetWidth(700)
		if not setupUIFrame then
			InterfaceOptionsFrame:SetMovable(true)
			InterfaceOptionsFrame:SetScript("OnMouseDown", function() this:StartMoving() end)
			InterfaceOptionsFrame:SetScript("OnMouseUp", function() this:StopMovingOrSizing() end)
			setupUIFrame = true
		end
		InterfaceOptionsFrame_OpenToFrame(optFrame)
	else
		AceConfig:SetDefaultSize("Omen", 500, 550)
		AceConfig:Open("Omen", configFrame)
	end
end
Omen.OpenMenu = Omen.ShowConfig		-- for fubar

function Omen:ShowDropdown()
	local dd = LibStub("LibDropdown-1.0")
	if dd then
		dd:OpenAce3Menu(self.configOptions)
	end
end

do
	local party = {}
	local partySort = {}
	function Omen:VersionCheck(onlyOutOfDate)
		if onlyOutOfDate then
			self:Print(L["ThreatLib Version Check: Outdated party members"])
		else
			self:Print(L["ThreatLib Version Check: All party members"])
		end
		local newestThreatVer = Threat.latestSeenRevision
		local revs = Threat.partyMemberRevisions
		local agents = Threat.partyMemberAgents
		for k, v in pairs(party) do
			party[k] = nil
		end
		for i = 1, 40 do
			local n = UnitName("raid" .. i) or UnitName("party" .. i)
			if n then
				party[n] = true
			end
		end
		for i = 1, #partySort do
			tremove(partySort)
		end
		for k, v in pairs(party) do
			tinsert(partySort, k)
		end
		table.sort(partySort)
		self:Print("-------------------------------------")
		for _, v in ipairs(partySort) do
			if not onlyOutOfDate or (not revs[v] or revs[v] < (newestThreatVer or 0)) then
				self:Print(("%s: %s / %s %s"):format(v, agents[v] or ("|cff777777" .. L["Unknown"] .. "|r"), revs[v] or ("|cff777777" .. L["Unknown"] .. "|r"), Threat:IsCompatible(v) and "" or " - |cffff0000" .. L["Not compatible!"]))
			end
		end
	end
	
	function Omen:WhisperOldClients()
		if not Threat:IsGroupOfficer("player") then
			self:Print(L["You must be the group leader or a group assistant to do this."])
			return
		end
		local newestThreatVer = Threat.latestSeenRevision
		local revs = Threat.partyMemberRevisions
		local agents = Threat.partyMemberAgents
	
		for i = 1, 40 do
			local n = UnitName("raid" .. i) or UnitName("party" .. i)
			if n then
				if Threat:IsCompatible(n) then
					if revs[n] and revs[n] < Threat.latestSeenRevision then
						SendChatMessage(L["Your version of Omen/Threat is out of date. Please update from WAU or http://files.wowace.com/Omen/Omen.zip when possible."], "WHISPER", nil, n)
					end
				else
					SendChatMessage(L["Your version of Omen/Threat is out of date and is not compatible with the newest version. You should update from WAU or http://files.wowace.com/Omen/Omen.zip as soon as possible."], "WHISPER", nil, n)
				end
			end
		end	
	end
end
