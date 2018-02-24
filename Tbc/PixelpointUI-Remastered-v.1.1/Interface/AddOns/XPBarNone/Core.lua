--- Libraries
local dewdrop = AceLibrary("Dewdrop-2.0")
local LSM3 = LibStub("LibSharedMedia-3.0")
local L = AceLibrary("AceLocale-2.2"):new("XPBarNone")
local waterfall = AceLibrary("Waterfall-1.0")

-- Make some stuff local
local _G = _G
local sformat = string.format
local smatch = string.match
local string_len = string.len
local string_gmatch = string.gmatch
local string_reverse = string.reverse
local gsub = string.gsub
local ceil = math.ceil
local floor = math.floor
local math_mod = mod
local tonumber = tonumber
local tostring = tostring
local type = type

-- Colour for the exalted rep, based on colour in the armory.
--local exalted = { r = 0, g = 0.84, b = 0.69 }
local exalted = { r = 0, g = 0.77, b = 0.63 }
-- Set the maximum player level
-- GetAccountExpansionLevel() will return the following for various expansions
-- 0: World of Warcraft.  Max Level 60.  No Expansions installed.
-- 1: The Burning Crusade.  Max Level 70.
-- 2: Wrath of the Lich King.  Max Level 80.  (perhaps!)
-- We then use these values to find the maximum player level by using the
-- MAX_PLAYER_LEVEL_TABLE[]
-- Thanks to cladhaire for informing me of this technique :)
local maxPlayerLevel = MAX_PLAYER_LEVEL_TABLE[GetAccountExpansionLevel()]

-- Register our textures.
LSM3:Register("statusbar", "BantoBar", "Interface\\AddOns\\XPBarNone\\Textures\\bantobar")
LSM3:Register("statusbar", "Charcoal", "Interface\\AddOns\\XPBarNone\\Textures\\charcoal")
LSM3:Register("statusbar", "Glaze", "Interface\\AddOns\\XPBarNone\\Textures\\glaze")
LSM3:Register("statusbar", "LiteStep", "Interface\\AddOns\\XPBarNone\\Textures\\litestep")
LSM3:Register("statusbar", "Marble", "Interface\\AddOns\\XPBarNone\\Textures\\marble")
LSM3:Register("statusbar", "Otravi", "Interface\\AddOns\\XPBarNone\\Textures\\otravi")
LSM3:Register("statusbar", "Perl", "Interface\\AddOns\\XPBarNone\\Textures\\perl")
LSM3:Register("statusbar", "Smooth", "Interface\\AddOns\\XPBarNone\\Textures\\smooth")
LSM3:Register("statusbar", "Striped", "Interface\\AddOns\\XPBarNone\\Textures\\striped")
LSM3:Register("statusbar", "Waves", "Interface\\AddOns\\XPBarNone\\Textures\\waves")

XPBarNone = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0")
local XPBarNone, self = XPBarNone, XPBarNone
XPBarNone:RegisterDB("XPBarNoneDB")
XPBarNone:RegisterDefaults('profile', {
	rested = { r = 0, g = 0.4, b = 1 },
	resting = { r = 1.0, g = 0.82, b = 0.25 },
	normal = { r = 0.8, g = 0, b = 1 },
	remaining = { r = 0.82, g = 0, b = 0 },
	Border = false,
	Texture = "Smooth",
	Width = 1028,
	Height = 20,
	FontSize = 14,
	FontOutLine = false,
	PosX = nil,
	PosY = nil,
	Scale = 1,
	Strata = "HIGH",
	HideText = false,
	IndicateRest = true,
	ShowRemaining = true,
	ShowReputation = false,
	DynamicBars = false,
	AutoWatchRep = true,
	MouseOver = false,
	Locked = false,
	Bubbles = false,
	XPString = "Exp: [curXP]/[maxXP] ([restPC]) :: [curPC] through level [pLVL] :: [needXP] XP left :: [KTL] kills to level",
	RepString = "Rep: [faction] ([standing]) [curRep]/[maxRep] :: [repPC]",
	Clamp = true,
	NeedShowZero = false,
	Commify = false,
})

