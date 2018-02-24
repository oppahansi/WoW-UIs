local pairs = pairs

local CreateFrame = CreateFrame
local GetSpellInfo = GetSpellInfo
local GetTime = GetTime

local Gladdy = LibStub("Gladdy")
local L = Gladdy.L
local Trinket = Gladdy:NewModule("Trinket", nil, {
    trinketDisableOmniCC = false,
})
LibStub("AceComm-3.0"):Embed(Trinket)

function Trinket:Initialise()
    self.frames = {}

    self:RegisterMessage("JOINED_ARENA")
end

function Trinket:CreateFrame(unit)
    local trinket = Gladdy.buttons[unit]:CreateTexture(nil, "ARTWORK")
    trinket:SetTexture("Interface\\Icons\\INV_Jewelry_TrinketPVP_02")

    trinket.frame = CreateFrame("Frame")
    trinket.frame:SetScript("OnUpdate", function(self, elapsed)
        if (self.active) then
            if (self.timeLeft <= 0) then
                self.active = false
                Gladdy:SendMessage("TRINKET_READY", unit)
            else
                self.timeLeft = self.timeLeft - elapsed
            end
        end
    end)

    trinket.cooldown = CreateFrame("Cooldown", nil, Gladdy.buttons[unit], "CooldownFrameTemplate")
    trinket.cooldown.noCooldownCount = Gladdy.db.trinketDisableOmniCC
    
    self.frames[unit] = trinket
end

function Trinket:UpdateFrame(unit)
    local trinket = self.frames[unit]
    if (not trinket) then return end

    local classIcon = Gladdy.modules.Classicon.frames[unit]

    trinket:SetWidth(classIcon:GetWidth())
    trinket:SetHeight(classIcon:GetHeight())
    trinket.cooldown:SetWidth(classIcon:GetWidth())
    trinket.cooldown:SetHeight(classIcon:GetWidth())

    trinket:ClearAllPoints()
    trinket:SetPoint("TOPLEFT", trinket:GetParent(), "TOPRIGHT", 2, 0)
    trinket.cooldown:ClearAllPoints()
    trinket.cooldown:SetAllPoints(trinket)

    trinket.cooldown.noCooldownCount = Gladdy.db.trinketDisableOmniCC
end

function Trinket:Reset()
    self:UnregisterComm("GladdyTrinketUsed")
end

function Trinket:ResetUnit(unit)
    local trinket = self.frames[unit]
    if (not trinket) then return end

    trinket.frame.timeLeft = nil
    trinket.frame.active = false
    trinket.cooldown:SetCooldown(GetTime(), 0)
end

function Trinket:Test(unit)
    local trinket = self.frames[unit]
    if (not trinket) then return end

    if (unit == "arena3" or unit == "arena4") then
        self:Used(unit)
    end
end

function Trinket:JOINED_ARENA()
    self:RegisterComm("GladdyTrinketUsed")
end

function Trinket:OnCommReceived(prefix, guid)
    if (prefix == "GladdyTrinketUsed") then
        for k, v in pairs(Gladdy.buttons) do
            if (v.guid == guid) then
                self:Used(k)
                break
            end
        end
    end
end

function Trinket:Used(unit)
    local trinket = self.frames[unit]
    if (not trinket) then return end

    Gladdy:SendMessage("TRINKET_USED", unit)

    trinket.frame.timeLeft = 120
    trinket.frame.active = true
    trinket.cooldown:SetCooldown(GetTime(), 120)
end

local function option(params)
    local defaults = {
        get = function(info)
            local key = info.arg or info[#info]
            return Gladdy.dbi.profile[key]
        end,
        set = function(info, value)
            local key = info.arg or info[#info]
            Gladdy.dbi.profile[key] = value
            Gladdy:UpdateFrame()
        end,
    }

    for k, v in pairs(params) do
        defaults[k] = v
    end

    return defaults
end

function Trinket:GetOptions()
    return {
        trinketDisableOmniCC = option({
            type = "toggle",
            name = L["No cooldown count (OmniCC)"],
            desc = L["Disable cooldown timers by addons (reload UI to take effect)"],
            order = 2,
        }),
    }
end

function Trinket:GetDispelList()
    return {
        -- The Beast Within
        [GetSpellInfo(19574)] = {
            immune = true,
        },

        -- Ice Block
        [GetSpellInfo(45438)] = {
            immune = true,
        },

        -- Divine Shield
        [GetSpellInfo(642)] = {
            immune = true,
        },
        -- Cleanse
        [GetSpellInfo(4987)] = {
            target = "dest",
            magic = true,
            poison = true,
        },

        -- Dispel Magic
        [GetSpellInfo(988)] = {
            target = "dest",
            magic = true,
        },

        -- Cloak of Shadows
        [GetSpellInfo(31224)] = {
            target = "self",
            magic = true,
        },

        -- Tremor Totem
        [GetSpellInfo(8143)] = {
            target = "dest",
            fear = true,
            sleep = true,
            charm = true,
        },

        -- Berserker Rage
        [GetSpellInfo(18499)] = {
            target = "self",
            fear = true,
            incapacite = true,
        },

        -- Escape Artist
        [GetSpellInfo(20589)] = {
            target = "self",
            root = true,
        },

        -- Will of the Forsaken
        [GetSpellInfo(7744)] = {
            target = "self",
            fear = true,
            sleep = true,
            charm = true,
        },
    }
end