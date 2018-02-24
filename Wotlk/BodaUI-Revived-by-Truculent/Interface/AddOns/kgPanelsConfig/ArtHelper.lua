local kgPanels = LibStub("AceAddon-3.0"):GetAddon("kgPanels")
local kgPanelsConfig = kgPanels:GetModule("kgPanelsConfig")
local L = LibStub("AceLocale-3.0"):GetLocale("kgPanels", false)
local cfgreg = LibStub("AceConfigRegistry-3.0")
--[[-----------------------------------------------------------------
	Loop through all our art assets and generate menus for each one
]]-------------------------------------------------------------------
function kgPanelsConfig:InitArt()
	local special = false
	for k,v in pairs(self.db.global.artwork) do
		if k == L["None"] then special = true else special = false end
		self:CreateArtMenu("artwork",k,v,special)
	end
	special = false
	for k,v in pairs(self.db.global.border) do
		if k == L["None"] or k == L["Blizzard Tooltip"] or k == L["Blizzard Dialog"] then special = true else special = false end
		self:CreateArtMenu("border",k,v,special)
	end	
end

--[[-----------------------------------------------------------
	Create a new art asset, and generate a panel for it
	params:
		assetType: border|artwork
		assetName: What to call thsi artwork
		assetPath: filesystem path to the artwork
]]-------------------------------------------------------------
function kgPanelsConfig:CreateArt(assetType, assetName, assetPath)
	self.db.global[assetType][assetName] = assetPath
	kgPanelsConfig:CreateArtMenu(assetType, assetName, assetPath, false)
	kgPanelsConfig:InjectArt(assetType,assetName)
end
--[[-----------------------------------------------------------------------------------------
	Create a option menu for an art asset, and insert it into our configuration menu table
	params:
		assetType: border|artwork
		assetName: user supplied name of this asset
		assetPath: path ont he filesystem for this art
		special: is this a special peice of art needed by kgPanels i.e. None and Tooltip
]]-------------------------------------------------------------------------------------------
function kgPanelsConfig:CreateArtMenu(assetType, assetName, assetPath, special)
	local sanitizedName = self:makeKey(assetName)	
	-- See if we should create a button to remove the asset from our database
	local width = 200
	local height = 100
	if assetType == "border" then
		width = 75
		height = 30
	end
	
	local tempDelTbl = nil
	if not special then
		tempDelTbl =
		{
			type = "group",
			name = "",
			inline = true,
			args = {
				path = {
					type = "input",
					name = L["Artwork Path"],
					get = function() return self.db.global[assetType][assetName] end,
					set = function(info,k) 
						self.db.global[assetType][assetName] = k
						self:ActivateLayout(self.activeLayout)
						if assetType == "artwork" then
							self.artLibrary.backgrounds.args[sanitizedName].args.preview = {
								type = "description",
								name = "",
								image = self.db.global[assetType][assetName], 
								imageWidth = width,
								imageHeight = height,
								order = 5,
							}
						else
							self.artLibrary.borders.args[sanitizedName].args.preview = {
								type = "description",
								name = "",
								image = self.db.global[assetType][assetName], 
								imageWidth = width,
								imageHeight = height,
								order = 5,
							}
						end
						cfgreg:NotifyChange("kgPanelsConfig")
				 	end,
					order = 3,
					width = "full",
				},
				space2 = {
					type = "description",
					name = " ",
					order = 4,
				},
				del = {
					type = "execute", 
					name = L["Delete"], 
					desc = L["Delete from Library"], 
					confirm = true, 
					confirmText = L["Are you sure?"], 
					func = function()
						-- Remove the asset from the database and our ace option menu
						if assetType == "artwork" then
							kgPanels.db.global.artwork[assetName] = nil 
							self.artLibrary.backgrounds.args[sanitizedName] = nil
						else
							kgPanels.db.global.border[assetName] = nil 
							self.artLibrary.borders.args[sanitizedName] = nil
						end
						kgPanelsConfig:DeleteArt(assetType,assetName)
					end,
					order = 100,
				},
			 -- 	rename = {
			--		-- rename the artwork
			--	}
		  	}
		}
	end
	-- Create the asset menu table (give a preview)
	local tempAssetMenu =
	{ 
		type = "group", 
		name = assetName, 
		desc = "Art Asset",
		args = 
		{
			desc = {
				type = "description",
				name = L["ART_PREVIEW"],
				order = 1,
			},
			preview = 
			{
				type = "description",
				name = "",
				image = self.db.global[assetType][assetName], 
				imageWidth = width,
				imageHeight = height,
				order = 5,
			},
			extras = tempDelTbl,
		}
	}
	-- Insert the asset into our configuration table using its sanitized name
	if assetType == "artwork" then
		self.artLibrary.backgrounds.args[sanitizedName] = tempAssetMenu
	else
		self.artLibrary.borders.args[sanitizedName] = tempAssetMenu
	end	
end