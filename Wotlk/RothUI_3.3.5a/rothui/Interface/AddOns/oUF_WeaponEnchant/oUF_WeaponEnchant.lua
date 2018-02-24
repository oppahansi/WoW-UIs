--[[	
	Elements handled: .Enchant
	
	Options:
	 - spacing: Padding between enchant icons. (Default: 0)
	 - size: Size of the enchant icons. (Default: 16)
	 - initialAnchor: Initial anchor in the enchant frame. (Default: "BOTTOMLEFT")
	 - growth-x: Growth direction, affected by initialAnchor. (Default: "UP")
	 - growth-y: Growth direction, affected by initialAnchor. (Default: "RIGHT")
	 - showCharges: Shows a count of the remaining charges. (Default: false)
			I'm actually not sure if any weapon enchants still have charges, but it's there just in case.
	 - showCD: Shows the duration using a cooldown animation. (Default: false)
	 - showBlizzard: Setting this prevents Blizzard's temp enchant frame from being hidden. (Default: false)
	 
	Variables set on each icon:
	 - expTime: Expiration time of this weapon enchant. Substract GetTime() to get remaining duration.
	 
	Functions that can be overridden from within a layout:
	 :PostCreateEnchantIcon(button, icons)
	 :PostUpdateEnchantIcons(icons)
]]

-- Allow embedding and what not.
local parent = debugstack():match[[\AddOns\(.-)\]]
local global = GetAddOnMetadata(parent, 'X-oUF')
local oUF = _G[global] or oUF
assert(oUF, 'oUF not loaded')

-- Set playerGUID after PEW.
local playerGUID
local pending
local frame = CreateFrame("Frame")
frame.elapsed = 0
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event) playerGUID = UnitGUID("player") self:UnregisterEvent(event) end)

local OnEnter = function(self)
	if(not self:IsVisible()) then return end

	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
	GameTooltip:SetInventoryItem("player", self.slot)
	GameTooltip:Show()
end

local OnLeave = function()
	GameTooltip:Hide()
end

local OnClick = function(self, button)
	if button == "RightButton" then
		CancelItemTempEnchantment(self.slot == 16 and 1 or 2)
	end
end

local function CreateIcon(self, icons)
	local button = CreateFrame("Frame", nil, icons)
	button:EnableMouse()
	
	button:SetWidth(icons.size or 16)
	button:SetHeight(icons.size or 16)
	
	local cd = CreateFrame("Cooldown", nil, button)
	cd:SetAllPoints(button)

	local icon = button:CreateTexture(nil, "BACKGROUND")
	icon:SetAllPoints(button)

	local count = button:CreateFontString(nil, "OVERLAY")
	count:SetFontObject(NumberFontNormal)
	count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -1, 0)
	
	local overlay = button:CreateTexture(nil, "OVERLAY")
	overlay:SetTexture"Interface\\Buttons\\UI-Debuff-Overlays"
	overlay:SetAllPoints(button)
	overlay:SetTexCoord(.296875, .5703125, 0, .515625)
		
	table.insert(icons, button)
	
	button.overlay = overlay
	button.frame = self
	button.icon = icon
	button.count = count
	button.cd = cd
	
	button:SetScript("OnEnter", OnEnter)
	button:SetScript("OnLeave", OnLeave)
	button:SetScript("OnMouseUp", OnClick)

	if(self.PostCreateEnchantIcon) then self:PostCreateEnchantIcon(button, icons) end

	return button
end

local function SetIconPosition(self, icons)
	local col = 0
	local row = 0
	local spacing = icons.spacing or 0
	local size = (icons.size or 16) + spacing
	local anchor = icons.initialAnchor or "TOPLEFT"
	local growthx = (icons["growth-x"] == "LEFT" and -1) or 1
	local growthy = (icons["growth-y"] == "DOWN" and -1) or 1
	local cols = math.floor(icons:GetWidth() / size + .5)
	local rows = math.floor(icons:GetHeight() / size + .5)
	
	local icon = icons[1]
	icons[1]:SetPoint(anchor, icons, anchor, 0,0)
	if icon:IsShown() then
		col = col + 1
		if(col >= cols) then
			col = 0
			row = row + 1
		end
		icons[2]:SetPoint(anchor, icons, anchor, col * growthx * size, row * growthy * size)
	else
		icons[2]:SetPoint(icon:GetPoint())
	end
end

local function UpdateIcons(self)
	local icons = self.Enchant
	
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo();
	local now = GetTime()
	
	local icon = icons[1] or CreateIcon(self, icons)
	if hasMainHandEnchant then
		icon.icon:SetTexture(GetInventoryItemTexture("player", 16))
		
		icon.expTime = mainHandExpiration
		if mainHandExpiration then
			icon.expTime = now+mainHandExpiration/1000
			
			if icons.showCD then
				icon.cd:SetCooldown(now, mainHandExpiration)
			end
		end
		
		if icons.showCharges and mainHandCharges then
			icon.count:SetText(mainHandCharges)
		end
		
		icon.slot = 16
		icon:Show()
	else
		icon:Hide()
	end
	
	icon = icons[2] or CreateIcon(self, icons)
	if hasOffHandEnchant then
		icon.icon:SetTexture(GetInventoryItemTexture("player", 17))
		
		icon.expTime = offHandExpiration
		if offHandExpiration then
			icon.expTime = now+offHandExpiration/1000
			
			if icons.showCD then
				icon.cd:SetCooldown(now, offHandExpiration)
			end
		end
		
		if icons.showCharges and offHandCharges then
			icon.count:SetText(offHandCharges)
		end
		
		icon.slot = 17
		icon:Show()
	else
		icon:Hide()
	end
	
	SetIconPosition(self, icons)
	
	if self.PostUpdateEnchantIcons then self:PostUpdateEnchantIcons(icons) end
end

-- Work around the annoying delay between casting and GetWeaponEnchantInfo's information being updated.
frame:SetScript("OnUpdate", function(self, elapsed)
	if pending then
		self.elapsed = self.elapsed + elapsed
		if self.elapsed > 1 then
			UpdateIcons(pending)
			self.elapsed = 0
			pending = nil
		end
	end
end)

local function CLEU(self, event, timestamp, subevent, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
	if subevent:sub(1,7) ~= "ENCHANT" or destGUID ~= playerGUID then
		return
	end
	if subevent:sub(9) == "REMOVED" then
		return UpdateIcons(self)
	end

	pending = self
end

local Enable = function(self)
	if(self.Enchant and self.unit == "player") then
		if not self.showBlizzard then
			TemporaryEnchantFrame:Hide()
		end

		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", CLEU)
		self:RegisterEvent("UNIT_INVENTORY_CHANGED", UpdateIcons)
		UpdateIcons(self)
		return true
	end
end

local Disable = function(self)
	if(self.Enchant) then
		self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", CLEU)
		self:UnregisterEvent("UNIT_INVENTORY_CHANGED", UpdateIcons)
	end
end

oUF:AddElement('WeaponEnchant', UpdateIcons, Enable, Disable)