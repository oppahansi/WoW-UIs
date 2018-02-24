local select = select
local pairs = pairs

local WorldFrame = WorldFrame

local Gladdy = LibStub("Gladdy")
local L = Gladdy.L
local Nameplates = Gladdy:NewModule("Nameplates")
LibStub("AceHook-3.0"):Embed(Nameplates)
LibStub("AceTimer-3.0"):Embed(Nameplates)

function Nameplates:Initialise()
    self.frames = 0

    self:RegisterMessage("JOINED_ARENA")
end

function Nameplates:JOINED_ARENA()
    self:ScheduleRepeatingTimer("Update", 1, self)
end

function Nameplates:Reset()
    self:CancelAllTimers()
    self:UnhookAll()

    self.frames = 0
end

function Nameplates:Update()
    if (self.frames ~= WorldFrame:GetNumChildren()) then
        self.frames = WorldFrame:GetNumChildren()
        self:UpdateFrames(WorldFrame:GetChildren())
    end
end

function Nameplates:UpdateFrames(...)
    for i = 1, select("#", ...) do
        local healthBar = self:FindBar(select(i, ...):GetChildren())

        if (healthBar) then
            self:HookScript(healthBar, "OnValueChanged")
            healthBar.GladdyHooked = true
        end
    end
end

function Nameplates:FindBar(...)
    for i = 1, select("#", ...) do
        local healthBar = select(i, ...)

        if (healthBar and not healthBar.GladdyHooked and healthBar.GetFrameType and healthBar:GetFrameType() == "StatusBar" and not healthBar:GetName() and healthBar:IsVisible()) then
            return healthBar
        end
    end
end

function Nameplates:OnValueChanged(frame, health)
    if (frame:IsVisible() and health) then
        self:CheckFrame(frame, health)
    end
end

function Nameplates:CheckFrame(frame, health)
    local name = select(5, frame:GetParent():GetRegions()):GetText()

    for k, v in pairs(Gladdy.buttons) do
        if (v.name == name) then
            local healthMax = v.healthMax

            if (healthMax) then
                Gladdy:SendMessage("UNIT_HEALTH", k, health, healthMax)
                break
            end
        end
    end
end