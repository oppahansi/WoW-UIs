-- initialise the addon global itself
GhostPulse = AceLibrary("AceAddon-2.0"):new("AceComm-2.0", "AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0")

local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")


local function ReloadMessage()
	GhostPulse:Print(L["You will need to reload the interface to reflect this change."])
end

-- options for configuration
GhostPulse.options = {
		type = 'group',
		name = L["Ghost: Pulse 2"],
		desc = L["Pulses stuff on-screen."],
    	args = {
    		Locked = {
    			type = "toggle",
    			name = L["Locked"],
    			desc = L["Locks frames in place so they can't be moved around."],
    			get = function()
    				return GhostPulse.locked
    			end,
    			set = function(value)
    				GhostPulse.locked = value
    				Pulse:SetLocked(value)
    			end,
    			order = 1,
    		},
			
			EarlyWarningMethod = {
				type = "text",
				name = L["Early Warning Method"],
				desc = L["Early Warning Method"],
				usage = L["<method>"],
				get = function()
					return GhostPulse.db.profile.earlyWarningMethod or L["Floating Combat Text"]
				end,
				set = function(value)
					GhostPulse.db.profile.earlyWarningMethod = value
				end,
				validate = {
					L["Floating Combat Text"],
					L["UIErrorsFrame"],
					L["MSBT"],
				},
				order = 2,
			},
			
			AllowSharedFrames = {
				type = "toggle",
				name = L["Allow Shared Frames"],
				desc = L["Allow Shared Frames"],
				get = function()
					return GhostPulse.db.profile.allowSharedFrames
				end,
				set = function(value)
					GhostPulse.db.profile.allowSharedFrames = value
				end,
				order = 3,
			},
			
			RemoveShared = {
				type = "execute",
				name = L["Remove Shared Frames"],
				desc = L["Remove Shared Frames"],
				func = function()
					for i, v in pairs(GhostPulse.db.profile.frames) do
						if v.raidShared then
							GhostPulse.db.profile.frames[i] = nil
							Pulse:Disable(i)
						end
					end

					GhostPulse:PopulateFrameConfigs()
					AceLibrary("Waterfall-1.0"):Refresh("GhostPulse")
				end,
				hidden = function()
					local anyShared = false
					
					
					for _, v in pairs(GhostPulse.db.profile.frames) do
						if v.raidShared then
							anyShared = true
							break
						end
					end
					
					return not anyShared
				end,
				order = 4,
			},
			
			SharedMedia = {
				type = "toggle",
				name = L["Use Shared Media"],
				desc = L["Use Shared Media"],
				get = function()
					return GhostPulse.db.profile.useSharedMedia
				end,
				set = function(value)
					GhostPulse.db.profile.useSharedMedia = value

					if value and sml == nil then
						sml = AceLibrary:HasInstance("LibSharedMedia-2.0") and AceLibrary("LibSharedMedia-2.0") or nil
					else
						sml = nil
					end
					
					GhostPulse:PopulateFrameConfigs()
					GhostPulse:PopulateAlertConfigs()
					GhostPulse:PopulateSpecificsConfigs()
				end,
				order = 5,
			},
			
			Skinning = {
				type = "group",
				name = L["Skinning"],
				desc = L["Skinning"],
				order = -20,
				args = {
					Texture = {
						type = "text",
						name = L["Texture"],
						desc = L["Texture"],
						usage = L["<name of texture>"],
						get = function()
							return GhostPulse.db.profile.overlay.texture
						end,
						set = function(value)
							GhostPulse.db.profile.overlay.texture = value
							ReloadMessage()
						end,
						order = 1,
					},
						
					Alpha = {
						type = "range",
						name = L["Alpha"],
						desc = L["Alpha"],
						min = 0.0,
						max = 1.0,
						step = 0.05,
						get = function()
							return GhostPulse.db.profile.overlay.alpha
						end,
						set = function(value)
							GhostPulse.db.profile.overlay.alpha = value
							ReloadMessage()
						end,
						hidden = function()
							return GhostPulse.db.profile.overlay.texture == nil or GhostPulse.db.profile.overlay.texture == ""
						end,
						order = 2,
					},

					Scale = {
						type = "range",
						name = L["Scale"],
						desc = L["Scale"],
						min = 0.5,
						max = 2,
						step = 0.1,
						get = function()
							return GhostPulse.db.profile.overlay.scale
						end,
						set = function(value)
							GhostPulse.db.profile.overlay.scale = value
							ReloadMessage()
						end,
						hidden = function()
							return GhostPulse.db.profile.overlay.texture == nil or GhostPulse.db.profile.overlay.texture == ""
						end,
						order = 3,
					},
					
					Default = {
						type = "execute",
						name = L["Default"],
						desc = L["Default"],
						func = function()
							GhostPulse.db.profile.overlay = {
								texture = GhostPulse.db.profile.overlay.texture,
								alpha = 0.4,
								scale = 1.0,
							}
							ReloadMessage()
						end,
						hidden = function()
							return GhostPulse.db.profile.overlay.texture == nil or GhostPulse.db.profile.overlay.texture == ""
						end,
						order = 4,
					},
				},
			},
										
			Debug = {
				type = "toggle",
				name = "Debug",
				desc = "Debug",
				get = function()
					return GhostPulse.debugMode
				end,
				set = function(value)
					GhostPulse.debugMode = value
				end,
				hidden = function()
					return true
				end,
				order = -1,
			},			
	    },
	}

