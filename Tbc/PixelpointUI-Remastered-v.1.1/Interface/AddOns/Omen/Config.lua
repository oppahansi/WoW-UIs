local MINOR_VERSION = tonumber(("$Revision: 72202 $"):match("%d+"))
if MINOR_VERSION > Omen.MINOR_VERSION then Omen.MINOR_VERSION = MINOR_VERSION end

local L = LibStub("AceLocale-3.0"):GetLocale("Omen")
local Threat = LibStub("Threat-2.0")
local Media = LibStub("LibSharedMedia-3.0")
local textures = Media:List("statusbar")
local fonts = Media:List("font")
local backgrounds = Media:List("background")
local borders = Media:List("border")
local outlines = {[""] = L["None"], ["OUTLINE"] = L["Outline"], ["THICKOUTLINE"] = L["Thick Outline"]}

Media.RegisterCallback(Omen, "LibSharedMedia_Registered", "UpdateDisplay")
Media.RegisterCallback(Omen, "LibSharedMedia_SetGlobal", "UpdateDisplay")

local function GetLSMIndex(t, value)
	for k, v in pairs(Media:List(t)) do
		if v == value then
			return k
		end
	end
	return nil
end

local function GetFuBarMinimapAttachedStatus(info)
	return Omen:IsFuBarMinimapAttached() or Omen.Options["FuBar.HideMinimapButton"]
end

function Omen:InjectFrameOptions(f, t)
	t.args.backgroundcolor = {
			type = "color",
			name = L["Background color"],
			desc = L["Background color"],
			hasAlpha = true,
			get = function(info)
				local r = Omen.Options["Skin."..f..".Background.Color.r"] or Omen.Options["Skin.Frames.Background.Color.r"]
				local g = Omen.Options["Skin."..f..".Background.Color.g"] or Omen.Options["Skin.Frames.Background.Color.g"]
				local b = Omen.Options["Skin."..f..".Background.Color.b"] or Omen.Options["Skin.Frames.Background.Color.b"]
				local a = Omen.Options["Skin."..f..".Background.Color.a"] or Omen.Options["Skin.Frames.Background.Color.a"]
				return r, g, b, a
			end,
			set = function(info, r, g, b, a)
				Omen.Options["Skin."..f..".Background.Color.r"] = r
				Omen.Options["Skin."..f..".Background.Color.g"] = g
				Omen.Options["Skin."..f..".Background.Color.b"] = b
				Omen.Options["Skin."..f..".Background.Color.a"] = a
				Omen:ResetMemoizations()
				Omen:UpdateDisplay()
			end
		}
		
	t.args.backgroundtexture = {
			type = "select",
			name = L["Background texture"],
			desc = L["Texture to use for the frame's background"],
			values = backgrounds,
			get = function(info) return GetLSMIndex("background", Omen.Options["Skin."..f..".Background.Texture"]) end,
			set = function(info, v)
				Omen.Options["Skin."..f..".Background.Texture"] = Media:List("background")[v]
				Omen:ResetMemoizations()
				Omen:UpdateDisplay()
			end
		}
		
	t.args.bordercolor = {
			type = "color",
			name = L["Border color"],
			desc = L["Frame's border color"],
			hasAlpha = true,
			get = function(info)
				local r = Omen.Options["Skin."..f..".Border.Color.r"] or Omen.Options["Skin.Frames.Border.Color.r"]
				local g = Omen.Options["Skin."..f..".Border.Color.g"] or Omen.Options["Skin.Frames.Border.Color.g"]
				local b = Omen.Options["Skin."..f..".Border.Color.b"] or Omen.Options["Skin.Frames.Border.Color.b"]
				local a = Omen.Options["Skin."..f..".Border.Color.a"] or Omen.Options["Skin.Frames.Border.Color.a"]
				return r, g, b, a
			end,
			set = function(info, r, g, b, a)
				Omen.Options["Skin."..f..".Border.Color.r"] = r
				Omen.Options["Skin."..f..".Border.Color.g"] = g
				Omen.Options["Skin."..f..".Border.Color.b"] = b
				Omen.Options["Skin."..f..".Border.Color.a"] = a
				Omen:ResetMemoizations()
				Omen:UpdateDisplay()
			end
		}
		
	t.args.bordertexture = {
			type = "select",
			name = L["Border texture"],
			desc = L["Texture to use for the frame's border"],
			values = borders,
			get = function(info) return GetLSMIndex("border", Omen.Options["Skin."..f..".Border.Texture"]) end,
			set = function(info, v)
				Omen.Options["Skin."..f..".Border.Texture"] = Media:List("border")[v]
				Omen:ResetMemoizations()
				Omen:UpdateDisplay()
			end
		}
	t.args.reset = {
			type = "execute",
			name = L["Reset to defaults"],
			desc = L["Use global defaults for this frame"],
			func = function()
				Omen:ResetOption("Skin."..f)
				Omen:ResetMemoizations()
				Omen:UpdateDisplay()
			end
		}
		
	t.args.alpha = {
			type = "range",
			name = L["Opacity"],
			desc = L["Opacity of the entire frame"],
			min = 0,
			max = 1,
			step = 0.01,
			bigStep = 0.05,
			get = function() return Omen.Options["Skin." .. f .. ".Opacity"] end,
			set = function(info, v)
				Omen.Options["Skin." .. f .. ".Opacity"] = v
				Omen:ResetMemoizations()
				Omen:UpdateDisplay()
			end
		}
