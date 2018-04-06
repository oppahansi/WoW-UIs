local K, C, L, _ = select(2, ...):unpack()
if C.Nameplate.Enable ~= true then return end

local tonumber, pairs, select, unpack = tonumber, pairs, select, unpack
local match = string.match
local floor = math.floor
local find = string.find
local CreateFrame = CreateFrame
local UnitGUID = UnitGUID
local InCombatLockdown = InCombatLockdown
local SetCVar = SetCVar
local GetUnitName = GetUnitName
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local WorldFrame = WorldFrame

local frames, numChildren = {}, -1
local goodR, goodG, goodB = unpack(C.Nameplate.GoodColor)
local badR, badG, badB = unpack(C.Nameplate.BadColor)
local transitionR, transitionG, transitionB = unpack(C.Nameplate.NearColor)

local OVERLAY = [=[Interface\TargetingFrame\UI-TargetingFrame-Flash]=]

-- Based on dNameplates(by Dawn, editor Kkthnx)
local NamePlates = CreateFrame("Frame", nil, UIParent)
NamePlates:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
if C.Nameplate.Auras == true then
	NamePlates:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

local function Abbrev(name)
	local newname = (string.len(name) > 18) and string.gsub(name, "%s?(.[\128-\191]*)%S+%s", "%1. ") or name
	return K.ShortenString(newname, 18, false)
end

local function QueueObject(frame, object)
	frame.queue = frame.queue or {}
	frame.queue[object] = true
end

local function HideObjects(frame)
	for object in pairs(frame.queue) do
		if object:GetObjectType() == "Texture" then
			object:SetTexture("")
		elseif object:GetObjectType() == "FontString" then
			object:SetWidth(0.001)
		elseif object:GetObjectType() == "StatusBar" then
			object:SetStatusBarTexture("")
		else
			object:Hide()
		end
	end
end

-- Create a fake backdrop frame using textures
local function CreateVirtualFrame(parent, point)
	if point == nil then point = parent end

	if point.backdrop then return end
	parent.backdrop = CreateFrame("Frame", nil , parent)
	parent.backdrop:SetAllPoints()
	parent.backdrop:SetBackdrop({
		bgFile = C.Media.Blank,
		edgeFile = C.Media.Glow,
		edgeSize = 3 * K.NoScaleMult,
		insets = {top = 3 * K.NoScaleMult, left = 3 * K.NoScaleMult, bottom = 3 * K.NoScaleMult, right = 3 * K.NoScaleMult}
	})
	parent.backdrop:SetPoint("TOPLEFT", point, -3 * K.NoScaleMult, 3 * K.NoScaleMult)
	parent.backdrop:SetPoint("BOTTOMRIGHT", point, 3 * K.NoScaleMult, -3 * K.NoScaleMult)
	parent.backdrop:SetBackdropColor(.05, .05, .05, .9)
	parent.backdrop:SetBackdropBorderColor(0, 0, 0, 1)

	if parent:GetFrameLevel() - 1 > 0 then
		parent.backdrop:SetFrameLevel(parent:GetFrameLevel() - 1)
	else
		parent.backdrop:SetFrameLevel(0)
	end
end

