--[[
	NOTE: 
	- I removed the temp var locals.  The menus (even in this file) now access the vars using kgPanelsConfig.name.  While this adds an extra table lookup, it's going to be much easier to understand than switching between local vars in this file and addon-scoped vars in the helper files
	- Why is the art asset database split up into "artwork" and "borders".  It would probably make more sense if it was "background" and "borders" for consistancy
	- When creating a new art asset, it now gives an error message if you try to make an asset with a name that currently exists.  Might be better to just use the uniqueName() function.  They can rename the asset later if they need to

	
	TODO:
	-- Probably want to improve upon our menu callback functions
	-- Implement config panel options
	-- Have config save to db
]]

local kgPanels = LibStub("AceAddon-3.0"):GetAddon("kgPanels")
local kgPanelsConfig = kgPanels:NewModule("kgPanelsConfig")
local L = LibStub("AceLocale-3.0"):GetLocale("kgPanels", false)
local cfgreg = LibStub("AceConfigRegistry-3.0")
local serializer = LibStub("AceSerializer-3.0")

local _assetName,_assetPath,_assetType = nil,nil,"artwork"
local _panelName = nil
local _layoutName = nil
local activeLayout = nil
local _importData = nil
local _importName = nil
local frameup = false
local gui = nil 

kgPanelsConfig.activeLayout = L["None"]
local defaultPanelOptions = {
	parent = "UIParent",
	x = 0,
	y = 0,
	width = 200,
	height = 100,
	level = 0,
	strata = "BACKGROUND",
	mouse = false,
	rotation = 0,
	hflip=false,
	vflip=false,
	anchor = "UIParent",
	anchorFrom = "CENTER",
	anchorTo = "CENTER",
	border_color = {r=1,g=1,b=1,a=1},
	border_texture = "Blizzard Tooltip",
	border_edgeSize = 16,
	bg_blend = "BLEND",
	bg_style = "SOLID",
	bg_texture = "None",
	bg_alpha = 1,
	bg_color = {r=.3,g=.3,b=.3,a=0.6},
	bg_insets = {t=4,b=-4,l=-4,r=4},
	bg_orientation = "HORIZONTAL",
	gradient_color = {r=1,g=1,b=1,a=1},
	text = {text="", color={r=1,g=1,b=1,a=1}, x=0,y=0,size = 0, justifyV="MIDDLE", justifyH="CENTER", font=L["Blizzard"]},
	scripts = {},
	tileSize = 0,
	tiling = false,
}
local function DeepCopy(t, lookup_table)
	local copy = {}
	if type(t) ~= "table" then return t end
	for i,v in pairs(t) do
		if type(v) ~= "table" then
			copy[i] = v
		else
			lookup_table = lookup_table or {}
			lookup_table[t] = copy
			if lookup_table[v] then
				copy[i] = lookup_table[v] -- we already copied this table. reuse the copy.
			else
				copy[i] = DeepCopy(v,lookup_table) -- not yet copied. copy it.
			end
		end
	end
	return copy
end

