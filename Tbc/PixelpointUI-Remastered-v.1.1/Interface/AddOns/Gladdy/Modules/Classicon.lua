local unpack = unpack

local CLASS_BUTTONS = CLASS_BUTTONS

local Gladdy = LibStub("Gladdy")
local Classicon = Gladdy:NewModule("Classicon", 80)

function Classicon:Initialise()
    self.frames = {}

    self:RegisterMessage("ENEMY_SPOTTED")
    self:RegisterMessage("UNIT_DEATH")
end

function Classicon:CreateFrame(unit)
    local classIcon = Gladdy.buttons[unit]:CreateTexture(nil, "ARTWORK")
    classIcon:ClearAllPoints()
    classIcon:SetPoint("TOPLEFT", Gladdy.buttons[unit], "TOPLEFT", -2, 0)

    self.frames[unit] = classIcon
end

function Classicon:UpdateFrame(unit)
    local classIcon = self.frames[unit]
    if (not classIcon) then return end

    local iconSize = Gladdy.db.healthBarHeight + Gladdy.db.powerBarHeight

    classIcon:SetWidth(iconSize)
    classIcon:SetHeight(iconSize + 1)
end

function Classicon:Test(unit)
    self:ENEMY_SPOTTED(unit)
end

function Classicon:ResetUnit(unit)
    local classIcon = self.frames[unit]
    if (not classIcon) then return end

    classIcon:SetTexture("")
end

function Classicon:ENEMY_SPOTTED(unit)
    local classIcon = self.frames[unit]
    if (not classIcon) then return end

    classIcon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
    classIcon:SetTexCoord(unpack(CLASS_BUTTONS[Gladdy.buttons[unit].class]))
end