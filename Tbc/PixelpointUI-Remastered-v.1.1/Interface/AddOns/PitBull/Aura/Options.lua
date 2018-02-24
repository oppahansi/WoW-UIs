if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 63495 $"):match("%d+"))

local PitBull = PitBull
local PitBull_Aura = PitBull:GetModule("Aura")
local self = PitBull_Aura
PitBull:ProvideVersion("$Revision: 63495 $", "$Date: 2008-03-03 19:02:08 -0500 (Mon, 03 Mar 2008) $")

local L = PitBull:L("PitBull-Aura")

local newDict, unpackDictAndDel = Rock:GetRecyclingFunctions("PitBull", "newDict", "unpackDictAndDel")

local _G = _G
local next = _G.next
local pairs = _G.pairs
local unpack = _G.unpack
local select = _G.select

local allFriendlyBuffs, allFriendlyDebuffs, enemyDebuffs, totalAuraFrames
_G.table.insert(PitBull_Aura.OnInitialize_funcs, function()
	allFriendlyBuffs = PitBull_Aura.allFriendlyBuffs
	allFriendlyDebuffs = PitBull_Aura.allFriendlyDebuffs
	enemyDebuffs = PitBull_Aura.enemyDebuffs
	totalAuraFrames = PitBull_Aura.totalAuraFrames
end)

local function updategroup(group)
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull_Aura:OnClearUnitFrame(unit, frame)
		PitBull_Aura:OnPopulateUnitFrame(unit, frame)
		PitBull_Aura:OnUpdateFrame(unit, frame)
		PitBull:UpdateLayout(frame)
	end
end

local function value_get(group, key)
	return PitBull_Aura.db.profile[group][key]
end

local function value_set(group, key, value)
	if PitBull_Aura.db.profile[group][key] == value then
		return
	end
	PitBull_Aura.db.profile[group][key] = value
	updategroup(group)
end

local function allOrBuffHidden_get(group)
	return PitBull_Aura.db.profile[group].hidden or PitBull_Aura.db.profile[group]["hiddenBuffs"]
end
local function allOrDebuffHidden_get(group)
	return PitBull_Aura.db.profile[group].hidden or PitBull_Aura.db.profile[group]["hiddenDebuffs"]
end

local function hidden_get(group)
	return PitBull_Aura.db.profile[group].hidden
end

local function multiHidden_get(group, type)
	return PitBull_Aura.db.profile[group]["hidden"..type]
end

local function multiEnabled_get(group, type)
	return not PitBull_Aura.db.profile[group]["hidden"..type]
end

local function multiEnabled_set(group, type, value)
	value = not value
	PitBull_Aura.db.profile[group]["hidden"..type] = value
	if PitBull_Aura.db.profile[group].hiddenBuffs and PitBull_Aura.db.profile[group].hiddenDebuffs then
		PitBull_Aura.db.profile[group].hidden = true
	else
		PitBull_Aura.db.profile[group].hidden = false
	end
	updategroup(group)
end

local function border_get(group, type)
	return PitBull_Aura.db.profile[group].border[type]
end

local function border_set(group, type, value)
	PitBull_Aura.db.profile[group].border[type] = value
	updategroup(group)
end

local function typeBorder_get(group, type)
	return PitBull_Aura.db.profile[group].borderType[type]
end

local function typeBorder_set(group, type, value)
	PitBull_Aura.db.profile[group].borderType[type] = value
	updategroup(group)
end

local function grow_get(group)
	local d = PitBull_Aura.db.profile[group].grow
	if d == 1 then
		return "Up"
	elseif d == -1 then
		return "Down"
	end
end

local function grow_set(group, value)
	if grow_get(group) == value then
		return
	end

	if value == "Up" then
		PitBull_Aura.db.profile[group].grow = 1
	elseif value == "Down" then
		PitBull_Aura.db.profile[group].grow = -1
	end

	updategroup(group)
end

