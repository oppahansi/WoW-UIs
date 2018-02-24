--[[ simpleMinimap by arJUna ]]--
simpleMinimap = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceEvent-2.0", "AceModuleCore-2.0")
local simpleMinimap = simpleMinimap

local L = AceLibrary("AceLocale-2.2"):new("simpleMinimap")

local stratas = {
	"BACKGROUND",
	"LOW",
	"MEDIUM",
	"HIGH",
	"DIALOG",
	"FULLSCREEN",
	"FULLSCREEN_DIALOG",
	"TOOLTIP"
}

local buttons = {
	bgs = MiniMapBattlefieldFrame,
	map = MiniMapWorldMapButton,
	mail = MiniMapMailFrame,
	meet = MiniMapMeetingStoneFrame,
	time = GameTimeFrame,
	track = MiniMapTracking,
	voice = MiniMapVoiceChatFrame,
	zoomin = MinimapZoomIn,
	zoomout = MinimapZoomOut
}

local inside = true

local options
do
	local function get(key)
		return simpleMinimap.db.profile[key]
	end
	local function set(key, val)
		simpleMinimap.db.profile[key] = val
		simpleMinimap:UpdateScreen()
	end

	options = {
		type = "group",
		args = {
			title = {
				type = "header",
				order = 1,
				name = "simpleMinimap",
			},
			spacer1 = {
				type = "header",
				order = 2,
				name=" ",
			},
			alpha = {
				type = "range",
				order = 5,
				name = L["alpha"],
				desc = L["alpha_desc"],
				min = 0,
				max = 1,
				step = 0.05,
				isPercent = true,
				get = get,
				set = set,
				passValue = "alpha",
			},
			radius = {
				type = "range",
				order = 5,
				name = L["radius"],
				desc = L["radius_desc"],
				min = -20,
				max = 20,
				step = 2,
				get = get,
				set = set,
				passValue = "radius",
			},
			scale = {
				type="range",
				order = 5,
				name = L["scale"],
				desc = L["scale_desc"],
				min = 0.5,
				max = 2,
				step = 0.05,
				get = function() return simpleMinimap.db.profile.scale end,
				set = function(x)
					local p = simpleMinimap.db.profile
					if(p.mapPosition) then
						p.mapPosition[1] = (p.scale / x) * p.mapPosition[1]
						p.mapPosition[2] = (p.scale / x) * p.mapPosition[2]
					end
					p.scale = x
					simpleMinimap:UpdateScreen()
				end
			},
			show = {
				type = "group",
				order = 5,
				name = L["show"],
				desc = L["show_desc"],
				pass = true,
				get = function(key)
					return simpleMinimap.db.profile.show[key]
				end,
				set = function(key, value)
					simpleMinimap.db.profile.show[key] = value
					simpleMinimap:UpdateScreen()
				end,
				args = {
					location = {
						type = "group",
						order = 1,
						name = L["location"],
						desc = L["location"],
						args = {
							show = {
								type = "toggle",
								order = 1,
								name = L["locationShow"],
								desc = L["locationShow_desc"],
								get = get,
								set = set,
								passValue = "locationShow",
							},
							text = {
								type = "toggle",
								order = 2,
								name = L["locationText"],
								desc = L["locationText_desc"],
								get = get,
								set = set,
								passValue = "locationText",
							}
						}
					},
					bgs = {
						type = "toggle",
						order = 5,
						name = L["bgs"],
						desc = L["bgs_desc"],
					},
					direction = {
						type = "toggle",
						order = 5,
						name = L["direction"],
						desc = L["direction_desc"],
						set = set,
					},
					map = {
						type = "toggle",
						order = 5,
						name = L["map"],
						desc = L["map_desc"],
					},
					mail = {
						type = "toggle",
						order = 5,
						name = L["mail"],
						desc = L["mail_desc"],
					},
					meet = {
						type = "toggle",
						order = 5,
						name = L["meet"],
						desc = L["meet_desc"],
					},
					time = {
						type = "toggle",
						order = 5,
						name = L["time"],
						desc = L["time_desc"],
					},
					track = {
						type = "toggle",
						order = 5,
						name = L["track"],
						desc = L["track_desc"],
					},
					voice = {
						type = "toggle",
						order = 5,
						name = L["voice"],
						desc = L["voice_desc"],
					},
					zoom = {
						type = "toggle",
						order = 5,
						name = L["zoom"],
						desc = L["zoom_desc"],
					}
				}
			},
			strata = {
				type="range",
				order = 5,
				name = L["strata"],
				desc = L["strata_desc"],
				min = 1,
				max = 7,
				step = 1,
				get = get,
				set = set,
				passValue = "strata",
			},
			spacer2 = {
				type = "header",
				order = 9,
				name = " ",
			},
			spacer3 = {
				type = "header",
				order = 10,
				name = L["modules"],
			},
			spacer4 = {
				type = "header",
				order = 96,
				name = " ",
			},
			lock = {
				type = "toggle",
				order = 97,
				name = L["lock"],
				desc = L["lock_desc"],
				get = get,
				set = set,
				passValue = "lock",
			},
			lockdown = {
				type = "toggle",
				order = 98,
				name = L["lockdown"],
				desc = L["lockdown_desc"],
				get = get,
				set = set,
				passValue = "lockdown",
			},
			reset = {
				type="execute",
				order = 99,
				name = L["reset"],
				desc = L["reset_desc"],
				func = StaticPopup_Show,
				passValue = "smmRESET",
			}
		}
	}
