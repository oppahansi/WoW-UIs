local kgPanels = LibStub("AceAddon-3.0"):GetAddon("kgPanels")
local kgPanelsConfig = kgPanels:GetModule("kgPanelsConfig")
local L = LibStub("AceLocale-3.0"):GetLocale("kgPanels", false)
local guide = kgPanels:GetModule("GuideFrame")

--[[
	Generate menus for every layout in our database
]]
function kgPanelsConfig:InitLayouts()
	for k,v in pairs(self.db.global.layouts) do
		self:CreateLayoutMenu(k)
	end
	self.activeLayout = kgPanels.db.profile.layout
end


--[[
	Create a new layout and set it as active
]]
function kgPanelsConfig:CreateLayout(layoutName)
	layoutName = kgPanelsConfig:uniqueName(layoutName, self.layoutList, 0)
	self.db.global.layouts[layoutName] = {}
	self:CreateLayoutMenu(layoutName)
	self:ActivateLayout(layoutName)
end


--[[
	Take a serialized layout table, de-serialize it, store it as a layout, and activate it
]]


--[[
	Create a option menu for a layout, and insert it into our configuration menu table
]]
function kgPanelsConfig:CreateLayoutMenu(layoutName)
	local sanitizedName = self:makeKey(layoutName)
	local _tname = nil
	local tempLayoutMenu = {
		type = "group",
		name = layoutName,
		desc = L["Panel Layout"],
		childGroups = "tree",
		args = {
			
			header1 = {
				type = "description",
				name = L["Set as Active Layout"],
				order = 1,
			},
			activate = {
				type = "execute",
				name = L["Activate"],
				desc = L["Set this layout as your active layout."],
				func = function() kgPanelsConfig:ActivateLayout(layoutName); kgPanelsConfig:InitPanelMenus() end,
				order = 2,
			},
			space1 = {
				type = "description",
				name = " ",
				order = 3,
			},
			
			header2 = {
				type = "description",
				name = L["Copy Layout To Clipboard"],
				order = 4,
			},
			copy = {
				type = "execute",
				name = L["Export"],
				desc = L["Export this layout to the clipboard to copy and send to friends."],
				func = function()
					kgPanelsConfig:CreateExport(layoutName)
				end,
				order = 5,
			},
			space2 = {
				type = "description",
				name = " ",
				order = 6,
			},
			header3 = {
				type = "description",
				name = L["Delete Layout"],
				order = 7,
			},
			remove = {
				type = "execute",
				name = L["Delete"],
				desc = L["Delete this layout from your layout list."],
				func = function() 
					kgPanelsConfig:RemoveLayout(layoutName); self.layoutList[sanitizedName] = nil 
				end,
				order = 8,
			},
			space3 = {
				type = "description",
				name = " ",
				order = 9,
			},
			header4 = {
				name = L["Rename Layout"],
				desc = L["Enter the new name of the layout"],
				type = "input",
				get = function() return _tname end,
				set = function(info, val) _tname = val end,
				order = 10
			},
			rename = {
				type = "execute",
				name = L["Rename"],
				desc = L["Change the name of this layout"],
				disabled = function() return _tname == nil or _tname == L["None"] end,
				confirm = function() return _tname and strlen(_tname) > 1 and self.layoutList[self:makeKey(_tname)]	end,
				confirmText = L["A layout with that name already exists. Overwrite?"],
				func = function()
				    -- are we about to nuke an active layout
					local isActive = self.activeLayout == self:makeKey(_tname)
					local wasActive = self.activeLayout == sanitizedName
					local data = self.layoutList[sanitizedName]
					local dbData = self.db.global.layouts[layoutName]
					self.db.global.layouts[layoutName] = nil
					self.layoutList[sanitizedName] = nil
					-- do teh rename
					sanitizedName = self:makeKey(_tname)
					data.name = _tname
					self.db.global.layouts[_tname] = dbData
					self.layoutList[sanitizedName] = data
					if isActive or wasActive then
						self:ActivateLayout(_tname)
					end
					_tname = nil
				end,
				order = 11,
			},
		},
	}
	if layoutName == L["None"] then
		tempLayoutMenu.args.rename = nil
	end
	self.layoutList[sanitizedName] = tempLayoutMenu
end


--[[
	Activate a layout
]]
function kgPanelsConfig:ActivateLayout(layoutName)
	for k,v in pairs(self.panelList) do
		if k ~= "panelCreation" then
			self.panelList[k] = nil
		end
	end
	if self.lockFrames then
		for k,v in pairs(self.lockFrames) do
			guide:DeleteGuide(self.lockFrames[k])
			self.lockFrames[k] = nil
		end
	end
	kgPanels:ActivateLayout(layoutName or L["None"])
	kgPanels.db.profile.layout = layoutName or L["None"]
	self.activeLayout = layoutName or L["None"]
	self:InitPanelMenus()
end

--[[
	Remove a layout from the database
]]
function kgPanelsConfig:RemoveLayout(layoutName)
	self.db.global.layouts[layoutName] = nil
	local wasActive = self.activeLayout == layoutName
	if wasActive then
		self:ActivateLayout(L["None"])
	end
end


--[[
	Remove a layout menu from the database
]]
function kgPanelsConfig:RemoveLayoutMenu(layout)
	self.layoutList[layoutName] = nil
end