function XPBarNone:OnInitialize()
	self.options = {
		desc = L["Lightweight XP Bar."],
		type = "group",
		args = {
			general = {
				name = L["General"],
				desc = L["General options"],
				type = "group",
				order = 1000,
				args = {
					lock = {
						name = L["Lock"],
						desc = L["Toggle the locking."],
						type = "toggle",
						get = function() return self.db.profile.Locked end,
						set = function()
							self.db.profile.Locked = not self.db.profile.Locked
						end,
					},
					clamp = {
						name = L["Screen Clamp"],
						desc = L["Toggle screen clamping."],
						type = "toggle",
						get = function() return self.db.profile.Clamp end,
						set = function()
							self.db.profile.Clamp = not self.db.profile.Clamp
							self:ToggleClamp()
						end,
					},
					commify = {
						name = L["Commify"],
						desc = L["Insert thousands separators into long numbers."],
						type = "toggle",
						get = function() return self.db.profile.Commify end,
						set = function()
							self.db.profile.Commify = not self.db.profile.Commify
							self:UpdateXPBar()
						end,
					},
					--[[commifyseparator = {
						name = "Commify Separator",
						desc = "Switch between ',' or '.' as your Commify separator."
						type = "toggle",
						get = function() return self.db.profile.CommifySeparator end,
						set = function()
							self.db.profile.CommifySeparator = not self.db.profile.CommifySeparator
							self:UpdateXPBar()
						end,
						map = {
							[false] = ".",
							[true] = ",",
						},
					},]]
					border = {
						name = L["Border"],
						desc = L["Toggle the border."],
						type = "toggle",
						get = function() return self.db.profile.Border end,
						set = function()
							self.db.profile.Border = not self.db.profile.Border
							self:ToggleBorder()
						end,
					},
					bubbles = {
						name = L["Bubbles"],
						desc = L["Toggle bubbles on the XP bar."],
						type = "toggle",
						get = function() return self.db.profile.Bubbles end,
						set = function()
							self.db.profile.Bubbles = not self.db.profile.Bubbles
							self:ToggleBubbles()
						end,
					},
					scale = {
						name = L["Scale"],
						desc = L["Set the bar scale."],
						type = "range",
						min = 0.5,
						max = 2,
						get = function() return self.db.profile.Scale end,
						set = function(val)
							self:SavePosition()
							XPBarNoneFrame:SetScale(val)
							self.db.profile.Scale = val
							self:RestorePosition()
						end,
					},
					width = {
						name = L["Width"],
						desc = L["Set the bar width."],
						type = "range",
						min = 100,
						max = 2000,
						step = 1,
						get = function() return self.db.profile.Width end,
						set = function(val) 
							self.db.profile.Width = val
							XPBarNoneFrame:SetWidth(val)
							XPBarNoneB:SetWidth(val-4)
							XPBarNoneA:SetWidth(val-4)
							XPBarNoneR:SetWidth(val-4)
							XPBarNoneBubbles:SetWidth(val-4)
						end,

					},
					height = {
						name = L["Height"],
						desc = L["Set the bar height."],
						type = "range",
						min = 10,
						max = 100,
						step = 1,
						get = function() return self.db.profile.Height end,
						set = function(val)
							self.db.profile.Height = val
							XPBarNoneFrame:SetHeight(val)
							XPBarNoneB:SetHeight(val-8)
							XPBarNoneA:SetHeight(val-8)
							XPBarNoneR:SetHeight(val-8)
							XPBarNoneBubbles:SetHeight(val-8)
						end,
					},
					fontsize = {
						name = L["Font Size"],
						desc = L["Change the size of the text."],
						type = "range",
						min = 5,
						max = 30,
						step = 1,
						get = function() return self.db.profile.FontSize end,
						set = function(val)
							self.db.profile.FontSize = val
							self:SetFontOptions()
						end,
					},
					fontoutline = {
						name = L["Font Outline"],
						desc = L["Toggles the font outline."],
						type = "toggle",
						get = function() return self.db.profile.FontOutLine end,
						set = function()
							self.db.profile.FontOutLine = not self.db.profile.FontOutLine
							self:SetFontOptions()
						end,
					},
					mouseover = {
						name = L["Mouse Over"],
						desc = L["Toggles switching between XP bar and Rep bar when you mouse over XPBarNone."],
						type = "toggle",
						disabled = function() return self.db.profile.DynamicBars end,
						get = function() return self.db.profile.MouseOver end,
						set = function()
							self.db.profile.MouseOver = not self.db.profile.MouseOver
						end,
					},
					strata = {
						name = L["Frame Strata"],
						desc = L["Set the frame strata."],
						type = "text",
						get = function() return self.db.profile.Strata end,
						set = function(val)
							self.db.profile.Strata = val
							XPBarNoneFrame:SetFrameStrata(val)
						end,
						validate = { ["HIGH"] = "High", ["MEDIUM"] = "Medium", ["LOW"] = "Low", ["BACKGROUND"] = "Background" },
					},
					texture = {
						name = L["Texture"],
						desc = L["Set the bar texture."],
						type = "text",
						get = function() return self.db.profile.Texture end,
						set = function(val)
							self.db.profile.Texture = val
							self:SetTexture(val)
						end,
						validate = LSM3:List("statusbar")
					},
					hidetext = {
						name = L["Hide Text"],
						desc = L["Hide the text on the XP and Rep bars."],
						type = "toggle",
						get = function() return self.db.profile.HideText end,
						set = function()
							self.db.profile.HideText = not self.db.profile.HideText
							self:UpdateXPBar()
						end,
					},
					needshowzero = {
						name = L["Show Zero"],
						desc = L["Show zero values in the various Need tags, instead of an empty string"],
						type = "toggle",
						get = function() return self.db.profile.NeedShowZero end,
						set = function()
							self.db.profile.NeedShowZero = not self.db.profile.NeedShowZero
							self:UpdateXPBar()
						end,
					},
					dynamicbars = {
						name = L["Dynamic Bars"],
						desc = L["Show Rep bar on max level, XP bar on lower levels."],
						type = "toggle",
						get = function() return self.db.profile.DynamicBars end,
						set = function()
							self.db.profile.DynamicBars = not self.db.profile.DynamicBars
							self:UpdateDynamicBars()
							self:UpdateXPBar()
						end,
					},
				},
			},
			xp = {
				name = L["Experience"],
				desc = L["Experience Bar related options"],
				type = "group",
				order = 2000,
				args = {
					string = {
						name = L["Customise Text"],
						desc = L["Customise the XP text string."],
						type = "text",
						usage = L["Customise the XP text string."],
						get = function() return self.db.profile.XPString end,
						set = function(s)
							self.db.profile.XPString = s
							self:UpdateXPBar()
						end,
					},
					remaining = {
						name = L["Remaining Rested XP"],
						desc = L["Toggle the display of remaining rested XP."],
						type = "toggle",
						get = function() return self.db.profile.ShowRemaining end,
						set = function()
							self.db.profile.ShowRemaining = not self.db.profile.ShowRemaining
							self:UpdateXPBar()
						end,
					},
					resting = {
						name = L["Rest Indication"],
						desc = L["Toggle the rest indication."],
						type = "toggle",
						get = function() return self.db.profile.IndicateRest end,
						set = function()
							self.db.profile.IndicateRest = not self.db.profile.IndicateRest
							self:UpdateXPBar()
						end,
					},
					col = {
						name = L["Colours"],
						desc = L["Set the various bar colours."],
						type = "group",
						args = {
							normal = {
								name = L["Normal"],
								desc = L["Set the colour of the normal bar."],
								type = "color",
								get = function()
									return self.db.profile.normal.r, self.db.profile.normal.g, self.db.profile.normal.b
								end,
								set = function(r, g, b)
									self.db.profile.normal.r, self.db.profile.normal.g, self.db.profile.normal.b = r, g, b
									self:UpdateXPBar()
								end,
								hasAlpha = false
							},
							rested = {
								name = L["Rested"],
								desc = L["Set the colour of the rested bar."],
								type = "color",
								get = function()
									return self.db.profile.rested.r, self.db.profile.rested.g, self.db.profile.rested.b
								end,
								set = function(r, g, b)
									self.db.profile.rested.r, self.db.profile.rested.g, self.db.profile.rested.b = r, g, b
									self:UpdateXPBar()
								end,
								hasAlpha = false
							},
							resting = {
								name = L["Resting"],
								desc = L["Set the colour of the resting bar."],
								type = "color",
								get = function()
									return self.db.profile.resting.r, self.db.profile.resting.g, self.db.profile.resting.b
								end,
								set = function(r, g, b)
									self.db.profile.resting.r, self.db.profile.resting.g, self.db.profile.resting.b = r, g, b
									self:UpdateXPBar()
								end,
								hasAlpha = false
							},
							remaining = {
								name = L["Remaining"],
								desc = L["Set the colour of the remaining bar."],
								type = "color",
								get = function()
									return self.db.profile.remaining.r, self.db.profile.remaining.g, self.db.profile.remaining.b
								end,
								set = function(r, g, b)
									self.db.profile.remaining.r, self.db.profile.remaining.g, self.db.profile.remaining.b = r, g, b
									self:UpdateXPBar()
								end,
								hasAlpha = false
							},
						},
					},
				},
			},
			reputation = {
				name = L["Reputation"],
				desc = L["Reputation Bar related options"],
				type = "group",
				order = 3000,
				args = {
					autowatch = {
						name = L["Auto Watch Reputation"],
						desc = L["Automatically watch the factions you gain rep with."],
						type = "toggle",
						get = function() return self.db.profile.AutoWatchRep end,
						set = function()
							self.db.profile.AutoWatchRep = not self.db.profile.AutoWatchRep
							self:ToggleAutoWatch()
						end,
					},
					showrep = {
						name = L["Show Reputation"],
						desc = L["Show the reputation bar instead of the XP bar."],
						type = "toggle",
						disabled = function() return self.db.profile.DynamicBars end,
						get = function() return self.db.profile.ShowReputation end,
						set = function()
							self.db.profile.ShowReputation = not self.db.profile.ShowReputation
							self:UpdateXPBar()
						end,
					},
					string = {
						name = L["Customise Text"],
						desc = L["Customise the Reputation text string."],
						type = "text",
						usage = L["Customise the Reputation text string."],
						get = function() return self.db.profile.RepString end,
						set = function(s)
							self.db.profile.RepString = s
							self:UpdateRepData()
						end,
					},
				},
			},
			config = {
				name = L["Config"],
				desc = L["Open XPBarNone Configuration Window"],
				type = "execute",
				order = 500,
				func = function()
					waterfall:Open("XPBarNone_Config")
					dewdrop:Close()
				end,
			},
		},
	}
	XPBarNone:RegisterChatCommand({ "/xpbn", "/xpbarnone" }, self.options)

	waterfall:Register('XPBarNone_Config',
		'aceOptions', self.options,
		'title', L["XPBarNone Config"]
	)