-- OPTION CHOICES
local artworkTypes = {
	["artwork"] = "Background",
	["border"] = "Border",
}
-- OPTION TABLE VAR
function kgPanelsConfig:makeOptions()
return {
	type = "group",
	icon = "Interface\\Addons\\kgPanels\\icon.tga",--isn't used atm, but might as well set it
	name = "kgPanels",
	childGroups = "tree",
	args = {
		general = {
			type = "group",
			name = L["General Options"],
			desc = L["This is the general option menu. Core seetings are located in this main area."],
			childGroups = "tree",
			order = 1,
			args = {
				addonConfig = {
					type = "group",
					name = L["Addon Settings"],
					guiInline = true,
					order = 0,
					args = {	
						-- We'll want to enable / disable kgPanels, kgPanelsConfig, and minimapIcon (if it's turned on)
						enable = {
							type = "toggle",
							name = L["Enable Addon"],
							desc = L["This option allows you to turn kgPanels on/off"],
							get = function() return kgPanels.db.profile.enabled end,
							set = function(info,k)
								kgPanels.db.profile.enabled = k
								if k then
									kgPanels:OnEnable()
								else
									kgPanels:OnDisable()
								end
							end,
							order = 1,
						},
						help = {
							type = "description",
							name = L["For help using kgPanels, please see the FAQ section."],
							order = 3,
						},
						space = {
							type = "description",
							name = function() return L["Active Layout: "]..kgPanelsConfig.activeLayout end,	
							order = 2,
						},
						-- code here for profile groups once it comes up in aceDB
					},
				},
				layouts = {
					type = "group",
					name = L["Layouts"],
					desc = L["Layout tab"],
					childGroups = "tree",
					order = 3,
					args = {
						newLayout = {
							type = "group",
							name = L["Add New Layout"],
							guiInline = true,
							order = 0,
							args = {
								-- NOTE: If no name is set, or if it collides with an existing name, we'll want to give it a default one
								layoutName = {
									type = "input",
									name = L["Layout Name"],
									desc = L["This is the name of the layout, as it will appear in drops downs, and the under the Layout tab."],
									get = function() return _layoutName end,
									set = function(info, val) _layoutName = val end,
									order = 0,
								},
								createLayout = {
									type = "execute",
									name = L["Create"],
									desc = L["Create a new layout. NOTE: This will change your current layout to the newly created layout."],
									func = function() 
										kgPanelsConfig:RemoveLayout(_layoutName)
										kgPanelsConfig:CreateLayout(_layoutName)
										_layoutName = nil 
									end,
									disabled = function() 
										return not _layoutName or strlen(_layoutName) < 2 
									end, 
									order = 1,
									confirm = function()
										if kgPanels.db.global.layouts[_layoutName] then
											return true
										end
										return false
									end,
									confirmText = L["A layout with that name already exists. Overwrite?"],
								},	
							},
						},
						importLayout = {
							type = "group",
							name = L["Import New Layout"],
							guiInline = true,
							order = 2,
							args = {
								import_name = {
									type = "input",
									name = L["Import As.."],
									desc = L["Name to import this layout under."],
									get = function() return _importName end,
									set = function(info,k) _importName = k end,
									order = 1,
									width = "full",
								},
								space = {
									type = "description",
									name = " ",
									order = 2,
								},
								importLayout = {
									type = "input",
									multiline = 10,
									width = "full",
									name = L["Import Layout"],
									desc = L["This will import a layout into your configuration."],
									order = 30,
									set = function(info, v)
										_importData = v
									end,
									get = function()
										return _importData
									end,
								},
								createLayout = {
									type = "execute",
									name = L["Import"],
									desc = L["Perform the import."],
									order = 50,
									disabled = function() return _importData == nil or strlen(_importData) < 2 or _importName == nil or strlen(_importName) < 2 end,
									func = function() kgPanelsConfig:ImportLayout(_importName,_importData) end,
									confirm = function()
										return kgPanels.db.global.layouts[_importName] ~= nil
									end,
									confirmText = L["A layout with that name already exists. Overwrite?"],
								},
								import_eepanels = {
									type = "execute",
									name = L["Import from eePanels2"],
									desc = L["Import panels from eePanels2"],
									order = 60,
									disabled = function() return _importName == nil or strlen(_importName) < 2 or not eePanels2 end,
									confirm = function()
										return kgPanels.db.global.layouts[_importName] ~= nil
									end,
									confirmText = L["A layout with that name already exists. Overwrite?"],
									func = function() kgPanelsConfig:ImportEELayout(_importName) end,
								}
							},
						},
					},
				},
			},
		},
		art = {
			type = "group",
			name = L["Art Library"],
			childGroups = "tree",
			order = 2,
			args = {
				backgrounds = {
					type = "group",
					name = L["Backgrounds"],
					args = {},	
				},
				borders = {
					type = "group",
					name = L["Borders"],
					args = {},
				},
				createAsset = {
					type = "group",
					name = L["Add New Artwork"],
					guiInline = true,
					order = 0,
					args = {
						assetName = {
							type = "input",
							name = L["Artwork Name"],
							desc = L["This is the name as it will appear in drops down menus and the side tab."],
							set = function(info,val) _assetName = val end,
							get = function() return _assetName end, 
							order = 0,
						},
						assetType = {
							type = "select",
							name = L["Artwork Type"],
							desc = L["Indicate what type of artwork you are adding."],
							values = artworkTypes,
							set = function(info,v) _assetType = v end,
							get = function() return _assetType end,
							order = 1,
						},
						assetPath = {
							type = "input",
							name = L["Artwork Path"],
							desc = L["This is the path to the texture you wish to add. NOTE: this path must be realtive to the WoW folder and seperated by '\\\\'"],
							width = "full",
							set = function(info,val) _assetPath = val end,
							get = function() return _assetPath end,
							order = 2,
						},
						create = {
							type = 'execute',
							name = L["Add"],
							desc = L["Create a new entry in the Artwork Library"],
							order = 20,
							func = function() kgPanelsConfig:CreateArt(_assetType,_assetName,_assetPath); _assetName = nil;_assetType = "artwork";_assetPath = nil end,
							disabled = function() 
								return 
									_assetPath == nil
									or _assetName == nil
									or _assetPath == nil
									or strlen(_assetPath) < 1 
									or strlen(_assetName) < 1 
								end,
							confirm = function()
								if kgPanelsConfig.db.global[_assetType][_assetName] then
									return true
								end
								return false
							end,
							confirmText = L["Artwork already exists. Overwrite?"],
						},
					},
				},
			},
		},		
		-- Aside from the filter table, this is basically the same options as an individual panel
		-- Hide group if no panels exist in current layout
		defaultPanel = {
			type = "group",
			name = L["Default Panel Options"],
			childGroups = "tree",
			order = 3,
			args = {},
		},
		-- Hide group if no panels exist in current layout
		panelList = {
			type = "group",
			name = L["Active Panels"],
			childGroups = "tree",
			order = 4,
			args = {	
				panelCreation = {
					type = "group",
					name = L["Panel Creation"],
					guiInline = true,
					order = 0,
					args = {
						addPanelName = {
							type = "input",
							name = L["Panel Name"],
							desc = L["Name of this new panel"],
							get = function() return _panelName end,
							set = function(info, val) _panelName = val end,
							order = 1,
							width = "full",
						},
						cleanPanel = {
							type = "execute",
							name = L["Create"],
							desc = L["Create a new panel with generic defaults"],
							func = function() kgPanelsConfig:CreatePanel(_panelName, defaultPanelOptions); _panelName = nil end,
							disabled = function() return _panelName == nil or strlen(_panelName) < 1 or kgPanelsConfig.activeLayout == L["None"] end,
							confirm = function()
								if kgPanels.db.global.layouts[kgPanelsConfig.activeLayout][_panelName] then
									return true
								end
								return false
							end,
							order = 2,
							confirmText = L["Panel already exists. Overwrite?"],
						},
						space = {
							type = "description",
							name = function() return L["Active Layout: "]..kgPanelsConfig.activeLayout end,
							
							order = 2,
						},
						addPanel = {
							type = "execute",
							name = L["Create Using Defaults"],
							desc = L["Create a new panel using your specific defaults."],
							func = function() kgPanelsConfig:CreatePanel(_panelName); _panelName = nil end,
							disabled = function() return _panelName == nil or strlen(_panelName) < 1 or kgPanelsConfig.activeLayout == "None" end,
							confirm = function()
								if kgPanels.db.global.layouts[kgPanelsConfig.activeLayout][_panelName] then
									return true
								end
								return false
							end,
							order = 4,
							confirmText = L["Panel already exists. Overwrite?"],
						},
						notice = {
							type = "description",
							name = L["To create a panel you are required to have a layout active."],
							order = 5,
						}
					},
				},
			},
		},
		faq = {
			type = "group",
			name = L["FAQ"],
			childGroups = "tree",
			order = 5,
			args = {
				topic1 = {
					type = "group",
					name = L["1. kgPanels"],
					childGroups = "tree",
					order = 1,
					args = {
						item1 = {
							type = "description",
							name = L["FAQ_1_1"],
							order = 1,
						},
						item2 = {
							type = "description",
							name = L["FAQ_1_2"],
							order = 2,
						},
						item3 = {
							type = "description",
							name = L["FAQ_1_3"],
							order = 2,
						},
						item4 = {
							type = "description",
							name = L["FAQ_1_4"],
							order = 3,
						},
					}
				},
				topic2 = {
					type = "group",
					name = L["2. Artwork"],
					order = 2,
					childGroups = "tree",
					args = {
						item1 = {
							type = "description",
							name = L["FAQ_2_1"],
							order = 1,
						},						
						item2 = {
							type = "description",
							name = L["FAQ_2_2"],
							order = 2,
						},
						item3 = {
							type = "description",
							name = L["FAQ_2_3"],
							order = 3,
						},
						item4 = {
							type = "description",
							name = L["FAQ_2_4"],
							order = 4,
						},
					}
				},
				topic3 = {
					type = "group",
					name = L["3. Textures"],
					order = 3,
					childGroups = "tree",
					args = {
						item1 = {
							type = "description",
							name = L["FAQ_3_1"],
							order = 1,
						},
						item2 = {
							type = "description",
							name = L["FAQ_3_2"],
							order = 2,
						},
						item3 = {
							type = "description",
							name = L["FAQ_3_3"],
							order = 3,
						},
						item4 = {
							type = "description",
							name = L["FAQ_3_4"],
							order = 4,
						},
						item5 = {
							type = "description",
							name = L["FAQ_3_5"],
							order = 5,							
						}
					}
				},
				topic4 = {
					type = "group",
					name = L["4. Text"],
					order = 4,
					childGroups = "tree",
					args = {
						item1 = {
							type = "description",
							name = L["FAQ_4_1"],
							order = 1,
						},
					}
				},
				topic5 = {
					type = "group",
					name = L["5. Scripting"],
					order = 5,
					childGroups = "tree",
					args = {
						item1 = {
							type = "description",
							name = L["FAQ_5_1"],
							order = 1,
						},
						item2 = {
							type = "description",
							name = L["FAQ_5_2"],
							order = 2,
						},
						item3 = {
							type = "description",
							name = L["FAQ_5_3"],
							order = 3,
						},
						item4 = {
							type = "description",
							name = L["FAQ_5_4"],
							order = 4,
						},
						item5 = {
							type = "description",
							name = L["FAQ_5_5"],
							order = 5,
						},
						item6 = {
							type = "description",
							name = L["FAQ_5_6"],
							order = 6,
						},
					}
				},
				topic6 = {
					type = "group",
					name = L["6. Import and Export"],
					order = 6,
					childGroups = "tree",
					args = {
						item1 = {
							type = "description",
							name = L["FAQ_6_1"],
							order = 1,
						},
						item2 = {
							type = "description",
							name = L["FAQ_6_2"],
							order = 2,
						},
						item3 = {
							type = "description",
							name = L["FAQ_6_3"],
							order = 3,
						},						
					}
				}
			}
		}
	}
}
end