-- register bits with Ace
GhostPulse:RegisterDB("GhostPulseDB")
GhostPulse:SetCommPrefix("GhostPulse")
GhostPulse:RegisterChatCommand(L["Console-Slash-Commands"], GhostPulse.options)

-- register bits with Waterfall
local buildNumber = tonumber(GetAddOnMetadata("GhostPulse", "X-Build"):match("%d+"))
local versionString = string.format("v%s", GetAddOnMetadata("GhostPulse", "Version"))

AceLibrary("Waterfall-1.0"):Register("GhostPulse",
	"aceOptions", GhostPulse.options,
	"title", string.format("Ghost: Pulse 2 - %s", versionString),
	"treeLevels", 3,
	"colorR", 0.6, "colorG", 0.6, "colorB", 0.6)

	
-- a chat command to bring up the configuration GUI
GhostPulse:RegisterChatCommand(L["GUI-Slash-Commands"], function()
	AceLibrary("Waterfall-1.0"):Open("GhostPulse")
end)	

function GhostPulse:PopulateSpecificsConfigs()
	local curIndex = 101
	local specificsMain = {
		type = "group",
		name = L["Specifics"],
		desc = L["Contains options for configuring specific things."],
		order = -30,
		args = {
			Add = {
				type = "text",
				name = L["Add"],
				desc = L["Enter the name of the thing you want specific settings for."],
				usage = L["<name of thing>"],
				get = function() end,
				set = function(value)
					self.db.profile.specifics[value] = {
						sound = L["None"],
						earlyWarningSound = L["None"],
						limit = 0,
					}
					GhostPulse:PopulateSpecificsConfigs()
					AceLibrary("Waterfall-1.0"):Refresh("GhostPulse")
				end,
				order = 1,
			},
			
			Clear = {
				type = "execute",
				name = L["Clear"],
				desc = L["Clear"],
				func = function()
					self.db.profile.specifics = { }
					GhostPulse:PopulateSpecificsConfigs()
					AceLibrary("Waterfall-1.0"):Refresh("GhostPulse")
				end,
				order = 2,
			},
		},
	}

	GhostPulse.options.args.Specifics = specificsMain
	
	for i, v in pairs(self.db.profile.specifics) do
		local curOpt = {
			type = "group",
			name = i,
			desc = string.format(L["Options for %s"], i),
			args = {
				Sound = {
					type = "text",
					name = L["Sound"],
					desc = L["Sound"],
					usage = L["<name of sound>"],
					get = function()
						return self.db.profile.specifics[i].sound
					end,
					set = function(value)
						if value == nil or value == "" then
							value = L["None"]
						end
						
						self.db.profile.specifics[i].sound = value
						GhostPulse:PlayPulseSound(value)
					end,
					order = 1,
				},
				EarlyWarningSound = {
					type = "text",
					name = L["Early Warning Sound"],
					desc = L["Early Warning Sound"],
					usage = L["<name of sound>"],
					get = function()
						return self.db.profile.specifics[i].earlyWarningSound
					end,
					set = function(value)
						if value == nil or value == "" then
							value = L["None"]
						end
						
						self.db.profile.specifics[i].earlyWarningSound = value
						GhostPulse:PlayPulseSound(value)
					end,
					order = 2,
				},
				Limit = {
					type = "text",
					name = L["Limit"],
					desc = string.format(L["Enter a numeric limit for %s"], i),
					usage = L["<limit>"],
					get = function()
						return self.db.profile.specifics[i].limit
					end,
					set = function(value)
						if value == nil then
							value = 0
						end
						
						self.db.profile.specifics[i].limit = value
					end,
					order = 3,
				},
				Remove = {
					type = "execute",
					name = L["Remove"],
					desc = L["Remove"],
					func = function()
						self.db.profile.specifics[i] = nil
						GhostPulse:PopulateSpecificsConfigs()
						AceLibrary("Waterfall-1.0"):Refresh("GhostPulse")
					end,
				},
			},
			order = curIndex,
		}
		
		if sml then
			curOpt.args.Sound.validate = sml:List("sound")
		end
		
		GhostPulse.options.args.Specifics.args[i] = curOpt
	end			