local grow_choices = {
	["Up"] = L["Up"],
	["Down"] = L["Down"],
}

local function checkSplitOptionsHidden(group)
	return PitBull_Aura.db.profile[group].split
end

local function checkNonSplitOptionsHidden(group)
	return not PitBull_Aura.db.profile[group].split
end

local function frameWidth_get(group, kind)
	return PitBull_Aura.db.profile[group][kind]
end
local function frameWidth_set(group, kind, value)
	PitBull_Aura.db.profile[group][kind] = value
	
	updategroup(group)
end
local function frameWidth_hidden(group)
	if PitBull_Aura.db.profile[group].split then
		return false
	end
	local side = PitBull_Aura.db.profile[group].auraSide
	if side == "top" or side == "bottom" then
		return true
	end
end

local function auraOffset_get(group, kind)
	return PitBull_Aura.db.profile[group][kind]
end
local function auraOffset_set(group, kind, value)
	PitBull_Aura.db.profile[group][kind] = value

	updategroup(group)
end

local function auraSide_get(group, key)
	return PitBull_Aura.db.profile[group][key]
end

local function auraSide_set(group, key, value)
	PitBull_Aura.db.profile[group][key] = value

	updategroup(group)
end


local auraSide_choices = {
	left = L["Left"],
	topleft = L["Top-left"],
	bottomleft = L["Bottom-left"],
	right = L["Right"],
	topright = L["Top-right"],
	bottomright = L["Bottom-right"],
	top = L["Top"],
	bottom = L["Bottom"],
}

local buffDirection_choices = {
	["Up then Left"] = L["Up then Left"],
	["Up then Right"] = L["Up then Right"],
	["Down then Left"] = L["Down then Left"],
	["Down then Right"] = L["Down then Right"],
	["Left then Up"] = L["Left then Up"],
	["Left then Down"] = L["Left then Down"],
	["Right then Up"] = L["Right then Up"],
	["Right then Down"] = L["Right then Down"],
}

local frameHighlight_choices = {
	["Never"] = L["Never"],
	["All Debuffs"] = L["All Debuffs"],
	["Cureable"] = L["Cureable"],
	["Cureable by me"] = L["Cureable by me"],
}

local frameHighlightStyle_choices = {
	border = L["Border"],
	thinborder = L["Thin Border"],
	normal = L["Normal"],
}