end

function XPBarNone:CreateXPBar()
	-- Check if the XPBar was already created before continuing.
	if XPBarNoneFrame then return end

	-- Make the XP Bar.
	XPBarNoneFrame = CreateFrame("Frame", "XPBarNoneFrame", UIParent)
	XPBarNoneFrame:SetFrameStrata(self.db.profile.Strata)
	XPBarNoneFrame:SetMovable(true)
	XPBarNoneFrame:Hide()

	if self.db.profile.Scale then
		XPBarNoneFrame:SetScale(self.db.profile.Scale)
	end

	XPBarNoneFrame:ClearAllPoints()
	if not self.db.profile.PosX then
		XPBarNoneFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	else
		XPBarNoneFrame:SetPoint("BOTTOM", UIParent, "TOPLEFT", self.db.profile.PosX, self.db.profile.PosY)
	end
	XPBarNoneFrame:SetWidth(self.db.profile.Width)
	XPBarNoneFrame:SetHeight(self.db.profile.Height)
	
	XPBarNoneFrame:SetBackdrop({
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", edgeSize = 12,
		insets = {left = 5, right = 5, top = 5, bottom = 5}
	})
	self:ToggleBorder()

	local XPBarNoneButton = CreateFrame("Button", "XPBarNoneButton", XPBarNoneFrame)
	XPBarNoneButton:SetAllPoints(XPBarNoneFrame)
	XPBarNoneButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	XPBarNoneButton:RegisterForDrag("LeftButton")
	XPBarNoneButton:SetScript("OnClick", function()
		-- Paste currently displayed text to editbox on Shift-LeftClick
		if IsShiftKeyDown() and arg1 == "LeftButton" then
			if not ChatFrameEditBox:IsVisible() then ChatFrameEditBox:Show() end
			ChatFrameEditBox:Insert(XPBarNoneText:GetText())
		end
		-- Display options menu on Shift-RightClick
		if IsShiftKeyDown() and arg1 == "RightButton" then
			dewdrop:Register(XPBarNoneButton, 'children', self.options, 'dontHook', true)
			dewdrop:Open(XPBarNoneButton, 'point', "LEFT", 'relativePoint', "RIGHT", 'cursorX', true, 'cursorY', true)
			dewdrop:Unregister(XPBarNoneButton)
		end
		-- Display Reputation Menu on Ctrl-RightClick
		if IsControlKeyDown() and arg1 == "RightButton" then
			dewdrop:Register(XPBarNoneButton, 'children', function() self:DewdropFactionsMenu() end, 'dontHook', true)
			dewdrop:Open(XPBarNoneButton, 'point', "LEFT", 'relativePoint', "RIGHT", 'cursorX', true, 'cursorY', true)
			dewdrop:Unregister(XPBarNoneButton)
		end
	end)
	XPBarNoneButton:SetScript("OnDragStart", function ()
		if not self.db.profile.Locked then
			XPBarNoneFrame:StartMoving()
		end
	end)
	XPBarNoneButton:SetScript("OnDragStop", function()
		XPBarNoneFrame:StopMovingOrSizing()
		self:SavePosition()
	end)
	XPBarNoneButton:SetScript("OnEnter", function()
		if self.db.profile.MouseOver and not IsShiftKeyDown() and not IsControlKeyDown() then
			XPBarNone:ToggleShowReputation()
		else
			self.moshift = 1
		end
	end)
	XPBarNoneButton:SetScript("OnLeave", function()
		if self.db.profile.MouseOver and not self.moshift then
			XPBarNone:ToggleShowReputation()
		else
			self.moshift = nil
		end
	end)

	-- Frame Background
	local XPBarNoneB = CreateFrame("StatusBar", "XPBarNoneB", XPBarNoneFrame)
	XPBarNoneB:SetPoint("CENTER", XPBarNoneFrame, "CENTER", 0, 0)
	XPBarNoneB:SetWidth(XPBarNoneFrame:GetWidth() - 4)
	XPBarNoneB:SetHeight(XPBarNoneFrame:GetHeight() - 8)

	-- XP Bar
	local XPBarNoneA = CreateFrame("StatusBar", "XPBarNoneA", XPBarNoneFrame)
	XPBarNoneA:SetPoint("CENTER", XPBarNoneFrame, "CENTER", 0, 0)
	XPBarNoneA:SetWidth(XPBarNoneFrame:GetWidth() - 4)
	XPBarNoneA:SetHeight(XPBarNoneFrame:GetHeight() - 8)

	-- Remaining Rested XP Bar
	local XPBarNoneR = CreateFrame("StatusBar", "XPBarNoneR", XPBarNoneFrame)
	XPBarNoneR:SetPoint("CENTER", XPBarNoneFrame, "CENTER", 0, 0)
	XPBarNoneR:SetWidth(XPBarNoneFrame:GetWidth() - 4)
	XPBarNoneR:SetHeight(XPBarNoneFrame:GetHeight() - 8)

	-- Bubbles
	local XPBarNoneBubbles = CreateFrame("StatusBar", "XPBarNoneBubbles", XPBarNoneFrame)
	XPBarNoneBubbles:SetStatusBarTexture("Interface\\AddOns\\XPBarNone\\Textures\\bubbles")
	XPBarNoneBubbles:SetPoint("CENTER", XPBarNoneFrame, "CENTER", 0, 0)
	XPBarNoneBubbles:SetWidth(XPBarNoneFrame:GetWidth() - 4)
	XPBarNoneBubbles:SetHeight(XPBarNoneFrame:GetHeight() - 8)

	-- XP Bar Text
	local XPBarNoneText = XPBarNoneButton:CreateFontString("XPBarNoneText", "OVERLAY")
	self:SetFontOptions()
	XPBarNoneText:SetShadowOffset(1, -1)
	XPBarNoneText:SetPoint("CENTER", XPBarNoneFrame, "CENTER")
	XPBarNoneText:SetTextColor(1,1,1,1)

	-- Set frame levels
	XPBarNoneFrame:SetFrameLevel(0)
	XPBarNoneB:SetFrameLevel(XPBarNoneFrame:GetFrameLevel() + 1)
	XPBarNoneR:SetFrameLevel(XPBarNoneFrame:GetFrameLevel() + 2)
	XPBarNoneA:SetFrameLevel(XPBarNoneFrame:GetFrameLevel() + 3)
	XPBarNoneBubbles:SetFrameLevel(XPBarNoneFrame:GetFrameLevel() + 4)
	XPBarNoneButton:SetFrameLevel(XPBarNoneFrame:GetFrameLevel() + 5)

	-- Sort out the textures
	self:SetTexture(self.db.profile.Texture)

	-- Sort out the Bubbles
	self:ToggleBubbles()

	-- Set the screen clamp if required
	self:ToggleClamp()

	-- Restore the bar position
	self:RestorePosition()