end

function GhostPulse:PopulateAlertConfigs()
	local curIndex = 101
	local alertTypes = self:GetAlertTypes()
	
	
	local alertsMain = {
		type = "group",
		name = L["Alerts"],
		desc = L["Contains the options for the different alerts you can set up."],
		order = 2,
		args = {	
		},
	}

	GhostPulse.options.args.Alerts = alertsMain
	
	for _, v in pairs(alertTypes) do
		local curOpt = {
			type = "group",
			name = v.name,
			desc = string.format(L["Options for %s"], v.name),
			args = {
			},
			order = curIndex,
		}

		self.db.profile.alerts = self.db.profile.alerts or { }
		self.db.profile.alerts[v.key] = self.db.profile.alerts[v.key] or { }
		self.db.profile.alerts[v.key].whitelist = self.db.profile.alerts[v.key].whitelist or { }
		self.db.profile.alerts[v.key].blacklist = self.db.profile.alerts[v.key].blacklist or { }
		
		curOpt.args.Solo = {
			type = "toggle",
			name = L["While Solo"],
			desc = L["While Solo"],
			get = function()
				return self.db.profile.alerts[v.key].solo
			end,
			set = function(value)
				self.db.profile.alerts[v.key].solo = value
			end,
			order = 1,
		}
		
		curOpt.args.Party = {
			type = "toggle",
			name = L["In Party"],
			desc = L["In Party"],
			get = function()
				return self.db.profile.alerts[v.key].party
			end,
			set = function(value)
				self.db.profile.alerts[v.key].party = value
			end,
			order = 2,
		}
		
		curOpt.args.Raid = {
			type = "toggle",
			name = L["In Raid"],
			desc = L["In Raid"],
			get = function()
				return self.db.profile.alerts[v.key].raid
			end,
			set = function(value)
				self.db.profile.alerts[v.key].raid = value
			end,
			order = 3,
		}
		
		curOpt.args.InCombat = {
			type = "toggle",
			name = L["In-Combat Only"],
			desc = L["In-Combat Only"],
			get = function()
				return self.db.profile.alerts[v.key].inCombat
			end,
			set = function(value)
				self.db.profile.alerts[v.key].inCombat = value
			end,
			order = 4,
		}
		
		curOpt.args.Mounted = {
			type = "toggle",
			name = L["While Mounted"],
			desc = L["While Mounted"],
			get = function()
				return self.db.profile.alerts[v.key].whileMounted
			end,
			set = function(value)
				self.db.profile.alerts[v.key].whileMounted = value
			end,
			order = 5,
		}
		
		curOpt.args.Dead = {
			type = "toggle",
			name = L["While Dead"],
			desc = L["While Dead"],
			get = function()
				return self.db.profile.alerts[v.key].whileDead
			end,
			set = function(value)
				self.db.profile.alerts[v.key].whileDead = value
			end,
			order = 6,
		}
		
		curOpt.args.Battlegrounds = {
			type = "toggle",
			name = L["In Battlegrounds"],
			desc = L["In Battlegrounds"],
			get = function()
				return self.db.profile.alerts[v.key].inBattlegrounds
			end,
			set = function(value)
				self.db.profile.alerts[v.key].inBattlegrounds = value
			end,
			order = 7,
		}
		
		curOpt.args.MinCooldown = {
			type = "range",
			name = L["Minimum Cooldown Time"],
			desc = L["Minimum Cooldown Time"],
			min = 1.5,
			max = 3600,
			step = 0.5,
			get = function()
				return self.db.profile.alerts[v.key].minCooldown or 1.5
			end,
			set = function(value)
				self.db.profile.alerts[v.key].minCooldown = value
			end,
			order = 8,
		}
		
		curOpt.args.MaxCooldown = {
			type = "range",
			name = L["Maximum Cooldown Time"],
			desc = L["Maximum Cooldown Time"],
			min = 1.5,
			max = 3600,
			step = 0.5,
			get = function()
				return self.db.profile.alerts[v.key].maxCooldown or 3600
			end,
			set = function(value)
				self.db.profile.alerts[v.key].maxCooldown = value
			end,
			order = 9,
		}
		
		curOpt.args.Color = {
			type = "color",
			name = L["Highlight Color"],
			desc = L["Highlight Color"],
			get = function()
				local c = self.db.profile.alerts[v.key].color or { 0, 0, 0 }
				return c[1], c[2], c[3]
			end,
			set = function(r, g, b)
				self.db.profile.alerts[v.key].color = { r, g, b }
			end,
			hasAlpha = false,
			order = 10,
		}
		
		curOpt.args.Sound = {
			type = "text",
			name = L["Sound"],
			desc = L["Sound"],
			usage = L["<name of sound>"],
			get = function()
				return self.db.profile.alerts[v.key].sound or L["None"]
			end,
			set = function(value)
				if value == nil or value == "" then
					value = L["None"]
				end
						
				self.db.profile.alerts[v.key].sound = value
				GhostPulse:PlayPulseSound(value)
			end,
			order = 11,
		}
		
		curOpt.args.Announce = {
			type = "toggle",
			name = L["Announce Alerts to Group"],
			desc = L["Announce Alerts to Group"],
			get = function()
				return self.db.profile.alerts[v.key].announceAlert
			end,
			set = function(value)
				self.db.profile.alerts[v.key].announceAlert = value
			end,
			order = 12,
		}
		
		curOpt.args.EarlyWarning = {
			type = "toggle",
			name = L["Show Early Warnings"],
			desc = L["Show Early Warnings"],
			get = function()
				return self.db.profile.alerts[v.key].earlyWarning
			end,
			set = function(value)
				self.db.profile.alerts[v.key].earlyWarning = value
			end,
			order = 13,
		}

		curOpt.args.EarlyWarningTime = {
			type = "range",
			name = L["Early Warning Time"],
			desc = L["Early Warning Time"],
			min = 0.5,
			max = 30,
			step = 0.5,
			get = function()
				return self.db.profile.alerts[v.key].earlyWarningTime or 3.0
			end,
			set = function(value)
				self.db.profile.alerts[v.key].earlyWarningTime = value
			end,
			hidden = function()
				return not self.db.profile.alerts[v.key].earlyWarning
			end,
			order = 14,
		}
				
		curOpt.args.EarlyWarningColor = {
			type = "color",
			name = L["Early Warning Color"],
			desc = L["Early Warning Color"],
			get = function()
				local c = self.db.profile.alerts[v.key].earlyWarningColor or { 0, 0, 0 }
				return c[1], c[2], c[3]
			end,
			set = function(r, g, b)
				self.db.profile.alerts[v.key].earlyWarningColor = { r, g, b }
			end,
			hidden = function()
				return not self.db.profile.alerts[v.key].earlyWarning
			end,
			hasAlpha = false,
			order = 15,
		}
		
		curOpt.args.EarlyWarningSound = {
			type = "text",
			name = L["Early Warning Sound"],
			desc = L["Early Warning Sound"],
			usage = L["<name of sound>"],
			get = function()
				return self.db.profile.alerts[v.key].earlyWarningSound or L["None"]
			end,
			set = function(value)
				self.db.profile.alerts[v.key].earlyWarningSound = value
				GhostPulse:PlayPulseSound(value)
			end,
			hidden = function()
				return not self.db.profile.alerts[v.key].earlyWarning
			end,
			order = 16,
		}
		
		curOpt.args.EarlyWarningAnnounce = {
			type = "toggle",
			name = L["Announce Warnings to Group"],
			desc = L["Announce Warnings to Group"],
			get = function()
				return self.db.profile.alerts[v.key].announceWarning
			end,
			set = function(value)
				self.db.profile.alerts[v.key].announceWarning = value
			end,
			hidden = function()
				return not self.db.profile.alerts[v.key].earlyWarning
			end,
			order = 17,
		}
		
		curOpt.args.EarlyWarningTemplate = {
			type = "text",
			name = L["Early Warning Text"],
			desc = L["Early Warning Text"],
			usage = L["<template>"],
			get = function()
				return self.db.profile.alerts[v.key].earlyWarningTemplate or L["[Name] is ready soon"]
			end,
			set = function(value)
				self.db.profile.alerts[v.key].earlyWarningTemplate = value
			end,
			hidden = function()
				return not self.db.profile.alerts[v.key].earlyWarning
			end,
			order = 18,
		}
		
		curOpt.args.TextTemplate = {
			type = "text",
			name = L["Alert Text"],
			desc = L["Alert Text"],
			usage = L["<template>"],
			get = function()
				return self.db.profile.alerts[v.key].textTemplate or "[Name]"
			end,
			set = function(value)
				self.db.profile.alerts[v.key].textTemplate = value
			end,
			order = 19,
		}
		
		curOpt.args.Whitelist = {
			type = "group",
			name = L["Whitelist"],
			desc = L["Whitelist"],
			order = -3,
			args = {
				Add = {
					type = "text",
					name = L["Add"],
					desc = L["Add"],
					usage = L["<name of thing>"],
					get = function() end,
					set = function(value)
						self.db.profile.alerts[v.key].whitelist[value] = true
						self:Print(string.format(L["'%s' added to the whitelist for alert '%s'."], value, v.name))
					end,
					order = 1,
				},
				Remove = {
					type = "text",
					name = L["Remove"],
					desc = L["Remove"],
					usage = L["<name of thing>"],
					get = function() end,
					set = function(value)
						self.db.profile.alerts[v.key].whitelist[value] = nil
						self:Print(string.format(L["'%s' removed from the whitelist for alert '%s'."], value, v.name))
					end,
					order = 2,
				},
				List = {
					type = "execute",
					name = L["List"],
					desc = L["List"],
					func = function()
						local any = false
						
						
						self:Print(string.format(L["Showing the whitelist for alert '%s'..."], v.name))
						
						for i, v in pairs(self.db.profile.alerts[v.key].whitelist) do
							if v then
								any = true
								self:Print("- "..i)
							end
						end
						
						if not any then
							self:Print(L["*** Empty ***"])
						end
					end,
					order = 4,
				},
				Clear = {
					type = "execute",
					name = L["Clear"],
					desc = L["Clear"],
					func = function()
						self.db.profile.alerts[v.key].whitelist = { }
						self:Print(string.format(L["Whitelist cleared for alert '%s'."], v.name))
					end,
					order = 5,
				},
			},
		}
		
		curOpt.args.Blacklist = {
			type = "group",
			name = L["Blacklist"],
			desc = L["Blacklist"],
			order = -2,
			args = {
				Add = {
					type = "text",
					name = L["Add"],
					desc = L["Add"],
					usage = L["<name of thing>"],
					get = function() end,
					set = function(value)
						self.db.profile.alerts[v.key].blacklist[value] = true
						self:Print(string.format(L["'%s' added to the blacklist for alert '%s'."], value, v.name))
					end,
					order = 1,
				},
				Remove = {
					type = "text",
					name = L["Remove"],
					desc = L["Remove"],
					usage = L["<name of thing>"],
					get = function() end,
					set = function(value)
						self.db.profile.alerts[v.key].blacklist[value] = nil
						self:Print(string.format(L["'%s' removed from the blacklist for alert '%s'."], value, v.name))
					end,
					order = 2,
				},
				List = {
					type = "execute",
					name = L["List"],
					desc = L["List"],
					func = function()
						local any = false
						
						
						self:Print(string.format(L["Showing the blacklist for alert '%s'..."], v.name))
						
						for i, v in pairs(self.db.profile.alerts[v.key].blacklist) do
							if v then
								any = true
								self:Print("- "..i)
							end
						end
						
						if not any then
							self:Print(L["*** Empty ***"])
						end
					end,
					order = 4,
				},
				Clear = {
					type = "execute",
					name = L["Clear"],
					desc = L["Clear"],
					func = function()
						self.db.profile.alerts[v.key].blacklist = { }
						self:Print(string.format(L["Blacklist cleared for alert '%s'."], v.name))
					end,
					order = 5,
				},
			},
		}
		
		if sml then
			curOpt.args.Sound.validate = sml:List("sound")
		end

		GhostPulse.options.args.Alerts.args[v.key] = curOpt
	end

	AceLibrary("Waterfall-1.0"):Refresh("GhostPulse")