--[[
	Config addon has been loaded
]]
local _G = getfenv(0)
local optionTable = nil
function kgPanelsConfig:OnInitialize()
	self.db = kgPanels.db -- you now have a ref to the kgPanels DB
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
	-- Register our option table
	optionTable = self:makeOptions()
	optionTable.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(kgPanels.db)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("kgPanelsConfig", optionTable) 
	-- LAYOUT MENU SHORTCUTS
	-- Holds layout menus.  Do not flush
	self.layoutList = optionTable.args.general.args.layouts.args
	-- Holds menus for art assets.  Do not flush
	self.artLibrary = optionTable.args.art.args
	-- Holds global panel options - basically the same as a normal panel menu.  Do not flush
	self.defaultOptions = optionTable.args.defaultPanel
	-- Holds list of panels. Do not flush
	self.panelList = optionTable.args.panelList.args
	_G["BINDING_NAME_KGPANELFF"] = L["Frame Finder"]
	_G["BINDING_HEADER_KGPANEL"] = L["kgPanel"]
end
function kgPanelsConfig:OnProfileChanged()
	local layoutName = kgPanels.db.profile.layout
	kgPanelsConfig:ActivateLayout(layoutName)
	kgPanelsConfig:InitPanelMenus()
end

--[[
	Config addon has been enabled
]]
function kgPanelsConfig:OnEnable()
	-- Setup art library menus
	kgPanelsConfig:InitArt()
	-- Setup layout menus
	kgPanelsConfig:InitLayouts()
	-- Setup global layout menus
	kgPanelsConfig:InitDefaultMenu()
	-- Setup individual panel menus
	kgPanelsConfig:InitPanelMenus()