end

function XPBarNone:OnEnable()
	self:CreateXPBar()
	self:RegisterEvent("PLAYER_XP_UPDATE", "UpdateXPData")
	self:RegisterEvent("PLAYER_LEVEL_UP", "LevelUp")
	self:RegisterEvent("UPDATE_EXHAUSTION", "UpdateXPBar")
	self:RegisterEvent("PLAYER_UPDATE_RESTING", "UpdateXPData")
	self:RegisterEvent("UPDATE_FACTION", "UpdateXPBar")
	--[[self:RegisterEvent("LibSharedMedia_Registered", "EthernetBroadcast")
	self:RegisterEvent("LibSharedMedia_SetGlobal", function(mtype, override)
		if mtype == "statusbar" then
			self:SetTexture(override)
		end
	end)]]

	LSM3.RegisterCallback(self, "LibSharedMedia_Registered", "MediaUpdate")
	LSM3.RegisterCallback(self, "LibSharedMedia_SetGlobal", function(callback, mtype, override)
		if mtype == "statusbar" and override ~= nil then
			self:SetTexture(override)
		end
	end)

	-- If enabled, initially show the reputation bar on max level
	-- (for those using the same profile for different chars)
	if self.db.profile.DynamicBars then
		self:UpdateDynamicBars()
	end

	self:UpdateXPData()
	self:MediaUpdate()
	XPBarNoneFrame:Show()

	-- Only register this event if we're auto watching
	if self.db.profile.AutoWatchRep then
		self:RegisterEvent("COMBAT_TEXT_UPDATE")
	end