end

function GhostPulse:PopulateFrameConfigs()
	local curIndex = 1001
	
	
	local framesMain = {
		type = 'group',
		name = L["Frames"],
		desc = L["Create and configure frames to show alerts."],
		order = 1,
		args = {
			Add = { type = "text",
	        		name = L["Add"],
		  			desc = L["Enter a name for the new frame."],
					usage = L["<name of frame>"],
					get = function() end,
					set = function(name)
						GhostPulse.db.profile.frames[name] = Pulse:CreateDefaultOptions()
						GhostPulse.db.profile.frames[name].name = name
						GhostPulse:PopulateFrameConfigs()
						GhostPulse:CreateAllFrames()
						
						if not GhostPulse.locked then
							Pulse:SetLocked(false)
						end
						
						AceLibrary("Waterfall-1.0"):Refresh("GhostPulse")
					end,
					order = 1,
			},
		},
	}
	
	GhostPulse.options.args.Frames = framesMain
	
	-- basic settings, like size, fontScale etc
	for i, v in pairs(self.db.profile.frames) do
		local alertTypes = self:GetAlertTypes()
		local curOpt = {
			type = "group",
			name = i,
			desc = string.format(L["Options for %s"], i),
			args = {
			},
		}
		
		curOpt.args.Share = {
			type = "execute",
			name = L["Share Frame with Group"],
			desc = L["Share Frame with Group"],
			func = function()
				self:SendCommMessage("GROUP", "share", self.db.profile.frames[i])
			end,
			hidden = function()
				local hideIt = true
				
				
				if GetNumRaidMembers() > 0 and ( IsRaidLeader() or IsRaidOfficer() ) then
					hideIt = false
				end
				
				return hideIt
			end,
			order = 10,
		}
		
		-- basic settings like size etc
		curOpt.args.Size = {
			type = "range",
			name = L["Size"],
			desc = L["Size"],
			min = 32,
			max = 384,
			step = 8,
			get = function()
				return self.db.profile.frames[i].pulse.size
			end,
			set = function(value)
				self.db.profile.frames[i].pulse.size = value
				Pulse:GetFrame(i):SetSize(value)
			end,
			order = 20,
		}
		
		curOpt.args.ShowText = {
			type = "toggle",
			name = L["Show Text"],
			desc = L["Show Text"],
			get = function()
				return self.db.profile.frames[i].pulse.showText
			end,
			set = function(value)
				self.db.profile.frames[i].pulse.showText = value
			end,
			order = 30,
		}
		
		curOpt.args.FontScale = {
			type = "range",
			name = L["Font Scale"],
			desc = L["Font Scale"],
			min = 0.5,
			max = 2,
			step = 0.1,
			get = function()
				return self.db.profile.frames[i].pulse.fontScale
			end,
			set = function(value)
				self.db.profile.frames[i].pulse.fontScale = value
				Pulse:GetFrame(i):SetSize(self.db.profile.frames[i].pulse.size)
			end,
			hidden = function()
				return not self.db.profile.frames[i].pulse.showText
			end,
			order = 40,
		}

		curOpt.args.Alpha = {
			type = "range",
			name = L["Alpha"],
			desc = L["Alpha"],
			min = 0.1,
			max = 1.0,
			step = 0.1,
			get = function()
				return self.db.profile.frames[i].pulse.alpha
			end,
			set = function(value)
				self.db.profile.frames[i].pulse.alpha = value
			end,
			order = 50,
		}
		
		curOpt.args.FadeInTime = {
			type = "range",
			name = L["Fade-in Time"],
			desc = L["Fade-in Time"],
			min = 0.1,
			max = 2.0,
			step = 0.1,
			get = function()
				return self.db.profile.frames[i].pulse.fadeInTime
			end,
			set = function(value)
				self.db.profile.frames[i].pulse.fadeInTime = value
			end,
			order = 60,
		}
		
		curOpt.args.HoldTime = {
			type = "range",
			name = L["Hold Time"],
			desc = L["Hold Time"],
			min = 0.25,
			max = 20.0,
			step = 0.25,
			get = function()
				return self.db.profile.frames[i].pulse.holdTime
			end,
			set = function(value)
				self.db.profile.frames[i].pulse.holdTime = value
			end,
			order = 70,
		}
		
		curOpt.args.FadeOutTime = {
			type = "range",
			name = L["Fade-out Time"],
			desc = L["Fade-out Time"],
			min = 0.1,
			max = 2.0,
			step = 0.1,
			get = function()
				return self.db.profile.frames[i].pulse.fadeOutTime
			end,
			set = function(value)
				self.db.profile.frames[i].pulse.fadeOutTime = value
			end,
			order = 80,
		}
		
		curOpt.args.Sound = {
			type = "text",
			name = L["Override Sound"],
			desc = L["If specified, this sound will play for all alerts shown in this frame instead of the alert-specific sound.  The general 'Sounds' options can override this, however."],
			usage = L["<name of sound>"],
			get = function()
				return self.db.profile.frames[i].overrideSound or L["None"]
			end,
			set = function(value)
				if value == nil or value == "" then
					value = L["None"]
				end
				
				self.db.profile.frames[i].overrideSound = value
				GhostPulse:PlayPulseSound(value)
			end,
			order = 90,
		}
		
		for _, w in pairs(alertTypes) do
			local curType = {
				type = "toggle",
				name = w["name"],
				desc = w["name"],
				get = function()
					return self.db.profile.frames[i].alertTypes[w["key"]]
				end,
				set = function(value)
					self.db.profile.frames[i].alertTypes[w["key"]] = value
					self:EnableActiveAlerts()
				end,
				order = curIndex,
			}
			
			curOpt.args[w.key] = curType
			curIndex = curIndex + 1
		end
		
		curOpt.args.Whitelist = {
			type = "group",
			name = L["Whitelist"],
			desc = L["Whitelist"],
			order = -3,
			args = {
				Add = {
					type = "text",
					name = L["Add"],
					desc = L["Add"],
					usage = L["<name of thing>"],
					get = function() end,
					set = function(value)
						self.db.profile.frames[i].whitelist[value] = true
						self:Print(string.format(L["'%s' added to the whitelist for frame '%s'."], value, i))
					end,
					order = 1,
				},
				Remove = {
					type = "text",
					name = L["Remove"],
					desc = L["Remove"],
					usage = L["<name of thing>"],
					get = function() end,
					set = function(value)
						self.db.profile.frames[i].whitelist[value] = nil
						self:Print(string.format(L["'%s' removed from the whitelist for frame '%s'."], value, i))
					end,
					order = 2,
				},
				List = {
					type = "execute",
					name = L["List"],
					desc = L["List"],
					func = function()
						local any = false
						
						
						self:Print(string.format(L["Showing the whitelist for frame '%s'..."], i))
						
						for i, v in pairs(self.db.profile.frames[i].whitelist) do
							if v then
								any = true
								self:Print("- "..i)
							end
						end
						
						if not any then
							self:Print(L["*** Empty ***"])
						end
					end,
					order = 4,
				},
				Clear = {
					type = "execute",
					name = L["Clear"],
					desc = L["Clear"],
					func = function()
						self.db.profile.frames[i].whitelist = { }
						self:Print(string.format(L["Whitelist cleared for frame '%s'."], i))
					end,
					order = 5,
				},
			},
		}
		
		curOpt.args.Blacklist = {
			type = "group",
			name = L["Blacklist"],
			desc = L["Blacklist"],
			order = -2,
			args = {
				Add = {
					type = "text",
					name = L["Add"],
					desc = L["Add"],
					usage = L["<name of thing>"],
					get = function() end,
					set = function(value)
						self.db.profile.frames[i].blacklist[value] = true
						self:Print(string.format(L["'%s' added to the blacklist for frame '%s'."], value, i))
					end,
					order = 1,
				},
				Remove = {
					type = "text",
					name = L["Remove"],
					desc = L["Remove"],
					usage = L["<name of thing>"],
					get = function() end,
					set = function(value)
						self.db.profile.frames[i].blacklist[value] = nil
						self:Print(string.format(L["'%s' removed from the blacklist for frame '%s'."], value, i))
					end,
					order = 2,
				},
				List = {
					type = "execute",
					name = L["List"],
					desc = L["List"],
					func = function()
						local any = false
						
						
						self:Print(string.format(L["Showing the blacklist for frame '%s'..."], i))
						
						for i, v in pairs(self.db.profile.frames[i].blacklist) do
							if v then
								any = true
								self:Print("- "..i)
							end
						end
						
						if not any then
							self:Print(L["*** Empty ***"])
						end
					end,
					order = 4,
				},
				Clear = {
					type = "execute",
					name = L["Clear"],
					desc = L["Clear"],
					func = function()
						self.db.profile.frames[i].blacklist = { }
						self:Print(string.format(L["Blacklist cleared for frame '%s'."], i))
					end,
					order = 5,
				},
			},
		}
		
		curOpt.args.Keep = {
			type = "execute",
			name = L["Keep"],
			desc = L["Keep"],
			func = function()
				self.db.profile.frames[i].raidShared = nil
			end,
			hidden = function()
				return not self.db.profile.frames[i].raidShared
			end,
			order = -2,
		}
		
		curOpt.args.Remove = {
			type = "execute",
			name = L["Remove"],
			desc = L["Removes the frame."],
			func = function()
				self.db.profile.frames[i] = nil
				Pulse:Disable(i)
				GhostPulse:PopulateFrameConfigs()
				AceLibrary("Waterfall-1.0"):Refresh("GhostPulse")
			end,
			order = -1,
		}
		
		if sml then
			curOpt.args.Sound.validate = sml:List("sound")
		end

		GhostPulse.options.args.Frames.args[i] = curOpt
	end
	
	AceLibrary("Waterfall-1.0"):Refresh("GhostPulse")
end
