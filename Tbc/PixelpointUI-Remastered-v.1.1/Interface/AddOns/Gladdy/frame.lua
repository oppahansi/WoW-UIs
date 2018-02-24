local tonumber = tonumber
local pairs = pairs

local CreateFrame = CreateFrame
local UIParent = UIParent
local InCombatLockdown = InCombatLockdown

local Gladdy = LibStub("Gladdy")
local L = Gladdy.L

Gladdy.BUTTON_DEFAULTS = {
    name = "",
    guid = "",
    raceLoc = "",
    classLoc = "",
    class = "",
    health = "",
    healthMax = 0,
    power = 0,
    powerMax = 0,
    powerType = 0,
    spec = "",
    spells = {},
    ns = false,
    nf = false,
    pom = false,
    fd = false,
    damaged = 0,
    click = false,
}

function Gladdy:CreateFrame()
    self.frame = CreateFrame("Frame", "GladdyFrame", UIParent)
    self.frame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16})
    self.frame:SetClampedToScreen(true)
    self.frame:EnableMouse(true)
    self.frame:SetMovable(true)
    self.frame:RegisterForDrag("LeftButton")
    self.frame:SetScript("OnDragStart", function(f)
        if (not InCombatLockdown() and not self.db.locked) then
            f:StartMoving()
        end
    end)
    self.frame:SetScript("OnDragStop", function(f)
        if (not InCombatLockdown()) then
            f:StopMovingOrSizing()

            local scale = f:GetEffectiveScale()
            self.db.x = f:GetLeft() * scale
            self.db.y = (self.db.growUp and f:GetBottom() or f:GetTop()) * scale
        end
    end)

    self.anchor = CreateFrame("Button", "GladdyAnchor", self.frame)
    self.anchor:SetHeight(20)
    self.anchor:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16})
    self.anchor:SetBackdropColor(0, 0, 0, 1)
    self.anchor:SetClampedToScreen(true)
    self.anchor:EnableMouse(true)
    self.anchor:SetMovable(true)
    self.anchor:RegisterForDrag("LeftButton")
    self.anchor:RegisterForClicks("RightButtonUp")
    self.anchor:SetScript("OnDragStart", function()
        if (not InCombatLockdown() and not self.db.locked) then
            self.frame:StartMoving()
        end
    end)
    self.anchor:SetScript("OnDragStop", function()
        if (not InCombatLockdown()) then
            self.frame:StopMovingOrSizing()

            local scale = self.frame:GetEffectiveScale()
            self.db.x = self.frame:GetLeft() * scale
            self.db.y = (self.db.growUp and self.frame:GetBottom() or self.frame:GetTop()) * scale
        end
    end)
    self.anchor:SetScript("OnClick", function()
        if (not InCombatLockdown()) then
            self:ShowOptions()
        end
    end)

    self.anchor.text = self.anchor:CreateFontString("GladdyAnchorText", "ARTWORK", "GameFontHighlightSmall")
    self.anchor.text:SetText(L["Gladdy - drag to move"])
    self.anchor.text:SetPoint("CENTER")

    self.anchor.button = CreateFrame("Button", "GladdyAnchorButton", self.anchor, "UIPanelCloseButton")
    self.anchor.button:SetWidth(20)
    self.anchor.button:SetHeight(20)
    self.anchor.button:SetPoint("RIGHT", self.anchor, "RIGHT", 2, 0)
    self.anchor.button:SetScript("OnClick", function(_, _, down)
        if (not down) then
            self.db.locked = true
            self:UpdateFrame()
        end
    end)

    if (self.db.locked) then
        self.anchor:Hide()
    end

    self.frame:Hide()
end