end

local options = {
	type = "group",
	args = {
		standby = {
			type = "toggle",
			name = L["Standby"],
			desc = L["Standby"],
			get = function(info) return Omen.Options["Standby"] end,
			set = function(info, v)
				Omen.Options["Standby"] = v
				if v then
					Omen:Disable()
				else
					Omen:Enable()
					if Omen:IsFuBarMinimapAttached() ~= Omen.Options["FuBar.AttachMinimap"] then
						Omen:ToggleFuBarMinimapAttached()
					end
					
				end
			end,
			guiHidden = true
		},
		toggle = {
			type = "execute",
			name = L["Toggle Omen"],
			desc = L["Toggle Omen"],
			func = function()
				Omen:Toggle()
				Omen.Options["HardOff"] = not OmenAnchor:IsVisible()
			end,
			guiHidden = true
		},
		clear = {
			type = "execute",
			name = L["Issue threat clear"],
			desc = L["Issue threat clear (requires party leader or raid assistant)"],
			func = function() Threat:RequestThreatClear() end,
			disabled = function() return not Threat:IsGroupOfficer("player") end,
			guiHidden = true
		},
		center = {
			type = "execute",
			name = L["Center Omen"],
			desc = L["Center Omen"],
			func = function()
				Omen.Anchor:ClearAllPoints()
				Omen.Anchor:SetPoint("CENTER", UIParent, "CENTER")
				Omen:SetAnchors()
			end,
			guiHidden = true
		},
		showWhen = {
			type = "group",
			name = L["Show when..."],
			desc = L["Show Omen when..."],
			args = {
				pet = {
					type = "toggle",
					name = L["You have a pet"],
					desc = L["Show Omen when you have a pet out"],
					get = function(info) return Omen.Options["ShowWith.Pet"] end,
					set = function(info, v)
						Omen.Options["ShowWith.Pet"] = v
						Omen:UpdateVisible()
					end
				},
				alone = {
					type = "toggle",
					name = L["You are alone"],
					desc = L["Show Omen when you are alone"],
					get = function(info) return Omen.Options["ShowWith.Alone"] end,
					set = function(info, v)
						Omen.Options["ShowWith.Alone"] = v
						Omen:UpdateVisible()
					end
				},
				party = {
					type = "toggle",
					name = L["You are in a party"],
					desc = L["Show Omen when you are in a 5-man party"],
					get = function(info) return Omen.Options["ShowWith.Party"] end,
					set = function(info, v)
						Omen.Options["ShowWith.Party"] = v
						Omen:UpdateVisible()
					end
				},
				raid = {
					type = "toggle",
					name = L["You are in a raid"],
					desc = L["Show Omen when you are in a raid"],
					get = function(info) return Omen.Options["ShowWith.Raid"] end,
					set = function(info, v)
						Omen.Options["ShowWith.Raid"] = v
						Omen:UpdateVisible()
					end
				},
				resting = {
					type = "toggle",
					name = L["You are resting"],
					desc = L["Show Omen when you are resting"],
					get = function(info) return Omen.Options["ShowWith.Resting"] end,
					set = function(info, v)
						Omen.Options["ShowWith.Resting"] = v
						Omen:UpdateVisible()
					end
				},
				battleground = {
					type = "toggle",
					name = L["You are in a battleground"],
					desc = L["Show Omen when you are in a battleground or arena"],
					get = function(info) return Omen.Options["ShowWith.PVP"] end,
					set = function(info, v)
						Omen.Options["ShowWith.PVP"] = v
						Omen:UpdateVisible()
					end
				},
				instance = {
					type = "toggle",
					name = L["You are in a dungeon"],
					desc = L["Show Omen when you are in a dungeon (5 man and raid)"],
					get = function(info) return Omen.Options["ShowWith.Dungeon"] end,
					set = function (info, v)
						Omen.Options["ShowWith.Dungeon"] = v
						Omen:UpdateVisible()
					end
				}
			}
		},
		versioncheck = {
			type = "group",
			name = L["Version Checks"],
			desc = L["Version Checks"],
			args = {
				all = {
					type = "execute",
					name = L["Show all party member revisions"],
					desc = L["Show all party member revisions"],
					func = function()
						Omen:VersionCheck()
					end
				},
				outdated = {
					type = "execute",
					name = L["Show oudated party member revisions"],
					desc = L["Show oudated party member revisions"],
					func = function()
						Omen:VersionCheck(true)
					end
				},
				whisper = {
					type = "execute",
					name = L["Whisper older clients informing them to update."],
					desc = L["Whisper older clients informing them to update."],
					func = function() Omen:WhisperOldClients() end,
					disabled = function() return not Threat:IsGroupOfficer("player") end
				}
			},
		},
		fubar = {
			type = "group",
			name = L["FuBar options"],
			desc = L["FuBar options"],
			disabled = function() return Omen.IsFuBarMinimapAttached == nil end,
			args = {
				attachMinimap = {
					type = "toggle",
					name = L["Attach to minimap"],
					desc = L["Attach to minimap"],
					get = function(info)
						return Omen:IsFuBarMinimapAttached()
					end,
					set = function(info, v)
						Omen:ToggleFuBarMinimapAttached()
						Omen.Options["FuBar.AttachMinimap"] = Omen:IsFuBarMinimapAttached()
					end
				},
				hideIcon = {
					type = "toggle",
					name = L["Hide minimap/FuBar icon"],
					desc = L["Hide minimap/FuBar icon"],
					get = function(info) return Omen.Options["FuBar.HideMinimapButton"] end,
					set = function(info, v)
						Omen.Options["FuBar.HideMinimapButton"] = v
						if v then
							Omen:Hide()
						else
							Omen:Show()
						end
					end
				},
				showIcon = {
					type = "toggle",
					name = L["Show icon"],
					desc = L["Show icon"],
					get = function(info) return Omen:IsFuBarIconShown() end,
					set = function(info, v) Omen:ToggleFuBarIconShown() end,
					disabled = GetFuBarMinimapAttachedStatus
				},
				showText = {
					type = "toggle",
					name = L["Show text"],
					desc = L["Show text"],
					get = function(info) return Omen:IsFuBarTextShown() end,
					set = function(info, v) Omen:ToggleFuBarTextShown() end,
					disabled = GetFuBarMinimapAttachedStatus
				},
				position = {
					type = "select",
					name = L["Position"],
					desc = L["Position"],
					values = {LEFT = L["Left"], CENTER = L["Center"], RIGHT = L["Right"]},
					get = function() return Omen:GetPanel() and Omen:GetPanel():GetPluginSide(Omen) end,
					set = function(info, val)
						if Omen:GetPanel() and Omen:GetPanel().SetPluginSide then
							Omen:GetPanel():SetPluginSide(Omen, val)
						end
					end,
					disabled = GetFuBarMinimapAttachedStatus
				}
			}
		},
		skin = {
			type = "group",
			name = L["Skin"],
			desc = L["Save your current settings and load other skins"],
			args = {
				load = {
					type = "select",
					name = L["Load Skin..."],
					desc = L["Load a saved skin"],
					values = Omen.SkinList,
					get = function(info) return Omen.Options["ActiveSkinName"] or "<default>" end,
					set = function(info, v) Omen:SwitchSkin(v) end
				},
				save = {
					type = "input",
					name = L["Save Skin As..."],
					desc = L["Save the current settings as a skin"],
					get = function(info) return Omen.Options["Skin.Name"] end,
					set = function(info, v) Omen:SaveSkin(v) end
				}
			}
		},
		display = {
			type = "group",
			name = L["Display options"],
			desc = L["Options that control Omen's appearance"],
			args = {
				lock = {
					type = "toggle",
					name = L["Lock Omen"],
					desc = L["Locks Omen in place and prevents it from being dragged or resized."],
					get = function(info) return Omen.Options["Lock"] end,
					set = function(info, v)
						Omen.Options["Lock"] = v
						Omen:UpdateDisplay()
					end
				},			
				scale = {
					type = "range",
					name = L["Scale"],
					desc = L["Control the scale of the entire Omen GUI"],
					min = 1,
					max = 150,
					step = 1,
					bigStep = 1,
					get = function(info) return Omen.Options["Skin.Scale"] end,
					set = function(info, v)
						Omen.Options["Skin.Scale"] = v
						Omen:UpdateDisplay()
					end					
				},
				clamp = {
					type = "toggle",
					name = L["Clamp to screen"],
					desc = L["Clamp the Omen frame to the screen"],
					get = function(info) return Omen.Options["Skin.Clamp"] end,
					set = function(info, v) Omen.Options["Skin.Clamp"] = v; Omen:UpdateDisplay() end
				},				
				classes = {
					type = "group",
					name = L["Classes"],
					desc = L["Classes"],
					args = {}		-- Filled dynamically
				},
				test = {
					type = "execute",
					name = L["Show test bars"],
					desc = L["Show test bars"],
					func = Omen.Test
				},			
				defaults = {
					type = "group",
					name = L["Defaults"],
					desc = L["Options that affect the appearance of all frames"],
					args = {},
					order = 1
				},
				moduleList = {
					type = "group",
					name = L["Modules window"],
					desc = L["Options that affect the appearance of the module list window"],
					args = {
						hide = {
							type = "toggle",
							name = L["Hide"],
							desc = L["Hide this frame"],
							get = function(info) return Omen.Options["Skin.Modules.Hide"] end,
							set = function(info, v)
								Omen.Options["Skin.Modules.Hide"] = v
								Omen:UpdateDisplay()
							end
						},
						height = {
							type = "range",
							name = L["Size"],
							desc = L["Control the size of this frame"],
							min = 20,
							max = 75,
							step = 1,
							bigStep = 1,
							get = function(info) return Omen.Options["Skin.Modules.Height"] end,
							set = function(info, v)
								Omen.Options["Skin.Modules.Height"] = v
								Omen:LayoutModuleIcons()
								Omen:UpdateDisplay()
							end
						}
					}
				},
				barList = {
					type = "group",
					name = L["Bars window"],
					desc = L["Options that affect the appearance of the bar list window"],
					args = {
						growUp = {
							type = "toggle",
							name = L["Grow Up"],
							desc = L["Grow bars upwards"],
							get = function(info) return Omen.Options["Skin.Bars.GrowUp"] end,
							set = function(info, v)
								Omen.Options["Skin.Bars.GrowUp"] = v
								Omen:SetAnchors()
							end
						},
						collapse = {
							type = "toggle",
							name = L["Autocollapse"],
							desc = L["Collapse to show a minimum number of bars"],
							order = 99,
							get = function(info) return Omen.Options["Skin.Bars.Autocollapse"] end,
							set = function(info, v)
								Omen.Options["Skin.Bars.Autocollapse"] = v
								if Omen.Options["Show"] then
									Omen.Anchor:Show()
								end
								if v then
									Omen.Anchor:SetHeight(Omen.Title:GetHeight() + Omen.ModuleList:GetHeight())
								else
									Omen.Anchor:SetHeight(Omen.Title:GetHeight() + Omen.ModuleList:GetHeight() + Omen.Options["Skin.Bars.NumBars"]*Omen.Options["Skin.Bars.Height"] + 4)
								end
								Omen.BarList:Show()
								Omen:UpdateDisplay()
							end,
						},
						collapseMax = {
							type = "range",
							name = L["Number of bars to show"],
							desc = L["Number of bars to show"],
							step = 1,
							bigStep = 1,
							order = 99,
							min = 1,
							max = 40,
							get = function(info) return Omen.Options["Skin.Bars.NumBars"] or 10 end,
							set = function(info, v)
								Omen.Options["Skin.Bars.NumBars"] = v
								Omen:UpdateDisplay()
							end,
							disabled = function() return not Omen.Options["Skin.Bars.Autocollapse"] end
						},	
						collapseHidesWindow = {
							type = "toggle",
							name = L["Collapse hides bar list"],
							desc = L["Let autocollapse hide the bar list if no bars are shown"],
							order = 99,
							get = function(info) return Omen.Options["Skin.Bars.Autohide"] end,
							set = function(info, v)
								Omen.Options["Skin.Bars.Autohide"] = v
								if Omen.Options["Show"] then
									Omen.Anchor:Show()
								end
								Omen.BarList:Show()
								Omen:UpdateDisplay()
							end,
							disabled = function() return not Omen.Options["Skin.Bars.Autocollapse"] end
						},
						collapseHidesAll = {
							type = "toggle",
							name = L["Collapse hides entire Omen window"],
							desc = L["Let autocollapse hide the |c00ffffffentire window|r if no bars are shown. Note: This |c00ffffffwill|r prevent you from switching modules out of combat."],
							order = 99,
							get = function(info) return Omen.Options["Skin.Bars.AutohideAll"] end,
							set = function(info, v)
								Omen.Options["Skin.Bars.AutohideAll"] = v
								if Omen.Options["Show"] then
									Omen.Anchor:Show()
								end
								Omen.BarList:Show()
								Omen:UpdateDisplay()
							end,
							disabled = function() return not Omen.Options["Skin.Bars.Autocollapse"] or not Omen.Options["Skin.Bars.Autohide"] end
						},
						bars = {
							type = "group",
							name = L["Bar options"],
							desc = L["Options which affect the style of the threat bars"],
							args = {
								texture = {
									type = "select",
									name = L["Texture"],
									desc = L["The texture that the bar will use"],
									values = textures,
									get = function(info) return GetLSMIndex("statusbar", Omen.Options["Skin.Bars.Texture"]) end,
									set = function(info, v)
										Omen.Options["Skin.Bars.Texture"] =  Media:List("statusbar")[v]
										Omen:UpdateDisplay()
									end
								},
								backgroundOpacity = {
									type = "range",
									name = L["Background opacity"],
									desc = L["Opacity of each bar's background"],
									min = 0,
									max = 1,
									step = 0.01,
									bigStep = 0.05,
									get = function(info) return Omen.Options["Skin.Bars.Background.Alpha"] end,
									set = function(info, v)
										Omen.Options["Skin.Bars.Background.Alpha"] = v
										Omen:UpdateDisplay()
									end
								},
								backgroundDarkness = {
									type = "range",
									name = L["Background darkness"],
									desc = L["Darkness of each bar's background"],
									min = 0,
									max = 1,
									step = 0.01,
									bigStep = 0.05,
									get = function(info) return Omen.Options["Skin.Bars.Background.Color"] end,
									set = function(info, v)
										Omen.Options["Skin.Bars.Background.Color"] = v
										Omen:UpdateDisplay()
									end
								},	
								animate = {
									type = "toggle",
									name = L["Animate bars"],
									desc = L["Smoothly animate bar changes"],
									get = function(info) return Omen.Options["Skin.Bars.Animate"] end,
									set = function(info, v)
										Omen.Options["Skin.Bars.Animate"] = v
										Omen:UpdateDisplay()
									end
								},
								stretch = {
									type = "toggle",
									name = L["Stretch textures"],
									desc = L["Stretch textures to fit the width of the bar"],
									get = function(info) return Omen.Options["Skin.Bars.StretchTextures"] end,
									set = function(info, v)
										Omen.Options["Skin.Bars.StretchTextures"] = v
										Omen:UpdateDisplay()
									end
								},
								height = {
									type = "range",
									name = L["Height"],
									desc = L["Height of each bar"],
									min = 5,
									max = 50,
									step = 1,
									bigStep = 1,
									get = function(info) return Omen.Options["Skin.Bars.Height"] end,
									set = function(info, v)
										Omen.Options["Skin.Bars.Height"] = v
										Omen:UpdateDisplay()
									end
								},
								spacing = {
									type = "range",
									name = L["Spacing"],
									desc = L["Spacing between each bar"],
									min = 0,
									max = 20,
									step = 1,
									bigStep = 1,
									get = function(info) return Omen.Options["Skin.Bars.Spacing"] end,
									set = function(info, v)
										Omen.Options["Skin.Bars.Spacing"] = v
										Omen:UpdateDisplay()
									end
								},
								labels = {
									type = "group",
									name = L["Labels"],
									desc = L["Configure the labels that appear on the bars"],
									args = {
										size = {
											type = "range",
											name = L["Size"],
											desc = L["Control the font size of the labels"],
											min = 4,
											max = 30,
											step = 1,
											get = function(info) return Omen.Options["Skin.Labels.Font.Size"] end,
											set = function(info, v)
												Omen.Options["Skin.Labels.Font.Size"] = v
												Omen:UpdateDisplay()
											end
										},
										font = {
											type = "select",
											name = L["Font"],
											desc = L["The font that the labels will use"],
											values = fonts,
											get = function(info) return GetLSMIndex("font", Omen.Options["Skin.Labels.Font.Font"]) end,
											set = function(info, v)
												Omen.Options["Skin.Labels.Font.Font"] = Media:List("font")[v]
												Omen:UpdateDisplay()
											end
										},
										outline = {
											type = "select",
											name = L["Outline"],
											desc = L["The outline that the labels will use"],
											values = outlines,
											get = function(info) return Omen.Options["Skin.Labels.Font.Flags"] end,
											set = function(info, v)
												Omen.Options["Skin.Labels.Font.Flags"] = v
												Omen:UpdateDisplay()
											end
										},
										color = {
											type = "color",
											name = L["Color"],
											desc = L["The color of the labels"],
											hasAlpha = true,
											get = function(info)
												local r = Omen.Options["Skin.Labels.Font.Color.r"]
												local g = Omen.Options["Skin.Labels.Font.Color.g"]
												local b = Omen.Options["Skin.Labels.Font.Color.b"]
												local a = Omen.Options["Skin.Labels.Font.Color.a"]
												return r,g,b,a
											end,
											set = function(info, r, g, b, a)
												Omen.Options["Skin.Labels.Font.Color.r"] = r
												Omen.Options["Skin.Labels.Font.Color.g"] = g
												Omen.Options["Skin.Labels.Font.Color.b"] = b
												Omen.Options["Skin.Labels.Font.Color.a"] = a
												Omen:UpdateDisplay()
											end
										}
									}
								}
							}
						}				
					}
				},
				title = {
					type = "group",
					name = L["Title window"],
					desc = L["Options that affect the appearance of the title window"],
					args = {
						voffset = {
							type = "range",
							name = L["Height"],
							desc = L["Height"],
							min = 1,
							max = 100,
							step = 1,
							bigStep = 1,
							get = function(info) return Omen.Options["Skin.Title.Height"] end,
							set = function(info, v) 
								Omen.Options["Skin.Title.Height"] = v
								Omen:UpdateDisplay()
							end
						},
						hide = {
							type = "toggle",
							name = L["Hide"],
							desc = L["Hide this frame"],
							get = function(info) return Omen.Options["Skin.Title.Hide"] end,
							set = function(info, v)
								Omen.Options["Skin.Title.Hide"] = v
								Omen:UpdateDisplay()
							end
						},
						hideVersion = {
							type = "toggle",
							name = L["Hide version"],
							desc = L["Hide the version number and out-of-date notice"],
							get = function(info) return Omen.Options["Skin.Title.HideVersion"] end,
							set = function(info, v)
								Omen.Options["Skin.Title.HideVersion"] = v
								Omen:UpdateDisplay()
							end
						},
						font = {
							type = "select",
							name = L["Font"],
							desc = L["The font that the labels will use"],
							values = fonts,
							get = function(info) return GetLSMIndex("font", Omen.Options["Skin.Title.Font"]) end,
							set = function(info, v)
								Omen.Options["Skin.Title.Font"] = Media:List("font")[v]
								Omen:UpdateDisplay()
							end
						},
					}
				}
			}
		},
		modules = {
			type = "group",
			name = L["Modules"],
			desc = L["Options for Omen's various modules"],
			args = {}
		},
		config = {
			type = "execute",
			name = L["Configure"],
			desc = L["Open the configuration dialog"],
			func = Omen.ShowConfig,
			guiHidden = true
		}
	}
}

do
	local classes = {"DRUID", "HUNTER", "MAGE", "PALADIN", "PET", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR"}
	local t = options.args.display.args.classes.args
	for _, v in ipairs(classes) do
		t[v] = {
			type = "toggle",
			name = L[v],
			desc = L[v],
			get = function(info) return Omen.Options["Classes." .. v] end,
			set = function(info, val)
				Omen.Options["Classes." .. v] = val
				Omen:UpdateDisplay()
			end
		}
	end
end


Omen.configOptions = options
LibStub("AceConfig-3.0"):RegisterOptionsTable("Omen", options, "omen")