-------------------------------------------------------------------------------
-- Locals
-------------------------------------------------------------------------------

local DEBUGMODE = false

local BUTTONNAME = {buff="BuffaloButton", debuff="DebuffaloButton", weapon = "WeaponBuffaloButton"}
local BUTTON_TEMPLATE_NAME = {buff="BuffaloButton", debuff="DebuffaloButton", weapon = "WeaponBuffaloButton"}
local FRAME_NAME = {buff="BuffaloFrame", debuff="DebuffaloFrame", weapon = "WeaponBuffaloFrame"}
local MININDEX = {buff=0, debuff=0, weapon=0}
local MAXINDEX = {buff=31, debuff=15, weapon=1}
local TEMPENCHANTGHOSTTEXT = {"MH", "OH"}
local BUFF, DEBUFF, WEAPON = "buff", "debuff", "weapon" -- Categories
local GHOST_COLOR = {
	buff    = {r=0.2, g=0.8, b=0.2},
	debuff  = {r=0.8, g=0.2, b=0.2},
	weapon  = {r=0.2, g=0.2, b=0.8},
	warning = {r=1.0, g=0.2, b=0.2},
	alpha   = 0.8,
}
local BUFF_FILTER={buff="HELPFUL", debuff="HARMFUL"}
local UPDATETIME = 0.2

