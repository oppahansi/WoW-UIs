Stuffing_Config = CreateFrame("Frame")

-- stub for localization.
local L = setmetatable({}, {
	__index = function (t, v)
		t[v] = v
		return v
	end
})

local AceDialog = nil
local LSM = LibStub("LibSharedMedia-3.0")

local function UpdateLayouts()
	Stuffing:Layout()
	if Stuffing.bankFrame then
		Stuffing:Layout(true)
	end
end

local function UpdateButtons()
	Stuffing:SearchReset()
end


local function GlowDisabled()
	return StuffingDB.rarity_glow == 0
end


local function StackFontDisabled()
	return StuffingDB.custom_stackfont == 0
end


local options = {
	type = "group",
	name = "Stuffing",
	args = {
		frame1 = {
			type = "group",
			inline = true,
			order = 1,
			name = "Frame Settings",
			desc = "",
			args = {

				bag_cols = {
					type = "range",
					order = 1,
					min = 6,
					max = 25,
					step = 1,
					name = L["Bag Columns"],
					desc = L["Set the number of Columns used for the bags frame."],
					get = function ()
						return StuffingDB.cols
					end,
					set = function(i, v)
						StuffingDB.cols = v
						UpdateLayouts()
					end,
				},

				bank_cols = {
					type = "range",
					order = 1,
					min = 6,
					max = 25,
					step = 1,
					name = L["Bank Columns"],
					desc = L["Set the number of Columns used for the bank frame."],
					get = function ()
						return StuffingDB.bankCols
					end,
					set = function(i, v)
						StuffingDB.bankCols = v
						if Stuffing.bankFrame then
							Stuffing:Layout(true)
						end
					end,
				},

				pad = {
					type = "range",
					order = 1,
					min = 6,
					max = 40,
					step = 1,
					name = L["Padding"],
					desc = L["This sets the space between the background border and the adjacent buttons."],
					get = function ()
						return StuffingDB.padding
					end,
					set = function(i, v)
						StuffingDB.padding = v
						UpdateLayouts()
					end,
				},

				clamp = {
					type = "toggle",
					order = 1,
					name = L["Clamp to screen"],
					desc = L["If this is enabled, you can't move the frames out of the screen."],
					get = function ()
						return StuffingDB.clamp == 1
					end,
					set = function(self, v)
						StuffingDB.clamp = v == true and 1 or 0
						UpdateLayouts()
					end,
				},

				lock = {
					type = "toggle",
					order = 1,
					name = L["Lock Bags"],
					desc = L["Lock the bags frame position."],
					get = function ()
						return StuffingDB.locked == 1
					end,
					set = function(self, v)
						StuffingDB.locked = v == true and 1 or 0
						Stuffing:LockUnlock()
					end,
				},
			}
		},

		glowgroup = {
			type = "group",
			inline = true,
			order = 4,
			name = "Button Glow",
			desc = "",
			args = {

				glow = {
					type = "toggle",
					order = 1,
					name = L["Glow"],
					desc = L["When enabled, items will have a glow indicating the rarity of the item. When searching, the items found by the search are highlighted with a glow, too."],
					get = function ()
						return StuffingDB.rarity_glow == 1
					end,
					set = function(self, v)
						StuffingDB.rarity_glow = v == true and 1 or 0
						-- XXX
						print("This requires a UI reload!")
					end,
				},

				qitemglow = {
					type = "toggle",
					order = 2,
					name = L["Quest item glow"],
					desc = L["When enabled, quest items will have a glow, making it easier to spot them in your bag. This will also highlight items that you can turn in for repeatable quests."],
					disabled = GlowDisabled,
					get = function ()
						return StuffingDB.quest_glow == 1
					end,
					set = function(self, v)
						StuffingDB.quest_glow = v == true and 1 or 0
						UpdateButtons()
						UpdateLayouts()
					end,
				},

				searchglowcolor = {
					type = "color",
					order = 3,
					name = L["Search glow color"],
					desc = L["The color used for search highlighting."],
					hasAlpha = true,
					disabled = GlowDisabled,
					get = function ()
						return unpack(StuffingDB.search_glow)
					end,
					set = function(self, r, g, b, a)
						StuffingDB.search_glow = {r, g, b, a}
					end,
				},

				qitemglowcolor = {
					type = "color",
					order = 4,
					name = L["Quest item glow color"],
					desc = L["The color used for quest item glow."],
					hasAlpha = true,
					disabled = GlowDisabled,
					get = function ()
						return unpack(StuffingDB.quest_glow_color)
					end,
					set = function(self, r, g, b, a)
						StuffingDB.quest_glow_color = {r, g, b, a}
						UpdateButtons()
						UpdateLayouts()
					end,
				},


			}
		},

		frame2 = {
			type = "group",
			inline = true,
			order = 3,
			name = "Button Settings",
			desc = "",
			args = {

				bsize = {
					type = "range",
					order = 1,
					min = 20,
					max = 50,
					step = 1,
					name = L["Item Button Size"],
					desc = L["Set the size of the item buttons in the bank and bags frame."],
					get = function ()
						return StuffingDB.bsize
					end,
					set = function(i, v)
						StuffingDB.bsize = v
						UpdateLayouts()
					end,
				},

				space = {
					type = "range",
					order = 2,
					min = 1,
					max = 15,
					step = 1,
					name = L["Button Spacing"],
					desc = L["This sets the distance between buttons."],
					get = function ()
						return StuffingDB.spacing
					end,
					set = function(i, v)
						StuffingDB.spacing = v
						UpdateLayouts()
					end,
				},

				customskin = {
					type = "toggle",
					order = 5,
					name = L["Custom skin"],
					desc = L["When enabled, item buttons will be skinned with the file border.tga in the Stuffing directory. Requieres a UI reload to take effect."],
					get = function ()
						return StuffingDB.custom_skin == 1
					end,
					set = function(self, v)
						StuffingDB.custom_skin = v == true and 1 or 0
						print("This requires a UI reload!")
					end,
				},

				custom_sfont = {
					type = "toggle",
					order = 5,
					name = L["Custom Stack Font"],
					desc = L["When enabled, you can select your own font for stack sizes."],
					get = function ()
						return StuffingDB.custom_stackfont == 1
					end,
					set = function(self, v)
						StuffingDB.custom_stackfont = v == true and 1 or 0
						UpdateLayouts()
					end,
				},
				sfontsize = {
					type = "range",
					order = 3,
					min = 8,
					max = 32,
					step = 1,
					disabled = StackFontDisabled,
					name = L["Stack Font size"],
					desc = L["Set the font size for stack counts."],
					get = function ()
						return StuffingDB.stackfont_size
					end,
					set = function(i, v)
						StuffingDB.stackfont_size = v
						UpdateLayouts()
					end,
				},

				sfont = {
					type = "select",
					dialogControl = "LSM30_Font",
					name = L["Font"],
					desc = L["Select font for stack counts."],
					disabled = StackFontDisabled,
					values = AceGUIWidgetLSMlists.font,
					get = function()
						return StuffingDB.stackfontName or ""
					end,
					set = function(self, v)
						StuffingDB.stackfont = LSM:Fetch("font", v)
						StuffingDB.stackfontName = v
						UpdateLayouts()
					end,
				},
			}
		},

		frame3 = {
			type = "group",
			inline = true,
			order = 2,
			name = "Frame Look",	-- don't delete the space
			desc = "",
			args = {
				bgcolor = {
					type = "color",
					order = 1,
					name = L["Background color"],
					desc = L["The background color of the frames."],
					hasAlpha = true,
					get = function ()
						return unpack(StuffingDB.backdrop_color)
					end,
					set = function(self, r, g, b, a)
						StuffingDB.backdrop_color = {r, g, b, a}
						UpdateLayouts()
					end,
				},

				bordercolor = {
					type = "color",
					order = 2,
					name = L["Frame border color"],
					desc = L["The color of the frame border."],
					hasAlpha = true,
					get = function ()
						return unpack(StuffingDB.border_color)
					end,
					set = function(self, r, g, b, a)
						StuffingDB.border_color = {r, g, b, a}
						UpdateLayouts()
					end,
				},

				bordersize = {
					type = "range",
					order = 3,
					min = 1,
					max = 25,
					step = 1,
					name = L["Border Size"],
					desc = L["Set the size of the border around the bags and bank frame."],
					get = function ()
						return StuffingDB.edgeSize
					end,
					set = function(i, v)
						StuffingDB.edgeSize = v
						UpdateLayouts()
					end,
				},

				bordertex = {
					type = "select",
					dialogControl = "LSM30_Border",
					name = L["Border"],
					desc = L["Select border texture."],
					values = AceGUIWidgetLSMlists.border,
					get = function()
						return StuffingDB.edgeName or "Blizzard Tooltip"
					end,
					set = function(self, v)
						StuffingDB.edge = LSM:Fetch("border", v)
						StuffingDB.edgeName = v
						UpdateLayouts()
					end,
				},

				fontsize = {
					type = "range",
					order = 3,
					min = 8,
					max = 32,
					step = 1,
					name = L["Font size"],
					desc = L["Set the font size of the gold display and search text."],
					get = function ()
						return StuffingDB.fontSize
					end,
					set = function(i, v)
						StuffingDB.fontSize = v
						UpdateLayouts()
					end,
				},

				font = {
					type = "select",
					dialogControl = "LSM30_Font",
					name = L["Font"],
					desc = L["Select font for the search text and gold display."],
					values = AceGUIWidgetLSMlists.font,
					get = function()
						return StuffingDB.fontName or ""
					end,
					set = function(self, v)
						StuffingDB.font = LSM:Fetch("font", v)
						StuffingDB.fontName = v
						UpdateLayouts()
					end,
				},

				hidesoulbag = {
					type = "toggle",
					order = 5,
					name = L["Hide soulbag"],
					desc = L["When enabled, your soulbag won't show in the bag frame."],
					get = function ()
						return StuffingDB.hide_soulbag == 1
					end,
					set = function(self, v)
						StuffingDB.hide_soulbag = v == true and 1 or 0
						UpdateLayouts()
					end,
				},

				bag_soul = {
					type = "color",
					order = 2,
					name = L["Soulbag color"],
					desc = L["The color used for soulbags."],
					hasAlpha = true,
					get = function ()
						return unpack(StuffingDB.soulbag_color)
					end,
					set = function(self, r, g, b, a)
						StuffingDB.soulbag_color = {r, g, b, a}
						UpdateLayouts()
					end,
				},

				bag_prof = {
					type = "color",
					order = 2,
					name = L["Profession color"],
					desc = L["The color used for profession bags."],
					hasAlpha = true,
					get = function ()
						return unpack(StuffingDB.special_color)
					end,
					set = function(self, r, g, b, a)
						StuffingDB.special_color = {r, g, b, a}
						UpdateLayouts()
					end,
				},

				bag_quiv = {
					type = "color",
					order = 2,
					name = L["Quiver color"],
					desc = L["The color used for quivers and ammo pouches."],
					hasAlpha = true,
					get = function ()
						return unpack(StuffingDB.quiver_color)
					end,
					set = function(self, r, g, b, a)
						StuffingDB.quiver_color = {r, g, b, a}
						UpdateLayouts()
					end,
				},
			}
		},

	}
}

function Stuffing_Config:Init()
	local f = CreateFrame("Frame")
	f.name = "Stuffing"

	local b = CreateFrame("Button", nil, f, "OptionsButtonTemplate")
	b:SetPoint ("TOPLEFT", f, "TOPLEFT", 20, -20)
	b:SetText ("Open Config")
	b:SetScript ("OnClick", function ()
		InterfaceOptionsFrameCancel_OnClick()
		HideUIPanel(GameMenuFrame)
		Stuffing_Config:ShowConfig()
	end)

	InterfaceOptions_AddCategory(f)
end

function Stuffing_Config:ShowConfig()
	if not AceDialog then
		AceDialog = LibStub("AceConfigDialog-3.0")
		local AceConfig = LibStub("AceConfig-3.0")
		AceConfig:RegisterOptionsTable("Stuffing", options)
		AceDialog:SetDefaultSize ("Stuffing", 400, 490)
	end

	AceDialog:Open ("Stuffing")
end