-- Create aura icons
local function CreateAuraIcon(frame)
	local button = CreateFrame("Frame", nil, frame.hp)
	button:SetSize(C.Nameplate.AuraSize, C.Nameplate.AuraSize * 16/25)

	button.shadow = CreateFrame("Frame", nil, button)
	button.shadow:SetFrameLevel(0)
	button.shadow:SetBackdrop({
		bgFile = C.Media.Blank,
		edgeFile = C.Media.Glow,
		edgeSize = 3 * K.NoScaleMult,
		insets = {top = 3 * K.NoScaleMult, left = 3 * K.NoScaleMult, bottom = 3 * K.NoScaleMult, right = 3 * K.NoScaleMult}
	})
	button.shadow:SetPoint("TOPLEFT", button, -3 * K.NoScaleMult, 3 * K.NoScaleMult)
	button.shadow:SetPoint("BOTTOMRIGHT", button, 3 * K.NoScaleMult, -3 * K.NoScaleMult)
	button.shadow:SetBackdropColor(.05, .05, .05, .9)
	button.shadow:SetBackdropBorderColor(0, 0, 0, 1)

	button.bord = button:CreateTexture(nil, "BORDER")
	button.bord:SetTexture(0/255, 0/255, 0/255, 1)
	button.bord:SetPoint("TOPLEFT", button, "TOPLEFT", K.NoScaleMult, -K.NoScaleMult)
	button.bord:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -K.NoScaleMult, K.NoScaleMult)

	button.icon = button:CreateTexture(nil, "OVERLAY")
	button.icon:SetAllPoints(button)
	button.icon:SetTexCoord(.07, 1-.07, .23, 1-.23)

	button.text = button:CreateFontString(nil, "OVERLAY")
	button.text:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, -3)
	button.text:SetJustifyH("CENTER")
	button.text:SetFont(C.Media.Font, C.Media.Font_Size * (C.Nameplate.AuraSize / 24), C.Media.Font_Style)
	button.text:SetShadowColor(0/255, 0/255, 0/255, 1)
	button.text:SetShadowOffset((0), -(0))

	button.cd = CreateFrame("Cooldown", nil, button)
	button.cd:SetAllPoints(button)
	button.cd:SetReverse(true)

	button.count = button:CreateFontString(nil, "OVERLAY")
	button.count:SetFont(C.Media.Font, C.Media.Font_Size * (C.Nameplate.AuraSize / 24), C.Media.Font_Style)
	button.count:SetShadowOffset((0), -(0))
	button.count:SetPoint("TOPRIGHT", button, "TOPRIGHT", 0, 3)

	return button
end

-- Update an aura icon
local function UpdateAuraIcon(button, unit, index, filter)
	local _, _, icon, count, _, duration, expirationTime, _, _, _, spellID = UnitAura(unit, index, filter)

	button.icon:SetTexture(icon)
	button.cd:SetCooldown(expirationTime - duration, duration)
	button.expirationTime = expirationTime
	button.duration = duration
	button.spellID = spellID
	if count > 1 then
		button.count:SetText(count)
	else
		button.count:SetText("")
	end
	button.cd:SetScript("OnUpdate", function(self)
		if not button.cd.timer then
			self:SetScript("OnUpdate", nil)
			return
		end
		button.cd.timer.text:SetFont(C.Media.Font, C.Media.Font_Size * K.NoScaleMult, C.Media.Font_Style)
		button.cd.timer.text:SetShadowOffset((0), -(0))
	end)
	button:Show()
end

-- Filter auras on nameplate, and determine if we need to update them or not
local function OnAura(frame, unit)
	if not frame.icons or not frame.unit or not C.Nameplate.Auras then return end
	local i = 1
	for index = 1, 5 do -- Temp until I fix this to show 2 row if 5 is already shown
		if i > C.Nameplate.Width / C.Nameplate.AuraSize then return end
		local match
		local name, _, _, _, _, duration, _, caster, _, _, spellid = UnitAura(frame.unit, index, "HARMFUL")

		if K.DebuffWhiteList[name] and caster == "player" then match = true end

		if duration and match == true then
			if not frame.icons[i] then frame.icons[i] = CreateAuraIcon(frame) end
			local icon = frame.icons[i]
			if i == 1 then icon:SetPoint("RIGHT", frame.icons, "RIGHT") end
			if i ~= 1 and i <= C.Nameplate.Width / C.Nameplate.AuraSize then icon:SetPoint("RIGHT", frame.icons[i-1], "LEFT", -2, 0) end
			i = i + 1
			UpdateAuraIcon(icon, frame.unit, index, "HARMFUL")
		end
	end
	for index = i, #frame.icons do frame.icons[index]:Hide() end
end

local function CastTextUpdate(frame, curValue)
	local _, maxValue = frame:GetMinMaxValues()
	local last = frame.last and frame.last or 0
	local finish = (curValue > last) and (maxValue - curValue) or curValue

	frame.time:SetFormattedText("%.1f ", finish)
	frame.last = curValue

	if frame.shield:IsShown() then
		frame:SetStatusBarColor(217/255, 69/255, 69/255)
		frame.bg:SetTexture(217/255, 69/255, 69/255, 0.2)
	else
		frame.bg:SetTexture(217/255, 196/255, 92/255, 0.2)
	end
end

