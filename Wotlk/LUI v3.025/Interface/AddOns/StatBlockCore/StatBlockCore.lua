
-----------------------------------------------------------------
--       StatBlockCore, a core for informational blocks        --
-----------------------------------------------------------------

local SBC = _G.CreateFrame("Frame", "StatBlockCore")
local L = _G.LibStub("AceLocale-3.0"):GetLocale("StatBlockCore", true)

local ldb = _G.LibStub("LibDataBroker-1.1")
local media = _G.LibStub("LibSharedMedia-3.0")
local pairs = _G.pairs
local SBC_display = {}
local db

------------------------------
--         Config           --
------------------------------

local options
local function getOptions()
	if not options then
		options = {
			name = "StatBlockCore",
			childGroups = "tab", type = "group",
			args = {
				general = {
					name = _G["GENERAL"],
					order = 1, type = "group",
					args = {
						header = {
							name = L["A core for your informational blocks"],
							order = 1, type = "header",
						},
						launchers = {
							name = L["Create AddOn QuickLaunchers"],
							order = 2, type = "toggle", width = "full",
							get = function() return db.launchers end,
							set = function(_, state)
								db.launchers = state
								for name, obj in ldb:DataObjectIterator() do
									if obj.type == "launcher" then
										local block = _G["StatBlockCore_"..name]
										if block and state then
											block:Show()
											db.plugins[name].enabled = true
										elseif not block and state then
											SBC:New(nil, name, obj)
										elseif block and not state then
											block:Hide()
											db.plugins[name].enabled = nil
										end
									end
								end
							end,
						},
						iconpos = {
							name = _G["EMBLEM_SYMBOL"], --Icon
							order = 3, type = "select", width = "full",
							values = {LEFT = L["LEFT"], RIGHT = L["RIGHT"]},
							get = function() return db.iconPos end,
							set = function(_, pos) db.iconPos = pos
								for name in ldb:DataObjectIterator() do
									local blockIcon = _G["StatBlockCoreIcon_"..name]
									if blockIcon then
										blockIcon:ClearAllPoints()
										blockIcon:SetPoint(pos, _G["StatBlockCore_"..name])
										SBC_display[name]:ClearAllPoints()
										SBC_display[name]:SetPoint(pos, blockIcon,
											pos == "LEFT" and "RIGHT" or "LEFT"
										)
										SBC_display[name]:SetWidth(db.plugins[name].width - 20)
									end
								end
							end,
						},
						globalalpha = {
							name = L["Global Backdrop Alpha"],
							order = 4, type = "range", width = "full",
							min = 0, max = 1, step = 0.01,
							get = function() return db.globalAlpha end,
							set = function(_, a)
								db.globalAlpha = a
								for name in ldb:DataObjectIterator() do
									local block = _G["StatBlockCore_"..name]
									if block then
										block:SetBackdropColor(db.globalBDC.r,db.globalBDC.g,db.globalBDC.b,a)
									end
								end
							end,
						},
						globalbgcolor = {
							name = L["Global Backdrop Color"],
							order = 5, type = "color", width = "full",
							get = function() return db.globalBDC.r, db.globalBDC.g, db.globalBDC.b end,
							set = function(_, r, g, b)
								db.globalBDC.r = r db.globalBDC.g = g db.globalBDC.b = b
								for name in ldb:DataObjectIterator() do
									local block = _G["StatBlockCore_"..name]
									if block then
										block:SetBackdropColor(r,g,b)
									end
								end
							end,
						},
						globallock = {
							name = L["Global Lock"],
							order = 6, type = "toggle", width = "full",
							get = function() return db.globalLock end,
							set = function(_, state)
								db.globalLock = state
								for name in ldb:DataObjectIterator() do
									local block = _G["StatBlockCore_"..name]
									if block then
										db.plugins[name].lock = state
										local l
										if not state then l = true else l = false end
										block:SetMovable(l)
										block:EnableMouseWheel(l)
									end
								end
							end,
						},
						globalscale = {
							name = L["Global Scale"],
							order = 7, type = "range", width = "full",
							min = 0.5, max = 2, step = 0.01,
							get = function() return db.globalScale end,
							set = function(_, scale)
								db.globalScale = scale
								for name in ldb:DataObjectIterator() do
									local block = _G["StatBlockCore_"..name]
									if block then
										db.plugins[name].scale = scale
										block:SetScale(scale)
									end
								end
							end,
						},
						globalhiddenalpha = {
							name = L["Global Object Alpha"],
							order = 8, type = "range", width = "full",
							min = 0, max = 1, step = 0.01,
							get = function() return db.globalHiddenAlpha end,
							set = function(_, a)
								db.globalHiddenAlpha = a
								for name in ldb:DataObjectIterator() do
									local block = _G["StatBlockCore_"..name]
									if block then
										db.plugins[name].hiddenAlpha = a
										block:SetAlpha(a)
									end
								end
							end,
						},
						globalshownalpha = {
							name = L["Global MouseOver Alpha"],
							order = 9, type = "range", width = "full",
							min = 0, max = 1, step = 0.01,
							get = function() return db.globalShownAlpha end,
							set = function(_, a)
								db.globalShownAlpha = a
								for name in ldb:DataObjectIterator() do
									local block = _G["StatBlockCore_"..name]
									if block then
										db.plugins[name].shownAlpha = a
									end
								end
							end,
						},
					},
				},
				font = {
					name = L["Global Font"],
					order = 2, type = "group",
					args = {
						globalvaluecolor = {
							name = L["Global Value Color"],
							order = 1, type = "color", width = "full",
							get = function() return db.globalColor.r, db.globalColor.g, db.globalColor.b end,
							set = function(_, r, g, b)
								db.globalColor.r = r db.globalColor.g = g db.globalColor.b = b
								for k,v in pairs(SBC_display) do
									db.plugins[k].color.r = r db.plugins[k].color.g = g db.plugins[k].color.b = b
									v:SetTextColor(r,g,b)
								end
							end,
						},
						classvalue = {
							name = L["Class Color Value"],
							order = 2, type = "execute",
							func = function()
								local c = _G["RAID_CLASS_COLORS"][select(2, UnitClass("player"))]
								db.globalColor.r = c.r db.globalColor.g = c.g db.globalColor.b = c.b
								for k,v in pairs(SBC_display) do
									db.plugins[k].color.r = c.r db.plugins[k].color.g = c.g db.plugins[k].color.b = c.b
									v:SetTextColor(c.r,c.g,c.b)
								end
							end,
						},
						globallabelcolor = {
							name = L["Global Label Color"],
							order = 3, type = "color", width = "full",
							get = function() return db.globalLabelColor.r, db.globalLabelColor.g, db.globalLabelColor.b end,
							set = function(_, r, g, b)
								db.globalLabelColor.r = r db.globalLabelColor.g = g db.globalLabelColor.b = b
								local c = ("%02x%02x%02x"):format(r*255, g*255, b*255)
								for name, obj in ldb:DataObjectIterator() do
									if _G["StatBlockCore_"..name] and obj.suffix then
										db.plugins[name].labelc = c
										db.plugins[name].labelColor.r = r db.plugins[name].labelColor.g = g db.plugins[name].labelColor.b = b
										SBC:ValueUpdate(nil, name, nil, obj.value, obj)
									end
								end
							end,
						},
						classlabel = {
							name = L["Class Color Label"],
							order = 4, type = "execute",
							func = function()
								local c = _G["RAID_CLASS_COLORS"][select(2, UnitClass("player"))]
								db.globalLabelColor.r = c.r db.globalLabelColor.g = c.g db.globalLabelColor.b = c.b
								local ch = ("%02x%02x%02x"):format(c.r*255, c.g*255, c.b*255)
								for name, obj in ldb:DataObjectIterator() do
									if _G["StatBlockCore_"..name] and obj.suffix then
										db.plugins[name].labelc = ch
										db.plugins[name].labelColor.r = c.r db.plugins[name].labelColor.g = c.g db.plugins[name].labelColor.b = c.b
										SBC:ValueUpdate(nil, name, nil, obj.value, obj)
									end
								end
							end,
						},
						globalfont = {
							name = L["Global Font"],
							order = 5, type = "select", width = "full",
							values = media:List("font"),
							get = function()
								for k,v in pairs(media:List("font")) do
									if db.globalFont == v then
										return k
									end
								end
							end,
							set = function(_, newfont)
								db.globalFont = media:List("font")[newfont]
								local font = media:Fetch("font", db.globalFont)
								for _,v in pairs(SBC_display) do
									v:SetFont(font, db.globalSize, db.outline)
								end
							end,
						},
						globalsize = {
							name = _G["FONT_SIZE"],
							order = 6, type = "range", width = "full",
							min = 1, max = 48, step = 1,
							get = function() return db.globalSize end,
							set = function(_, size)
								db.globalSize = size
								for _,v in pairs(SBC_display) do
									v:SetFont(media:Fetch("font", db.globalFont), size, db.outline)
								end
							end,
						},
						globaloutline = {
							name = L["Outline"], width = "full",
							order = 7, type = "select",
							values = {NONE = _G["NONE"], OUTLINE = L["Outline"], THICKOUTLINE = L["Thick Outline"]},
							get = function() return db.outline end,
							set = function(_, value) db.outline = value
								for _,v in pairs(SBC_display) do
									v:SetFont(media:Fetch("font", db.globalFont), db.globalSize, db.outline)
								end
							end,
						},
						globalshadow = {
							name = L["Global Font Shadow"],
							order = 8, type = "toggle",
							get = function() return db.shadow end,
							set = function(_, state) db.shadow = state
								if state then
									for _,v in pairs(SBC_display) do
										v:SetShadowColor(0, 0, 0, 1)
										v:SetShadowOffset(1, -1)
									end
								else
									for _,v in pairs(SBC_display) do
										v:SetShadowColor(0, 0, 0, 0)
										v:SetShadowOffset(0, 0)
									end
								end
							end,
						},
					},
				},
				profiles = _G.LibStub("AceDBOptions-3.0"):GetOptionsTable(SBC.db),
			},
		}
	end
	return options