PitBull_Aura:RegisterPitBullOptionsMethod(function(group)
	local options = {
		type = "group",
		name = L["Auras"],
		desc = L["Options for buff and debuff display for this unit type."],
		args = {
			snap = {
				type = "boolean",
				name = L["Snap"],
				desc = L["Resize auras to fill the available row space."],
				get = value_get,
				set = value_set,
				passValue = group,
				passValue2 = 'snap',
				disabled = hidden_get,
			},
			sort = {
				type = "boolean",
				name = L["Sort"],
				desc = L["Sort this unit's debuffs by type then alphabetically."],
				get = value_get,
				set = value_set,
				passValue = group,
				passValue2 = 'sort',
				disabled = hidden_get,
			},
			enable = {
				type = "group",
				name = L["Enable"],
				desc = L["Enable buffs or debuffs."],
				args = {
					buffs = {
						type = "boolean",
						name = L["Buffs"],
						desc = L["Enable buffs."],
						get = multiEnabled_get,
						set = multiEnabled_set,
						passValue = group,
						passValue2 = "Buffs",
					},
					debuffs = {
						type = "boolean",
						name = L["Debuffs"],
						desc = L["Enable debuffs."],
						get = multiEnabled_get,
						set = multiEnabled_set,
						passValue = group,
						passValue2 = "Debuffs",
					}
				},
				order = 1,
			},
			borders = {
				type = "group",
				name = L["Borders"],
				desc = L["Options for aura icon borders."],
				disabled = hidden_get,
				passValue = group,
				args = {
					buffs = {
						type = "boolean",
						name = L["Buffs"],
						desc = L["Enable colored buff borders"],
						get = border_get,
						set = border_set,
						passValue = group,
						passValue2 = "Buffs",
						disabled = multiHidden_get,
					},
					buffsType = {
						type = "boolean",
						name = L["Buff types"],
						desc = L["Color buff borders by buff type."],
						get = typeBorder_get,
						set = typeBorder_set,
						passValue = group,
						passValue2 = "Buffs",
						disabled = function(group, type) return (not border_get(group, type) or multiHidden_get(group, type) or allOrBuffHidden_get(group, type)) end,
					},
					debuffs = {
						type = "boolean",
						name = L["Debuffs"],
						desc = L["Enable colored debuff borders"],
						get = border_get,
						set = border_set,
						passValue = group,
						passValue2 = "Debuffs",
						disabled = multiHidden_get,
					},
					debuffsType = {
						type = "boolean",
						name = L["Debuff types"],
						desc = L["Color debuff borders by debuff type."],
						get = typeBorder_get,
						set = typeBorder_set,
						passValue = group,
						passValue2 = "Debuffs",
						disabled = function(group, type) return (not border_get(group, type) or multiHidden_get(group, type) or allOrDebuffHidden_get(group, type)) end,
					},
				}
			},
			frameHighlight = {
				type = "choice",
				name = L["Frame debuff highlight"],
				desc = L["Highlighting the unit frame itself when the unit is debuffed."],
				choices = frameHighlight_choices,
				get = value_get,
				set = value_set,
				passValue = group,
				passValue2 = 'frameHighlight',
			},
			frameHighlightStyle = {
				type = "choice",
				name = L["Frame debuff highlight style"],
				desc = L["Set how the frame debuff highlight looks."],
				choices = frameHighlightStyle_choices,
				get = value_get,
				set = value_set,
				passValue = group,
				passValue2 = 'highlightStyle',
			},
			buffFilter = {
				type = "boolean",
				name = L["Enable buff filtering"],
				desc = L["Filter certain buffs based on your class."],
				get = value_get,
				set = value_set,
				passValue = group,
				passValue2 = 'buffFilter',
				disabled = hidden_get,
			},
			debuffFilter = {
				type = "boolean",
				name = L["Enable debuff filtering"],
				desc = L["Filter certain debuffs based on your class."],
				get = value_get,
				set = value_set,
				passValue = group,
				passValue2 = 'debuffFilter',
				disabled = hidden_get,
			},
			debuffsize = {
				type = "number",
				name = L["Debuff size"],
				desc = L["Set size of debuff icons."],
				get = value_get,
				set = value_set,
				passValue = group,
				passValue2 = 'debuffsize',
				min = 4,
				max = 48,
				step = 1,
				disabled = allOrDebuffHidden_get,
			},
			buffsize = {
				type = "number",
				name = L["Buff size"],
				desc = L["Set size of buff icons."],
				get = value_get,
				set = value_set,
				passValue = group,
				passValue2 = 'buffsize',
				min = 4,
				max = 48,
				step = 1,
				disabled = allOrBuffHidden_get,
			},
			buffSpacing = {
				type = "number",
				name = L["Buff spacing"],
				desc = L["Set horizontal spacing between each buff."],
				get = value_get,
				set = value_set,
				passValue = group,
				passValue2 = 'buffSpacing',
				min = 0,
				max = 10,
				step = 1,
				disabled = allOrBuffHidden_get,
			},
			maxbuffs = {
				type = "number",
				name = L["Max buffs"],
				desc = L["Set the maximum number of buffs to display."],
				get = value_get,
				set = value_set,
				passValue = group,
				passValue2 = 'maxbuffs',
				min = 0,
				max = 40,
				step = 1,
				disabled = allOrBuffHidden_get,
			},
			maxdebuffs = {
				type = "number",
				name = L["Max debuffs"],
				desc = L["Set the maximum number of debuffs to display."],
				get = value_get,
				set = value_set,
				passValue = group,
				passValue2 = 'maxdebuffs',
				min = 0,
				max = 40,
				step = 1,
				disabled = allOrDebuffHidden_get,
			},
			layout = {
				type = "group",
				name = L["Layout"],
				desc = L["Options for where to place aura frames"],
				disabled = hidden_get,
				passValue = group,
				args = {
					split = {
						type = "boolean",
						name = L["Split"],
						desc = L["Split buff and debuff positions."],
						get = value_get,
						set = value_set,
						passValue = group,
						passValue2 = 'split',
						disabled = hidden_get,
					},
					side = {
						name = L["Side"],
						desc = L["Which side to position all aura icons at."],
						type = "choice",
						choices = auraSide_choices,
						get = auraSide_get,
						set = auraSide_set,
						passValue = group,
						passValue2 = 'auraSide',
						hidden = checkSplitOptionsHidden,
						disabled = function(group)
							for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
								if frame.auraContainer then
									return false
								end
							end	
							return true
						end,
					},
					-- options when in split mode
					buffDirection = {
						type = "choice",
						name = L["Buff growth direction"],
						desc = L["Set the direction in which buffs grow."],
						get = value_get,
						set = value_set,
						passValue = group,
						passValue2 = 'buffdirection',
						choices = buffDirection_choices,
						hidden = checkNonSplitOptionsHidden,
						disabled = allOrBuffHidden_get,
					},
					debuffDirection = {
						type = "choice",
						name = L["Debuff growth direction"],
						desc = L["Set the direction in which debuffs grow."],
						get = value_get,
						set = value_set,
						passValue = group,
						passValue2 = 'debuffdirection',
						choices = buffDirection_choices,
						hidden = checkNonSplitOptionsHidden,
						disabled = allOrDebuffHidden_get,
					},
					buffside = {
						name = L["Buff side"],
						desc = L["Which side to position buff icons at."],
						type = "choice",
						choices = auraSide_choices,
						get = auraSide_get,
						set = auraSide_set,
						passValue = group,
						passValue2 = 'buffSide',
						hidden = checkNonSplitOptionsHidden,
					},
					debuffside = {
						name = L["Debuff side"],
						desc = L["Which side to position debuff icons at."],
						type = "choice",
						choices = auraSide_choices,
						get = auraSide_get,
						set = auraSide_set,
						passValue = group,
						passValue2 = 'debuffSide',
						hidden = checkNonSplitOptionsHidden,
					},
					frameWidth = {
						type = "number",
						name = L["Buff frame width"],
						desc = L["The width of the buff frame."],
						min = 50,
						max = 500,
						step = 10,
						get = frameWidth_get,
						set = frameWidth_set,
						passValue = group,
						passValue2 = 'frameWidth',
						hidden = frameWidth_hidden,
						disabled = allOrBuffHidden_get,
					},
					frame2Width = {
						type = "number",
						name = L["Debuff frame width"],
						desc = L["The width of the debuff frame in split mode."],
						min = 50,
						max = 500,
						step = 10,
						get = frameWidth_get,
						set = frameWidth_set,
						passValue = group,
						passValue2 = 'frame2Width',
						hidden = checkNonSplitOptionsHidden,
						disabled = allOrDebuffHidden_get,
					},
					-- options when not in split mode
					flip = {
						type = "boolean",
						name = L["Flip buffs/debuffs"],
						desc = L["Flip the positions of buffs and debuffs."],
						get = value_get,
						set = value_set,
						passValue = group,
						passValue2 = 'flip',
						hidden = checkSplitOptionsHidden,
					},
					nvert = {
						type = "boolean",
						name = L["Invert debuff direction"],
						desc = L["Invert the direction of debuffs."],
						get = value_get,
						set = value_set,
						passValue = group,
						passValue2 = 'invert',
						hidden = checkSplitOptionsHidden,
						disabled = allOrDebuffHidden_get,
					},
					grow = {
						type = "choice",
						name = L["Growth direction"],
						desc = L["Set the growth direction for extra rows of buffs and debuffs."],
						get = grow_get,
						set = grow_set,
						passValue = group,
						choices = grow_choices,
						hidden = checkSplitOptionsHidden,
					},
				},
			},
			offsets = {
				type = "group",
				name = L["Offsets"],
				desc = L["Aura frame offsets."],
				disabled = hidden_get,
				passValue = group,
				args = {
					auraLeft = {
						type = "number",
						name = L["Buff horizontal offset"],
						desc = L["Buff horizontal offset"],
						min = -200,
						max = 200,
						step = 1,
						bigStep = 5,
						get = auraOffset_get,
						set = auraOffset_set,
						passValue = group,
						passValue2 = 'auraOffsetX',
						disabled = allOrBuffHidden_get,
					},
					auraTop = {
						type = "number",
						name = L["Buff vertical offset"],
						desc = L["Buff vertical offset"],
						min = -200,
						max = 200,
						step = 1,
						bigStep = 5,
						get = auraOffset_get,
						set = auraOffset_set,
						passValue = group,
						passValue2 = 'auraOffsetY',
						disabled = allOrBuffHidden_get,
					},
					aura2Left = {
						type = "number",
						name = L["Debuff horizontal offset"],
						desc = L["Debuff horizontal offset"],
						min = -200,
						max = 200,
						step = 1,
						bigStep = 5,
						get = auraOffset_get,
						set = auraOffset_set,
						passValue = group,
						passValue2 = 'aura2OffsetX',
						hidden = checkNonSplitOptionsHidden,
						disabled = allOrDebuffHidden_get,
					},
					aura2Top = {
						type = "number",
						name = L["Debuff vertical offset"],
						desc = L["Debuff vertical offset"],
						min = -200,
						max = 200,
						step = 1,
						bigStep = 5,
						get = auraOffset_get,
						set = auraOffset_set,
						passValue = group,
						passValue2 = 'aura2OffsetY',
						hidden = checkNonSplitOptionsHidden,
						disabled = allOrDebuffHidden_get,
					},
				},
			},
			fontSize = {
				type = 'number',
				name = L["Font Size"],
				desc = L["Font size used for duration text and aura stack counter."],
				min = 8,
				max = 20,
				step = 1,
				passValue = group,
				passValue2 = 'fontSize',
				get = value_get,
				set = value_set,
			},
		}
	}
    
	-- weapon buffs are only for the player
	if group == "player" then
		options.args.enable.args.WeaponBuffs = {
			type = "boolean",
			name = L["Weapon Buffs"],
			desc = L["Enable weapon buffs."],
			get = multiEnabled_get,
			set = multiEnabled_set,
			passValue = group,
			passValue2 = "WeaponBuffs",
			disabled = function() return not multiEnabled_get(group, "Buffs") end,
		}
	end
    
    return options
end)