local function HealthBar_ValueChanged(frame)
	frame = frame:GetParent()
	frame.hp:SetMinMaxValues(frame.healthOriginal:GetMinMaxValues())
	frame.hp:SetValue(frame.healthOriginal:GetValue())
end

-- We need to reset everything when a nameplate it hidden
local function OnHide(frame)
	frame.hp:SetStatusBarColor(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor)
	frame.hp:SetScale(1)
	frame.overlay:Hide()
	frame.cb:Hide()
	frame.cb:SetScale(1)
	frame.unit = nil
	frame.guid = nil
	frame.isClass = nil
	frame.isFriendly = nil
	frame.hp.rcolor = nil
	frame.hp.gcolor = nil
	frame.hp.bcolor = nil
	if frame.icons then
		for _, icon in ipairs(frame.icons) do
			icon:Hide()
		end
	end
	frame:SetScript("OnUpdate", nil)
end

-- Color Nameplate
local function Colorize(frame)
	local r, g, b = frame.healthOriginal:GetStatusBarColor()
	local texcoord = {0, 0, 0, 0}
	frame.isClass = false

	for class, _ in pairs(RAID_CLASS_COLORS) do
		local r, g, b = floor(r * 100 + 0.5) / 100, floor(g * 100 + 0.5) / 100, floor(b * 100 + 0.5) / 100
		if RAID_CLASS_COLORS[class].r == r and RAID_CLASS_COLORS[class].g == g and RAID_CLASS_COLORS[class].b == b then
			frame.isClass = true
			frame.isFriendly = false
			if C.Nameplate.ClassIcons == true then
				texcoord = CLASS_BUTTONS[class]
				frame.class.Glow:Show()
				frame.class:SetTexCoord(texcoord[1], texcoord[2], texcoord[3], texcoord[4])
			end
			frame.hp.name:SetTextColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
			frame.hp:SetStatusBarColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
			frame.hp.bg:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b, 0.2)
			return class
		end
	end

	frame.isTapped = false

	if (r + g + b) == 1.59 then
		r, g, b = 153/255, 153/255, 153/255
		frame.isFriendly = false
		frame.isTapped = true
	elseif g + b == 0 then
		r, g, b = 217/255, 69/255, 69/255
		frame.isFriendly = false
	elseif r + b == 0 then
		r, g, b = 79/255, 115/255, 161/255
		frame.isFriendly = true
	elseif r + g > 1.95 then
		r, g, b = 217/255, 196/255, 92/255
		frame.isFriendly = false
	elseif r + g == 0 then
		r, g, b = 84/255, 150/255, 84/255
		frame.isFriendly = true
	else
		frame.isFriendly = false
	end

	if C.Nameplate.ClassIcons == true then
		if frame.isClass == true then
			frame.class.Glow:Show()
		else
			frame.class.Glow:Hide()
		end
		frame.class:SetTexCoord(texcoord[1], texcoord[2], texcoord[3], texcoord[4])
	end

	frame.hp:SetStatusBarColor(r, g, b)
	frame.hp.bg:SetTexture(r, g, b, 0.2)
	frame.hp.name:SetTextColor(r, g, b)
end

-- HealthBar OnShow, use this to set variables for the nameplate
local function UpdateObjects(frame)
	frame = frame:GetParent()

	-- Set scale
	while frame.hp:GetEffectiveScale() < 1 do
		frame.hp:SetScale(frame.hp:GetScale() + 0.01)
	end

	while frame.cb:GetEffectiveScale() < 1 do
		frame.cb:SetScale(frame.cb:GetScale() + 0.01)
	end

	-- Have to reposition this here so it doesnt resize after being hidden
	frame.hp:ClearAllPoints()
	frame.hp:SetSize(C.Nameplate.Width * K.NoScaleMult, C.Nameplate.Height * K.NoScaleMult)
	frame.hp:SetPoint("TOP", frame, "TOP", 0, -15)

	-- Match values
	HealthBar_ValueChanged(frame.hp)

	-- Colorize Plate
	Colorize(frame)
	frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor = frame.hp:GetStatusBarColor()

	-- Set the name text
	if C.Nameplate.NameAbbreviate == true and C.Nameplate.Auras ~= true then
		frame.hp.name:SetText(Abbrev(frame.hp.oldname:GetText()))
	else
		frame.hp.name:SetText(frame.hp.oldname:GetText())
	end

	-- Setup level text
	local level, elite, mylevel = tonumber(frame.hp.oldlevel:GetText()), frame.hp.elite:IsShown(), K.Level
	frame.hp.level:ClearAllPoints()
	if C.Nameplate.ClassIcons == true and frame.isClass == true then
		frame.hp.level:SetPoint("RIGHT", frame.hp.name, "LEFT", -2, 0)
	else
		frame.hp.level:SetPoint("RIGHT", frame.hp, "LEFT", -2, 0)
	end
	frame.hp.level:SetTextColor(frame.hp.oldlevel:GetTextColor())
	if frame.hp.boss:IsShown() then
		frame.hp.level:SetText("??")
		frame.hp.level:SetTextColor(204/255, 13/255, 0/255)
		frame.hp.level:Show()
	elseif not elite and level == mylevel then
		frame.hp.level:Hide()
	else
		frame.hp.level:SetText(level..(elite and "+" or ""))
		frame.hp.level:Show()
	end

	frame.overlay:ClearAllPoints()
	frame.overlay:SetAllPoints(frame.hp)

	HideObjects(frame)