end

local blockOpts = {}
local function getBlockOptions()
	local name = InterfaceOptionsFramePanelContainer.displayedPanel.name
	if not blockOpts[name] then
		local obj = ldb:GetDataObjectByName(name)
		local block = _G["StatBlockCore_"..name]
		local pDB = db.plugins[name]
		blockOpts[name] = {
			name = name,
			order = 1, type = "group",
			args = {
				enabled = {
					name = _G["ENABLE"],
					order = 5, type = "toggle", width = "half",
					get = function() return pDB.enabled end,
					set = function(_, state) pDB.enabled = state
						if not state and block then
							block:Hide()
						elseif state and block then
							block:Show()
						else
							_G.ChatFrame1:AddMessage("|cff33ff99StatBlockCore|r: ".. L["Reload UI"])
						end
					end,
				},
				lock = block and {
					name = _G["LOCK"],
					order = 10, type = "toggle", width = "half",
					get = function() return pDB.lock end,
					set = function(_, state) pDB.lock = state
						if not state then state = true else state = false end
						block:SetMovable(state)
						block:EnableMouseWheel(state)
					end,
					disabled = function() return not pDB.enabled end,
				},
				color = block and {
					name = L["Value Color"],
					order = 20, type = "color", width = "half",
					get = function() return pDB.color.r, pDB.color.g, pDB.color.b end,
					set = function(_, r, g, b) local cdb = pDB.color 
						cdb.r = r cdb.g = g cdb.b = b SBC_display[name]:SetTextColor(r,g,b)
					end,
					disabled = function() return not pDB.enabled end,
				},
				labelcolor = block and {
					name = L["Label Color"],
					order = 30, type = "color", width = "half",
					get = function() return pDB.labelColor.r, pDB.labelColor.g, pDB.labelColor.b end,
					set = function(_, r, g, b)
						local c = ("%02x%02x%02x"):format(r*255, g*255, b*255)
						pDB.labelc = c
						pDB.labelColor.r = r pDB.labelColor.g = g pDB.labelColor.b = b
						SBC:ValueUpdate(nil, name, nil, obj.value, obj)
					end,
					disabled = function() return not obj.suffix or not pDB.enabled end,
				},
				label = block and {
					name = L["Text Display"],
					order = 40, type = "input",
					get = function() return pDB.label or obj.suffix or
						(obj.type == "launcher" and obj.label) or _G["NOT_APPLICABLE"]
					end,
					set = function(_, label)
						pDB.label = label
						if obj.suffix then
							obj.suffix = label
							SBC:ValueUpdate(nil, name, nil, obj.value, obj)
						elseif obj.type == "launcher" then
							obj.label = label
							SBC:TextUpdate(nil, name, nil, obj.label)
						end
					end,
					disabled = function() return not obj.suffix and obj.type ~= "launcher" or not pDB.enabled end,
				},
				align = block and {
					name = L["Font Align"],
					order = 50, type = "select", 
					values = {LEFT = L["LEFT"], CENTER = L["CENTER"], RIGHT = L["RIGHT"]},
					get = function() return pDB.align end,
					set = function(_, e) pDB.align = e SBC_display[name]:SetJustifyH(e) end,
					disabled = function() return not pDB.enabled end,
				},
				x = block and {
					name = L["X Position"],
					order = 60, type = "input",
					get = function() return tostring(pDB.posx / block:GetEffectiveScale()) end,
					set = function(_, x) x = tonumber(x)
						local s = block:GetEffectiveScale()
						pDB.posx = x * s
						block:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, pDB.posy / s)
					end,
					disabled = function() return not pDB.enabled end,
				},
				y = block and {
					name = L["Y Position"],
					order = 70, type = "input",
					get = function() return tostring(pDB.posy / block:GetEffectiveScale()) end,
					set = function(_, y) y = tonumber(y)
						local s = block:GetEffectiveScale()
						pDB.posy = y * s
						block:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", pDB.posx / s, y)
					end,
					disabled = function() return not pDB.enabled end,
				},
				scale = block and {
					name = L["Scale"],
					order = 80, type = "range", width = "full",
					min = 0.5, max = 2, step = 0.01,
					get = function() return pDB.scale end,
					set = function(_, scale) pDB.scale = scale block:SetScale(scale) end,
					disabled = function() return not pDB.enabled end,
				},
				parent = block and {
					name = L["Parenting"],
					order = 90, type = "input",
					get = function() return pDB.parent end,
					set = function(_, p)
						if _G[p] then
							pDB.parent = p
							block:SetParent(p)
						else
							_G.ChatFrame1:AddMessage("|cff33ff99StatBlockCore|r: ".. _G["ERR_TAXINOPATH"])
						end
					end,
					disabled = function() return not pDB.enabled end,
				},
				strata = block and {
					name = L["Strata"],
					order = 100, type = "select",
					get = function() return pDB.strata end,
					set = function(_, strata) pDB.strata = strata
						block:SetFrameStrata(pDB.strata)
					end,
					values = {HIGH = _G["HIGH"], MEDIUM = _G["AUCTION_TIME_LEFT2"], LOW = _G["LOW"], BACKGROUND = _G["BACKGROUND"]},
					disabled = function() return not pDB.enabled end,
				},
				hiddenalpha = block and {
					name = _G["OBJECT_ALPHA"],
					order = 110, type = "range",
					min = 0, max = 1, step = 0.01,
					get = function() return pDB.hiddenAlpha end,
					set = function(_, a) pDB.hiddenAlpha = a block:SetAlpha(a) end,
					disabled = function() return not pDB.enabled end,
				},
				shownalpha = block and {
					name = L["MouseOver Alpha"],
					order = 120, type = "range",
					min = 0, max = 1, step = 0.01,
					get = function() return pDB.shownAlpha end,
					set = function(_, a) pDB.shownAlpha = a end,
					disabled = function() return not pDB.enabled end,
				},
				icon = block and {
					name = _G["EMBLEM_SYMBOL"], --Icon
					order = 130, type = "toggle",
					get = function() return pDB.icon end,
					set = function(_, i) pDB.icon = i
						local blockIcon = _G["StatBlockCoreIcon_"..name]
						if blockIcon then
							if i then blockIcon:Show()
								SBC_display[name]:ClearAllPoints()
								SBC_display[name]:SetPoint(db.iconPos, blockIcon,
									db.iconPos == "LEFT" and "RIGHT" or "LEFT"
								)
								SBC_display[name]:SetWidth(db.plugins[name].width - 20)
							else
								blockIcon:Hide()
								SBC_display[name]:ClearAllPoints()
								SBC_display[name]:SetPoint("CENTER", block, "CENTER")
								SBC_display[name]:SetWidth(db.plugins[name].width)
							end
						else
							blockIcon = block:CreateTexture("StatBlockCoreIcon_"..name)
							blockIcon:SetTexture(obj.icon)
							blockIcon:SetWidth(20)
							blockIcon:SetHeight(20)
							blockIcon:SetPoint(db.iconPos, block)
							SBC_display[name]:ClearAllPoints()
							SBC_display[name]:SetPoint(db.iconPos, blockIcon,
								db.iconPos == "LEFT" and "RIGHT" or "LEFT"
							)
							SBC_display[name]:SetWidth(db.plugins[name].width - 20)
						end
					end,
					disabled = function() return not obj.icon or not pDB.enabled end,
				},
				text = block and {
					name = L["Show Text"],
					order = 140, type = "toggle",
					get = function() return pDB.showtext end,
					set = function(_, state) pDB.showtext = state
						if not state then
							ldb.UnregisterCallback(SBC, "LibDataBroker_AttributeChanged_"..name.."_value")
							ldb.UnregisterCallback(SBC, "LibDataBroker_AttributeChanged_"..name.."_text")
							SBC:TextUpdate(nil, name, nil, "")
						else
							if obj.type == "launcher" then
								SBC:TextUpdate(nil, name, nil, obj.label or "")
							else
								if obj.suffix then
									SBC:ValueUpdate(nil, name, nil, obj.value or name, obj)
									ldb.RegisterCallback(SBC, "LibDataBroker_AttributeChanged_"..name.."_value", "ValueUpdate")
								else
									SBC:TextUpdate(nil, name, nil, obj.text or name)
									ldb.RegisterCallback(SBC, "LibDataBroker_AttributeChanged_"..name.."_text", "TextUpdate")
								end
							end
						end
						local s = SBC_display[name]:GetStringWidth()
						SBC_display[name]:SetWidth(s)
						block:SetWidth(s+(pDB.icon and 20 or 0))
					end,
					disabled = function() return not obj.icon or not pDB.enabled end,
				},
				tipcombat = block and {
					name = L["No Tooltip In Combat"],
					order = 150, type = "toggle",
					get = function() return pDB.notipincombat end,
					set = function(_, v) pDB.notipincombat = v end,
					disabled = function() return not pDB.enabled end,
				},
			},
		}
	end
	return blockOpts[name]