local function UpdateAllAuras()
	for unit, frame in PitBull:IterateUnitFrames() do
		PitBull_Aura:UpdateAuras(unit, frame)
	end
end

local function highlightColor_get(type, type2)
	return unpack(type2 and PitBull_Aura.db.profile.colors[type][type2] or PitBull_Aura.db.profile.colors[type])
end

local function highlightColor_set(type, type2, r, g, b, a)
	if type2 then
		PitBull_Aura.db.profile.colors[type][type2] = {r, g, b, a}
	else
		PitBull_Aura.db.profile.colors[type] = {r, g, b, a}
	end
	UpdateAllAuras()
end

-- Global settings
PitBull:RegisterGlobalSetting("Aura", function()
	return "@cache", {
		type = 'group',
		name = L["Aura"],
		desc = L["Aura options for all units."],
		args = {
			cooldown = {
				type = 'boolean',
				name = L["Cooldown spiral"],
				desc = L["Toggle whether the cooldown spiral shows."],
				get = function()
					return PitBull_Aura.db.profile.cooldown
				end,
				set = function(value)
					PitBull_Aura.db.profile.cooldown = value
					UpdateAllAuras()
				end,
			},
			cooldownText = {
				type = 'group',
				name = L["Cooldown text"],
				desc = L["Options for the cooldown text display."],
				args = {
					toggle = {
						type = 'boolean',
						name = L["Toggle"],
						desc = L["Toggle whether to show the cooldown text."],
						get = function()
							return PitBull_Aura.db.profile.cooldownText
						end,
						set = function(value)
							PitBull_Aura.db.profile.cooldownText = value
							UpdateAllAuras()
						end,
					},
					color = {
						type = 'color',
						name = L["Color"],
						desc = L["Color of the cooldown text (including opacity)."],
						hasAlpha = true,
						get = function()
							return unpack(PitBull_Aura.db.profile.cooldownTextColor)
						end,
						set = function(...)
							local t = PitBull_Aura.db.profile.cooldownTextColor
							for i = 1, 4 do 
								t[i] = select(i, ...) or 1
							end
							for frame in pairs(totalAuraFrames) do
								frame.cooldownText:SetTextColor(unpack(t))
							end
						end,
					},
				}
			},
			zoomAura = {
				type = 'boolean',
				name = L["Zoom textures"],
				desc = L["Zoom in on aura icons slightly."],
				get = function()
					return PitBull_Aura.db.profile.zoomAura
				end,
				set = function(value)
					PitBull_Aura.db.profile.zoomAura = value
				
					for frame in pairs(totalAuraFrames) do
						if value then
							frame.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
						else
							frame.icon:SetTexCoord(0, 1, 0, 1)
						end
					end
				end,
			},
			WeaponBuffSpellIcon = {
				type = "boolean",
				name = L["Use Weapon Buff Spell Icon"],
				desc = L["Display weapon buffs using the spell icon rather than the weapon's icon."],
				get = function()
					return PitBull_Aura.db.profile.weaponBuffSpellIcon
				end,
				set = function(value)
					PitBull_Aura.db.profile.weaponBuffSpellIcon = value
					UpdateAllAuras()
				end,
			},
			colors = {
				type = "group",
				name = L["Border Colors"],
				desc = L["Set the border colors for the various aura types."],
				args = {
					buffs = {
						type = "group",
						name = L["Buffs"],
						desc = L["Set the border colors for the various buff types."],
						args = {
							Own = {
								type = "color",
								name = L["Own"],
								desc = L["Set the color for buffs that you cast."],
								hasAlpha = true,
								get = highlightColor_get,
								set = highlightColor_set,
								passValue = "buffs",
								passValue2 = "Own",
							},
							Other = {
								type = "color",
								name = L["Other"],
								desc = L["Set the color for buffs cast by others."],
								hasAlpha = true,
								get = highlightColor_get,
								set = highlightColor_set,
								passValue = "buffs",
								passValue2 = "nil",
							},
							Weapon = {
								type = "color",
								name = L["Weapon"],
								desc = L["Set the color for weapon buffs."],
								hasAlpha = true,
								get = highlightColor_get,
								set = highlightColor_set,
								passValue = "buffs",
								passValue2 = "Weapon",
								disabled = function()
									return PitBull_Aura.db.profile.colors.weaponBuffItemQuality
								end,
							},
							ItemQualityColor = {
								type = "boolean",
								name = L["Use Weapon Item Quality"],
								desc = L["Weapon buff borders will be colored by weapon quality."],
								get = function()
									return PitBull_Aura.db.profile.colors.weaponBuffItemQuality
								end,
								set = function(value)
									PitBull_Aura.db.profile.colors.weaponBuffItemQuality = value
									UpdateAllAuras()
								end,
							},
						},
					},
					Debuffs = {
						type = "group",
						name = L["Debuffs"],
						desc = L["Set the border colors for the various debuff types."],
						args = {
							Curse = {
								type = "color",
								name = L["Curse"],
								desc = L["Set color for curses."],
								hasAlpha = true,
								get = highlightColor_get,
								set = highlightColor_set,
								passValue = "debuffs",
								passValue2 = "Curse",
							},
							Poison = {
								type = "color",
								name = L["Poison"],
								desc = L["Set color for poisons."],
								hasAlpha = true,
								get = highlightColor_get,
								set = highlightColor_set,
								passValue = "debuffs",
								passValue2 = "Poison",
							},
							Magic = {
								type = "color",
								name = L["Magic"],
								desc = L["Set color for magic."],
								hasAlpha = true,
								get = highlightColor_get,
								set = highlightColor_set,
								passValue = "debuffs",
								passValue2 = "Magic",
							},
							Disease = {
								type = "color",
								name = L["Disease"],
								desc = L["Set color for diseases."],
								hasAlpha = true,
								get = highlightColor_get,
								set = highlightColor_set,
								passValue = "debuffs",
								passValue2 = "Disease",
							},
							Other = {
								type = "color",
								name = L["Other"],
								desc = L["Set color for others."],
								hasAlpha = true,
								get = highlightColor_get,
								set = highlightColor_set,
								passValue = "debuffs",
								passValue2 = "nil",
							}
						}
					}
				}
			},
			buffFilter = {
				type = "multichoice",
				name = L["Friend buff filtering"],
				desc = L["Select buffs to be filtered for friends and yourself."],
				choices = function()
					local t = newDict()
					for k in pairs(allFriendlyBuffs) do
						t[k] = k
					end
					return "@dict", unpackDictAndDel(t)
				end,
				get = function(key)
					return PitBull_Aura.db.profile.filter.buffs[key]
				end,
				set = function(key, value)
					PitBull_Aura.db.profile.filter.buffs[key] = value

					for unit, frame in PitBull:IterateUnitFrames() do
						PitBull_Aura:OnUpdateFrame(unit, frame)
					end
				end,
				order = 150,
			},
			extraBuffFilter = {
				type = "multichoice",
				name = L["Extra friend buffs"],
				desc = L["Additional buffs that will be shown on friends and yourself."],
				choices = function()
					local t = newDict()
					for k in pairs(PitBull_Aura.db.profile.filter.extraBuffs) do
						t[k] = k
					end
					return "@dict", unpackDictAndDel(t)
				end,
				get = function(key)
					return PitBull_Aura.db.profile.filter.extraBuffs[key]
				end,
				set = function(key, value)
					PitBull_Aura.db.profile.filter.extraBuffs[key] = value

					for unit, frame in PitBull:IterateUnitFrames() do
						PitBull_Aura:OnUpdateFrame(unit, frame)
					end
				end,
				disabled = function()
					return not next(PitBull_Aura.db.profile.filter.extraBuffs)
				end,
				order = 151,
			},
			addBuff = {
				type = 'string',
				name = L["Add extra friend buff"],
				desc = L["Add a buff to show on friends that is not listed."],
				get = false,
				set = function(value)
					PitBull_Aura.db.profile.filter.extraBuffs[value] = true
					
					for unit, frame in PitBull:IterateUnitFrames() do
						PitBull_Aura:OnUpdateFrame(unit, frame)
					end
				end,
				usage = L["<Buff name>"],
				order = 152,
			},
			enemyDebuffFilter = {
				type = "multichoice",
				name = L["Enemy debuff filtering"],
				desc = L["Select debuffs to be filtered for enemies."],
				choices = function()
					local t = newDict()
					for k in pairs(enemyDebuffs) do
						t[k] = k
					end
					return "@dict", unpackDictAndDel(t)
				end,
				get = function(key)
					return PitBull_Aura.db.profile.filter.enemyDebuffs[key]
				end,
				set = function(key, value)
					PitBull_Aura.db.profile.filter.enemyDebuffs[key] = value

					for unit, frame in PitBull:IterateUnitFrames() do
						PitBull_Aura:OnUpdateFrame(unit, frame)
					end
				end,
				order = 153,
			},
			extraEnemyDebuffFilter = {
				type = "multichoice",
				name = L["Extra enemy debuffs"],
				desc = L["Additional debuffs that will be shown on enemies."],
				choices = function()
					local t = newDict()
					for k in pairs(PitBull_Aura.db.profile.filter.extraEnemyDebuffs) do
						t[k] = k
					end
					return "@dict", unpackDictAndDel(t)
				end,
				get = function(key)
					return PitBull_Aura.db.profile.filter.extraEnemyDebuffs[key]
				end,
				set = function(key, value)
					PitBull_Aura.db.profile.filter.extraEnemyDebuffs[key] = value

					for unit, frame in PitBull:IterateUnitFrames() do
						PitBull_Aura:OnUpdateFrame(unit, frame)
					end
				end,
				disabled = function()
					return not next(PitBull_Aura.db.profile.filter.extraEnemyDebuffs)
				end,
				order = 154,
			},
			addEnemyDebuff = {
				type = 'string',
				name = L["Add extra enemy debuff"],
				desc = L["Add a debuff to show on enemies that is not listed."],
				get = false,
				set = function(value)
					PitBull_Aura.db.profile.filter.extraEnemyDebuffs[value] = true

					for unit, frame in PitBull:IterateUnitFrames() do
						PitBull_Aura:OnUpdateFrame(unit, frame)
					end
				end,
				usage = L["<Debuff name>"],
				order = 155,
			},
			friendDebuffFilter = {
				type = "multichoice",
				name = L["Friend debuff filtering"],
				desc = L["Select debuffs to be filtered for friends."],
				choices = function()
					local t = newDict()
					for k in pairs(allFriendlyDebuffs) do
						t[k] = k
					end
					return "@dict", unpackDictAndDel(t)
				end,
				get = function(key)
					return PitBull_Aura.db.profile.filter.friendDebuffs[key]
				end,
				set = function(key, value)
					PitBull_Aura.db.profile.filter.friendDebuffs[key] = value

					for unit, frame in PitBull:IterateUnitFrames() do
						PitBull_Aura:OnUpdateFrame(unit, frame)
					end
				end,
				order = 156,
			},
			extraFriendDebuffFilter = {
				type = "multichoice",
				name = L["Extra friend debuffs"],
				desc = L["Additional debuffs that will be shown on friends and yourself."],
				choices = function()
					local t = newDict()
					for k in pairs(PitBull_Aura.db.profile.filter.extraFriendDebuffs) do
						t[k] = k
					end
					return "@dict", unpackDictAndDel(t)
				end,
				get = function(key)
					return PitBull_Aura.db.profile.filter.extraFriendDebuffs[key]
				end,
				set = function(key, value)
					PitBull_Aura.db.profile.filter.extraFriendDebuffs[key] = value

					for unit, frame in PitBull:IterateUnitFrames() do
						PitBull_Aura:OnUpdateFrame(unit, frame)
					end
				end,
				disabled = function()
					return not next(PitBull_Aura.db.profile.filter.extraFriendDebuffs)
				end,
				order = 157,
			},
			addFriendDebuff = {
				type = 'string',
				name = L["Add extra friend debuff"],
				desc = L["Add a debuff to show on friends that is not listed."],
				get = false,
				set = function(value)
					PitBull_Aura.db.profile.filter.extraFriendDebuffs[value] = true

					for unit, frame in PitBull:IterateUnitFrames() do
						PitBull_Aura:OnUpdateFrame(unit, frame)
					end
				end,
				usage = L["<Debuff name>"],
				order = 158,
			},
		},
	}
end)

