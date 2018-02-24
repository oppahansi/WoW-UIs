MBFversion = GetAddOnMetadata("MinimapButtonFrame", "Version");
MBF_DRAGTITLE = "MBF " .. MBFversion;

local LibStub = LibStub
MBF = LibStub("AceAddon-3.0"):NewAddon("Minimap Button Frame", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Minimap Button Frame")
local libdbicon = LibStub("LibDBIcon-1.0", true)

-- Internal Variables
local scanned = false;
local MBF_ButtonInfoStorage = {};
local MBF_ChildEventStorage = {};
local tBackdrop = {};
local tBorder = {};
local tList = {};
local tSize = {};
local currentProfile;
local numButtons = 2;

local oldParentName;
local oldPoint;
local oldRelativeTo;
local oldRelativePoint;
local oldXofs;
local oldYofs;
local oldOnEvent;
local oldOnDragStart;
local oldOnDragStop;
local oldName;
local oldFrameLevel;
local oldWidth;
local oldHeight;
local oldScale;
local oldLevel;
local oldStrata;


local BlizzButtons = { "MiniMapTracking", "MiniMapVoiceChatFrame", "MiniMapWorldMapButton", "MiniMapLFGFrame", "MinimapZoomIn", "MinimapZoomOut", "MiniMapMailFrame", "MiniMapBattlefieldFrame", "GameTimeFrame", "FeedbackUIButton" };
local BlizzUI = { "ActionBar", "BonusActionButton", "MainMenu", "ShapeshiftButton", "MultiBar", "KeyRingButton", "PlayerFrame", "TargetFrame", "PartyMemberFrame", "ChatFrame", "ExhaustionTick", "TargetofTargetFrame", "WorldFrame", "ActionButton", "CharacterMicroButton", "SpellbookMicroButton", "TalentMicroButton", "QuestLogMicroButton", "SocialsMicroButton", "LFGMicroButton", "HelpMicroButton", "CharacterBag", "PetFrame",  "MinimapCluster", "MinimapBackdrop", "UIParent", "WorldFrame", "Minimap", "BuffButton", "BuffFrame", "TimeManagerClockButton" };
local BlizzParentStop = { "WorldFrame", "Minimap", "MinimapBackdrop", "UIParent", "MinimapCluster" }
local SkinProtect = { "MinimapButtonFrameDragButton", "MBFRestoreButton", "GameTimeFrame" }

-- Configuration Screens

local hidewhenlocked_options = {
	["Nothing"]	= L["Nothing"],
	["Border"]	= L["Border"],
	["Background"]	= L["Background"],
	["All"]	= L["All"],
}

local sortorder_options = {
	["Alphabetical"]	= L["Alphabetical"],
	["Blizzard First"]	= L["Blizzard First"],
	["Blizzard Last"]	= L["Blizzard Last"],
	["Custom"]		= L["Custom"],
}

local frameanchor_options = {
	["TOPLEFT"]	= L["Top Left"],
	["TOPRIGHT"]	= L["Top Right"],
	["BOTTOMRIGHT"]	= L["Bottom Right"],
	["BOTTOMLEFT"]  = L["Bottom Left"],
}

local minimapIconList = {};
local buttonOverrideList = {};
local childList = {};

local display = {
	order = 1,
	type = "group",
	name = L["Display"],
	desc = L["Display Settings"],
	handler = MBF,
	args = {		
		hidewhenlocked = {
			order	= 1,
			type	= "select",
			name	= L["Hide when Locked"],
			desc	= L["HIDELOCKED_DESC"],
			get	= function() return MBF.db.profile.colorLocked end,
			set	= function(info,name) MBF.db.profile.colorLocked = name 
					MBFC_ColorLocked()
				end,
			values	= hidewhenlocked_options,
		},
		locked = {
			order	= 2,
			type	= "toggle",
			name	= L["Locked"],
			desc	= L["LOCKED_DESC"],
			get	= function() return MBF.db.profile.locked end,
			set	= function() MBF.db.profile.locked = not MBF.db.profile.locked 
					if not MBF.db.profile.locked and not MBF.db.profile.mbfHidden then
						MinimapButtonFrameDragButton:Show()
						MBFRestoreButtonFrame:Show()
					else
						MinimapButtonFrameDragButton:Hide()
						MBFRestoreButtonFrame:Hide()
					end	
					MBFC_ColorLocked()
				end,
		},
		altTitle = {
			order	= 3,
			type	= "toggle",
			name	= L["ALTTITLE_DESC"],
			desc	= L["ALTTITLEDESC_DESC"],
			get	= function() return MBF.db.profile.altTitle end,
			set	= function() MBF.db.profile.altTitle = not MBF.db.profile.altTitle
					MBF:SwapTitleLocation()
				end,
		},
		space = {
			order	= 4,
			name	= "\n",
			type	= "description",
		},
		backgroundcolor = {
			order	= 10,
			type	= 'color',
			name	= L['Background Color'],
			desc	= L['COLOR_DESC'],
			hasAlpha = true,
			get	= function() 
					local t = MBF.db.profile.MBFBackdropColor 
					return t.Red, t.Green, t.Blue, t.Alpha 
				end,
			set	= function(info, r, g, b, a)
					local t = MBF.db.profile.MBFBackdropColor
					t.Red = r
					t.Green = g
					t.Blue = b
					t.Alpha = a
					MBFC_ColorLocked()
				end,
		},
		space1 = {
			order	= 11,
			name	= "",
			type	= "description",
		},
		opacity = {
			order	= 20,
			type	= "range",
			name	= L["Opacity"],
			desc	= L["OPACITY_DESC"],
			min	= 0,
			max	= 1,
			step	= .1,
			get	= function() return MBF.db.profile.opacity end,
			set	= function(info, v) MBF.db.profile.opacity = v 
					MinimapButtonFrame:SetAlpha(MBF.db.profile.opacity)
					MBFRestoreButtonFrame:SetAlpha(MBF.db.profile.opacity)
				end,
		},
		space2 = {
			order	= 21,
			name	= "",
			type	= "description",
		},
		columnsorrows = {
			order	= 30,
			type	= "range",
			name	= L["Columns or Rows"],
			desc	= L["CLR_DESC"],
			min	= 1,
			max	= 50,
			step	= 1,
			get	= function() return MBF.db.profile.columns_or_rows end,
			set	= function(info, v) MBF.db.profile.columns_or_rows = v 
					MBF:Scan()
				end,
		},
		mbfanchor = {
			order	= 31,
			type	= "select",
			name	= L["MBF Anchor"],
			desc	= L["MBFANCHOR_DESC"],
			get	= function() return MBF.db.profile.mbfAnchor end,
			set	= function(info,name) MBF.db.profile.mbfAnchor = name 
					MBF:SavePosition();
				end,
			values	= frameanchor_options,
		},
		space3 = {
			order	= 32,
			name	= "",
			type	= "description",
		},
		padding = {
			order	= 40,
			type	= "range",
			name	= L["Padding"],
			desc	= L["PADDING_DESC"],
			min	= 0,
			max	= 20,
			step	= .5,
			get	= function() return MBF.db.profile.padding end,
			set	= function(info, v) MBF.db.profile.padding = v 
					MBF:Scan()
				end,
		},
		space4 = {
			order	= 41,
			name	= "",
			type	= "description",
		},
		scale = {
			order	= 50,
			type	= "range",
			name	= L["Scale"],
			desc	= L["SCALE_DESC"],
			min	= .5,
			max	= 2,
			step	= .1,
			get	= function() return MBF.db.profile.addonScale end,
			set	= function(info, v) MBF.db.profile.addonScale = v 
					MinimapButtonFrame:SetScale(MBF.db.profile.addonScale)
					MBFRestoreButtonFrame:SetScale(MBF.db.profile.addonScale)
				end,
		},
		space5 = {
			order	= 51,
			name	= "",
			type	= "description",
		},
		buttonskin = {
			order	= 60,
			type	= "select",
			name	= L["Buttonskin"],
			desc	= L["BUTTONSKIN_DESC"],
			get	= function() return MBF.db.profile.currentTexture end,
			set	= function(info,name) MBF.db.profile.currentTexture = name 
					textureFrame(MinimapButtonFrame)
					MBF:Scan()
				end,
			values	= tList,
		},
	},
}

local gathering = {
	order = 2,
	type = "group",
	name = L["Gathering"],
	desc = L["Gathering Settings"],
	handler = MBF,
	args = {		
		header1 = {
			order	= 1,
			type	= "header",
			name	= L["GATHERHEAD1_DESC"],
		},
		desc1 = {
			order	= 2,
			type	= "description",
			name	= L["GATHERDESC1_DESC"] .. "\n",
		},
		ShowMinimapButton = {
			order	= 3,
			type	= "toggle",
			name	= L["Show Minimap Button"],
			desc	= L["SHOWBUTTON_DESC"],
			get	= function() return not MBF.db.profile.minimapButton.hide end,
			set	= function(_,v) MBF.db.profile.minimapButton.hide = not(v)
					if MBF.db.profile.minimapButton.hide then
						libdbicon:Hide("MBF")
					else
						libdbicon:Show("MBF")
					end
					MBF:Scan()
				end,
			disabled = function() if libdbicon then return false end return true end,
		},
		GatherMBFButton = {
			order	= 4,
			type	= "toggle",
			name	= L["Collect Button"],
			desc	= L["COLLECT1_DESC"],
			get	= function() return MBF.db.profile.grabMBFButton end,
			set	= function(info, value) MBF.db.profile.grabMBFButton = not MBF.db.profile.grabMBFButton 
					if (MBF.db.profile.grabMBFButton) then
						MinimapButtonFrame:Show();
						MBF.db.profile.mbfHidden = false;
					else
						removeButton(LibDBIcon10_MBF, 0);
					end
					MBF:Scan()
				end,
			disabled = function() if MBF.db.profile.minimapButton.hide then return true end return false end,
		},
		spacer0 = {
			order	= 5,
			name	= "\n",
			type	= "description",
		},
		header2 = {
			order	= 10,
			type	= "header",
			name	= L["GATHERHEAD2_DESC"],
		},
		desc2 = {
			order	= 11,
			type	= "description",
			name	= L["GATHERDESC2_DESC"] .. "\n",
		},
		GatherBlizz = {
			order	= 12,
			type	= "toggle",
			name	= L["Collect Buttons"],
			desc	= L["COLLECT2_DESC"],
			get	= function() return MBF.db.profile.grabBlizzButtons end,
			set	= function(info, value) MBF.db.profile.grabBlizzButtons = not MBF.db.profile.grabBlizzButtons 
					if not (MBF.db.profile.grabBlizzButtons) then
						removeBlizzButtons()
						MBF.db.profile.disabledMail = false
					end
					MBF:Scan()
				end,
		},
		spacer1 = {
			order	= 13,
			name	= "",
			type	= "description",
		},
		HideBlizzMail = {
			order	= 14,
			type	= "toggle",
			name	= L["Hide Mail"],
			desc	= L["HIDEMAIL_DESC"],
			get	= function() return MBF.db.profile.MBFHideMiniMapMailFrame end,
			set	= function(info, value) MBF.db.profile.MBFHideMiniMapMailFrame = not MBF.db.profile.MBFHideMiniMapMailFrame 
					if MBF.db.profile.MBFHideMiniMapMailFrame then
						MiniMapMailFrame:Hide()
						MBF.db.profile.disabledMail = false
					else
						if (HasNewMail() == 1) then
							MiniMapMailFrame:Show()
						end
					end
					MBF:Scan()
				end,
		},
		ShowNoMail = {
			order	= 15,
			type	= "toggle",
			name	= L["Show No Mail Icon"],
			desc	= L["NOMAIL_DESC"],
			get	= function() return MBF.db.profile.disabledMail end,
			set	= function(info, value) MBF.db.profile.disabledMail = not MBF.db.profile.disabledMail 
					MBF:Scan()
				end,
			disabled = function() if MBF.db.profile.MBFHideMiniMapMailFrame or (MBF.db.profile.grabBlizzButtons == false) then return true end return false end,
		},
		spacer2 = {
			order	= 16,
			name	= "",
			type	= "description",
		},
		HideTracking = {
			order	= 17,
			type	= "toggle",
			name	= L["Hide Tracking"],
			desc	= L["TRACKING_DESC"],
			get	= function() return MBF.db.profile.MBFHideMiniMapTracking end,
			set	= function(info, value) MBF.db.profile.MBFHideMiniMapTracking = not MBF.db.profile.MBFHideMiniMapTracking 
					if MBF.db.profile.MBFHideMiniMapTracking then
						MiniMapTracking:Hide()
					else
						MiniMapTracking:Show()
					end
					MBF:Scan()
				end,
		},
		spacer4 = {
			order	= 18,
			name	= "",
			type	= "description",
		},
		HideVoiceChat = {
			order	= 19,
			type	= "toggle",
			name	= L["Hide Voice Chat"],
			desc	= L["VOICECHAT_DESC"],
			get	= function() return MBF.db.profile.MBFHideMiniMapVoiceChatFrame end,
			set	= function(info, value) MBF.db.profile.MBFHideMiniMapVoiceChatFrame = not MBF.db.profile.MBFHideMiniMapVoiceChatFrame 
					if MBF.db.profile.MBFHideMiniMapVoiceChatFrame then
						MiniMapVoiceChatFrame:Hide()
					else
						MiniMapVoiceChatFrame:Show()
					end
					MBF:Scan()
				end,
		},
		spacer5 = {
			order	= 20,
			name	= "",
			type	= "description",
		},
		 HideGameTime = {
			order	= 21,
			type	= "toggle",
			name	= L["Hide Calendar"],
			desc	= L["CALENDAR_DESC"],
			get	= function() return MBF.db.profile.MBFHideGameTimeFrame end,
			set	= function(info, value) MBF.db.profile.MBFHideGameTimeFrame = not MBF.db.profile.MBFHideGameTimeFrame 
					if MBF.db.profile.MBFHideGameTimeFrame then
						GameTimeFrame:Hide()
					else
						GameTimeFrame:Show()
					end
					MBF:Scan()
				end,
		},
		spacer6 = {
			order	= 22,
			name	= "",
			type	= "description",
		},
		HideMinimapZoom = {
			order	= 23,
			type	= "toggle",
			name	= L["Hide Zoom Buttons"],
			desc	= L["ZOOM_DESC"],
			get	= function() return MBF.db.profile.MBFHideMinimapZoomIn end,
			set	= function(info, value) MBF.db.profile.MBFHideMinimapZoomIn = not MBF.db.profile.MBFHideMinimapZoomIn 
					if MBF.db.profile.MBFHideMinimapZoomIn then
						MinimapZoomIn:Hide()
						MinimapZoomOut:Hide()
					else
						MinimapZoomIn:Show()
						MinimapZoomOut:Show()
					end
					MBF:Scan()
				end,
		},
		spacer7 = {
			order	= 24,
			name	= "",
			type	= "description",
		},
		HideWorldMap = {
			order	= 25,
			type	= "toggle",
			name	= L["Hide World Map"],
			desc	= L["WORLDMAP_DESC"],
			get	= function() return MBF.db.profile.MBFHideMiniMapWorldMapButton end,
			set	= function(info, value) MBF.db.profile.MBFHideMiniMapWorldMapButton = not MBF.db.profile.MBFHideMiniMapWorldMapButton 
					if MBF.db.profile.MBFHideMiniMapWorldMapButton then
						MiniMapWorldMapButton:Hide()
					else
						MiniMapWorldMapButton:Show()
					end
					MBF:Scan()
				end,
		},
	},
}

local exceptions = {
	order = 1,
	type = "group",
	name = L["Exceptions"],
	desc = L["Exceptions Settings"],
	handler = MBF,
	args = {		
		header1 = {
			order	= 1,
			type	= "header",
			name	= L["Protected Items"],
		},
		desc1 = {
			order	= 2,
			type	= "description",
			name	= L["ICONSDESC_DESC"] .. "\n",
		},
		minimapIcons = {
			order	= 3,
			type	= "select",
			name	= L["Protected Items"],
			desc	= L["CURRENTEXCEPTIONS_DESC"],
			get	= function() return MBF.db.profile.currentMinimapIcon end,
			set	= function(info,name) MBF.db.profile.currentMinimapIcon = name end,
			values	= minimapIconList,
		},
		removeIcon = {
			order	= 4, 
			type	= "execute",
			name	= L["Remove"],
			desc	= L["ICONREMOVE_DESC"],
			func	= function() 
					local button = MBF.db.profile.currentMinimapIcon
					removeFromTable(MBF.db.profile.MinimapIcons, button)
					minimapIconList[button] = nil;
					for i, name in pairs(MBF.db.profile.MinimapIcons) do
						minimapIconList[name] = name
						if i == 1 then 
							MBF.db.profile.currentMinimapIcon = name
						end
					end
					MBF:Scan()
				end,
		},
		spacer1 = {
			order	= 5,
			name	= "\n",
			type	= "description",
		},
		iconInput = {
			order	= 6,		
			type	= "input",
			name	= L["ICONADDTITLE_DESC"],
			desc	= L["ICONADD_DESC"],
			set	= function(info, newValue)
					local liveButton
					tinsert(MBF.db.profile.MinimapIcons, newValue)
					minimapIconList[newValue] = newValue
					for i, liveButton in ipairs({MinimapButtonFrame:GetChildren()}) do
						if (isMinimapIcon(liveButton:GetName())) then	
							removeButton(liveButton, 1)
						end
					end
					MBF:Scan()
				end,
		},
		header2 = {
			order	= 10,
			type	= "header",
			name	= L["Button Override"],
		},
		desc2 = {
			order	= 11,
			type	= "description",
			name	= L["OVERRIDEDESC_DESC"] .. "\n",
		},
		buttonOverride = {
			order	= 12,
			type	= "select",
			name	= L["Button Override"],
			desc	= L["Current Button Overrides"],
			get	= function() return MBF.db.profile.currentButtonOverride end,
			set	= function(info,name) MBF.db.profile.currentButtonOverride = name end,
			values	= buttonOverrideList,
		},
		removeOverride = {
			order	= 13, 
			type	= "execute",
			name	= L["Remove"],
			desc	= L["OVERRIDEREMOVE_DESC"],
			func	= function() 
					local liveButton
					local button = MBF.db.profile.currentButtonOverride
					if isInTable(MBF.db.profile.ButtonOverride, button) then
						removeFromTable(MBF.db.profile.ButtonOverride, button)
						liveButton = getglobal(button)
						if ((liveButton ~= nil) and (MBF_ButtonInfoStorage[button] ~= nil)) then
							removeButton(liveButton, 0)
						end
						for i, name in pairs(MBF.db.profile.ButtonOverride) do
							buttonOverrideList[name] = name
							if i == 1 then 
								MBF.db.profile.currentButtonOverride = name
							end
						end
						buttonOverrideList[button] = nil;
						MBF:Scan()
					end
				end,
		},
		spacer2 = {
			order	= 14,
			name	= "\n",
			type	= "description",
		},
		overrideInput = {
			order	= 15,
			type	= "input",
			name	= L["Add Button Override"],
			desc	= L["OVERRIDEADD_DESC"],
			set	= function(info, newValue)
					tinsert(MBF.db.profile.ButtonOverride, newValue)
					buttonOverrideList[newValue] = newValue
					MBF:Scan()
				end,
		},
	},
}

local sorting = {
	order = 1,
	type = "group",
	name = L["Sorting"],
	desc = L["Sorting Settings"],
	handler = MBF,
	args = {
		sortOrder = {
			order	= 1,
			type	= "select",
			name	= L["Sort Order"],
			desc	= L["SORTORDER_DESC"],
			get	= function() return MBF.db.profile.sortOrder end,
			set	= function(info,name) MBF.db.profile.sortOrder = name 
					MBF:Scan()
				end,
			values	= sortorder_options,
		},
		growUp = {
			order	= 2,
			type	= "toggle",
			name	= L["Grow Buttons Up"],
			desc	= L["GROWUP_DESC"],
			get	= function() return MBF.db.profile.GrowUp end,
			set	= function(info, value) MBF.db.profile.GrowUp = not MBF.db.profile.GrowUp
					MBF:Scan()
				end,
		},
		 sortByRows = {
			order	= 3,
			type	= "toggle",
			name	= L["Sort By Rows"],
			desc	= L["SBR_DESC"],
			get	= function() return MBF.db.profile.sort_by_rows end,
			set	= function(info, value) MBF.db.profile.sort_by_rows = not MBF.db.profile.sort_by_rows 
					MBF:Scan()
				end,
		},
		space = {
			order	= 9,
			name	= "\n",
			type	= "description",
		},
		mbfKids = {
			order	= 10,
			type	= "select",
			name	= L["Children"],
			desc	= L["Children"],
			get	= function() return MBF.db.profile.currentChild end,
			set	= function(info,name) MBF.db.profile.currentChild = name end,
			values	= childList,
		},
		moveUp = {
			order	= 11, 
			type	= "execute",
			name	= L["UP"],
			image	= "Interface/Buttons/UI-ScrollBar-ScrollUpButton-Up",
			imageWidth = 50,
			imageHeight = 50,
			desc	= L["UP_DESC"],
			func	= function() MBF:moveButton(1) end,
		},
		moveDown = {
			order	= 12, 
			type	= "execute",
			name	= L["DOWN"],
			image	= "Interface/Buttons/UI-ScrollBar-ScrollDownButton-Up",
			imageWidth = 50,
			imageHeight = 50,
			desc	= L["DOWN_DESC"],
			func	= function() MBF:moveButton(2) end,
		},
	}
}

local defaults = {
	profile = {
		version = MBFVersion,
		-- Display Vars
		locked = false,
		colorLocked = "Nothing",
		altTitle = false,
		mbfAnchor = "TOPRIGHT",
		currentTexture = "Blizzard",
		MBFBackdropColor = { Red = 0, Green = 0, Blue = 0, Alpha = 1 },
		columns_or_rows = 3,
		sort_by_rows = false,
		padding = 5,
		opacity = 1,
		addonScale = .8,
		MBF_FrameLocation = { "TOPRIGHT", "TOPRIGHT", 0, 0 },
		mbfHidden = false,
		rollUp = false,
		-- Gathering Vars
		minimapButton = { hide = true },
		grabMBFButton = false,
		grabBlizzButtons = false,
		disabledMail = true,
		MBFHideMiniMapMailFrame = false,
		MBFHideMiniMapTracking = false,
		MBFHideMiniMapVoiceChatFrame = false,
		MBFHideGameTimeFrame = false,
		MBFHideMinimapZoomIn  = false,
		MBFHideMiniMapWorldMapButton = false,
		MBFHideMiniMapLFGFrame = false,
		MBFHideMiniMapBattlefieldFrame = false,
		-- Exception Vars
		currentMinimapIcon = "Note",
		MinimapIcons = { "Note", "JQuest", "NauticusMiniIcon", "MinimapIcon", "GatherMatePin", "WestPointer", "Chinchilla_", "SmartMinimapZoom", "pMinimap", "GuildMap3Mini", "MiniButton" },
		currentButtonOverride = "notesiconframe",
		ButtonOverride = { "notesiconframe", "duckiebank_minimapicon", "cta_minimapicon", "BejeweledMinimapIcon", "EMPMINIMAPBUTTON", "MobMapMinimapButtonFrame", "Karma_MinimapIconFrame", "FuBarPluginCraftNotesFrameMinimapButton", "PeggledMinimapIcon"},
		UserUIProtected = { "TitanPanel", "AutoBarButton", "FuBarFrame", "RicoMinimap_CoordinatesFrame", "MinimapZoom", "MinimapButtonFrame", "Xparky", "MBFRestoreButton", "BasicMiniMap", "CT_RASetsFrame", "SMM", "GuildOrg_Toggle" },
		ParentStop = { "CECBMiniMapButtonFrame", "CT_RASetsFrame", "GuildOrg_Toggle", "PoisonerStateHeader" },
		MBF_Ignore = { "MetamapButton" },
		MBF_Include = { },
		-- Sorting Vars
		sortOrder = "Alphabetical",
		growUp = false,
		currentChild = "",
		customChildren = {},
	}
}


-- Init and Event Handler Functions

function MBF:OnInitialize()
    -- Called when the addon is loaded
	self.db = LibStub("AceDB-3.0"):New("MBFDB", defaults, true)

	if LibStub:GetLibrary("LibAboutPanel", true) then
		self.optionsFrame = LibStub:GetLibrary("LibAboutPanel").new(nil, "Minimap Button Frame")
	else
		self:Print("Lib AboutPanel not loaded.")
	end

	LibStub("AceConfig-3.0"):RegisterOptionsTable("MBF Display", display)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("MBF Gathering", gathering)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("MBF Exceptions", exceptions)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("MBF Sorting", sorting)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("MBF Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db))
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("MBF Display", L["Display"], "MinimapButtonFrame")
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("MBF Gathering", L["Gathering"], "MinimapButtonFrame")
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("MBF Exceptions", L["Exceptions"], "MinimapButtonFrame")
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("MBF Sorting", L["Sorting"], "MinimapButtonFrame")
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("MBF Profiles", L["Profiles"], "MinimapButtonFrame")

	self:RegisterChatCommand(L["MBF"], "ChatCommand")

	self:fillDropdowns();

	MBFC_LoadStandardSkins();

	MBF.obj = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("MinimapButtonFrame", {
		type = "launcher",
		text = "MinimapButtonFrame",
		OnClick = function(_, msg)
			if (IsShiftKeyDown()) or (arg1 == "RightButton") then						
				MBFC_Toggle();
			elseif ( arg1 == "LeftButton" ) then
				MBFC_Visible(2, this:GetParent():GetName());
			end
		end,
		icon = "Interface\\Icons\\INV_Misc_Coin_11",
		OnTooltipShow = function(tooltip)
			if not tooltip or not tooltip.AddLine then return end
			tooltip:AddLine(L["ADDON"]);
			tooltip:AddLine(L["MBF_LDB_TOOLTIP"])
		end,
	})

	-- register MBF with LibDBicon and show minimap icon
	if libdbicon then
		libdbicon:Register("MBF", MBF.obj, MBF.db.profile.minimapButton)
	end

	self:Init();

	MinimapButtonFrame:RegisterForDrag("LeftButton");
	MinimapButtonFrameDragButton:RegisterForClicks("RightButtonUp");
	MBFRestoreButton:RegisterForClicks("RightButtonUp");

	self:ScheduleRepeatingTimer("Scan", 5)
end

function MBF:Init()
	currentProfile = self.db:GetCurrentProfile();
	
	setMBFLocation();
	
	if (((MBF.db.profile.disabledMail == true) and (HasNewMail() ~= 1)) and (((MBF.db.profile.grabBlizzButtons == true) and (isInTable(MBF.db.profile.MBF_Ignore,"MiniMapMailFrame") == false)) or ((MBF.db.profile.grabBlizzButtons == false) and (isInTable(MBF.db.profile.MBF_Include,"MiniMapMailFrame") == true)))) then
		MiniMapMailFrameDisabled:Show();
		MiniMapMailFrameDisabled:SetFrameLevel(MinimapButtonFrame:GetFrameLevel()+1)
	end

	if (MBF.db.profile.locked) then
		MinimapButtonFrameDragButton:Hide();
		MBFRestoreButtonFrame:Hide();
	end

	self:SwapTitleLocation()

	MBFRestoreButtonFrame:SetAlpha(MBF.db.profile.opacity);
	MBFRestoreButtonFrame:SetScale(MBF.db.profile.addonScale);
	
	MinimapButtonFrame:SetAlpha(MBF.db.profile.opacity);
	MinimapButtonFrame:SetScale(MBF.db.profile.addonScale);
	MBFC_ColorLocked();

	if MBF.db.profile.mbfHidden then
		MinimapButtonFrame:Hide();
		MBFRestoreButtonFrame:Hide();
	end
	if MBF.db.profile.rollUp then
		MBFRestoreButton:Show();
		MBFRestoreButtonFrame:Show();
	end

	if libdbicon then
		if MBF.db.profile.minimapButton.hide then
			libdbicon:Hide("MBF")
		else
			libdbicon:Show("MBF")
		end
	end
	numButtons = MinimapButtonFrame:GetNumChildren();
end

function MBF:ChatCommand(input)
	if not input or input:trim() == "" then
		InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
	else
		local startPos, endPos, firstWord, restOfString = strfind(input, "(%w+)[%s%p]*(.*)");
		firstWord = strlower(firstWord)

		if (firstWord == L["usage"]) then
			self:Print(L["Version"] .. " " .. MBFversion);
			self:Print(L["MBF_SLASH_Detail1"]);
		end
		if (firstWord == L["info"]) then
			displayInfo(GetMouseFocus());
		end 
		if (firstWord == L["show"]) then
			MBFC_Visible(3);
		end
		if (firstWord == L["hide"]) then
			MBFC_Visible(4);
		end
		if (firstWord == L["help"]) then
			self:Print(L["MBF_SLASH_Detail1"]);
			self:Print(L["MBF_SLASH_Detail2"]);
			self:Print(L["MBF_SLASH_Detail3"]);
			self:Print(L["MBF_SLASH_Detail4"]);
			self:Print(L["MBF_SLASH_Detail5"]);
			self:Print(L["MBF_SLASH_Detail6"]);
			self:Print(L["MBF_SLASH_Detail7"]);
			self:Print(L["MBF_SLASH_Detail8"]);
		end
		if (firstWord == L["config"]) then
			MBFC_Toggle();
		end
		if (firstWord == L["remove"]) then
			if (restOfString == "") then
				if (GetMouseFocus():GetName() ~= "WorldFrame") then
					removeButton(GetMouseFocus(), 0)
				end
			else
				if (restOfString ~= "WorldFrame") then
					local button = _G[restOfString];
					if (button ~= nil) then
						removeButton(button, 0)
					else
						self:Print(L["MBF_ERR7"]);
					end
				end
			end
		end
		if (firstWord == L["add"]) then
			if (restOfString == "") then 
				includeButton(GetMouseFocus());
			else
				local button = _G[restOfString];
				if (button ~= nil) then
					includeButton(button)
				else
					self:Print(L["MBF_ERR7"]);
				end
			end
		end
	end
end

function displayInfo(target)
	MBF:Print("----------------------------------------------------------");
	MBF:Print("----------------------------------------------------------");
	MBF:Print(format(target:GetName() or '(' .. L["Unnamed Object"] .. ')'));
	MBF:Print("----------------------------------------------------------");
	if (target:GetName() ~= "WorldFrame") then
		MBF:Print(L["Parent"] .. " : " .. format(target:GetParent():GetName() or '(' .. L["Unknown Parent Name"] .. ')'));
	else
		MBF:Print(L["Parent"] .. " : " .. L["No Parent"]);
	end 
	MBF:Print(L["Object Type"] .. " : " .. format(target:GetObjectType() or '(' .. L["Unknown Object Type"] .. ')'));
	MBF:Print("----------------------------------------------------------");
	MBF:Print("Textures");
	MBF:Print("----------------------------------------------------------");
	for _, r in pairs({target:GetRegions()}) do
		if r:GetObjectType() == "Texture" then
			rName = r:GetName();
			rTex = r:GetTexture();
			rDL = r:GetDrawLayer();
			MBF:Print("Texture Name : " .. format(rName or "nil"));
			MBF:Print("Texture Path : " .. format(rTex or "nil"));
			MBF:Print("Draw Layer   : " .. format(rDL or "nil"));
			MBF:Print("----------------------------------------------------------");
		end
	end
	MBF:Print("----------------------------------------------------------");
	MBF:Print("Size");
	MBF:Print("----------------------------------------------------------");
	MBF:Print("Width : " .. target:GetWidth());
	MBF:Print("Height : " .. target:GetHeight());
end

function MBF:OnDragStart()
	if (MBF.db.profile.locked == false) then
		MinimapButtonFrame:StartMoving();
		MinimapButtonFrame.isMoving = true;
	end
end

function MBF:OnDragStop()
	if (MBF.db.profile.locked == false) then
		MinimapButtonFrame:StopMovingOrSizing();
		MinimapButtonFrame.isMoving = false;
		MinimapButtonFrame:SetUserPlaced(false);
		MinimapButtonFrame:SetFrameLevel(2);
		
		MBF:SavePosition();
	end
end 

function MBF:SavePosition()

	local bPoint;
	local bRelativeTo;
	local bRelativePoint;
	local bXofs;
	local bYofs;
	local width;
	local height;

	bPoint, bRelativeTo, bRelativePoint, bXofs, bYofs = MinimapButtonFrame:GetPoint();

	if MBF.db.profile.mbfAnchor == bPoint then
		MBF.db.profile.MBF_FrameLocation = { bPoint, bRelativePoint, bXofs, bYofs }
	else
		width = MinimapButtonFrame:GetWidth();
		height = MinimapButtonFrame:GetHeight();

		if bPoint == "TOP" then
			bXofs = bXofs - (width / 2)
		elseif bPoint == "LEFT" then
			bYofs = bYofs + (height / 2)
		elseif bPoint == "BOTTOMLEFT" then
			bYofs = bYofs + height
		elseif bPoint == "TOPRIGHT" then
			bXofs = bXofs - width
		elseif bPoint == "RIGHT" then
			bYofs = bYofs + (height / 2)
			bXofs = bXofs - width
		elseif bPoint == "BOTTOM" then
			bYofs = bYofs + height
			bXofs = bXofs - (width / 2)
		elseif bPoint == "BOTTOMRIGHT" then
			bYofs = bYofs + height
			bXofs = bXofs - width
		elseif bPoint == "CENTER" then
			bYofs = bYofs + (height / 2)
			bXofs = bXofs - (width / 2)
		end
	
		if MBF.db.profile.mbfAnchor == "TOPRIGHT"then
			bXofs = bXofs + width
		elseif MBF.db.profile.mbfAnchor == "BOTTOMRIGHT" then
			bYofs = bYofs - height
			bXofs = bXofs + width
		elseif MBF.db.profile.mbfAnchor == "BOTTOMLEFT" then
			bYofs = bYofs - height
		end

		MBF.db.profile.MBF_FrameLocation = { MBF.db.profile.mbfAnchor, bRelativePoint, bXofs, bYofs }
	end

	setMBFLocation();
end

-- Utility Functions


function CloneTable(t)			--Code by Grayhoof (SCT)
	local new = {};
	local i, v = next(t, nil);
	while i do
		if type(v)=="table" then
			v=CloneTable(v);
		end
		new[i] = v;
		i, v = next(t, i);
	end
	return new;
end

function setMBFLocation()
	local bPoint;
	local bRelativePoint;
	local bXofs;
	local bYofs;

	if not MinimapButtonFrame.isMoving then

		bPoint, bRelativePoint, bXofs, bYofs = unpack(MBF.db.profile.MBF_FrameLocation);

		MinimapButtonFrame:ClearAllPoints();
		MinimapButtonFrame:SetPoint(bPoint, UIParent, bRelativePoint, bXofs, bYofs);
		MinimapButtonFrame:SetFrameLevel(2);
		MinimapButtonFrame:SetUserPlaced(false);
	end
end

isInTable = function(tab, frameName)
	for k,v in ipairs(tab) do
		if (strlower(v) == strlower(frameName)) then
			return true;
		end
	end
	return false;
end

isPartialMatch = function(frameName, tab)
	local result = false

	for k,v in ipairs(tab) do
		startpos, endpos = strfind(strlower(frameName), strlower(v))
		if (startpos == 1) then
			result = true;
		end
	end

	return result;
end

isBlizzButton = function(frameName)
	return isInTable(BlizzButtons, frameName);
end

getTopParent = function(frame) 
-- returns 1 for ParentStop parent, and 0 for MBF
	local result;
	local parentName = frame:GetParent():GetName();

	if (isInTable(MBF.db.profile.ParentStop,parentName) or isInTable(BlizzParentStop,parentName)) then 
		result = 1
	elseif (parentName == "MinimapButtonFrame") then
		result = 0
	else
		result = getTopParent(frame:GetParent());
	end
	
	return result;
end

isMinimapIcon = function(frame)
	local foundPos = 0;
	local frameName = strlower(frame);
	local result = false;

	for k,v in ipairs(MBF.db.profile.MinimapIcons) do
		foundPos = strfind(frameName,strlower(v),1);
		
		if (foundPos) then
			if not isInTable(MBF.db.profile.ButtonOverride, frameName) then
				result = true;
			end
		end
	end
	return result;
end

isValidAdd = function(frame, autoGather)
	local result = true;
	local frameName = frame:GetName();

	if (frameName ~= nil) then
		if (frame:IsVisible()) then
			if (getTopParent(frame) == 1) then
				if (isPartialMatch(frameName, BlizzUI) or isPartialMatch(frameName,MBF.db.profile.UserUIProtected)) then
					result = false;
				end

				if (isMinimapIcon(frameName)) then
					result = false;
				end

				if (frameName == "LibDBIcon10_MBF") then
					if (MBF.db.profile.grabMBFButton == false) then
						result = false;
					else
						result = true;
					end
				end 

				if (frameName == "GuildOrgButtonFrame") then
					result = false;
				end

				if (autoGather) then
					if (isBlizzButton(frameName)) then
						if (MBF.db.profile.grabBlizzButtons == true) then
							result = true;
						else
							result = false;
						end
					end
					if (isInTable(MBF.db.profile.MBF_Ignore,frameName)) then
						result = false;
					end
				else
					if (isBlizzButton(frameName)) then
						if ((MBF.db.profile.grabBlizzButtons == true) and (isInTable(MBF.db.profile.MBF_Ignore,frameName))) then
							result = true;
						elseif (MBF.db.profile.grabBlizzButtons == false) then
							result = true;
						end
					end
				end
			else
				result = false;
			end
		elseif (frameName == "MiniMapMailFrame") then
			if ((MBF.db.profile.disabledMail == false) or (MBF.db.profile.MBFHideMiniMapMailFrame == true) or ((MBF.db.profile.grabBlizzButtons == false) and (isInTable(MBF.db.profile.MBF_Include, frameName) == false)) or ((MBF.db.profile.grabBlizzButtons == true) and (isInTable(MBF.db.profile.MBF_Ignore, frameName) == true))) then
				result = false;
			end
		else
			result = false;
		end
	else
		result = false;
	end
	return result

end

isButtonFrame = function(frame)
	return (frame:GetObjectType() == ("Frame"))
end

function removeFromTable(tab, buttonName)
	for k,v in ipairs(tab) do
		if (strlower(v) == strlower(buttonName)) then
			tremove(tab,k);
		end
	end
end

displayDisabledMail = function()
	-- Will return if the button should be shown
	local result = true;
	if (((MBF.db.profile.disabledMail == false) or (MBF.db.profile.MBFHideMiniMapMailFrame == true) or (HasNewMail() == 1)) or ((MBF.db.profile.grabBlizzButtons == true) and (isInTable(MBF.db.profile.MBF_Ignore,"MiniMapMailFrame") == true)) or ((MBF.db.profile.grabBlizzButtons == false) and (isInTable(MBF.db.profile.MBF_Include,"MiniMapMailFrame") == false))) then
		result = false;
	end
	return result;
end

-- Button Skinning Functions

function MBFAddSkin(tID, tBorderPath, tBackdropPath, size)
	tList[tID] = tID;
	tBorder[tID] = tBorderPath;
	tBackdrop[tID] = tBackdropPath;
	tSize[tID] = size;
end

function textureFrame(frame)
local button;

	for i = 1, select("#", frame:GetChildren()) do
		button = select(i, frame:GetChildren());
		textureButton(button);
	end
	
	-- Blizz Button Tweaks
	MiniMapVoiceChatFrameIcon:ClearAllPoints();
	MiniMapVoiceChatFrameIcon:SetPoint("CENTER");
	if ((MBF.db.profile.grabBlizzButtons == true) and (isInTable(MBF.db.profile.MBF_Ignore,"GameTimeFrame") == false)) or (isInTable(MBF.db.profile.MBF_Include,"GameTimeFrame") == true) then
			MBFSkinMinimapButton(GameTimeFrame,1);
	end	
end

function removeTextures(button)
	if button:GetName() == "MiniMapTracking" then
		button = getglobal("MiniMapTrackingButton");
	end

	for _, r in pairs({button:GetRegions()}) do
		if r:GetObjectType() == "Texture" then
			rName = r:GetName();
			rTex = r:GetTexture();
			rDL = r:GetDrawLayer();
			if (rTex and string.find(rTex, "TrackingBorder")) then
				r:Show();
			end
		end
	end

	if button.MBFoTex then
		button.MBFoTex:SetTexture(nil);
		button.MBFoTex:Hide();
	end

	if button.MBFbTex then
		button.MBFbTex:SetTexture(nil);
		button.MBFbTex:Hide();
	end
end

function textureButton(button)
local buttonName, buttonType, rName, rTex, rDL, foundOverlay;
local override = 0

	buttonName = button:GetName();
	buttonType = button:GetObjectType();
	if (buttonName == "MiniMapTrackingButton") then
		override = 1;
	end
	
	if buttonName and (buttonType == "Button" or (buttonType == "Frame" and (buttonName == "MiniMapMailFrame" or buttonName == "BejeweledMinimapIcon" or buttonName == "PeggledMinimapIcon"))) and (not isInTable(SkinProtect, buttonName)) then
		foundOverlay = false;
		for _, r in pairs({button:GetRegions()}) do
			if r:GetObjectType() == "Texture" then
				rName = r:GetName();
				rTex = r:GetTexture();
				rDL = r:GetDrawLayer();
				if ((rDL == "OVERLAY") or (rTex and string.find(rTex, "TrackingBorder"))) then
					foundOverlay = true;
					r:Hide();
					MBFSkinMinimapButton(button,override);
				elseif (((rDL == "BACKGROUND") or (rDL == "BORDER") or (rDL == "ARTWORK")) and (buttonName ~= "WIM3MinimapButton")) then
					if (rName == "MBFBackground") then
						r:SetDrawLayer("BACKGROUND");
					else
						r:SetDrawLayer("ARTWORK");
					end
				end
			end
		end
		if (foundOverlay == false) then
			MBFSkinMinimapButton(button);
		end
	elseif (buttonName and (buttonType == "Frame")) then
		textureFrame(button);
	end
end

function MBFSkinMinimapButton(button, override)
	local size = tSize[MBF.db.profile.currentTexture];

	if (override == nil) then
		override = 0;
	end

	if not button.MBFoTex then 
		button.MBFoTex = button:CreateTexture("MBFOverlay");
	end

	if (tBorder[MBF.db.profile.currentTexture] == nil) then
		button.MBFoTex:SetTexture(nil);
		button.MBFoTex:Hide();
	else
		button.MBFoTex:Show();
		button.MBFoTex:SetTexture(tBorder[MBF.db.profile.currentTexture]);
		button.MBFoTex:SetWidth(size);
		button.MBFoTex:SetHeight(size);
		button.MBFoTex:ClearAllPoints();
		button.MBFoTex:SetPoint("CENTER");
		button.MBFoTex:SetDrawLayer("OVERLAY");
	end
	
	if (override ~= 1) then
		if not button.MBFbTex then 
			button.MBFbTex = button:CreateTexture("MBFBackground"); 
		end

		if (tBackdrop[MBF.db.profile.currentTexture] == nil) then
			button.MBFbTex:SetTexture(nil);
			button.MBFbTex:Hide();
		else
			button.MBFbTex:Show();
			button.MBFbTex:SetDrawLayer("BACKGROUND");
			button.MBFbTex:SetTexture(tBackdrop[MBF.db.profile.currentTexture]);
			button.MBFbTex:ClearAllPoints();
			button.MBFbTex:SetPoint("CENTER");
			button.MBFbTex:SetWidth(size); 
			button.MBFbTex:SetHeight(size);
		end
	end
end

-- Button Gathering Functions

function findButtons(frame)
	for i, child in ipairs({frame:GetChildren()}) do
		if (child:GetName() == "CECBMiniMapButtonFrame") then
			child = CECBMiniMapButton;
		end
		if (isValidAdd(child, true)) then
			addButton(child);
		end
	end
end

function findIncluded()
	local button;
	for k,v in ipairs(MBF.db.profile.MBF_Include) do
		button = getglobal(v);
		if (button ~= nil) and (button:IsVisible()) then
			addButton(button);
		end
	end
end

saveOldData = function(button)
	local result = false;
	oldPoint = nil;

	oldPoint, oldRelativeTo, oldRelativePoint, oldXofs, oldYofs = button:GetPoint();

	if oldPoint ~= nil then
		oldName = button:GetName();
		oldParentName = button:GetParent():GetName();
		oldFrameLevel = button:GetFrameLevel();
		oldOnDragStart = button:GetScript('OnDragStart');
		oldOnDragStop = button:GetScript('OnDragStop');
		oldOnEvent = button:GetScript('OnEvent');
		oldWidth = button:GetWidth();
		oldHeight = button:GetHeight();
		oldScale = button:GetScale();
		oldLevel = button:GetFrameLevel();
		oldStrata = button:GetFrameStrata();

		MBF_ButtonInfoStorage[button:GetName()] = { oldName, oldParentName, oldFrameLevel, oldPoint, oldRelativeTo, oldRelativePoint, oldXofs, oldYofs, oldOnDragStart, oldOnDragStop, oldOnEvent, oldWidth, oldHeight, oldScale, oldLevel, oldStrata };
		result = true;
	end
	return result;
end

function saveAndDisableChildScripts(button)
	local childName;
	local childParentName;
	local childOnDragStart;
	local childOnDragStop;
	local childOnEvent;

	if not isInTable(BlizzButtons, button:GetName()) then
		for i, child in ipairs({button:GetChildren()}) do
			childName = child:GetName();

			if (childName ~= nil) then
				childParentName = child:GetParent():GetName();
				childOnDragStart = child:GetScript('OnDragStart');
				childOnDragStop = child:GetScript('OnDragStop');
				childOnEvent = child:GetScript('OnEvent');

				MBF_ChildEventStorage[childName] = {childParentName, childName, childOnDragStart, childOnDragStop, childOnEvent};	

				child:SetScript('OnDragStart', nil);
				child:SetScript('OnDragStop', nil);
				
				if (isInTable(BlizzButtons, childName) == false) then
					child:SetScript('OnEvent', nil);
				end
			end
		end
	end
end

removeChildScriptStorageRow = function(buttonName)
	local childName;
	local childParentName;
	local childOnDragStart;
	local childOnDragStop;
	local childOnEvent;
	local result = false;
	local DummyTable = {};	

	for k,v in pairs(MBF_ChildEventStorage) do
		childParentName, childName, childOnDragStart, childOnDragStop, childOnEvent = unpack(v);

		if(childParentName == buttonName) then
			result = true;
		else
			DummyTable[childName] = { childParentName, childName, childOnDragStart, childOnDragStop, childOnEvent };
		end
	end
	MBF_ChildEventStorage = DummyTable;
	DummyTable = {};
	return result;
end

function restoreChildScripts(button)
	local oldChild;
	local childName;
	local childParentName;
	local childOnDragStart;
	local childOnDragStop;
	local childOnEvent;
	local buttonName = button:GetName();
	local success = false;

	if not isInTable(BlizzButtons, buttonName) then
		for i, child in ipairs({button:GetChildren()}) do

			oldChild = MBF_ChildEventStorage[child:GetName()]
			if oldChild ~= nil then

				childParentName, childName, childOnDragStart, childOnDragStop, childOnEvent = unpack(oldChild);

				child:SetScript('OnDragStart', childOnDragStart);
				child:SetScript('OnDragStop', childOnDragStop);
				child:SetScript('OnEvent', childOnEvent);
			end
		end
		
		if oldChild ~= nil then
			success = removeChildScriptStorageRow(buttonName);

			if (success == false) then
				MBF:Print(L["MBF_ERR5"] .. " : " .. buttonName);
			end
		end
	end
 end

addButton = function(button)
	local transferResult = false;

	if button:GetParent() ~= MinimapButtonFrame then
		local buttonName = button:GetName();

		if saveOldData(button) then

			button:SetParent(MinimapButtonFrame)
			button:SetScript('OnDragStart', nil);
			button:SetScript('OnDragStop', nil);
			
			if (isButtonFrame(button)) then
				saveAndDisableChildScripts(button);
			end
			
			if (isBlizzButton(buttonName) == false) then
				button:SetScript('OnEvent', nil);
			end
			if (buttonName == "BigFootMinimapButton") then
				button:SetScript('OnShow', nil);
				button:SetFrameLevel(MinimapButtonFrame:GetFrameLevel()+1)
			end
			if ((buttonName == "MiniMapTracking") or (buttonName == "GameTimeFrame") or (buttonName == "FeedbackUIButton")) then
				button:SetWidth(36);
				button:SetHeight(34);
			end
			if (buttonName == "MonkeyBuddyIconButton") then
				button:SetWidth(33);
				button:SetHeight(33);
			end
			if ((button:GetHeight() ~= 33) and (buttonName ~= "AM_MinimapButton") and (buttonName ~= "BejeweledMinimapIcon") and (buttonName == "PeggledMinimapIcon")) then
				button:SetScale(33 / button:GetHeight());
			end

			textureButton(button);
			transferResult = true;
		end
	end
	return transferResult;
end

restoreButtonSettings = function(button)
	local buttonName = button:GetName();
	local foundButton = false;

	-- Load row and Remove from Storage
	
	if MBF_ButtonInfoStorage[buttonName] ~= nil then
		
		oldName, oldParentName, oldFrameLevel, oldPoint, oldRelativeTo, oldRelativePoint, oldXofs, oldYofs, oldOnDragStart, oldOnDragStop, oldOnEvent, oldWidth, oldHeight, oldScale, oldLevel, oldStrata = unpack(MBF_ButtonInfoStorage[buttonName]);

		button:ClearAllPoints();
		if (oldPoint ~= nil) then
			button:SetPoint(oldPoint, oldRelativeTo, oldRelativePoint, oldXofs, oldYofs);
		end
		button:SetParent(oldParentName);
		button:SetFrameLevel(oldFrameLevel);
		button:SetScript('OnDragStart', oldOnDragStart);
		button:SetScript('OnDragStop', oldOnDragStop);
		button:SetScript('OnEvent', oldOnEvent);
		button:SetWidth(oldWidth);
		button:SetHeight(oldHeight);
		button:SetScale(oldScale);
		button:SetFrameLevel(oldLevel);
		button:SetFrameStrata(oldStrata);

		if (button:GetNumChildren() > 0) then
			restoreChildScripts(button);
		end

		button:GetParent():Show();
		
		removeTextures(button);

		foundButton = true;
		MBF_ButtonInfoStorage[buttonName] = nil;
	end
	return foundButton;
end

function ClearMBF()
	for i, button in ipairs({MinimapButtonFrame:GetChildren()}) do
		removeButton(button, 1);
	end
end

function removeButton(button, clear)
	local success = false;
	local isBlizz = false;

	if (button:GetParent() == MinimapButtonFrame and (button:GetName() ~= "MinimapButtonFrameDragButton")) then
		if (button:GetName() == "MiniMapMailFrameDisabled") then
			button = MiniMapMailFrame;
			MiniMapMailFrameDisabled:Hide();
		elseif (button:GetName() == "MiniMapMailFrame") then
			MiniMapMailFrameDisabled:Hide();
		end
		
		success = restoreButtonSettings(button);
		
		if ((success) and (clear == 0)) then
			if (isInTable(MBF.db.profile.MBF_Include, button:GetName())) then
				removeFromTable(MBF.db.profile.MBF_Include, button:GetName());
			elseif (isInTable(MBF.db.profile.MBF_Ignore, button:GetName()) == false) then
				isBlizz = isBlizzButton(button:GetName());
				if (((isBlizz and MBF.db.profile.grabBlizzButtons) or (isBlizz == false)) and (button:GetName() ~= "LibDBIcon10_MBF")) then
					tinsert(MBF.db.profile.MBF_Ignore, button:GetName());
				end 
			end
		elseif (success == false) and (clear == 0) then
			MBF:Print(L["MBF_ERR1"] .. " : " .. button:GetName());
		end

		if (clear == 0) then
			MBF:Scan()
		end
	else
		if (((isInTable(MBF.db.profile.ParentStop, button:GetParent():GetName()) == true) or (isInTable(BlizzParentStop, button:GetParent():GetName()) == true)) and (button:GetName() ~= "MiniMapMailFrame")) then
			MBF:Print(L["MBF_ERR2"] .. " : " .. button:GetName());
		elseif (button:GetName() ~= "MinimapButtonFrameDragButton") and (button:GetName() ~= "MiniMapMailFrame") then 
			removeButton(button:GetParent(), clear);
		end
	end
end

function removeInvisible(button)
	local success = false;
	if ((button:GetParent() == MinimapButtonFrame) and (button:GetName() ~= "MinimapButtonFrameDragButton"))then
		success = restoreButtonSettings(button);
		if (success == false) then
			MBF:Print(L["MBF_ERR3"] .. " : " .. button:GetName());
		end
	end
end

function removeBlizzButtons()
local button;
local mbfHide = MBF.db.profile.mbfHidden;

	if (mbfHide == true) then
		MinimapButtonFrame:Show();
		MBFRestoreButtonFrame:Show();
	end
	for k,v in pairs(BlizzButtons) do
		button = getglobal(v);
		if (button ~= nil) and (button:IsVisible()) and (isInTable(MBF.db.profile.MBF_Ignore,v) == false) then
			removeButton(button, 0)
		elseif ((v == "MiniMapMailFrame") and (isInTable(MBF.db.profile.MBF_Ignore,v) == false)) then
			removeButton(button, 0)
		end
	end
	if (mbfHide == true) then
		MinimapButtonFrame:Hide();
		MBFRestoreButtonFrame:Hide();
	end
end

function includeButton(button)
	local buttonName = button:GetName();
	local parentName;

	if (buttonName ~= "WorldFrame") then
		parentName = button:GetParent():GetName();
		if (isValidAdd(button,false)) then
			if (isInTable(MBF.db.profile.ParentStop, parentName) or isInTable(BlizzParentStop, parentName)) then
				if addButton(button) then
					if (isInTable(MBF.db.profile.MBF_Ignore, buttonName)) then
						removeFromTable(MBF.db.profile.MBF_Ignore, buttonName);
					else
						tinsert(MBF.db.profile.MBF_Include, buttonName);
					end
					MBF:Scan()
				else
					MBF:Print(L["MBF_ERR6"] .. " : " .. button:GetName());
				end
			else
				includeButton(button:GetParent())
			end
		else
			if (button:GetName() ~= nil) then
				MBF:Print(L["MBF_ERR4"] .. " : " .. button:GetName());
			else
				MBF:Print(L["MBF_ERR4"] .. " : " .. L["MBF_UnnamedObject"]);
			end
		end 
	else
		MBF:Print(L["MBF_ERR4"] .. " : " .. button:GetName());
	end
end

local sortChildren = function()
	if (MBF.db.profile.sortOrder ~= L["Custom"]) then
		local buttonName;
		local Children = {};
		local Blizz = {};
		for i, button in ipairs({MinimapButtonFrame:GetChildren()}) do
			buttonName = button:GetName();
			if ((button:IsVisible()) or (MBF.db.profile.mbfHidden)) then
				if (((MBF.db.profile.sortOrder == L["Blizzard First"]) or (MBF.db.profile.sortOrder == L["Blizzard Last"])) and (isBlizzButton(buttonName))) then
					tinsert(Blizz, buttonName);
				else 
					tinsert(Children, buttonName);
				end
			else
				if (((buttonName ~= "MiniMapMailFrame") or (MBF.db.profile.MBFHideMiniMapMailFrame == true) or (MBF.db.profile.disabledMail == false)) and (buttonName ~= "MiniMapMailFrameDisabled")) then
					if (MinimapButtonFrame:IsVisible()) then
						removeInvisible(button);
					end
				elseif ((MBF.db.profile.sortOrder == L["Blizzard First"]) or (MBF.db.profile.sortOrder == L["Blizzard Last"])) then
					if ((displayDisabledMail()) or (buttonName == "MiniMapMailFrame")) then
						tinsert(Blizz, buttonName);
					end
				else
					if ((displayDisabledMail()) or (buttonName == "MiniMapMailFrame")) then
						tinsert(Children, buttonName);
					end
				end
			end
		end
		sort(Blizz);
		sort(Children);
		if (MBF.db.profile.sortOrder == L["Blizzard First"]) then
			for i, button in ipairs(Children) do
				tinsert(Blizz, button);
			end
			return Blizz;
		elseif (MBF.db.profile.sortOrder == L["Blizzard Last"]) then
			for i, button in ipairs(Blizz) do
				tinsert(Children, button);
			end
			return Children;
		else	
			return Children;
		end
	else
		return MBF.db.profile.customChildren
	end
end

function updatePositions()

	local processMail = false;
	local childExceptions = 2
	
	local avgButtonSize = 33 + MBF.db.profile.padding;
	local spacer = avgButtonSize / 2;
	local x = spacer + 5;
	local y = -spacer - 5;
	
	local crPad;
	local iterator = 1;

	local numChildrenRC = ceil((MinimapButtonFrame:GetNumChildren() - childExceptions) / MBF.db.profile.columns_or_rows);
	local userSize = (MBF.db.profile.columns_or_rows * avgButtonSize)
	local dynamicSize = (numChildrenRC * avgButtonSize)

	if (MBF.db.profile.sort_by_rows) then
		MinimapButtonFrame:SetHeight(userSize + 10);
		MinimapButtonFrame:SetWidth(dynamicSize + 10);
	else
		MinimapButtonFrame:SetWidth(userSize + 10);
		MinimapButtonFrame:SetHeight(dynamicSize + 10);
	end		

	setMBFLocation();
	
	for i, buttonName in ipairs(sortChildren()) do

		local button = getglobal(buttonName);

		if ((buttonName ~= "MinimapButtonFrameDragButton") and (buttonName ~= "MiniMapMailFrameDisabled") and (button ~= nil) and (((MinimapButtonFrame:IsVisible()) and (buttonName == "MiniMapMailFrame") or (button:IsVisible())))) then
			
			button:SetFrameStrata("MEDIUM");
			button:SetFrameLevel(MinimapButtonFrame:GetFrameLevel() + 1);
			
			if ((mod(iterator-1,MBF.db.profile.columns_or_rows) == 0) and iterator > 1) then
				if (MBF.db.profile.sort_by_rows) then
					y = -spacer - 5;
					x = x + avgButtonSize;
				else
					y = y - avgButtonSize;
					x = spacer + 5;
					
				end
			end

			button:ClearAllPoints();
			
			if (button:GetScale() ~= 1) then
				if MBF.db.profile.GrowUp then
					button:SetPoint("CENTER", MinimapButtonFrame, "BOTTOMLEFT", x + (x * (1 - button:GetScale())), -y - (y * (1 - button:GetScale())));
				else
					button:SetPoint("CENTER", MinimapButtonFrame, "TOPLEFT", x + (x * (1 - button:GetScale())), y + (y * (1 - button:GetScale())));
				end
			else
				if MBF.db.profile.GrowUp then
					button:SetPoint("CENTER", MinimapButtonFrame, "BOTTOMLEFT", x, -y);
				else
					button:SetPoint("CENTER", MinimapButtonFrame, "TOPLEFT", x, y);
				end
			end
			
			if (MBF.db.profile.sort_by_rows) then
				y = y - avgButtonSize;
			else
				x = x + avgButtonSize;
			end

			iterator = iterator + 1;
			
			if (buttonName == "MiniMapMailFrame") then
				MiniMapMailFrameDisabled:ClearAllPoints();
				MiniMapMailFrameDisabled:SetPoint(button:GetPoint());
				if (HasNewMail() == 1) then
					MiniMapMailFrameDisabled:Hide();
					MiniMapMailFrameDisabled:SetFrameLevel(MiniMapMailFrame:GetFrameLevel()-1)
					MiniMapMailFrame:Show()
				elseif ((MBF.db.profile.grabBlizzButtons == true) and (MBF.db.profile.disabledMail == true)) then
					MiniMapMailFrameDisabled:Show();
					MiniMapMailFrameDisabled:SetFrameLevel(MiniMapMailFrame:GetFrameLevel()+1)
				end
			end
		elseif (buttonName == "MiniMapMailFrameDisabled") then
			if (displayDisabledMail()) then 
				MiniMapMailFrameDisabled:Show();
				MiniMapMailFrameDisabled:SetFrameLevel(MiniMapMailFrame:GetFrameLevel()+1)
			else
				MiniMapMailFrameDisabled:Hide();
				MiniMapMailFrameDisabled:SetFrameLevel(MinimapButtonFrame:GetFrameLevel()-1)
			end
		end
		button = "";
	end
end

function MBF:Scan()
	if currentProfile ~= self.db:GetCurrentProfile() then
		setFrameDefaults()

		MiniMapTracking:Show()
		MiniMapVoiceChatFrame:Show()
		MiniMapWorldMapButton:Show()
		MinimapZoomIn:Show()
		MinimapZoomOut:Show()
		GameTimeFrame:Show()
		if HasNewMail() then
			MiniMapMailFrame:Show()
		end
		ClearMBF()
	end

	MBFC_KeepBlizzHidden()
	findButtons(Minimap)
	findButtons(MinimapBackdrop)
	findIncluded()
	if isValidAdd(GameTimeFrame, true) then
		addButton(GameTimeFrame)
	end
	updatePositions()
	if currentProfile ~= self.db:GetCurrentProfile() then self:Init() end
	self:SwapTitleLocation()

	for i, button in ipairs({MinimapButtonFrame:GetChildren()}) do
		if button:GetName() ~= "MinimapButtonFrameDragButton" and button:GetName() ~= "MiniMapMailFrameDisabled" then 
			childList[button:GetName()] = button:GetName()
		end
	end

	if MinimapButtonFrame:GetNumChildren() ~= numButtons then
		updateCustomChildren();
		numButtons = MinimapButtonFrame:GetNumChildren()
	end
	
	if not scanned then
		MBFC_CheckSkin();
		textureFrame(MinimapButtonFrame);

		scanned = true
	end
end

-- Config Functions

function MBFC_Toggle ()
	if InterfaceOptionsFrame:IsVisible() then
		InterfaceOptionsFrame:Hide();
	else
		InterfaceOptionsFrame_OpenToCategory("MinimapButtonFrame");
	end
end

function MBFC_Visible(source, parentName) 
local activate = false;
	
	if (source == 1) then -- From MBF Minimap Button
		if (MBF.db.profile.grabMBFButton == false) then
			activate = true;
		end
	elseif (source == 2) then -- From FuBar or Titan Plugin
		if (parentName ~= "MinimapButtonFrame") then
			activate = true;
		end
	elseif (source == 3) then -- Command Line Show
		if (MBF.db.profile.mbfHidden == true) then
			activate = true;
		end	
	elseif (source == 4) then -- Command Line Hide
		if (MBF.db.profile.mbfHidden == false) then
			activate = true;
		end
	end

	if (activate) then 
		if MinimapButtonFrame:IsVisible() then
			MinimapButtonFrame:Hide();
			MBFRestoreButtonFrame:Hide();
			MBF.db.profile.mbfHidden = true;
		else
			MinimapButtonFrame:Show();
			if not MBF.db.profile.locked then
				MBFRestoreButtonFrame:Show();
				MinimapButtonFrameDragButton:Show();
			end
			MBFRestoreButton:Hide();
			MBF.db.profile.mbfHidden = false;
		end
	end
end

function setFrameDefaults()
	-- Set the MBF Frame, dragButton, and restore button to their default visiblility
		MinimapButtonFrame:Show();
		MinimapButtonFrameDragButton:Show();
		MBFRestoreButtonFrame:Show();
		MBFRestoreButton:Hide();		
end

function MBFC_KeepBlizzHidden()
	if MBF.db.profile.MBFHideMiniMapTracking == true then
		MiniMapTracking:Hide();
	end
	if MBF.db.profile.MBFHideMiniMapVoiceChatFrame == true then
		MiniMapVoiceChatFrame:Hide();
	end
	if MBF.db.profile.MBFHideMiniMapWorldMapButton == true then
		MiniMapWorldMapButton:Hide();
	end
	if MBF.db.profile.MBFHideMinimapZoomIn  == true then
		MinimapZoomIn:Hide();
		MinimapZoomOut:Hide();
	end
	if MBF.db.profile.MBFHideMiniMapMailFrame == true then
		MiniMapMailFrame:Hide();
		MiniMapMailFrameDisabled:Hide();	
	end
	if MBF.db.profile.MBFHideGameTimeFrame == true then
		GameTimeFrame:Hide();
	end
end

function MBFC_LoadStandardSkins()
	MBFAddSkin("Blizzard", "Interface\\AddOns\\MinimapButtonFrame\\Textures\\BlizzBorder.tga", nil, 55);
	MBFAddSkin("Blizzard Square", "Interface\\AddOns\\MinimapButtonFrame\\Textures\\BlizzSquare.tga", "Interface\\Buttons\\UI-EmptySlot", 45);
end

function MBFC_CheckSkin()
	local tLoaded = false;
	for i, id in pairs(tList) do
		if MBF.db.profile.currentTexture == id then
			tLoaded = true;
			break;
		end
	end
	if tLoaded == false then
		MBF.db.profile.currentTexture = "Blizzard";
	end
end

function MBFC_ColorLocked() 
	local red = MBF.db.profile.MBFBackdropColor.Red;
	local green = MBF.db.profile.MBFBackdropColor.Green;
	local blue = MBF.db.profile.MBFBackdropColor.Blue;
	local opacity = MBF.db.profile.MBFBackdropColor.Alpha;	

	MBFRestoreButtonFrame:SetBackdropColor(red, green, blue, opacity);

	if ((MBF.db.profile.locked) and (MBF.db.profile.colorLocked == "All")) then
		MinimapButtonFrame:SetBackdropColor(0,0,0,0);
		MinimapButtonFrame:SetBackdropBorderColor(0,0,0,0);
	elseif ((MBF.db.profile.locked) and (MBF.db.profile.colorLocked == "Border")) then
		MinimapButtonFrame:SetBackdropColor(red, green, blue, opacity);
		MinimapButtonFrame:SetBackdropBorderColor(0,0,0,0);
	elseif ((MBF.db.profile.locked) and (MBF.db.profile.colorLocked == "Background")) then
		MinimapButtonFrame:SetBackdropColor(0,0,0,0);
		MinimapButtonFrame:SetBackdropBorderColor(1,1,1,1);
	else
		MinimapButtonFrame:SetBackdropColor(red, green, blue, opacity);
		MinimapButtonFrame:SetBackdropBorderColor(1,1,1,1);
	end
end

function MBFC_RollUp(setting)
	if (setting == 1) then
		MBFRestoreButton:ClearAllPoints();
		MBFRestoreButton:SetPoint(MinimapButtonFrameDragButton:GetPoint());
		MBFRestoreButton:Show();
		MBFRestoreButton:SetFrameLevel(MinimapButtonFrameDragButton:GetFrameLevel());
		MBFRestoreButton:SetFrameStrata(MinimapButtonFrameDragButton:GetFrameStrata());
		MBF.db.profile.rollUp = true;
		MBF.db.profile.mbfHidden = true;
		MinimapButtonFrame:Hide();
	elseif (setting == 2) then
		MinimapButtonFrameDragButton:ClearAllPoints();
		MinimapButtonFrameDragButton:SetPoint(MBFRestoreButton:GetPoint());
		MBFRestoreButton:Hide();
		MBF.db.profile.rollUp = false;
		MBF.db.profile.mbfHidden = false;
		MinimapButtonFrame:Show();
	end
end

function MBF:SetTitleSize(mbfWidth, mbfHeight)
	if mbfWidth <= mbfHeight then
		MinimapButtonFrameDragButton:SetWidth(mbfWidth);
		MinimapButtonFrameDragButton:SetHeight(28);
		MBFRestoreButtonFrame:SetWidth(mbfWidth);
		MBFRestoreButtonFrame:SetHeight(28);
		MBFRestoreButton:SetWidth(mbfWidth);
		MBFRestoreButton:SetHeight(28);
	else
		MinimapButtonFrameDragButton:SetWidth(28);
		MinimapButtonFrameDragButton:SetHeight(mbfHeight);
		MBFRestoreButtonFrame:SetWidth(28);
		MBFRestoreButtonFrame:SetHeight(mbfHeight);
		MBFRestoreButton:SetWidth(28);
		MBFRestoreButton:SetHeight(mbfHeight);
	end
end

function MBF:SwapTitleLocation()
	local mbfWidth = MinimapButtonFrame:GetWidth();
	local mbfHeight = MinimapButtonFrame:GetHeight();

	MinimapButtonFrameDragButton:ClearAllPoints();
	MBFRestoreButtonFrame:ClearAllPoints();

	self:SetTitleSize(mbfWidth, mbfHeight);

	if (mbfWidth <= mbfHeight) and (mbfWidth < 80) then
		MBFRestoreButton:SetText("MBF")
		MinimapButtonFrameDragButton:SetText("MBF")
	elseif (mbfWidth <= mbfHeight) and (mbfWidth >= 80) then
		MBFRestoreButton:SetText("MBF " .. MBFversion)
		MinimapButtonFrameDragButton:SetText("MBF " .. MBFversion)
	else
		MBFRestoreButton:SetText("M\nB\nF")
		MinimapButtonFrameDragButton:SetText("M\nB\nF")
	end

	if (MBF.db.profile.altTitle) and (mbfWidth <= mbfHeight) then
		MinimapButtonFrameDragButton:SetPoint("BOTTOMLEFT", "MinimapButtonFrame", "BOTTOMLEFT", 0, -30)
		MBFRestoreButtonFrame:SetPoint("BOTTOMLEFT", "MinimapButtonFrame", "BOTTOMLEFT", 0, -31)
	elseif (MBF.db.profile.altTitle) and (mbfWidth > mbfHeight) then
		MinimapButtonFrameDragButton:SetPoint("TOPRIGHT", "MinimapButtonFrame", "TOPRIGHT", 30, 0)
		MBFRestoreButtonFrame:SetPoint("TOPRIGHT", "MinimapButtonFrame", "TOPRIGHT", 31, 0)
	elseif (mbfWidth <= mbfHeight) then
		MinimapButtonFrameDragButton:SetPoint("TOPLEFT", "MinimapButtonFrame", "TOPLEFT", 0, 30)
		MBFRestoreButtonFrame:SetPoint("TOPLEFT", "MinimapButtonFrame", "TOPLEFT", 0, 31)
	else
		MinimapButtonFrameDragButton:SetPoint("BOTTOMLEFT", "MinimapButtonFrame", "BOTTOMLEFT", -30, 0)
		MBFRestoreButtonFrame:SetPoint("BOTTOMLEFT", "MinimapButtonFrame", "BOTTOMLEFT", -31, 0)
	end	

	MBFRestoreButton:ClearAllPoints();
	MBFRestoreButton:SetPoint(MinimapButtonFrameDragButton:GetPoint());
	MBFRestoreButton:SetFrameLevel(MinimapButtonFrameDragButton:GetFrameLevel());
	MBFRestoreButton:SetFrameStrata(MinimapButtonFrameDragButton:GetFrameStrata());
end

function MBF:fillDropdowns()
	for i, name in pairs(self.db.profile.MinimapIcons) do
		minimapIconList[name] = name
	end
	for i, name in pairs(self.db.profile.ButtonOverride) do
		buttonOverrideList[name] = name
	end
end

function updateCustomChildren()
-- This will make sure that all the MBF Children are in the customChildren table
-- Don't remove any children from the list.  Should only run on whenever the # of buttons on MBF changes.
	local buttonName
	local button
	local result = false

	for i, button in ipairs({MinimapButtonFrame:GetChildren()}) do
		buttonName = button:GetName()
		result = false
		for i, customButtonName in ipairs(MBF.db.profile.customChildren) do
			if buttonName == customButtonName then
				result = true
			end
		end
		if result == false then
			tinsert(MBF.db.profile.customChildren, buttonName)
		end
	end
	
end

function MBF:moveButton(direction)
-- Direction  1 - up  2 - down
	local custom = {}
	local deadButtons = {}
	local previous

	updateCustomChildren()

	for i, button in pairs(MBF.db.profile.customChildren) do
		if direction == 1 then
			if getglobal(button) == nil or button == "MinimapButtonFrameDragButton" or button == "MiniMapMailFrameDisabled" then
				if previous ~= "Button is Dead" then
					deadButtons = {};
					tinsert(deadButtons,previous)
				end
				tinsert(deadButtons, button)
				previous = "Button is Dead"
			elseif i == 1 then
				previous = button
			elseif button == MBF.db.profile.currentChild then
				if previous == "Button is Dead" then
					tinsert(deadButtons, 1, button)
				else
					tinsert(custom, button)
				end
			else
				if previous == "Button is Dead" then
					for x, deadButton in pairs(deadButtons) do
						tinsert(custom, deadButton)
					end
				else
					tinsert(custom, previous)
				end
				previous = button
			end
		elseif direction == 2 then
			if button ~= MBF.db.profile.currentChild then
				tinsert(custom, button)

				if previous == MBF.db.profile.currentChild and getglobal(button) ~= nil and button ~= "MinimapButtonFrameDragButton" and button ~= "MiniMapMailFrameDisabled" then
					tinsert(custom, previous)
					previous = button
				end

			else
				previous = MBF.db.profile.currentChild
			end
		end
	end
	if (direction == 2 and previous == MBF.db.profile.currentChild) or direction == 1 then
		if previous == "Button is Dead" then
			for x, deadButton in pairs(deadButtons) do
				tinsert(custom, deadButton)
			end
		else
			tinsert(custom, previous)
		end
	end

	MBF.db.profile.customChildren = custom
	MBF:Scan()
end 

-- Tooltips

function NoMail_OnEnter()
	GameTooltip:SetOwner(MiniMapMailFrameDisabled, "ANCHOR_LEFT");
	GameTooltip:SetText(L["No New Mail"]);
	GameTooltip:Show();
end

function RollUp_OnEnter(setting)
	if (setting == 1) then
		GameTooltip:SetOwner(MinimapButtonFrameDragButton, "ANCHOR_LEFT");
	elseif (setting == 2) then
		GameTooltip:SetOwner(MBFRestoreButton, "ANCHOR_LEFT");
	end
	GameTooltipTextLeft1:SetTextColor(1, 1, 1);
	GameTooltip:AddLine(L["MBF_TOOLTIP_ROLLUP"]);
	GameTooltip:Show();
end