end


--[[
	Makes sure a key is unique in a table and sanitized
]]
function kgPanelsConfig:uniqueName(name, tbl, val)
	name = strtrim(name)
	local checkName = name
	if val > 0 then checkName = name..val end
	-- Name collided, get a new one
	if tbl[checkName] ~= nil then
		return uniqueName(name, tbl, val+1)
	end
	-- Name is unique, send it back
	if val > 0 then
		return name..val
	else
		return name
	end
end

function kgPanelsConfig:UpdatePanel(name,w,h,x,y)
	local layoutdata = kgPanels.db.global.layouts[self.activeLayout]
	layoutdata[name].x = x
	layoutdata[name].y = y
	layoutdata[name].width  = w
	layoutdata[name].height = h
	cfgreg:NotifyChange("kgPanelsConfig")
end

--[[
	Convert any spaces to underscores. 
--]]
function kgPanelsConfig:makeKey(key)
	return string.gsub(key, '(%s+)', function(x) return '_' end)
end
--[[
	create an export frame
]]
function kgPanelsConfig:CreateExport(layoutName)
	gui = gui or LibStub("AceGUI-3.0")
	local message = serializer:Serialize(kgPanels.db.global.layouts[layoutName])
	local f = gui:Create("Frame")
	f:ReleaseChildren()
	f:SetCallback("OnClose", function(widget, event) gui:Release(widget)end)
	f:SetTitle(L["kgPanels Layout Export"])
	f:SetLayout("fill")
	--f = scroll
	local control = gui:Create("MultiLineEditBox")
	control:SetHeight(300)
	control:SetText(message)
	control.width = "fill"
	f:AddChild(control)
	f:PerformLayout()
	f:SetWidth(600)
	f:SetHeight(300)
	f:Show()
	control.button:Hide()
	f.line1:Hide()
	f.line2:Hide()
	if not IsMacClient() then
		-- Windows or Linux
		f.statustext:SetText(L["Press Ctrl-A to select the text, then Ctrl-C to copy."])
	else
		f.statustext:SetText(L["Press Cmd-A to select the text, then Cmd-C to copy."])
	end	
	f.frame:SetFrameStrata("TOOLTIP")