end

------------------------------
--      Main Functions      --
------------------------------

local function GetTipAnchor(frame)
	local x,y = frame:GetCenter()
	if not x or not y then return "TOPLEFT", "BOTTOMLEFT" end
	local hhalf = (x > _G.UIParent:GetWidth()*2/3) and "RIGHT" or (x < _G.UIParent:GetWidth()/3) and "LEFT" or ""
	local vhalf = (y > _G.UIParent:GetHeight()/2) and "TOP" or "BOTTOM"
	return vhalf..hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
end

SBC:RegisterEvent("ADDON_LOADED")
SBC:RegisterEvent("PLAYER_LOGIN")
SBC:SetScript("OnEvent", function(_, event, ...) SBC[event](SBC, ...) end)

function SBC:TextUpdate(_, name, _, data)
	SBC_display[name]:SetText(data)
end

local txtfmt = "%s|cff%s%s|r"
function SBC:ValueUpdate(_, name, _, data, obj)
	SBC_display[name]:SetFormattedText(txtfmt, data, db.plugins[name].labelc, obj.suffix)
end

function SBC:Icon(_, name, _, icon)
	_G["StatBlockCoreIcon_"..name]:SetTexture(icon)
end

function SBC:IconColor(_, name, _, _, obj)
	_G["StatBlockCoreIcon_"..name]:SetVertexColor(obj.iconR, obj.iconG, obj.iconB)