end

-- This is where we create most "Static" objects for the nameplate
local function SkinObjects(frame, nameFrame)
	local hp, cb = frame:GetChildren()
	local threat, hpborder, cbshield, cbborder, cbicon, overlay, oldname, oldlevel, bossicon, raidicon, elite = frame:GetRegions()

	-- Health Bar
	frame.healthOriginal = hp
	hp:SetStatusBarTexture(C.Media.Texture)
	CreateVirtualFrame(hp)

	-- Create Level
	hp.level = hp:CreateFontString(nil, "OVERLAY")
	hp.level:SetFont(C.Media.Font, C.Media.Font_Size * K.NoScaleMult, C.Media.Font_Style)
	hp.level:SetShadowOffset((0), -(0))
	hp.level:SetTextColor(255/255, 255/255, 255/255)
	hp.oldlevel = oldlevel
	hp.boss = bossicon
	hp.elite = elite

	-- Create Health Text
	if C.Nameplate.HealthValue == true then
		hp.value = hp:CreateFontString(nil, "OVERLAY")
		hp.value:SetFont(C.Media.Font, C.Media.Font_Size * K.NoScaleMult - 1, C.Media.Font_Style)
		hp.value:SetShadowOffset((0), -(0))
		hp.value:SetPoint("RIGHT", hp, "RIGHT", 0, 0)
		hp.value:SetTextColor(255/255, 255/255, 255/255)
	end

	-- Create Name Text
	hp.name = hp:CreateFontString(nil, "OVERLAY")
	hp.name:SetPoint("BOTTOMLEFT", hp, "TOPLEFT", -3, 4)
	hp.name:SetPoint("BOTTOMRIGHT", hp, "TOPRIGHT", 3, 4)
	hp.name:SetFont(C.Media.Font, C.Media.Font_Size * K.NoScaleMult, C.Media.Font_Style)
	hp.name:SetShadowOffset((0), -(0))
	hp.oldname = oldname

	hp.bg = hp:CreateTexture(nil, "BORDER")
	hp.bg:SetAllPoints(hp)
	hp.bg:SetTexture(255/255, 255/255, 255/255, 0.2)

	hp:HookScript("OnShow", UpdateObjects)
	frame.hp = hp

	if not frame.threat then
		frame.threat = threat
	end

	-- Create Cast Bar
	cb:ClearAllPoints()
	cb:SetPoint("TOPRIGHT", hp, "BOTTOMRIGHT", 0, -8)
	cb:SetPoint("BOTTOMLEFT", hp, "BOTTOMLEFT", 0, -8-(C.Nameplate.Height * K.NoScaleMult))
	cb:SetStatusBarTexture(C.Media.Texture)
	CreateVirtualFrame(cb)

	cb.bg = cb:CreateTexture(nil, "BORDER")
	cb.bg:SetAllPoints(cb)
	cb.bg:SetTexture(217/255, 196/255, 92/255, 0.2)

	-- Create Cast Time Text
	cb.time = cb:CreateFontString(nil, "ARTWORK")
	cb.time:SetPoint("RIGHT", cb, "RIGHT", 3, 0)
	cb.time:SetFont(C.Media.Font, C.Media.Font_Size * K.NoScaleMult, C.Media.Font_Style)
	cb.time:SetShadowOffset((0), -(0))
	cb.time:SetTextColor(255/255, 255/255, 255/255)

	-- Create Cast Name Text
	cb.name = cb:CreateFontString(nil, "ARTWORK")
	if C.Nameplate.CastBarName == true then
		cb.name:SetPoint("LEFT", cb, "LEFT", 3, 0)
		cb.name:SetFont(C.Media.Font, C.Media.Font_Size * K.NoScaleMult, C.Media.Font_Style)
		cb.name:SetShadowOffset((0), -(0))
		cb.name:SetTextColor(255/255, 255/255, 255/255)
	end

	-- Create Class Icon
	if C.Nameplate.ClassIcons == true then
		local cIconTex = hp:CreateTexture(nil, "OVERLAY")
		cIconTex:SetPoint("TOPRIGHT", hp, "TOPLEFT", -8, K.NoScaleMult * 2)
		cIconTex:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
		cIconTex:SetSize((C.Nameplate.Height * 2 * K.NoScaleMult) + 11, (C.Nameplate.Height * 2 * K.NoScaleMult) + 11)
		frame.class = cIconTex

		frame.class.Glow = CreateFrame("Frame", nil, frame)
		frame.class.Glow:SetBackdrop({
			bgFile = C.Media.Blank,
			edgeFile = C.Media.Glow,
			edgeSize = 3 * K.NoScaleMult,
			insets = {
				top = 3 * K.NoScaleMult, left = 3 * K.NoScaleMult, bottom = 3 * K.NoScaleMult, right = 3 * K.NoScaleMult
			}
		})
		frame.class.Glow:SetPoint("TOPLEFT", frame.class, -3 * K.NoScaleMult, 3 * K.NoScaleMult)
		frame.class.Glow:SetPoint("BOTTOMRIGHT", frame.class, 3 * K.NoScaleMult, -3 * K.NoScaleMult)
		frame.class.Glow:SetBackdropColor(.05, .05, .05, .9)
		frame.class.Glow:SetBackdropBorderColor(0, 0, 0, 1)
		frame.class.Glow:SetScale(K.NoScaleMult)
		frame.class.Glow:SetFrameLevel(hp:GetFrameLevel() -1 > 0 and hp:GetFrameLevel() -1 or 0)
		frame.class.Glow:Hide()
	end

	-- Create CastBar Icon
	cbicon:ClearAllPoints()
	cbicon:SetPoint("TOPLEFT", hp, "TOPRIGHT", 8, 0)
	cbicon:SetSize((C.Nameplate.Height * 2 * K.NoScaleMult) + 8, (C.Nameplate.Height * 2 * K.NoScaleMult) + 8)
	cbicon:SetTexCoord(unpack(K.TexCoords))
	cbicon:SetDrawLayer("OVERLAY")
	cb.icon = cbicon
	CreateVirtualFrame(cb, cb.icon)

	cb.shield = cbshield
	cb:HookScript("OnValueChanged", CastTextUpdate)
	frame.cb = cb

	-- Aura tracking
	if C.Nameplate.Auras == true then
		if not frame.icons then
			frame.icons = CreateFrame("Frame", nil, frame.hp)
			frame.icons:SetPoint("BOTTOMRIGHT", frame.hp, "TOPRIGHT", 0, C.Media.Font_Size + 5)
			frame.icons:SetSize(20 + C.Nameplate.Width, C.Nameplate.AuraSize)
			frame.icons:SetFrameLevel(frame.hp:GetFrameLevel() + 2)
			frame:RegisterEvent("UNIT_AURA")
			frame:HookScript("OnEvent", OnAura)
		end
	end

	-- Highlight texture
	if not frame.overlay then
		overlay:SetTexture(255/255, 255/255, 255/255, 0.15)
		overlay:SetAllPoints(frame.hp)
		frame.overlay = overlay
	end

	-- Raid icon
	if not frame.raidicon then
		raidicon:ClearAllPoints()
		raidicon:SetPoint("BOTTOM", hp, "TOP", 0, C.Nameplate.Auras == true and 38 or 16)
		raidicon:SetSize((C.Nameplate.Height * 2) + 8, (C.Nameplate.Height * 2) + 8)
		frame.raidicon = raidicon
	end

	-- Hide Old Stuff
	QueueObject(frame, oldlevel)
	QueueObject(frame, threat)
	QueueObject(frame, hpborder)
	QueueObject(frame, cbshield)
	QueueObject(frame, cbborder)
	QueueObject(frame, oldname)
	QueueObject(frame, bossicon)
	QueueObject(frame, elite)

	UpdateObjects(hp)

	--frame.hp:HookScript("OnShow", UpdateObjects)
	frame:HookScript("OnHide", OnHide)
	frames[frame] = true