end
function kgPanelsConfig:ImportLayout(name, data)
	local worked,tbl = serializer:Deserialize(data)
	if worked then
		kgPanels.db.global.layouts[name] = tbl
		self:CreateLayoutMenu(name)
		self.activeLayout = kgPanels.db.profile.layout
		self:ActivateLayout(name)
	else
		kgPanels:Print(tbl)
	end
end

function kgPanelsConfig:ImportEELayout(layout_name)
	kgPanels.db.global.layouts[layout_name] = {}
	local dbref = kgPanels.db.global.layouts[layout_name]
	local eep = {}
	for i,v in ipairs(eePanels2.db.profile.panels) do
		local name = v.name or "untitled"..i
		eep["eePanel"..i] = name
		dbref[name] = DeepCopy(defaultPanelOptions)
		dbref[name]["strata"] = v.strata
		dbref[name]["anchorTo"] = v.anchorTo
		dbref[name]["parent"] = eep[v.parent] or v.parent
		dbref[name]["border_color"] = v.border.color
		dbref[name]["anchor"] = eep[v.anchor] or v.anchor
		dbref[name]["bg_orientation"] = v.background.gradient.orientation
		dbref[name]["gradient_color"] = v.background.gradient.color
		dbref[name]["bg_blend"] = v.background.blend
		dbref[name]["bg_insets"] = v.background.insetSize
		dbref[name]["bg_color"] = v.background.color
		dbref[name]["border_edgeSize"] = v.border.edgeSize
		dbref[name]["anchorFrom"] = v.anchorFrom
		dbref[name]["mouse"] = v.mouse
		dbref[name]["level"] = v.level
		dbref[name]["width"] = v.width
		dbref[name]["height"] = v.height
		dbref[name]["x"] = v.x
		dbref[name]["y"] = v.y
		dbref[name]["scale"] = v.scale
		dbref[name]["bg_alpha"] = v.background.texture.alpha
		dbref[name]["bg_style"] = strupper(v.background.style)
		dbref[name]["vflip"] = false
		dbref[name]["hflip"] = false
		dbref[name]["rotation"] = 0
		dbref[name]["text"]["size"] = v.text.size or 12
		dbref[name]["text"]["text"] = v.text.text
		dbref[name]["tiling"] = v.background.tiling
		dbref[name]["tileSize"] = v.background.tileSize
		if v.border.texture and v.border.media and kgPanels:FetchArt(v.border.media,"border") then
			dbref[name]["border_texture"] = v.border.media
		elseif v.border.texture and (v.border.texture ~= "Interface\\None" or strlen(v.border.texture) < 1) then
			dbref[name]["border_texture"]=name.." border"
			kgPanels.db.global.border[name.." border"] = v.border.texture
			kgPanelsConfig:InjectArt("border",name.." border")
		end
		if v.background.texture.texture and v.background.texture.media and kgPanels:FetchArt(v.background.texture.media,"background") then
			dbref[name]["bg_texture"] = v.background.texture.media
			dbref[name].bg_blend = "BLEND"
			dbref[name].bg_style = "NONE"
		elseif v.background.texture.texture and (v.background.texture.texture ~= "Interface\\None" or strlen(v.background.texture.texture) < 1) then
			dbref[name]["bg_texture"] = name.." background"
			dbref[name].bg_blend = "BLEND"
			dbref[name].bg_style = "NONE"
			kgPanels.db.global.artwork[name.." background"] = v.background.texture.texture
			kgPanelsConfig:InjectArt("artwork",name.." background")
		end
	end
	self:CreateLayoutMenu(layout_name)
	self:ActivateLayout(layout_name)
	eePanels2:OnDisable()
	kgPanels:Print(L["Import complete, eePanels is now OFF, remember to disable or rmove eePanels2"])
end


function kgPanelsConfig:ShowFrames()
	gui = gui or LibStub("AceGUI-3.0")
	local finder = gui:Create("Frame")
	finder:ReleaseChildren()
	finder:SetCallback("OnClose", function(widget, event) gui:Release(widget)end)
	finder:SetTitle(L["Frame Finder"])
	finder:SetLayout("fill")
	local msg = "|cffffffff"..L["Frames"].."|r\n"
	local frame = EnumerateFrames()
	while frame do
	    if frame:IsVisible() and MouseIsOver(frame) then
			if frame.GetName and frame:GetName() then
				msg = msg..frame:GetName().."\n"
			else
				msg = msg..L["Unknown"].."\n"
			end
	    end
	    frame = EnumerateFrames(frame)
	end
	local control = gui:Create("Label")
	control:SetHeight(300)
	control:SetText(msg)
	control.width = "fill"
	finder:AddChild(control)
	finder:PerformLayout()
	finder:SetWidth(600)
	finder:SetHeight(300)
	finder:Show()
	frameup = true
	finder.line1:Hide()
	finder.line2:Hide()
	finder.frame:SetFrameStrata("TOOLTIP")
end