end

function XPBarNone:OnDisable()
	XPBarNoneFrame:Hide()
	LSM3.UnregisterAllCallbacks(self)
end

function XPBarNone:ToggleClamp()
	if self.db.profile.Clamp then
		XPBarNoneFrame:SetClampedToScreen(true)
	else
		XPBarNoneFrame:SetClampedToScreen(false)
	end
end

function XPBarNone:ToggleAutoWatch()
	if self.db.profile.AutoWatchRep then
		if not self:IsEventRegistered("COMBAT_TEXT_UPDATE") then
			self:RegisterEvent("COMBAT_TEXT_UPDATE")
		end
	else
		if self:IsEventRegistered("COMBAT_TEXT_UPDATE") then
			self:UnregisterEvent("COMBAT_TEXT_UPDATE")
		end
	end
end

function XPBarNone:ToggleBorder()
	if self.db.profile.Border then
		XPBarNoneFrame:SetBackdropBorderColor(1,1,1,1)
	else
		XPBarNoneFrame:SetBackdropBorderColor(0,0,0,0)
	end
end

function XPBarNone:ToggleBubbles()
	if self.db.profile.Bubbles then
		XPBarNoneBubbles:Show()
	else
		XPBarNoneBubbles:Hide()
	end
end

function XPBarNone:ToggleShowReputation()
	if self.db.profile.ShowReputation then
		self.db.profile.ShowReputation = false
		self:UpdateXPBar()
	else
		self.db.profile.ShowReputation = true
		self:UpdateXPBar()
	end