end

local function UpdateThreat(frame, elapsed)
	Colorize(frame)

	if frame.isClass then return end

	if C.Nameplate.EnhanceThreat ~= true then

	else

		if not frame.threat:IsShown() then
			if InCombatLockdown() and frame.isFriendly ~= true then
				-- No Threat
				if K.Role == "Tank" then
					frame.hp:SetStatusBarColor(badR, badG, badB)
					frame.hp.bg:SetTexture(badR, badG, badB, 0.2)
				else
					frame.hp:SetStatusBarColor(goodR, goodG, goodB)
					frame.hp.bg:SetTexture(goodR, goodG, goodB, 0.2)
				end
			end
		else
			-- Ok we either have threat or we"re losing/gaining it
			local r, g, b = frame.threat:GetVertexColor()
			if g + b == 0 then
				-- Have Threat
				if K.Role == "Tank" then
					frame.hp:SetStatusBarColor(goodR, goodG, goodB)
					frame.hp.bg:SetTexture(goodR, goodG, goodB, 0.2)
				else
					frame.hp:SetStatusBarColor(badR, badG, badB)
					frame.hp.bg:SetTexture(badR, badG, badB, 0.2)
				end
			else
				-- Losing/Gaining Threat
				frame.hp:SetStatusBarColor(transitionR, transitionG, transitionB)
				frame.hp.bg:SetTexture(transitionR, transitionG, transitionB, 0.2)
			end
		end
	end