function Gladdy:UpdateFrame()
    local teamSize = self.curBracket or 5

    local iconSize = self.db.healthBarHeight
    local margin = self.db.bottomMargin
    local width = self.db.barWidth + self.db.padding * 2 + 5
    local height = self.db.healthBarHeight * teamSize + margin * (teamSize - 1) + self.db.padding * 2 + 5
    local extraBarWidth = 0
    local extraBarHeight = 0

    -- Powerbar
    iconSize = iconSize + self.db.powerBarHeight
    margin = margin + self.db.powerBarHeight
    height = height + self.db.powerBarHeight * teamSize
    extraBarHeight = extraBarHeight + self.db.powerBarHeight

    -- Castbar
    margin = margin + self.db.castBarHeight
    height = height + self.db.castBarHeight * teamSize
    extraBarHeight = extraBarHeight + self.db.castBarHeight

    -- Classicon
    width = width + iconSize
    extraBarWidth = extraBarWidth + iconSize

    -- Trinket
    width = width + iconSize

    self.frame:SetScale(self.db.frameScale)
    self.frame:SetWidth(width)
    self.frame:SetHeight(height)
    self.frame:SetBackdropColor(self.db.frameColor.r, self.db.frameColor.g, self.db.frameColor.b, self.db.frameColor.a)
    self.frame:ClearAllPoints()
    if (self.db.x == 0 and self.db.y == 0) then
        self.frame:SetPoint("CENTER")
    else
        local scale = self.frame:GetEffectiveScale()
        if (self.db.growUp) then
            self.frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", self.db.x / scale, self.db.y / scale)
        else
            self.frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", self.db.x / scale, self.db.y / scale)
        end
    end

    self.anchor:SetWidth(width)
    self.anchor:ClearAllPoints()
    if (self.db.growUp) then
        self.anchor:SetPoint("TOPLEFT", self.frame, "BOTTOMLEFT")
    else
        self.anchor:SetPoint("BOTTOMLEFT", self.frame, "TOPLEFT")
    end

    if (self.db.locked) then
        self.anchor:Hide()
    else
        self.anchor:Show()
    end

    for i = 1, teamSize do
        local button = self.buttons["arena" .. i]

        button:SetWidth(self.db.barWidth + extraBarWidth)
        button:SetHeight(self.db.healthBarHeight)
        button.secure:SetWidth(self.db.barWidth + extraBarWidth)
        button.secure:SetHeight(self.db.healthBarHeight + extraBarHeight)

        button:ClearAllPoints()
        button.secure:ClearAllPoints()
        if (self.db.growUp) then
            if (i == 1) then
                button:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", self.db.padding + 2, self.db.padding + extraBarHeight)
                button.secure:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", self.db.padding + 2, self.db.padding)
            else
                button:SetPoint("BOTTOMLEFT", self.buttons["arena" .. (i - 1)], "TOPLEFT", 0, margin)
                button.secure:SetPoint("BOTTOMLEFT", self.buttons["arena" .. (i - 1)], "TOPLEFT", 0, margin - extraBarHeight)
            end
        else
            if (i == 1) then
                button:SetPoint("TOPLEFT", self.frame, "TOPLEFT", self.db.padding + 2, -self.db.padding)
                button.secure:SetPoint("TOPLEFT", self.frame, "TOPLEFT", self.db.padding + 2, -self.db.padding)
            else
                button:SetPoint("TOPLEFT", self.buttons["arena" .. (i - 1)], "BOTTOMLEFT", 0, -margin)
                button.secure:SetPoint("TOPLEFT", self.buttons["arena" .. (i - 1)], "BOTTOMLEFT", 0, -margin)
            end
        end

        for k, v in self:IterModules() do
            self:Call(v, "UpdateFrame", button.unit)
        end
    end
end

function Gladdy:HideFrame()
    if (self.frame) then
        self.frame:Hide()
    end

    self:UnregisterAllEvents()
    self:CancelAllTimers()
    self:UnregisterAllComm()

    self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

function Gladdy:ToggleFrame(i)
    self:Reset()

    if (self.frame and self.frame:IsShown() and i == self.curBracket) then
        self:HideFrame()
    else
        self:UnregisterAllEvents()
        self.curBracket = i

        if (not self.frame) then
            self:CreateFrame()
        end

        self:Test()
        self:UpdateFrame()
        self.frame:Show()
    end
end

function Gladdy:CreateButton(i)
    if (not self.frame) then
        self:CreateFrame()
    end

    local button = CreateFrame("Frame", "GladdyButtonFrame" .. i, self.frame)
    button:SetAlpha(0)

    local secure = CreateFrame("Button", "GladdyButton" .. i, button, "SecureActionButtonTemplate")
    secure:RegisterForClicks("AnyUp")
    secure:SetAttribute("*type*", "macro")

    button.id = i
    button.unit = "arena" .. i
    button.secure = secure

    for k, v in pairs(self.BUTTON_DEFAULTS) do
        button[k] = v
    end

    self.buttons[button.unit] = button

    for k, v in self:IterModules() do
        self:Call(v, "CreateFrame", button.unit)
    end
end