end

function XPBarNone:SetTexture(texture)
	local texturePath = LSM3:Fetch("statusbar", texture)
	XPBarNoneB:SetStatusBarTexture(texturePath)
	XPBarNoneA:SetStatusBarTexture(texturePath)
	XPBarNoneR:SetStatusBarTexture(texturePath)
	XPBarNoneB:SetStatusBarColor(0.5, 0.5, 0.5, 0.5)
end

function XPBarNone:MediaUpdate()
	self.options.args.general.args.texture.validate = LSM3:List("statusbar")
end

function XPBarNone:SetFontOptions()
	local font, size, flags = GameFontNormal:GetFont()
	if self.db.profile.FontOutLine then
		flags = "OUTLINE"
	end
	XPBarNoneText:SetFont(font, self.db.profile.FontSize, flags)
end

function XPBarNone:LevelUp(level)
	-- Set to show only reputation and disable the MouseOver mode
	-- if the player hits the max level.
	if level == maxPlayerLevel then
		self.db.profile.ShowReputation = true
		self.db.profile.MouseOver = false
	end
	self:UpdateXPBar()
end

function XPBarNone:UpdateDynamicBars()
	-- Shows only reputation when at max level.
	-- Otherwise, show XP bar.
	if UnitLevel("player") == maxPlayerLevel then
		self.db.profile.ShowReputation = true
		self.db.profile.MouseOver = false
	else
		self.db.profile.ShowReputation = false
		self.db.profile.MouseOver = true
	end
end

function XPBarNone:UpdateXPData()
	local prevXP = self.cXP or 0

	self.cXP = UnitXP("player")
	self.nXP = UnitXPMax("player")
	self.remXP = self.nXP - self.cXP
	self.diffXP = self.cXP - prevXP

	self:UpdateXPBar()
end

local function commify(num)
	if not self.db.profile.Commify or string_len(tostring(num)) <= 3 or type(num) ~= "number" then
		return num
	end
	local str = ""
	local count = 0
	for d in string_gmatch(string_reverse(tostring(num)), "%d") do
		if count ~= 0 and math_mod(count, 3) == 0 then
			str = str .. "," .. d
		else
			str = str .. d
		end
		count = count + 1
	end
	return string_reverse(str)
end


local function GetRepText(repName, repStanding, repMin, repMax, repValue)
	local text = XPBarNone.db.profile.RepString

	--Default: "Rep: [faction] ([standing]) [curRep]/[maxRep] :: [repPC]"
	text = gsub(text, "%[faction%]", repName)
	text = gsub(text, "%[standing%]", _G["FACTION_STANDING_LABEL"..repStanding])
	text = gsub(text, "%[curRep%]", commify(repValue)) --commify(sformat("%d", repValue)))
	text = gsub(text, "%[maxRep%]", commify(repMax)) --commify(sformat("%d", repMax)))
	text = gsub(text, "%[repPC%]", sformat("%.1f%%%%", repValue / repMax * 100))
	text = gsub(text, "%[needRep%]", commify(repMax - repValue)) --commify(sformat("%d", repMax - repValue)))
	text = gsub(text, "%[needPC%]", sformat("%.1f%%%%", floor(100 - (repValue / repMax * 100))))

	return text
end

local function SetWatchedFactionName(faction)
	for i = 1, GetNumFactions() do
		local name,_,_,_,_,_,_,_,isHeader,_,isWatched = GetFactionInfo(i)

		-- We've found our faction
		if name == faction then
			-- If it's not watched, and it's not a header
			-- set it to be watched and return
			-- if it's already watched, or it is a header
			-- do nothing
			if not isWatched and not isHeader then
				SetWatchedFactionIndex(i)
				return
			else
				return
			end
		end
	end
end

function XPBarNone:COMBAT_TEXT_UPDATE(msgtype, faction, amount)
	-- Bail out of it's not a FACTION update.
	if msgtype ~= "FACTION" then
		return
	end

	-- Make sure that we really are watching rep, although, we shouldn't even be in this function if we're not.
	-- I might remove this check later on because of the above fact.
	if self.db.profile.AutoWatchRep then
		-- We don't want to watch factions we're loosing rep with.
		if smatch(amount, "^%-.*") then
			return
		end

		-- Everything OK?  Good, watch the faction.
		SetWatchedFactionName(faction)
	end
end

function XPBarNone:UpdateRepData()
	if not self.db.profile.ShowReputation then return end
	
	local repName, repStanding, repMin, repMax, repValue = GetWatchedFactionInfo()

	if repName == nil then
		if XPBarNoneA:IsVisible() then XPBarNoneA:Hide() end
		XPBarNoneText:SetText(L["You need to select a faction to watch."])
		return
	end

	repMax = repMax - repMin
	repValue = repValue - repMin
	repMin = 0
	
	if not XPBarNoneA:IsVisible() then XPBarNoneA:Show() end

	XPBarNoneR:Hide()
	XPBarNoneA:SetMinMaxValues(min(0, repValue), repMax)
	XPBarNoneA:SetValue(repValue)

	local repColour = FACTION_BAR_COLORS[repStanding]
	XPBarNoneA:SetStatusBarColor(repColour.r, repColour.g, repColour.b)

	if not self.db.profile.HideText then
		XPBarNoneText:SetText(GetRepText(repName, repStanding, repMin, repMax, repValue))
	else
		XPBarNoneText:SetText("")
	end