end

function SBC:IconCoords(_, name, _, coords)
	_G["StatBlockCoreIcon_"..name]:SetTexCoord(unpack(coords))
end

local function onDragStart(frame)
	if frame:IsMovable() then
		frame.isMoving = true
		frame:StartMoving()
		_G.GameTooltip:Hide()
	end
end

local function onDragStop(frame)
	frame:StopMovingOrSizing()
	if not IsControlKeyDown() then
		--try to stick to a screen edge, then try to stick to a bar [ Thank you Tuller <3 ]
		for name in ldb:DataObjectIterator() do
			local block = _G["StatBlockCore_"..name]
			if block and FlyPaper.Stick(frame, block, 20, 2, 2) then
				break
			end
		end
	end
	frame.isMoving = nil
	for name in ldb:DataObjectIterator() do
		local block = _G["StatBlockCore_"..name]
		if block then
			local s = block:GetEffectiveScale()
			db.plugins[name].posx = block:GetLeft() * s
			db.plugins[name].posy = block:GetTop() * s
		end
	end
end

local function onClick(frame, btn)
	if not frame.isMoving and frame.pluginObject.OnClick then
		frame.pluginObject.OnClick(frame, btn)
	end
end

local function onTooltipEnter(frame)
	local name = frame.pluginName
	frame:SetAlpha(db.plugins[name].shownAlpha)
	if db.plugins[name].notipincombat and InCombatLockdown() then return end
	local obj = frame.pluginObject
	if not frame.isMoving and obj.OnTooltipShow then
		_G.GameTooltip:SetOwner(frame, "ANCHOR_NONE")
		_G.GameTooltip:SetPoint(GetTipAnchor(frame))
		obj.OnTooltipShow(_G.GameTooltip, frame)
		_G.GameTooltip:Show()
	elseif not frame.isMoving and obj.OnEnter then
		obj.OnEnter(frame)
	end