end

function simpleMinimap:GetOptions()
	return options
end

function simpleMinimap:OnInitialize()
	self:RegisterDB("smmConfig")
	self:RegisterDefaults("profile", {
		alpha = 1,
		buttonResize = false,
		buttonSize = 33,
		lock = false,
		lockdown = false,
		locationShow = true,
		locationText = true,
		mapPosition = nil,
		radius = 0,
		scale = 1,
		strata = 1,
		buttonPos = {},
		show = {
			bgs = true,
			direction = true,
			map = true,
			mail = true,
			meet = true,
			time = true,
			track = true,
			voice = true,
			zoom = true
		},
	})
	self:RegisterChatCommand("/simpleminimap", "/smm", options, "SIMPLEMINIMAP")

	StaticPopupDialogs["smmRESET"] = {
		text = L["reset_popup"], button1 = TEXT(ACCEPT), button2 = TEXT(CANCEL),
		timeout = 30, whileDead = 1, hideOnEscape = 1,
		OnAccept = function()
			self:ResetDB("profile")
			self:UpdateScreen()
		end
	}
end

local function mapDragOn()
	simpleMinimap:MapDrag(true)
end
local function mapDragOff()
	simpleMinimap:MapDrag(false)
end
local function buttonDragOn()
	simpleMinimap:ButtonDrag(true)
end
local function buttonDragOff()
	simpleMinimap:ButtonDrag(false)
end

local frame = nil
function simpleMinimap:GetFrame()
	return frame
end

function simpleMinimap:OnEnable()
	if not frame then
		frame = CreateFrame("Frame", "SMM", Minimap)
		frame:SetWidth(112)
		frame:SetHeight(112)
		frame:SetPoint("CENTER")
		frame:SetToplevel(true)
		frame:EnableMouseWheel(true)
		frame:SetScript("OnMouseWheel", function()
			if arg1 > 0 then
				Minimap_ZoomIn()
			else
				Minimap_ZoomOut()
			end
		end)
	end
	MinimapCluster:SetMovable(true)
	Minimap:RegisterForDrag("LeftButton")
	Minimap:SetScript("OnDragStart", mapDragOn)
	Minimap:SetScript("OnDragStop", mapDragOff)
	Minimap:SetClampedToScreen(true)
	MinimapZoneTextButton:RegisterForDrag("LeftButton")
	MinimapZoneTextButton:SetScript("OnDragStart", mapDragOn)
	MinimapZoneTextButton:SetScript("OnDragStop", mapDragOff)
	for _, f in pairs(buttons) do
		f:SetMovable(true)
		f:RegisterForDrag("LeftButton")
		f:SetScript("OnDragStart", buttonDragOn)
		f:SetScript("OnDragStop", buttonDragOff)
	end
	self:RegisterEvent("MINIMAP_UPDATE_ZOOM")

	MinimapCluster:StartMoving()
	MinimapCluster:StopMovingOrSizing()

	for n, m in self:IterateModules() do
		self:ToggleModuleActive(m, m.db.profile.enabled)
	end

	self:UpdateScreen()
end

function simpleMinimap:OnDisable()
	for n,m in self:IterateModules() do
		self:ToggleModuleActive(m, false)
	end
	self:UpdateScreen()
	MinimapCluster:SetMovable(false)
	Minimap:RegisterForDrag(nil)
	MinimapZoneTextButton:RegisterForDrag(nil)
	for _, f in pairs(buttons) do
		f:SetMovable(false)
		f:RegisterForDrag(nil)
	end