local anchors = {
	buff = {
		{point="TOPRIGHT", relativeTo="BuffaloFrame", relativePoint="TOPRIGHT", xOffs=0, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton0", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton1", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton2", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton3", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton4", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton5", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton6", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="TOP", relativeTo="BuffaloButton0", relativePoint="BOTTOM", xOffs=0, yOffs=-15},
		{point="RIGHT", relativeTo="BuffaloButton8", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton9", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton10", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton11", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton12", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton13", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton14", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="TOP", relativeTo="BuffaloButton8", relativePoint="BOTTOM", xOffs=0, yOffs=-15},
		{point="RIGHT", relativeTo="BuffaloButton16", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton17", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton18", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton19", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton20", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton21", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton22", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="TOP", relativeTo="BuffaloButton16", relativePoint="BOTTOM", xOffs=0, yOffs=-15},
		{point="RIGHT", relativeTo="BuffaloButton23", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton24", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton25", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton26", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton27", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton28", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="BuffaloButton29", relativePoint="LEFT", xOffs=-5, yOffs=0},
	},
	debuff = {
		{point="TOPRIGHT", relativeTo="DebuffaloFrame", relativePoint="TOPRIGHT", xOffs=0, yOffs=0},
		{point="RIGHT", relativeTo="DebuffButton0", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="DebuffButton1", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="DebuffButton2", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="DebuffButton3", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="DebuffButton4", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="DebuffButton5", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="DebuffButton6", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="TOP", relativeTo="DebuffButton0", relativePoint="BOTTOM", xOffs=0, yOffs=-15},
		{point="RIGHT", relativeTo="DebuffButton8", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="DebuffButton9", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="DebuffButton10", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="DebuffButton11", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="DebuffButton12", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="DebuffButton13", relativePoint="LEFT", xOffs=-5, yOffs=0},
		{point="RIGHT", relativeTo="DebuffButton14", relativePoint="LEFT", xOffs=-5, yOffs=0},
	},
	weapon = {
		{point="TOPRIGHT", relativeTo="WeaponBuffaloFrame", relativePoint="TOPRIGHT", xOffs=0, yOffs=0},
		{point="RIGHT", relativeTo="WeaponBuffalo1", relativePoint="LEFT", xOffs=-5, yOffs=0},
	}
}

local timeSinceWeaponUpdate = 0
local timeSinceBuffUpdate = 0
local loaded = 0

local L = AceLibrary("AceLocale-2.2"):new("Buffalo")
local dewdrop = AceLibrary("Dewdrop-2.0")
local abacus = AceLibrary("LibAbacus-3.0")
local LibButtonFacade = LibStub("LibButtonFacade", true)

-------------------------------------------------------------------------------
-- Initialization
-------------------------------------------------------------------------------

Buffalo = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceEvent-2.0", "AceDebug-2.0")
local self = Buffalo
function Buffalo:OnInitialize()
	self:RegisterDB("BuffaloDB")
	self:RegisterDefaults("profile", BUFFALO_DEFAULT_OPTIONS)
	local slashOptions = {
		type = 'group',
		args={
			lock = {
				type='toggle',
				name=L["Lock"],
				desc=L["When activated, the buff frames are locked and the reference frames are hidden"],
				get= function() return Buffalo.db.profile.locked end,
				set = function(v) Buffalo.ToggleLock(Buffalo, v) end,
				order=1
			},

			buffs = {
				type='group',
				name=L["Buffs"],
				desc=L["Manipulate Buffs Display"],
				order=2,
				args={

					title={
						type='header',
						name=L["Buffs"],
	--					icon="Interface\\Icons\\Ability_DualWield.blp",
						order=5
					},
					scale={
						type='range',
						name=L["Scale"],
						desc=L["Scale Buff Icons"],
						min=0,
						max=10,
						step=0.1,
						get = function() return Buffalo.db.profile.scale["buff"] end,
						set = function(v) Buffalo.SetScale(Buffalo, v, "buff") end,
						order=10
					},

					padding={
						type='group',
						name=L["Padding"],
						desc=L["Control the distance between rows/columns"],
						args={
							x={
								type='range',
								name=L["X-Padding"],
								desc=L["Distance between columns"],
								min=-10,
								max=100,
								step=1,
								get = function() return Buffalo.db.profile.padding["buff"].x end,
								set = function(v) Buffalo.SetPadding(Buffalo, v, "buff", "x") end
							},

							y={
								type='range',
								name=L["Y-Padding"],
								desc=L["Distance between rows"],
								min=-10,
								max=100,
								step=1,
								get = function() return Buffalo.db.profile.padding["buff"].y end,
								set = function(v) Buffalo.SetPadding(Buffalo, v, "buff", "y") end
							}
						},
						order=20
					},


					hGrowth={
						type='text',
						name=L["Horizontal Direction"],
						desc=L["In which horizontal direction should the display grow?"],
						get=function()
								if Buffalo.db.profile.growRight.buff then
									return "right"
								else
									return "left"
								end
							end,
						set=function(v) Buffalo.SetGrowthDirection(Buffalo, v, "buff") end,
						validate = {["left"] = L["To the left"], ["right"]=L["To the right"]},
						order=30
					},

					vGrowth={
						type='text',
						name=L["Vertical Direction"],
						desc=L["In which vertical direction should the display grow?"],
						get=function()
								if Buffalo.db.profile.growUpwards.buff then
									return "up"
								else
									return "down"
								end
							end,
						set=function(v) Buffalo.SetGrowthDirection(Buffalo, v, "buff") end,
						validate = {["up"] = L["Upwards"], ["down"]=L["Downwards"]},
						order=40
					},

					firstGrowth={
						type='text',
						name=L["Growth Precedence"],
						desc=L["In which direction should the display grow first (horizontally or vertically)?"],
						get=function() return Buffalo.db.profile.growHorizontalFirst.buff end,
						set=function(v) Buffalo.SetGrowHorizontalFirst(Buffalo, v, "buff")end,
						validate = {[true] = L["Horizontally"], [false]=L["Vertically"]},
						order=50
					},

					rows={
						type='range',
						name=L["Rows"],
						desc=L["Number of Rows. Only applies when Growth Precedence is Vertical"],
						min=1,
						max=16,
						step=1,
						get = function() return Buffalo.db.profile.rows["buff"] end,
						set = function(v) Buffalo.SetRows(Buffalo, v, "buff") end,
						order=60
					},

					cols={
						type='range',
						name=L["Columns"],
						desc=L["Number of Columns. Only applies when Growth Precedence is Horizontal"],
						min=1,
						max=16,
						step=1,
						get = function() return Buffalo.db.profile.cols["buff"] end,
						set = function(v) Buffalo.SetCols(Buffalo, v, "buff") end,
						order=70
					},
					hide = {
						type='toggle',
						name=L["Hide"],
						desc=L["Hides these buff frames"],
						get= function() return Buffalo.db.profile.hide["buff"] end,
						set = function(v) Buffalo.ToggleHide(Buffalo, v, "buff") end,
						order=90
					},
					flashing = {
						type='toggle',
						name=L["Flashing"],
						desc=L["Toggle flashing on fading buffs"],
						get= function() return Buffalo.db.profile.flashes["buff"] end,
						set = function(v) Buffalo.db.profile.flashes["buff"] = v end,
						order=95
					},
					timers = {
						type='group',
						name=L["Timers"],
						desc=L["Customize buff timers"],
						order=100,
						args = {
							verboseTimer = {
								type='toggle',
								name=L["Verbose Timers"],
								desc=L["Replaces the default time format for timers with HH:MM or MM:SS"],
								get= function() return Buffalo.db.profile.verboseTimers["buff"] end,
								set = function(v) Buffalo.db.profile.verboseTimers["buff"] = v end,
								order=100
							},
							whiteTimer = {
								type='toggle',
								name=L["White Timers"],
								desc=L["Use white timers instead of yellow ones"],
								get= function() return Buffalo.db.profile.whiteTimers["buff"] end,
								set = function(v) Buffalo.db.profile.whiteTimers["buff"] = v end,
								disabled = function() return not Buffalo.db.profile.verboseTimers["buff"] end,
								order=110
							},
						},
					},
				}
			},

			debuffs = {
				type='group',
				name=L["Debuffs"],
				desc=L["Manipulate Debuffs Display"],
				order=3,
				args={
					title={
						type='header',
						name=L["Debuffs"],
	--					icon="Interface\\Icons\\Ability_DualWield.blp",
						order=10
					},
					scale={
						type='range',
						name=L["Scale"],
						desc=L["Scale Debuff Icons"],
						min=0,
						max=10,
						get = function() return Buffalo.db.profile.scale["debuff"] end,
						set = function(v) Buffalo.SetScale(Buffalo, v, "debuff") end,
						order=20
					},

					padding={
						type='group',
						name=L["Padding"],
						desc=L["Control the distance between rows/columns"],
						args={
							x={
								type='range',
								name=L["X-Padding"],
								desc=L["Distance between columns"],
								min=-10,
								max=100,
								step=1,
								get = function() return Buffalo.db.profile.padding["debuff"].x end,
								set = function(v) Buffalo.SetPadding(Buffalo, v, "debuff", "x") end
							},

							y={
								type='range',
								name=L["Y-Padding"],
								desc=L["Distance between rows"],
								min=-10,
								max=100,
								step=1,
								get = function() return Buffalo.db.profile.padding["debuff"].y end,
								set = function(v) Buffalo.SetPadding(Buffalo, v, "debuff", "y") end
							}
						},
						order=30
					},


					hGrowth={
						type='text',
						name=L["Horizontal Direction"],
						desc=L["In which horizontal direction should the display grow?"],
						get=function()
								if Buffalo.db.profile.growRight.debuff then
									return "right"
								else
									return "left"
								end
							end,
						set=function(v) Buffalo.SetGrowthDirection(Buffalo, v, "debuff") end,
						validate = {["left"] = L["To the left"], ["right"]=L["To the right"]},
						order=40
					},

					vGrowth={
						type='text',
						name=L["Vertical Direction"],
						desc=L["In which vertical direction should the display grow?"],
						get=function()
								if Buffalo.db.profile.growUpwards.debuff then
									return "up"
								else
									return "down"
								end
							end,
						set=function(v) Buffalo.SetGrowthDirection(Buffalo, v, "debuff") end,
						validate = {["up"] = L["Upwards"], ["down"]=L["Downwards"]},
						order=50
					},

					firstGrowth={
						type='text',
						name=L["Growth Precedence"],
						desc=L["In which direction should the display grow first (horizontally or vertically)?"],
						get=function() return Buffalo.db.profile.growHorizontalFirst.debuff end,
						set=function(v) Buffalo.SetGrowHorizontalFirst(Buffalo, v, "debuff") end,
						validate = {[true] = L["Horizontally"], [false]=L["Vertically"]},
						order=60
					},

					rows={
						type='range',
						name=L["Rows"],
						desc=L["Number of Rows. Only applies when Growth Precedence is Vertical"],
						min=1,
						max=16,
						step=1,
						get = function() return Buffalo.db.profile.rows["debuff"] end,
						set = function(v) Buffalo.SetRows(Buffalo, v, "debuff") end,
						order=70
					},

					cols={
						type='range',
						name=L["Columns"],
						desc=L["Number of Columns. Only applies when Growth Precedence is Horizontal"],
						min=1,
						max=16,
						step=1,
						get = function() return Buffalo.db.profile.cols["debuff"] end,
						set = function(v) Buffalo.SetCols(Buffalo, v, "debuff") end,
						order=80
					},
					hide = {
						type='toggle',
						name=L["Hide"],
						desc=L["Hides these buff frames"],
						get= function() return Buffalo.db.profile.hide["debuff"] end,
						set = function(v) Buffalo.ToggleHide(Buffalo, v, "debuff") end,
						order=90
					},
					flashing = {
						type='toggle',
						name=L["Flashing"],
						desc=L["Toggle flashing on fading buffs"],
						get= function() return Buffalo.db.profile.flashes["debuff"] end,
						set = function(v) Buffalo.db.profile.flashes["debuff"] = v end,
						order=95
					},
					timers = {
						type='group',
						name=L["Timers"],
						desc=L["Customize buff timers"],
						order=100,
						args = {
							verboseTimer = {
								type='toggle',
								name=L["Verbose Timers"],
								desc=L["Replaces the default time format for timers with HH:MM or MM:SS"],
								get= function() return Buffalo.db.profile.verboseTimers["debuff"] end,
								set = function(v) Buffalo.db.profile.verboseTimers["debuff"] = v end,
								order=100
							},
							whiteTimer = {
								type='toggle',
								name=L["White Timers"],
								desc=L["Use white timers instead of yellow ones"],
								get= function() return Buffalo.db.profile.whiteTimers["debuff"] end,
								set = function(v) Buffalo.db.profile.whiteTimers["debuff"] = v end,
								disabled = function() return not Buffalo.db.profile.verboseTimers["debuff"] end,
								order=110
							},
						},
					},
				}
			},

			weapon = {
				type='group',
				name=L["Weapon Buffs"],
				desc=L["Manipulate Weapon Buffs Display"],
				order=4,
				args={
					title={
						type='header',
						name=L["Weapon Buffs"],
						icon="Interface\\Icons\\Ability_DualWield.blp",
						order=1
					},
					scale={
						type='range',
						name=L["Scale"],
						desc=L["Scale Buff Icons"],
						min=0,
						max=10,
						get = function() return Buffalo.db.profile.scale["weapon"] end,
						set = function(v) Buffalo.SetScale(Buffalo, v, "weapon") end,
						order=2
					},

					padding={
						type='group',
						name=L["Padding"],
						desc=L["Control the distance between rows/columns"],
						args={
							x={
								type='range',
								name=L["X-Padding"],
								desc=L["Distance between columns"],
								min=-10,
								max=100,
								step=1,
								get = function() return Buffalo.db.profile.padding["weapon"].x end,
								set = function(v) Buffalo.SetPadding(Buffalo, v, "weapon", "x") end
							},

							y={
								type='range',
								name=L["Y-Padding"],
								desc=L["Distance between rows"],
								min=-10,
								max=100,
								step=1,
								get = function() return Buffalo.db.profile.padding["weapon"].y end,
								set = function(v) Buffalo.SetPadding(Buffalo, v, "weapon", "y") end
							}
						},
						order=3
					},


					hGrowth={
						type='text',
						name=L["Horizontal Direction"],
						desc=L["In which horizontal direction should the display grow?"],
						get=function() 
								if Buffalo.db.profile.growRight.weapon then
									return "right"
								else
									return "left"
								end
							end,
						set=function(v) Buffalo.SetGrowthDirection(Buffalo, v, "weapon") end,
						validate = {["left"] = L["To the left"], ["right"]=L["To the right"]},
						order=4
					}, 

					vGrowth={
						type='text',
						name=L["Vertical Direction"],
						desc=L["In which vertical direction should the display grow?"],
						get=function() 
								if Buffalo.db.profile.growUpwards.weapon then
									return "up"
								else
									return "down"
								end
							end,
						set=function(v) Buffalo.SetGrowthDirection(Buffalo, v, "weapon") end,
						validate = {["up"] = L["Upwards"], ["down"]=L["Downwards"]},
						order=5
					},

					firstGrowth={
						type='text',
						name=L["Growth Precedence"],
						desc=L["In which direction should the display grow first (horizontally or vertically)?"],
						get=function() return Buffalo.db.profile.growHorizontalFirst.weapon end,
						set=function(v) Buffalo.SetGrowHorizontalFirst(Buffalo, v, "weapon")end,
						validate = {[true] = L["Horizontally"], [false]=L["Vertically"]},
						order=6
					},

					rows={
						type='range',
						name=L["Rows"],
						desc=L["Number of Rows. Only applies when Growth Precedence is Vertical"],
						min=1,
						max=2,
						step=1,
						get = function() return Buffalo.db.profile.rows["weapon"] end,
						set = function(v) Buffalo.SetRows(Buffalo, v, "weapon") end,
						order=7
					},

					cols={
						type='range',
						name=L["Columns"],
						desc=L["Number of Columns. Only applies when Growth Precedence is Horizontal"],
						min=1,
						max=2,
						step=1,
						get = function() return Buffalo.db.profile.cols["weapon"] end,
						set = function(v) Buffalo.SetCols(Buffalo, v, "weapon") end,
						order=8
					},
					hide = {
						type='toggle',
						name=L["Hide"],
						desc=L["Hides these buff frames"],
						get= function() return Buffalo.db.profile.hide["weapon"] end,
						set = function(v) Buffalo.ToggleHide(Buffalo, v, "weapon") end,
						order=90
					},
					flashing = {
						type='toggle',
						name=L["Flashing"],
						desc=L["Toggle flashing on fading buffs"],
						get= function() return Buffalo.db.profile.flashes["weapon"] end,
						set = function(v) Buffalo.db.profile.flashes["weapon"] = v end,
						order=95
					},
					timers = {
						type='group',
						name=L["Timers"],
						desc=L["Customize buff timers"],
						order=100,
						args = {
							verboseTimer = {
								type='toggle',
								name=L["Verbose Timers"],
								desc=L["Replaces the default time format for timers with HH:MM or MM:SS"],
								get= function() return Buffalo.db.profile.verboseTimers["weapon"] end,
								set = function(v) Buffalo.db.profile.verboseTimers["weapon"] = v end,
								order=100
							},
							whiteTimer = {
								type='toggle',
								name=L["White Timers"],
								desc=L["Use white timers instead of yellow ones"],
								get= function() return Buffalo.db.profile.whiteTimers["weapon"] end,
								set = function(v) Buffalo.db.profile.whiteTimers["weapon"] = v end,
								disabled = function() return not Buffalo.db.profile.verboseTimers["weapon"] end,
								order=110
							},
						},
					},
				}
			},
		}
	}
	self:RegisterChatCommand({"/buffalo"}, slashOptions)
	self:RegisterChatCommand({"/buf"}, slashOptions)
end

function Buffalo:OnEnable()
	if( not BuffaloButton0) then
		self:CreateBuffButtons()
	end
	self:SetDebugging(DEBUGMODE)
	self:DisableBlizzardBuffs()
	for cat, frameName in pairs(FRAME_NAME) do
		getglobal(frameName):Show()
	end
	self:RestoreSettings()
-- 	dewdrop:Register(UIParent, Buffalo_OptionsTable)
--	self:EnableBuffaloBuffs()
-- 	for i, buttonName in self.ButtonIterator, "buff", nil do
-- 		self:Debug("ButtonID: ", getglobal(buttonName):GetID())
-- 	end
	if not LibButtonFacade then
		self:CreateDLayout()
	end
	loaded = 1
end

function Buffalo:OnDisable()
	self:EnableBlizzardBuffs()
	for cat, frameName in pairs(FRAME_NAME) do
		getglobal(frameName):Hide()
	end
end

function Buffalo:OnProfileEnable()
	self:FillAnchors()
end

-------------------------------------------------------------------------------
-- Meat
-------------------------------------------------------------------------------

function Buffalo.ButtonIterator(cat, n)
	local buttonName, ghostButtonLabel
	if(not n) then
		n=MININDEX[cat]
		buttonName=BUTTONNAME[cat].."0"
	elseif(MININDEX[cat]<=n and n<MAXINDEX[cat]) then
		n=n+1
		buttonName=BUTTONNAME[cat]..(n-MININDEX[cat])
	else
		n=nil
	end
	if(cat==WEAPON and n) then
		ghostButtonLabel = TEMPENCHANTGHOSTTEXT[n+1]
	elseif(n) then
		ghostButtonLabel = n+1 - MININDEX[cat]
	end
	return n, buttonName, ghostButtonLabel
end


function Buffalo:RestoreSettings()
	self:ToggleLock(self.db.profile.locked)
	local frame
	if self.db.profile.hide["buff"] then
		frame = getglobal(FRAME_NAME["buff"])
		frame:Hide()
	end
	if self.db.profile.hide["debuff"] then
		frame = getglobal(FRAME_NAME["debuff"])
		frame:Hide()
	end
	if self.db.profile.hide["weapon"] then
		frame = getglobal(FRAME_NAME["weapon"])
		frame:Hide()
	end
	self:FillAnchors()
		
end

function Buffalo:DisableBlizzardBuffs()
	BuffaloFrame:Show()
	DebuffaloFrame:Show()
	WeaponBuffaloFrame:Show()
	BuffFrame:Hide()
	TemporaryEnchantFrame:Hide()
end

function Buffalo:EnableBlizzardBuffs()
	BuffaloFrame:Hide()
	DebuffaloFrame:Hide()
	WeaponBuffaloFrame:Hide()
	BuffFrame:Show()
	TemporaryEnchantFrame:Show()
end

function Buffalo:CreateBuffButtons()
	if LibButtonFacade then
		LibButtonFacade:RegisterSkinCallback(self.name, self.LibButtonFacade_Update, self)
	end
	for cat, templateName in pairs(BUTTON_TEMPLATE_NAME) do
		if LibButtonFacade then
			local db = self.db.profile.skins[cat]
			LibButtonFacade:Group(self.name, cat):Skin(db.skin, db.gloss, db.backdrop)
		end
		for i, buttonName, ghostButtonLabel in self.ButtonIterator, cat, nil do
			local button = CreateFrame("Button", buttonName, getglobal(FRAME_NAME[cat]), templateName)
			button.cat=cat
			if(cat ~= "weapon") then
				button:SetID(i)
			else
				button:SetID(i+16)
			end
			button.buffFilter=BUFF_FILTER[cat]
			button:RegisterForClicks("RightButtonUp")
			
			if LibButtonFacade then
				LibButtonFacade:Group(self.name, cat):AddButton(button)
			end
			getglobal(button:GetName().."_Ghost_Label"):SetText(ghostButtonLabel)
			self:BuffaloButton_Update(button)
		end
	end
	self:FillAnchors()
end

function Buffalo:LibButtonFacade_Update(skin, gloss, backdrop, cat)
	if not cat or cat == "nil" then return end
	local db = self.db.profile.skins[cat]
	db.skin = skin
	db.gloss = gloss
	db.backdrop = backdrop
end

function Buffalo:BuffaloButton_Update(button)
 	local buffIndex, untilCancelled = GetPlayerBuff(button:GetID() + 1, button.buffFilter)
 	button.buffIndex = buffIndex
 	button.untilCancelled = untilCancelled
 	local timeLeft = GetPlayerBuffTimeLeft(buffIndex)
 	local buffDuration = getglobal(button:GetName().."Duration")
 	buffDuration:SetFormattedText(self:GetDurationString(timeLeft, button.cat))

	UIFrameFlashRemoveFrame(button) -- STOP WITH THIS SILLY FLASHING!
	
 	if ( buffIndex < 1 and self.db.profile.locked ) then
 		button:Hide()
 		buffDuration:Hide()
 	else
 		button:SetAlpha(1.0)
 		button:Show()
 		if ( SHOW_BUFF_DURATIONS == "1" and timeLeft > 0) then
 			buffDuration:Show()
 		else
 			buffDuration:Hide()
 		end
 	end

 	local icon = getglobal(button:GetName().."Icon")
 	icon:SetTexture(GetPlayerBuffTexture(buffIndex))

 	-- Set color of debuff border based on dispel class.
 	local color
 	local debuffType = GetPlayerBuffDispelType(GetPlayerBuff(button:GetID() + 1, "HARMFUL"))
 	local debuffSlot = getglobal(button:GetName().."Border")
--  	self:Debug("debuffType:",debuffType)
--  	self:Debug("debuffSlot:",debuffSlot)
 	if ( debuffType ) then
 		color = DebuffTypeColor[debuffType]
 		color.a=1
 	elseif(buffIndex >= 1) then
 		color = DebuffTypeColor["none"]
 		color.a=1
 	else
 		color = {r=0, g=0, b=0, a=0}
 	end
	if ( debuffSlot ) then
		debuffSlot:SetVertexColor(color.r, color.g, color.b, color.a)
		if (loaded == 1) then
			local dflayout = getglobal("DFLayout"..button:GetID())
			if dflayout then
				dflayout:SetBackdropColor(color.r, color.g, color.b, color.a)
			end
			debuffSlot:Hide()
		end
 	end

	-- Set the number of applications of an aura if its a debuff
	local buffCount = getglobal(button:GetName().."Count")
	local count = GetPlayerBuffApplications(buffIndex)
	if ( count > 1 ) then
		buffCount:SetText(count)
		buffCount:Show()
	else
		buffCount:Hide()
	end

	if ( GameTooltip:IsOwned(button) ) then
		GameTooltip:SetPlayerBuff(buffIndex)
	end
	self.printnext=DebuffaloButton1 and (button:GetName() == "DebuffaloButton1")
	self:Test("Nach _Update")
end

function Buffalo:WeaponBuffaloFrame_OnUpdate(elapsed)
	timeSinceWeaponUpdate = timeSinceWeaponUpdate + elapsed
	if(timeSinceWeaponUpdate > UPDATETIME) then
		local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo()

		if(hasMainHandEnchant) then
			local textureName = GetInventoryItemTexture("player", 16)
			WeaponBuffaloButton0Icon:SetTexture(textureName)
			WeaponBuffaloButton0Duration:SetFormattedText(self:GetDurationString(mainHandExpiration/1000, "weapon"))
			WeaponBuffaloButton0Duration:Show()
			if(mainHandCharges > 0) then
				WeaponBuffaloButton0Count:SetText(mainHandCharges)
				WeaponBuffaloButton0Count:Show()
			else
				WeaponBuffaloButton0Count:Hide()
			end
			WeaponBuffaloButton0:SetID(16)
			WeaponBuffaloButton0:Show()
		elseif(self.db.profile.locked) then
			WeaponBuffaloButton0:Hide()
		else
			WeaponBuffaloButton0Icon:SetTexture(nil)
		end

		if(hasOffHandEnchant) then
			local textureName = GetInventoryItemTexture("player", 17)
			WeaponBuffaloButton1Icon:SetTexture(textureName)
			WeaponBuffaloButton1Duration:SetFormattedText(self:GetDurationString(offHandExpiration/1000, "weapon"))
			WeaponBuffaloButton1Duration:Show()
			if(offHandCharges > 0) then
				WeaponBuffaloButton1Count:SetText(offHandCharges)
				WeaponBuffaloButton1Count:Show()
			else
				WeaponBuffaloButton1Count:Hide()
			end
			WeaponBuffaloButton1:SetID(17)
			WeaponBuffaloButton1:Show()
		elseif(self.db.profile.locked) then
			WeaponBuffaloButton1:Hide()
		else
			WeaponBuffaloButton1Icon:SetTexture(nil)
		end

		timeSinceWeaponUpdate = 0
	end
end

function Buffalo:BuffButton_OnUpdate(elapsed, button)
	button.timeSinceLastUpdate = button.timeSinceLastUpdate + elapsed
	if(button.timeSinceLastUpdate > UPDATETIME) then
		local buffDuration = getglobal(button:GetName().."Duration")
		if ( button.untilCancelled == 1 ) then
			buffDuration:Hide()
			return
		end
	
		local buffIndex = button.buffIndex
		local timeLeft = GetPlayerBuffTimeLeft(buffIndex)
		if ( timeLeft < BUFF_WARNING_TIME and self.db.profile.locked and self.db.profile.flashes[button.cat]) then
--			local ghost = getglobal(button:GetName().."_Ghost_Texture")
--			ghost:SetTexture(GHOST_COLOR.warning.r, GHOST_COLOR.warning.g, GHOST_COLOR.warning.b)
			UIFrameFlash(button, 0.7, 0.7, timeLeft, true, 0, 0.6)
		else
			UIFrameFlashRemoveFrame(button)
			button:SetAlpha(1.0)
		end
	
		-- Update duration
		if(timeLeft>0) then
			buffDuration:SetFormattedText(self:GetDurationString(timeLeft, button.cat))
			buffDuration:Show()
		else
			buffDuration:Hide()
		end
		if ( (BuffFrameUpdateTime or BuffFrame.BuffFrameUpdateTime) > 0 ) then
			return
		end
		if ( GameTooltip:IsOwned(button) ) then
			GameTooltip:SetPlayerBuff(buffIndex)
		end
		button.timeSinceLastUpdate = 0
	end
end


function Buffalo:GetDurationString(seconds, cat)
	if(not self.db.profile.verboseTimers[cat])then
		return SecondsToTimeAbbrev(seconds)
	else
		if(seconds > 3600) then
			return abacus:FormatDurationCondensed(seconds, self.db.profile.whiteTimers[cat], true)
		else
			return abacus:FormatDurationCondensed(seconds, self.db.profile.whiteTimers[cat], false)
		end
	end
end

function Buffalo:SetShowGhostBuffFrames(value)
	if(value) then
		for cat, templateName in pairs(BUTTON_TEMPLATE_NAME) do
			for _, buttonName, ghostButtonLabel in self.ButtonIterator, cat, nil do
				local label = getglobal(buttonName.."_Ghost_Label")
				local ghost = getglobal(buttonName.."_Ghost_Texture")
				getglobal(buttonName):Show()
				label:SetText(ghostButtonLabel)
				label:Show()
				ghost:SetTexture(GHOST_COLOR[cat].r, GHOST_COLOR[cat].g, GHOST_COLOR[cat].b, GHOST_COLOR.alpha)
				ghost:Show()
			end
		end
	else
		for cat, templateName in pairs(BUTTON_TEMPLATE_NAME) do
			for _, buttonName in self.ButtonIterator, cat, nil do
				local label = getglobal(buttonName.."_Ghost_Label")
				local ghost = getglobal(buttonName.."_Ghost_Texture")
				if not getglobal(buttonName.."Icon"):GetTexture() then getglobal(buttonName):Hide() end
				label:Hide()
				ghost:Hide()
			end
		end
	end
end

function Buffalo:SavePos(cat)
	local frame=getglobal(FRAME_NAME[cat])
	self.db.profile.xPos[cat] = frame:GetRight() - UIParent:GetRight()
	self.db.profile.yPos[cat] = frame:GetTop() - UIParent:GetTop()
	self:Debug(self.db.profile.xPos[cat])
	self:Debug(self.db.profile.yPos[cat])
end

function Buffalo:SetScale(scale, cat)
	for i, buttonName in self.ButtonIterator, cat, nil do
		getglobal(buttonName):SetScale(scale)
	end
	local frame = getglobal(FRAME_NAME[cat])
	frame:ClearAllPoints()

	frame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", self.db.profile.xPos[cat], self.db.profile.yPos[cat])
	self.db.profile.scale[cat] = scale
	
end

--[[
Sets the distance between the buff buttons.
padding - the distance in pixels
cat - either "buff", "debuff" or "weapon"
direction - either "x" or "y"
]]
function Buffalo:SetPadding(padding, cat, direction)
	self.db.profile.padding[cat][direction] = padding
	self:FillAnchors(cat)
end

function Buffalo:GetGrowRightCoeff(cat)
	if self.db.profile.growRight[cat] then
		return 1
	else
		return -1
	end
end

function Buffalo:GetGrowUpwardsCoeff(cat)
	if self.db.profile.growUpwards[cat] then
		return 1
	else
		return -1
	end
end

--[[
Sets the direction in which the buffs grow
direction - either "right", "left", "up" or "down"
cat - either "buff", "debuff" or "weapon"
]]
function Buffalo:SetGrowthDirection(direction, cat)
	if(direction == "right") then
		self.db.profile.growRight[cat] = true
	elseif(direction == "left") then
		self.db.profile.growRight[cat] = nil
	elseif(direction == "up") then
		self.db.profile.growUpwards[cat] = true
	elseif(direction == "down") then
		self.db.profile.growUpwards[cat] = nil
	end
	self:FillAnchors(cat)
end

--[[
These set the number of rows/cols for the given cat
cat - either "buff", "debuff" or "weapon"
]]
function Buffalo:SetRows(rows, cat)
	self.db.profile.rows[cat] = rows
	self:FillAnchors(cat)
end
function Buffalo:SetCols(cols, cat)
	self.db.profile.cols[cat] = cols
	self:FillAnchors(cat)
end

function Buffalo:SetGrowHorizontalFirst(value, cat)
	self.db.profile.growHorizontalFirst[cat] = value or false
	self:FillAnchors(cat)
end

function Buffalo:ApplyAnchors(cat)

	if(self.db.profile.locked) then
		if not BuffButton1 then
			CreateFrame("Button", "BuffButton1", BuffFrame, "BuffButtonTemplate")
			
		end
		BuffButton1:SetMovable(true)
		if not BuffButton17 then
			CreateFrame("Button", "BuffButton17", BuffFrame, "BuffButtonTemplate")
			
		end
		BuffButton17:SetMovable(true)
		TempEnchant1:SetMovable(true)
	end
	if(type(cat) == "nil") then
		self:ApplyAnchors("buff")
		self:ApplyAnchors("debuff")
		self:ApplyAnchors("weapon")
		return
	end
	local frame = getglobal(FRAME_NAME[cat])
	
	frame:ClearAllPoints()
	frame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", self.db.profile.xPos[cat], self.db.profile.yPos[cat])
	self:Debug(self.db.profile.yPos[cat])
	for i, buttonName in self.ButtonIterator, cat, nil do
		local button = getglobal(buttonName)
		local anchor = anchors[cat][i+1]
		button:ClearAllPoints()
		button:SetPoint(anchor.point, anchor.relativeTo, anchor.relativePoint, anchor.xOffs, anchor.yOffs)
	end
	if(self.db.profile.locked) then
		BuffButton1:SetMovable(false)
		BuffButton17:SetMovable(false)
		TempEnchant1:SetMovable(false)
	end
	for cat, _ in pairs(BUTTON_TEMPLATE_NAME) do
		self:SetScale(self.db.profile.scale[cat], cat)
	end
end

function Buffalo:FillAnchors(cat)
	if(type(cat) == "nil") then
		self:FillAnchors("buff")
		self:FillAnchors("debuff")
		self:FillAnchors("weapon")
		return
	end
	for i, buttonName in self.ButtonIterator, cat, nil do
-- 		self:Debug("cat: ", cat)
-- 		self:Debug("i+1: ", i+1)

		local anchor = anchors[cat][i+1]
		if(i==MININDEX[cat]) then -- first button in this category
			anchor.point="TOPRIGHT"
			anchor.relativeTo=FRAME_NAME[cat]
			anchor.relativePoint="TOPRIGHT"
			anchor.xOffs=0
			anchor.yOffs=0
		else
			local anchorPoint, relativePoint, switchAnchorPoint, switchRelativePoint, limit = self:GetAnchorInfo(cat)
			if i==15 and false then
				self:Debug("Button: ", i)
				self:Debug("MinIndex: ", MININDEX[cat])
				self:Debug("limit: ", limit)
			end
			if(mod((i-MININDEX[cat]), limit) == 0 or (limit==1)) then --[[and not (i==MAXINDEX[cat])]]
				anchor.point = switchAnchorPoint
				anchor.relativeTo = BUTTONNAME[cat]..(i-limit)
				anchor.relativePoint = switchRelativePoint
				anchor.xOffs = (not self.db.profile.growHorizontalFirst[cat] and self:GetGrowRightCoeff(cat)*self.db.profile.padding[cat].x) or 0
				anchor.yOffs = (self.db.profile.growHorizontalFirst[cat] and self:GetGrowUpwardsCoeff(cat)*self.db.profile.padding[cat].y) or 0
			else
				anchor.point = anchorPoint
				anchor.relativeTo = BUTTONNAME[cat]..(i-1)
				anchor.relativePoint = relativePoint
				anchor.xOffs = (self.db.profile.growHorizontalFirst[cat] and self:GetGrowRightCoeff(cat)*self.db.profile.padding[cat].x) or 0
				anchor.yOffs = (not self.db.profile.growHorizontalFirst[cat] and self:GetGrowUpwardsCoeff(cat)*self.db.profile.padding[cat].y) or 0
			end
		end
	end
	self:ApplyAnchors(cat)
end

--[[
returns the needed information to determine which button is to be attached to which button in what way. wwwwwww
*anchorPoint - the anchorpoint of the current button
*relativePoint - the point where we attach it to
*switchAnchorPoint, switchRelativePoint - like above, but for when the row / column switches ("linebreak")
*limit - the number of columns / rows where to perform a switch
]]
function Buffalo:GetAnchorInfo(cat)
	local anchorPoint, relativePoint
	local switchAnchorPoint, switchRelativePoint
	local limit
	if(self.db.profile.growHorizontalFirst[cat]) then
		limit = self.db.profile.cols[cat]
		if(self.db.profile.growRight[cat]) then
			anchorPoint = "LEFT"
			relativePoint = "RIGHT"
		else
			anchorPoint = "RIGHT"
			relativePoint = "LEFT"
		end

		if(self.db.profile.growUpwards[cat]) then
			switchAnchorPoint = "BOTTOM"
			switchRelativePoint = "TOP"
		else
			switchAnchorPoint = "TOP"
			switchRelativePoint = "BOTTOM"
		end
	else
		limit = self.db.profile.rows[cat]
		if(self.db.profile.growRight[cat]) then
			switchAnchorPoint = "LEFT"
			switchRelativePoint = "RIGHT"
		else
			switchAnchorPoint = "RIGHT"
			switchRelativePoint = "LEFT"
		end

		if(self.db.profile.growUpwards[cat]) then
			anchorPoint = "BOTTOM"
			relativePoint = "TOP"
		else
			anchorPoint = "TOP"
			relativePoint = "BOTTOM"
		end
	end
	return anchorPoint, relativePoint, switchAnchorPoint, switchRelativePoint, limit
end

function Buffalo:ToggleLock(value)
	for cat, frameName in pairs(FRAME_NAME) do
		local frame = getglobal(frameName)
		frame:SetMovable(not value)
	end
	self.db.profile.locked = value
	self:SetShowGhostBuffFrames(not value)
end

function Buffalo:ToggleHide(value, cat)
	local frame = getglobal(FRAME_NAME[cat])
	self.db.profile.hide[cat] = value
	if(value) then
		frame:Hide()
	else
		frame:Show()
	end
end

function Buffalo:Reset()
	self:ResetDB("profile")
	self:OnProfileEnable()
end

function Buffalo:BuffButton_OnClick(button)
	if(IsAltKeyDown())then
		if(button.buffFilter == "HELPFUL") then
			dewdrop:Open(button, 'children', Buffalo_OptionsTable.args.buffs)
		elseif(button.buffFilter == "HARMFUL") then
			dewdrop:Open(button, 'children', Buffalo_OptionsTable.args.debuffs)
		end
	else
		CancelPlayerBuff(button.buffIndex)
	end
end

function Buffalo:WeaponButton_OnClick(button)
	if(IsAltKeyDown())then
		dewdrop:Open(button, 'children', Buffalo_OptionsTable.args.weapon)
	else
		if(button:GetID() == 16) then
			CancelItemTempEnchantment(1)
		elseif(button:GetID() == 17) then
			CancelItemTempEnchantment(2)
		end
	end
end

function Buffalo:PrintAnchor(frame)
	if(not self:IsDebugging()) then return end
	point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint()
	self:Debug("Point: ", point or "nil")
	self:Debug("RelativeTo: ", (relativeTo and relativeTo:GetName()) or "nil")
	self:Debug("RelativePoint: ", relativePoint or "nil")
	self:Debug("X-Offset:", xOfs or "nil")
	self:Debug("Y-Offset:", yOfs or "nil")
	local cx, cy = frame:GetCenter()
	self:Debug("Center: ", cx, cy)
end

function Buffalo:Test(position)
	if true then return end
	if(DebuffaloButton1Border) then
		local r,g,b,a = DebuffaloButton1Border:GetVertexColor()
		self:Debug(position, a)
		self.printnext=false
	end
end

function Buffalo:CreateDLayout()
	for i=0,31 do
		local frame = CreateFrame("Frame", "BFLayout"..i)
		frame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 1, edgeFile = "", edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0},})
		frame:SetBackdropColor(0,0,0,0.6)
		frame:SetBackdropBorderColor(0.5, 0.5, 0, 0)
		frame:SetPoint("TOPLEFT", "BuffaloButton"..i, "TOPLEFT", 0, 0)
		frame:SetPoint("BOTTOMRIGHT", "BuffaloButton"..i, "BOTTOMRIGHT", 0, 0)
		frame:SetParent("BuffaloButton"..i)
		frame:SetFrameLevel(1)
		
		local icon = getglobal("BuffaloButton"..i.."Icon")
		icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", "BFLayout"..i, "TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", "BFLayout"..i, "BOTTOMRIGHT", -2, 2)
	end
	
	for i=0,15 do
		local frame = CreateFrame("Frame", "DFLayout"..i)
		frame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 1, edgeFile = "", edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0},})
		frame:SetBackdropColor(1,0,0,1)
		frame:SetBackdropBorderColor(0.5, 0.5, 0, 0)
		frame:SetPoint("TOPLEFT", "DebuffaloButton"..i, "TOPLEFT", 0, 0)
		frame:SetPoint("BOTTOMRIGHT", "DebuffaloButton"..i, "BOTTOMRIGHT", 0, 0)
		frame:SetParent("DebuffaloButton"..i)
		frame:SetFrameLevel(1)

		getglobal("DebuffaloButton"..i.."Border"):Hide()
		local icon = getglobal("DebuffaloButton"..i.."Icon")
		icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", "DFLayout"..i, "TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", "DFLayout"..i, "BOTTOMRIGHT", -2, 2)
	end
	
	for i=0,1 do
		local frame = CreateFrame("Frame", "WBLayout"..i)
		frame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 1, edgeFile = "", edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0},})
		frame:SetBackdropColor(0.5,0.2,0.85,1)
		frame:SetBackdropBorderColor(0.5, 0.5, 0, 0)
		frame:SetPoint("TOPLEFT", "WeaponBuffaloButton"..i, "TOPLEFT", 0, 0)
		frame:SetPoint("BOTTOMRIGHT", "WeaponBuffaloButton"..i, "BOTTOMRIGHT", 0, 0)
		frame:SetParent("WeaponBuffaloButton"..i)
		frame:SetFrameLevel(1)
		
		local icon = getglobal("WeaponBuffaloButton"..i.."Icon")
		icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", "WBLayout"..i, "TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", "WBLayout"..i, "BOTTOMRIGHT", -2, 2)
	end
end
