local L = LibStub("AceLocale-3.0"):GetLocale("Gladiminish")
local Gladiminish = Gladiminish
local self = Gladiminish

local defaultDB = {
	profile = {
		framePos = true, --true: left
		frameDist = 10,
		iconDist = 5,
		iconSize = 40,
		iconGladius = true,
		fontSize = 16,
		fontGladius = false,
	}
}

local confTable = {
	name = L["Gladiminish"],
	handler = Gladiminish,
	type = 'group',
	args = {
		general = {
			name = L["General"],
			type = 'group',
			get = "GetConfigValue",
			set = "SetConfigValue",
			args = {
				framePos = {
					name = L["Icon Position"],
					desc = L["Position the icons left (checked) or right (unchecked) of Gladius"],
					type = 'toggle',			
					order = 1,
				},
				
				lineBreak = {
					name = "",
					type = 'description',
					order = 5,
				},
			
				frameDist = {
					name = L["Frame Distance"],
					desc = L["Distance between first icon and Gladius"],
					type = 'range',
					min = 0,
					max = 100,
					step = 1,
					order = 10,
				},
				
				iconDist = {
					name = L["Icon Distance"],
					desc = L["Distance between two icons"],
					type = 'range',
					min = 0,
					max = 25,
					step = 1,
					order = 15,
				},
				
				iconSize = {
					name = L["Iconsize"],
					desc = L["Size of the diminishing return icons"],
					type = 'range',
					min = 20,
					max = 120,
					step = 1,				
					order = 20,
				},				
				
				iconGladius = {
					name = L["Use Gladius Iconsize"],
					desc = L["Use Size of the Gladius Icon"],
					type = 'toggle',			
					order = 25,				
				},

				fontSize = {
					name = L["Fontsize"],
					desc = L["Fontsize of diminishing return countdown"],
					type = 'range',
					min = 8,
					max = 24,
					step = 1,				
					order = 30,
				},				
				
				fontGladius = {
					name = L["Use Gladius Fontsize"],
					desc = L["Use Fontsize of the Gladius Icon"],
					type = 'toggle',			
					order = 35,				
				},
			}
		}
	},
}

local confLinks = {
	["fontGladius"] = "fontSize",
	["iconGladius"] = "iconSize"
}

function Gladiminish:GetDefaultDB()
	return defaultDB
end

function Gladiminish:GetConfigValue(item)
	return self.db.profile[item[#item]] 
end

function Gladiminish:SetConfigValue(item, value)
	self.db.profile[item[#item]] = value
	
	if confLinks[item[#item]] then
		self.config.args.general.args[confLinks[item[#item]]].disabled = value
	end
	
	self:ClearAllFrames()
	self:UpdateiFrames()
	self:AddTestData()
end

function Gladiminish:AddTestData()
	if self.iFrames["arena1"] then
		self:DebuffGained("arena1", 51514)
		self:DebuffGained("arena1", 2094)		
			
		self:DebuffFaded("arena1", 51514)
		self:DebuffFaded("arena1", 2094)		
	end
	
	if self.iFrames["arena2"] then
		self:DebuffGained("arena2", 53308)
		
		self:DebuffFaded("arena2", 53308)
	end
end

function Gladiminish:SetupConfig()
	self.config = confTable
	self.config.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	
	for key, value in pairs(confLinks) do
		self.config.args.general.args[value].disabled = self.db.profile[key]
	end
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable(L["Gladiminish"], self.config)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions(L["Gladiminish"], L["Gladiminish"])
	
	self:RegisterChatCommand("gladiminish", function() InterfaceOptionsFrame_OpenToCategory(L["Gladiminish"]) end)
	self:RegisterChatCommand("gdm", function() InterfaceOptionsFrame_OpenToCategory(L["Gladiminish"]) end)
	--self:RegisterChatCommand("gdmt", function() Gladiminish:AddTestData() end)
end