end

function simpleMinimap:OnProfileEnable()
	self:UpdateScreen()
end

--[[ events ]]--

function simpleMinimap:MINIMAP_UPDATE_ZOOM()
	local z = Minimap:GetZoom()

	if GetCVar("minimapZoom") == GetCVar("minimapInsideZoom") then
		if z < 3 then
			Minimap:SetZoom(z + 1)
		else
			Minimap:SetZoom(z - 1)
		end
	else
		z = nil
	end

	if tonumber(GetCVar("minimapInsideZoom")) == Minimap:GetZoom() then
		inside = true
		self:Lockdown(MinimapCluster, "SetAlpha", 1)
	else
		inside = false
		self:Lockdown(MinimapCluster, "SetAlpha", self.db.profile.alpha)
	end

	if z then
		Minimap:SetZoom(z)
	end
end


--[[ frame events ]]--

local function swapZoom(frame)
	local z = frame:GetZoom()
	if z > 0 then
		frame:SetZoom(0)
	else
		frame:SetZoom(1)
	end
	frame:SetZoom(z)
end

local expandedFrame = nil
function simpleMinimap:ExpandMinimap(keystate)
	if keystate == "down" then
		if not expandedFrame then
			expandedFrame = CreateFrame("Minimap", nil, UIParent)
			expandedFrame:SetHeight(UIParent:GetHeight() * 0.6)
			expandedFrame:SetWidth(expandedFrame:GetHeight())
			expandedFrame:SetPoint("CENTER")
			expandedFrame:SetFrameStrata("TOOLTIP")
			expandedFrame:EnableMouse(false)
			expandedFrame:EnableMouseWheel(false)
			expandedFrame:EnableKeyboard(false)
		end
		MinimapCluster:Hide()
		expandedFrame:Show()
		swapZoom(expandedFrame)
	else
		if expandedFrame then
			expandedFrame:Hide()
		end
		MinimapCluster:Show()
		swapZoom(Minimap)
	end
end

function simpleMinimap:MapDrag(kick)
	if kick and not self.db.profile.lock then
		MinimapCluster.isMoving = true
		MinimapCluster:StartMoving()
	elseif MinimapCluster.isMoving then
		MinimapCluster.isMoving = false
		MinimapCluster:StopMovingOrSizing()
		MinimapCluster.smmTouched = true

		local x, y = MinimapCluster:GetCenter()
		local z = UIParent:GetEffectiveScale()
		self.db.profile.mapPosition = { x * z, y * z }
		self:UpdateScreen()
	end
end

local function getPos()
	local mx, my = Minimap:GetCenter()
	local cx, cy = GetCursorPosition(UIParent)
	local z = UIParent:GetEffectiveScale()
	local v = math.deg(math.atan2(cy / z - my, cx / z - mx))

	if v < 0 then
		return v + 360
	elseif v > 360 then
		return v - 360
	else
		return v
	end
end
local function onUpdateFunc()
	this:ClearAllPoints()
	this:SetPoint("CENTER", Minimap, "CENTER", simpleMinimap:GetButtonPos(getPos()))
end
function simpleMinimap:ButtonDrag(kick)
	if kick and not self.db.profile.lock then
		this.isMoving = true
		this:SetScript("OnUpdate", onUpdateFunc)
		this:StartMoving()
	elseif this.isMoving then
		this.isMoving = false
		this:StopMovingOrSizing()
		this:SetScript("OnUpdate", nil)
		for n, f in pairs(buttons) do
			if f == this then
				self.db.profile.buttonPos[n] = getPos()
				break
			end
		end
	end
end


--[[ screen updates ]]--
function simpleMinimap:UpdateScreen()
	local p = self.db.profile
-- set minimap
	self:Lockdown(MinimapCluster, "SetScale", p.scale)
	self:Lockdown(MinimapCluster, "SetFrameStrata", stratas[p.strata])
	self:Lockdown(MinimapCluster, "SetAlpha", p.alpha)
	if p.mapPosition then
		local z = UIParent:GetEffectiveScale()
		self:Lockdown(MinimapCluster, "ClearAllPoints")
		self:Lockdown(MinimapCluster, "SetPoint", "TOPRIGHT", UIParent, "TOPRIGHT", 4, 10)
		MinimapCluster.smmTouched = true
	elseif MinimapCluster.smmTouched then
		self:Lockdown(MinimapCluster, "ClearAllPoints")
		self:Lockdown(MinimapCluster, "SetPoint", "TOPRIGHT", UIParent)
		MinimapCluster:SetUserPlaced(false)
		MinimapCluster.smmTouched = nil
	end