end

local function onTooltipLeave(frame)
	local name = frame.pluginName
	local obj = frame.pluginObject
	_G.GameTooltip:Hide()
	if obj.OnLeave then obj.OnLeave(frame) end
	frame:SetAlpha(db.plugins[name].hiddenAlpha)
end

local function onMouseWheel(frame, d)
	local name = frame.pluginName
	local obj = frame.pluginObject
	if db.plugins[name].lock or (obj.secureTemplate and InCombatLockdown()) then return end
	local w = frame:GetWidth() + d
	frame:SetWidth(w) db.plugins[name].width = w
	SBC_display[name]:SetWidth(obj.icon and db.plugins[name].icon and w-20 or w)
end

local bg = {bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",}
function SBC:New(_, name, obj)
	if obj.type == "launcher" and not db.launchers then return end
	if _G.LibStub("AceConfigRegistry-3.0"):GetOptionsTable("SBC_"..name) then return end

	_G.LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("SBC_"..name, getBlockOptions)
	_G.LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SBC_"..name, name, "StatBlockCore")

	if not db.plugins[name].enabled then return end

	if obj.suffix then
		obj.suffix = db.plugins[name].label or " ".. obj.suffix
	elseif obj.type == "launcher" then
		obj.label = db.plugins[name].label or obj.label or obj.tocname or name
	end

	local newBlock = _G.CreateFrame("Button", "StatBlockCore_"..name, UIParent, obj.secureTemplate)
	newBlock.pluginName = name
	newBlock.pluginObject = obj
	newBlock:SetBackdrop(bg)
	newBlock:SetBackdropColor(db.globalBDC.r,db.globalBDC.g,db.globalBDC.b,db.globalAlpha)
	newBlock:EnableMouse(true)
	if not db.plugins[name].lock then newBlock:SetMovable(true) newBlock:EnableMouseWheel(true) end
	newBlock:SetFrameStrata(db.plugins[name].strata)
	newBlock:RegisterForDrag("LeftButton")
	newBlock:RegisterForClicks("anyUp")
	newBlock:SetScript("OnDragStart", onDragStart)
	newBlock:SetScript("OnDragStop", onDragStop)
	newBlock:SetScript("OnMouseWheel", onMouseWheel)
	newBlock:SetWidth(db.plugins[name].showtext and db.plugins[name].width or 20)
	newBlock:SetHeight(20)
	newBlock:Show()
	newBlock:SetScale(db.plugins[name].scale)
	newBlock:SetAlpha(db.plugins[name].hiddenAlpha)

	if db.plugins[name].posx == 0 and db.plugins[name].posy == 0 then
		newBlock:ClearAllPoints()
		newBlock:SetPoint("CENTER", UIParent, "CENTER", math.random(-150,150), math.random(-150,150))
	else
		local s = newBlock:GetEffectiveScale()
		newBlock:ClearAllPoints()
		newBlock:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", db.plugins[name].posx / s, db.plugins[name].posy / s)
	end
	newBlock:SetParent(_G[db.plugins[name].parent] and db.plugins[name].parent or _G.UIParent)

	SBC_display[name] = newBlock:CreateFontString("StatBlockCoreFont_"..name, "OVERLAY")
	if obj.icon and db.plugins[name].icon then
		local newIcon = newBlock:CreateTexture("StatBlockCoreIcon_"..name)
		newIcon:SetTexture(obj.icon)
		newIcon:SetWidth(20)
		newIcon:SetHeight(20)
		newIcon:SetPoint(db.iconPos, newBlock)
		if obj.iconCoords then
			newIcon:SetTexCoord(unpack(obj.iconCoords))
			ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_iconCoords", "IconCoords")
		end
		if obj.iconR then
			newIcon:SetVertexColor(obj.iconR or 1, obj.iconG or 1, obj.iconB or 1)
			ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_iconR", "IconColor")
			ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_iconG", "IconColor")
			ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_iconB", "IconColor")
		end
		ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_icon", "Icon")
		SBC_display[name]:SetPoint(db.iconPos, newIcon, db.iconPos == "LEFT" and "RIGHT" or "LEFT")
		SBC_display[name]:SetWidth(db.plugins[name].width - 20)
	else
		SBC_display[name]:SetPoint("CENTER", newBlock, "CENTER")
		SBC_display[name]:SetWidth(db.plugins[name].width)
	end
	SBC_display[name]:SetFont(media:Fetch("font", db.globalFont), db.globalSize, db.outline)

	--take master color settings for the value and apply to plugin if plugin is new (default colors)
	local c = db.plugins[name].color
	if c.r == 1 and c.g == 1 and c.b == 1 then
		c.r, c.g, c.b = db.globalColor.r, db.globalColor.g, db.globalColor.b
	end
	--take master color settings for the label and apply to plugin if plugin is new (default colors)
	local cl = db.plugins[name].labelColor
	if cl.r == 1 and cl.g == 1 and cl.b == 1 then
		cl.r, cl.g, cl.b = db.globalLabelColor.r, db.globalLabelColor.g, db.globalLabelColor.b
		db.plugins[name].labelc = ("%02x%02x%02x"):format(cl.r*255, cl.g*255, cl.b*255)
	end

	SBC_display[name]:SetTextColor(c.r, c.g, c.b)
	SBC_display[name]:SetJustifyH(db.plugins[name].align)
	if db.shadow then
		SBC_display[name]:SetShadowColor(0, 0, 0, 1)
		SBC_display[name]:SetShadowOffset(1, -1)
	end

	if db.plugins[name].showtext then
		if obj.type == "launcher" then
			self:TextUpdate(nil, name, nil, obj.label)
		else
			if obj.suffix then
				self:ValueUpdate(nil, name, nil, obj.value or name, obj)
				ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_value", "ValueUpdate")
			else
				self:TextUpdate(nil, name, nil, obj.text or name)
				ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_text", "TextUpdate")
			end
		end
	end
	newBlock:SetScript("OnEnter", onTooltipEnter)
	newBlock:SetScript("OnLeave", onTooltipLeave)
	newBlock:SetScript("OnClick", onClick)

	--Where a plugin wants a reference to the block
	if obj.OnCreate then obj.OnCreate(obj, newBlock) end
end

function SBC:ADDON_LOADED(msg)
	if msg == "StatBlockCore" then
		local defaults = {
			profile = {
				launchers = true,
				globalFont = "Friz Quadrata TT",
				globalSize = 20,
				globalScale = 1,
				globalColor = { r = 1, g = 1, b = 1 },
				globalBDC = { r = 1, g = 1, b = 1 },
				globalShownAlpha = 1,
				globalHiddenAlpha = 1,
				globalAlpha = 1,
				globalLabelColor = { r = 1, g = 1, b = 1 },
				iconPos = "LEFT",
				shadow = true,
				outline = "NONE",
				plugins = {
					["*"] = {
						color = { r = 1, g = 1, b = 1, },
						labelColor = { r = 1, g = 1, b = 1 },
						labelc = "ffffff",
						scale = 1,
						align = "CENTER",
						width = 100,
						posx = 0,
						posy = 0,
						parent = "UIParent",
						strata = "BACKGROUND",
						icon = true,
						enabled = true,
						shownAlpha = 1,
						hiddenAlpha = 1,
						showtext = true,
					},
				},
			},
		}
		self:UnregisterEvent("ADDON_LOADED")
		self.db = _G.LibStub("AceDB-3.0"):New("StatBlockCoreDB", defaults, "Default")
		db = self.db.profile

		local txt = "|cff33ff99StatBlockCore|r: "
		_G.LibStub("AceConfig-3.0"):RegisterOptionsTable("StatBlockCore", getOptions)
		_G.LibStub("AceConfigDialog-3.0"):AddToBlizOptions("StatBlockCore")
		_G.SlashCmdList["STATBLOCKCORE_MAIN"] = function()
			InterfaceOptionsFrame_OpenToCategory("StatBlockCore")
			_G.ChatFrame1:AddMessage(txt.. L["Open_Alert"])
		end
		_G.SLASH_STATBLOCKCORE_MAIN1 = "/sbc"
		_G.SLASH_STATBLOCKCORE_MAIN2 = "/statblockcore"

		local function profilePrint() _G.ChatFrame1:AddMessage(txt.. L["Reload UI"]) end
		self.db.RegisterCallback(self, "OnProfileReset", profilePrint)
		self.db.RegisterCallback(self, "OnProfileChanged", profilePrint)
		self.ADDON_LOADED = nil
	end
end

function SBC:PLAYER_LOGIN()
	self:SetScript("OnEvent", nil)
	self:UnregisterEvent("PLAYER_LOGIN")
	ldb.RegisterCallback(self, "LibDataBroker_DataObjectCreated", "New")
	for name, obj in ldb:DataObjectIterator() do
		if not _G["StatBlockCore_"..name] then
			self:New(nil, name, obj)
		end
	end
	self.PLAYER_LOGIN = nil
end

------------------------------
--         Cleanup          --
------------------------------

--[[		Only use if you don't have LoD plugins		]]--
--[[
local prev = 0
SBC:SetScript("OnUpdate", function(_, c)
	prev = prev + c
	if prev > 20 then
		SBC:SetScript("OnUpdate", nil)
		ldb.UnregisterCallback(SBC, "LibDataBroker_DataObjectCreated")
		SBC.New = nil
		SBC.Scripts = nil
		prev = nil
		for name in ldb:DataObjectIterator() do
			if _G["StatBlockCore_"..name] then
				ldb.UnregisterCallback(SBC, "LibDataBroker_AttributeChanged_"..name.."_OnClick")
				ldb.UnregisterCallback(SBC, "LibDataBroker_AttributeChanged_"..name.."_OnEnter")
				ldb.UnregisterCallback(SBC, "LibDataBroker_AttributeChanged_"..name.."_OnTooltipShow")
			end
		end
	end
end)
]]