end

-- Create our blacklist for nameplates
local function CheckBlacklist(frame, ...)
	if C.Nameplate.NameAbbreviate == true then return end
	if K.PlateBlacklist[frame.hp.name:GetText()] then
		frame:SetScript("OnUpdate", function() end)
		frame.hp:SetAlpha(0)
		frame.cb:Hide()
		frame.overlay:Hide()
		frame.hp.oldlevel:Hide()
		frame.hide = true
	elseif frame.hide then
		frame.hp:SetAlpha(1)
		frame.hide = false
	end
end

-- Force the name text of a nameplate to be behind other nameplates unless it is our target
local function AdjustNameLevel(frame, ...)
	if GetUnitName("target") == frame.hp.name:GetText() and frame:GetParent():GetAlpha() == 1 then
		frame.hp.name:SetDrawLayer("OVERLAY")
	else
		frame.hp.name:SetDrawLayer("BORDER")
	end
end

-- Health Text, also border coloring for certain plates depending on health
local function ShowHealth(frame, ...)
	-- Match values
	HealthBar_ValueChanged(frame.hp)

	-- Show current health value
	local _, maxHealth = frame.healthOriginal:GetMinMaxValues()
	local valueHealth = frame.healthOriginal:GetValue()
	local percent = (valueHealth / maxHealth) * 100

	if C.Nameplate.HealthValue == true then
		frame.hp.value:SetFormattedText(K.ShortValue(valueHealth).." - ".."%d%%", percent)
	end

	if GetUnitName("target") and frame:GetParent():GetAlpha() == 1 then
		frame.hp:SetSize((C.Nameplate.Width + C.Nameplate.AdditionalWidth) * K.NoScaleMult, (C.Nameplate.Height + C.Nameplate.AdditionalHeight) * K.NoScaleMult)
		frame.cb:SetPoint("BOTTOMLEFT", frame.hp, "BOTTOMLEFT", 0, -8-((C.Nameplate.Height + C.Nameplate.AdditionalHeight) * K.NoScaleMult))
		frame.cb.icon:SetSize(((C.Nameplate.Height + C.Nameplate.AdditionalHeight) * 2 * K.NoScaleMult) + 8, ((C.Nameplate.Height + C.Nameplate.AdditionalHeight) * 2 * K.NoScaleMult) + 8)
	else
		frame.hp:SetSize(C.Nameplate.Width * K.NoScaleMult, C.Nameplate.Height * K.NoScaleMult)
		frame.cb:SetPoint("BOTTOMLEFT", frame.hp, "BOTTOMLEFT", 0, -8-(C.Nameplate.Height * K.NoScaleMult))
		frame.cb.icon:SetSize((C.Nameplate.Height * 2 * K.NoScaleMult) + 8, (C.Nameplate.Height * 2 * K.NoScaleMult) + 8)
	end