-- set minimap location bar
	if p.locationShow then
		self:Lockdown(MinimapToggleButton, "Show")
		self:Lockdown(MinimapBorderTop, "Show")
		self:Lockdown(MinimapZoneTextButton, "Show")
	else
		self:Lockdown(MinimapToggleButton, "Hide")
		self:Lockdown(MinimapBorderTop, "Hide")
		if p.locationText then
			self:Lockdown(MinimapZoneTextButton, "Show")
		else
			self:Lockdown(MinimapZoneTextButton, "Hide")
		end
	end
-- set minimap buttons
	for n, f in pairs(buttons) do
		if n == "zoomin" or n == "zoomout" then
			if p.show.zoom then
				f:Show()
			else
				f:Hide()
			end
		else
			if not p.show[n] then
				if not f.smmHide then
					f.smmHide, f.smmShow = f.Hide, f.Show
					f.smmDoShow = f:IsShown()
					f.Hide = function() f.smmDoShow = false end
					f.Show = function() f.smmDoShow = true end
				end
				f:smmHide()
			elseif f.smmHide then
				f.Hide, f.Show = f.smmHide, f.smmShow
				if f.smmDoShow then
					f:Show()
				end
				f.smmHide, f.smmShow, f.smmDoShow = nil, nil, nil
			end
		end
		if p.buttonPos[n] then
			if not f.smmOldPos then
				local fx, fy = f:GetCenter()
				local mx, my = Minimap:GetCenter()
				if fx and mx then
					f.smmOldPos = { fx - mx, fy - my }
				end
			end
			f:ClearAllPoints()
			f:SetPoint("CENTER", Minimap, "CENTER", self:GetButtonPos(p.buttonPos[n]))
		elseif f.smmOldPos then
			f:ClearAllPoints()
			f:SetPoint("CENTER", Minimap, "CENTER", f.smmOldPos[1], f.smmOldPos[2])
			f.smmOldPos = nil
		end
	end

	if p.show.direction then
		MinimapNorthTag:SetTexCoord(0,1,0,1)--MinimapNorthTag:Show()
	else
		MinimapNorthTag:SetTexCoord(0,0,0,0)--MinimapNorthTag:Hide()
	end

	-- let any modules update the screen also
	for n,m in self:IterateModules() do
		m:UpdateScreen()
	end
end

local function noop() --[[]] end

--[[ internal functions ]]--
function simpleMinimap:Lockdown(frame, method, ...)
	if self:IsActive() and self.db.profile.lockdown then
		if not frame["smm"..method] then
			frame["smm"..method] = frame[method]
			frame[method] = noop
		end
		return frame["smm"..method](frame, ...)
	else
		if frame["smm"..method] then
			frame[method] = frame["smm"..method]
			frame["smm"..method] = nil
		end
		return frame[method](frame, ...)
	end
end

function simpleMinimap:GetButtonPos(vector)
	local v = math.rad(vector)
	local o = 80 + self.db.profile.radius
	return math.cos(v) * o, math.sin(v) * o
end

--[[ module stuff ]]--

function simpleMinimap:OnModuleCreated(name, module)
	self:SetModuleDefaultState(name, false)
end

local function toggleModule(mod, state)
	simpleMinimap:ToggleModuleActive(mod, state)
	mod.db.profile.enabled = state
end

local function registerModule(mod)
	if mod.options then
		options.args[mod.name] = {
			type = "group",
			name = mod.translatedName,
			desc = mod.desc,
			order = 80,
			args = mod.options,
		}
		options.args[mod.name].args.enabled = {
			type = "toggle",
			name = L["enabled"],
			desc = L["enabled_desc"],
			order = 1,
			get = "IsModuleActive",
			set = toggleModule,
			passValue = mod,
		}
		options.args[mod.name].args.enabledSpacer = {
			type = "header",
			name = " ",
			order = 2,
		}
	end
	mod.db = simpleMinimap:AcquireDBNamespace(mod.name)
	simpleMinimap:RegisterDefaults(mod.name, "profile", mod.defaults)

	if type(mod.OnRegister) == "function" then
		mod:OnRegister()
	end
end

function simpleMinimap.modulePrototype:OnInitialize()
	registerModule(self)
end

function simpleMinimap.modulePrototype:UpdateScreen() end