end

-- function to replace text
local function GetXPText(restedXP)
	local text = XPBarNone.db.profile.XPString

	--Default: "Exp: [curXP]/[maxXP] ([restPC]) :: [curPC] through level [pLVL] :: [needXP] XP left :: [KTL] kills to level"
	text = gsub(text, "%[curXP%]", commify(XPBarNone.cXP))
	text = gsub(text, "%[maxXP%]", commify(XPBarNone.nXP))
	
	if restedXP then
		text = gsub(text, "%[restXP%]", commify(restedXP))
		text = gsub(text, "%[restPC%]", sformat("%.1f%%%%", restedXP / XPBarNone.nXP * 100))
	else
		text = gsub(text, "%[restXP%]", XPBarNone.db.profile.NeedShowZero and "0%%" or "")
		text = gsub(text, "%[restPC%]", XPBarNone.db.profile.NeedShowZero and "0%%" or "")
	end

	text = gsub(text, "%[curPC%]", sformat("%.1f%%%%", XPBarNone.cXP / XPBarNone.nXP * 100))
	text = gsub(text, "%[needPC%]", sformat("%.1f%%%%", 100 - (XPBarNone.cXP / XPBarNone.nXP * 100)))
	text = gsub(text, "%[pLVL%]", UnitLevel("player"))
	text = gsub(text, "%[mLVL%]", maxPlayerLevel)
	text = gsub(text, "%[needXP%]", commify(XPBarNone.remXP))
	local ktl = tonumber(sformat("%d", ceil(XPBarNone.remXP / XPBarNone.diffXP)))
	if ktl <= 0 then
		ktl = '?'
	end
	text = gsub(text, "%[KTL%]", commify(ktl))

	-- Bars to level (those bubble things on the XP bar).  20 bars total, each is 5%.
	text = gsub(text, "%[BTL%]", sformat("%d", ceil(20 - ((XPBarNone.cXP / XPBarNone.nXP * 100) / 5))))

	return text
end

function XPBarNone:UpdateXPBar()
	if dewdrop:IsOpen(XPBarNoneButton) then
		dewdrop:Refresh(1)
	end
	if self.db.profile.ShowReputation then
		self:UpdateRepData()
		return
	else
		if not XPBarNoneA:IsVisible() then
			XPBarNoneA:Show()
		end
	end

	local restedXP = GetXPExhaustion()

	if restedXP == nil then
		if XPBarNoneR:IsVisible() then XPBarNoneR:Hide() end
		local normal = self.db.profile.normal
		XPBarNoneA:SetStatusBarColor(normal.r, normal.g, normal.b)
	else
		XPBarNoneR:SetMinMaxValues(min(0, self.cXP), self.nXP)
		XPBarNoneR:SetValue(self.cXP + restedXP)

		local remaining = self.db.profile.remaining
		XPBarNoneR:SetStatusBarColor(remaining.r, remaining.g, remaining.b)
		
		-- Do we want to indicate rest?
		if IsResting() and self.db.profile.IndicateRest then
			local resting = self.db.profile.resting
			XPBarNoneA:SetStatusBarColor(resting.r, resting.g, resting.b)
		else
			local rested = self.db.profile.rested
			XPBarNoneA:SetStatusBarColor(rested.r, rested.g, rested.b)
		end

		-- Are we showing the remaining xp?
		if self.db.profile.ShowRemaining then
				XPBarNoneR:Show()
		else
				XPBarNoneR:Hide()
		end
	end

	XPBarNoneA:SetMinMaxValues(min(0, self.cXP), self.nXP)
	XPBarNoneA:SetValue(self.cXP)

	-- Are we hiding the text or not?
	if not self.db.profile.HideText then
		XPBarNoneText:SetText(GetXPText(restedXP))
	else
		XPBarNoneText:SetText("")
	end
end

-- Reputation Colours, in HEX.																									       
--[[local RepHexColours = {}
for i = 1, 8 do
	local fbc = FACTION_BAR_COLORS[i]
	RepHexColours[i] = sformat("%2x%2x%2x", fbc.r * 255, fbc.g * 255, fbc.b * 255)																		       
end

-- Generate a coloured text string for the tooltip text.
local function GetRepHexColour(standing, text)
	local hex = RepHexColours[standing]

	return sformat("|cff%s%s|r", hex, text)
end]]