end

-- Scan all visible nameplate for a known unit
local function CheckUnit_Guid(frame, ...)
	if UnitExists("target") and frame:GetAlpha() == 1 and GetUnitName("target") == frame.hp.name:GetText() then
		frame.guid = UnitGUID("target")
		frame.unit = "target"
		OnAura(frame, "target")
	elseif frame.overlay:IsShown() and UnitExists("mouseover") and GetUnitName("mouseover") == frame.hp.name:GetText() then
		frame.guid = UnitGUID("mouseover")
		frame.unit = "mouseover"
		OnAura(frame, "mouseover")
	else
		frame.unit = nil
	end
end

-- Attempt to match a nameplate with a GUID from the combat log
local function MatchGUID(frame, destGUID, spellID)
	if not frame.guid then return end

	if frame.guid == destGUID then
		for _, icon in ipairs(frame.icons) do
			if icon.spellID == spellID then
				icon:Hide()
			end
		end
	end
end

-- Run a function for all visible nameplates, we use this for the blacklist, to check unitguid, and to hide drunken text
local function ForEachPlate(functionToRun, ...)
	for frame in pairs(frames) do
		if frame:IsShown() then
			functionToRun(frame, ...)
		end
	end
end

-- Check if the frames default overlay texture matches blizzards nameplates default overlay texture
local select = select
local function HookFrames(...)
	for index = 1, select("#", ...) do
		local frame = select(index, ...)
		local region = frame:GetRegions()

		if (not frames[frame] and not (frame:GetName() and frame:GetName():find("NamePlate%d")) and region and region:GetObjectType() == "Texture" and region:GetTexture() == OVERLAY) then
			SkinObjects(frame)
			frame.region = region
		end
	end
end


-- Core right here, scan for any possible nameplate frames that are Children of the WorldFrame
NamePlates:SetScript("OnUpdate", function(self, elapsed)
	if WorldFrame:GetNumChildren() ~= numChildren then
		numChildren = WorldFrame:GetNumChildren()
		HookFrames(WorldFrame:GetChildren())
	end

	if self.elapsed and self.elapsed > 0.2 then
		ForEachPlate(UpdateThreat, self.elapsed)
		ForEachPlate(AdjustNameLevel)
		self.elapsed = 0
	else
		self.elapsed = (self.elapsed or 0) + elapsed
	end

	ForEachPlate(ShowHealth)
	ForEachPlate(CheckBlacklist)
	if C.Nameplate.Auras then
		ForEachPlate(CheckUnit_Guid)
	end
end)

function NamePlates:COMBAT_LOG_EVENT_UNFILTERED(_, event, ...)
	if event == "SPELL_AURA_REMOVED" then
		local _, sourceGUID, _, _, _, destGUID, _, _, _, spellID = ...

		if sourceGUID == UnitGUID("player") or arg4 == UnitGUID("pet") then
			ForEachPlate(MatchGUID, destGUID, spellID)
		end
	end
end

-- Only show nameplates when in combat
if C.Nameplate.Combat == true then
	NamePlates:RegisterEvent("PLAYER_REGEN_ENABLED")
	NamePlates:RegisterEvent("PLAYER_REGEN_DISABLED")

	function NamePlates:PLAYER_REGEN_ENABLED()
		SetCVar("nameplateShowEnemies", 0)
	end

	function NamePlates:PLAYER_REGEN_DISABLED()
		SetCVar("nameplateShowEnemies", 1)
	end
end

NamePlates:RegisterEvent("PLAYER_ENTERING_WORLD")
function NamePlates:PLAYER_ENTERING_WORLD()
	if C.Nameplate.Combat == true then
		if InCombatLockdown() then
			SetCVar("nameplateShowEnemies", 1)
		else
			SetCVar("nameplateShowEnemies", 0)
		end
	end
end