-- Utility functions for the Dewdrop menu
local function GetRepTooltipText(standingText, bottom, top, earned)
	local maxRep = top - bottom
	local curRep = earned - bottom
	local repPercent = curRep / maxRep * 100

	return sformat("Standing: %s\nRep: %s/%s [%.1f%%]", standingText, commify(curRep), commify(maxRep), repPercent)
end

local function ToggleCollapse(faction, isCollapsed)
	if isCollapsed then
		ExpandFactionHeader(faction)
	else
		CollapseFactionHeader(faction)
	end
end

function XPBarNone:DewdropFactionsMenu()
	-- Menu Header
	dewdrop:AddLine(
		'text', L["Faction Listing"],
		'isTitle', true,
		'justifyH', "CENTER",
		'notCheckable', true,
		'textHeight', 14,
		'textR', 1,
		'textG', 1,
		'textB', 1
	)

	-- Create menu
	for faction = 1, GetNumFactions() do
		-- GetFactionInfo() returns
		---- name, description, standingId, bottomValue, topValue, earnedValue, atWarWith,
		---- canToggleAtWar, isHeader, isCollapsed, isWatched
		local name,_,standing,bottom,top,earned,atWar,_,isHeader,isCollapsed,isWatched = GetFactionInfo(faction)

		if not isHeader then
			local repColour
			if standing == 8 then
				repColour = exalted
			else
				repColour = FACTION_BAR_COLORS[standing]
			end
			local standingText = _G["FACTION_STANDING_LABEL"..standing]
			--local tipText = GetRepTooltipText(GetRepHexColour(standing, standingText), bottom, top, earned)
			local tipText = GetRepTooltipText(standingText, bottom, top, earned)

			dewdrop:AddLine(
				'text', sformat("%s (%s)", name, standingText),
				'textHeight', 12,
				'textR', repColour.r,
				'textG', repColour.g,
				'textB', repColour.b,
				'checked', isWatched,
				'func', SetWatchedFactionIndex,
				'arg1', faction,
				'tooltipTitle', name,
				'tooltipText', tipText --,
				--'icon', not isWatched and (atWar and "Interface\\Buttons\\UI-Checkbox-SwordCheck"),
				--'iconWidth', 32
				--'iconHeight', 32
			)
		else
			local tipText, iconPath

			-- If we're collapsed, play with the name and set a different tipText
			if isCollapsed then
				tipText = sformat(L["Click to expand %s faction listing"], name)
				iconPath = "Interface\\Buttons\\UI-PlusButton-Up"
			else
				tipText = sformat(L["Click to collapse %s faction listing"], name)
				iconPath = "Interface\\Buttons\\UI-MinusButton-Up"
			end

			dewdrop:AddLine(
				'text', name,
				'textHeight', 14,
				'checked', true,
				'checkIcon', iconPath,
				'justifyH', "LEFT",
				'func', ToggleCollapse,
				'arg1', faction,
				'arg2', isCollapsed,
				'tooltipTitle', name,
				'tooltipText', tipText
			)
		end
	end

	-- Add a hint
	dewdrop:AddLine(
		'text', L["Hint: Click to set watched faction."],
		'notClickable', true,
		'notCheckable', true,
		'justifyH', "CENTER",
		'textR', 0,
		'textG', 1,
		'textB', 0
	)
end

function XPBarNone:SavePosition()
	local x, y = XPBarNoneFrame:GetLeft(), XPBarNoneFrame:GetTop()
	local s = XPBarNoneFrame:GetEffectiveScale()

	x, y = x*s, y*s

	self.db.profile.PosX = x
	self.db.profile.PosY = y
end

function XPBarNone:RestorePosition()
	local x = self.db.profile.PosX
	local y = self.db.profile.PosY
	if not x or not y then return end

	local s = XPBarNoneFrame:GetEffectiveScale()
	
	x, y = x/s, y/s
	
	x, y = 0, 3

	XPBarNoneFrame:ClearAllPoints()
	XPBarNoneFrame:SetPoint("BOTTOM", UIParent, "BOTTOM", x, y)
end

--[[function XPBarNone:SetOrientation()
	local orientation = self.db.profile.Orientation
	local width, height
	if orientation == "HORIZONTAL" then
		width = self.db.profile.Width
		height = self.db.profile.Height
	else
		width = self.db.profile.Height
		height = self.db.profile.Width
	end

	XPBarNoneFrame:SetWidth(width)
	XPBarNoneB:SetWidth(width - 4)
	XPBarNoneA:SetWidth(width - 4)
	XPBarNoneR:SetWidth(width - 4)
	XPBarNoneBubbles:SetWidth(width - 4)

	XPBarNoneFrame:SetHeight(height - 8)
	XPBarNoneB:SetHeight(height - 8)
	XPBarNoneA:SetHeight(height - 8)
	XPBarNoneR:SetHeight(height - 8)
	XPBarNoneBubbles:SetHeight(height - 8)
	
	XPBarNoneB:SetOrientation(orientation)
	XPBarNoneA:SetOrientation(orientation)
	XPBarNoneR:SetOrientation(orientation)
	XPBarNoneBubbles:SetOrientation(orientation)
end]]
