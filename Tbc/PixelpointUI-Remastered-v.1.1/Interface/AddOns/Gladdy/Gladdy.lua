local setmetatable = setmetatable
local type = type
local tostring = tostring
local select = select
local pairs = pairs
local tinsert = table.insert
local tsort = table.sort
local strsplit = string.split

local CreateFrame = CreateFrame
local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME
local IsAddOnLoaded = IsAddOnLoaded
local IsInInstance = IsInInstance
local MAX_BATTLEFIELD_QUEUES = MAX_BATTLEFIELD_QUEUES
local GetBattlefieldStatus = GetBattlefieldStatus
local GetSpellInfo = GetSpellInfo
local UnitGUID = UnitGUID
local UnitBuff = UnitBuff
local UnitDebuff = UnitDebuff
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitMana = UnitMana
local UnitManaMax = UnitManaMax
local UnitPowerType = UnitPowerType
local UnitCastingInfo = UnitCastingInfo
local GetTime = GetTime
local UnitChannelInfo = UnitChannelInfo
local UnitIsPartyLeader = UnitIsPartyLeader
local UnitName = UnitName
local UnitExists = UnitExists
local UnitIsPlayer = UnitIsPlayer
local UnitCanAttack = UnitCanAttack
local UnitIsCharmed = UnitIsCharmed
local UnitRace = UnitRace
local UnitClass = UnitClass
local tonumber = tonumber
local CombatLogClearEntries = CombatLogClearEntries
local CombatLog_Object_IsA = CombatLog_Object_IsA
local COMBATLOG_OBJECT_TARGET = COMBATLOG_OBJECT_TARGET
local COMBATLOG_OBJECT_FOCUS = COMBATLOG_OBJECT_FOCUS

local MAJOR, MINOR = "Gladdy", 3
local Gladdy = LibStub:NewLibrary(MAJOR, MINOR)
local L

LibStub("AceTimer-3.0"):Embed(Gladdy)
LibStub("AceComm-3.0"):Embed(Gladdy)
Gladdy.modules = {}
setmetatable(Gladdy, {
    __tostring = function()
        return MAJOR
    end
})

function Gladdy:Print(...)
    local text = "|cff33ff99Gladdy|r:"

    for i = 1, select("#", ...) do
        text = text .. " " .. tostring(select(i, ...))
    end

    DEFAULT_CHAT_FRAME:AddMessage(text)
end

Gladdy.events = CreateFrame("Frame")
Gladdy.events.registered = {}
Gladdy.events:RegisterEvent("PLAYER_LOGIN")
Gladdy.events:SetScript("OnEvent", function(self, event, ...)
    if (event == "PLAYER_LOGIN") then
        Gladdy:OnInitialise()
        Gladdy:OnEnable()
    else
        local func = self.registered[event]

        if (type(Gladdy[func]) == "function") then
            Gladdy[func](Gladdy, event, ...)
        end
    end
end)

function Gladdy:RegisterEvent(event, func)
    self.events.registered[event] = func or event
    self.events:RegisterEvent(event)
end
function Gladdy:UnregisterEvent(event)
    self.events.registered[event] = nil
    self.events:UnregisterEvent(event)
end
function Gladdy:UnregisterAllEvents()
    self.events.registered = {}
    self.events:UnregisterAllEvents()
end

local function pairsByPrio(t)
    local a = {}
    for k, v in pairs(t) do
        tinsert(a, {k, v.priority})
    end
    tsort(a, function(x, y) return x[2] > y[2] end)

    local i = 0
    return function()
        i = i + 1

        if (a[i] ~= nil) then
            return a[i][1], t[a[i][1]]
        else
            return nil
        end
    end
end
function Gladdy:IterModules()
    return pairsByPrio(self.modules)
end

function Gladdy:Call(module, func, ...)
    if (type(module) == "string") then
        module = self.modules[module]
    end

    if (type(module[func]) == "function") then
        module[func](module, ...)
    end
end
function Gladdy:SendMessage(message, ...)
    for k, v in self:IterModules() do
        self:Call(v, v.messages[message], ...)
    end
end

function Gladdy:NewModule(name, priority, defaults)
    local module = {
        name = name,
        priority = priority or 0,
        defaults = defaults or {},
        messages = {},
    }

    module.RegisterMessage = function(self, message, func)
        self.messages[message] = func or message
    end

    module.GetOptions = function()
        return nil
    end

    for k, v in pairs(module.defaults) do
        self.defaults.profile[k] = v
    end

    self.modules[name] = module

    return module
end

function Gladdy:OnInitialise()
    self.dbi = LibStub("AceDB-3.0"):New("GladdyXZ", self.defaults)
    self.dbi.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
    self.dbi.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
    self.dbi.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
    self.db = self.dbi.profile

    self.LSM = LibStub("LibSharedMedia-3.0")
    self.LSM:Register("statusbar", "Gloss", "Interface\\AddOns\\Gladdy\\Images\\Gloss")
    self.LSM:Register("statusbar", "Minimalist", "Interface\\AddOns\\Gladdy\\Images\\Minimalist")

    L = self.L

    self.testData = {
        ["arena1"] = {name = "Swift", raceLoc = L["Undead"], classLoc = L["Warrior"], class = "WARRIOR", health = 9635, healthMax = 14207, power = 76, powerMax = 100, powerType = 1, spec = L["Arms"]},
        ["arena2"] = {name = "Vilden", raceLoc = L["Undead"], classLoc = L["Mage"], class = "MAGE", health = 10969, healthMax = 11023, power = 7833, powerMax = 10460, powerType = 0, spec = L["Frost"]},
        ["arena3"] = {name = "Krymu", raceLoc = L["Night Elf"], classLoc = L["Rogue"], class = "ROGUE", health = 1592, healthMax = 11740, power = 45, powerMax = 110, powerType = 3, spec = L["Subtlety"]},
        ["arena4"] = {name = "Talmon", raceLoc = L["Human"], classLoc = L["Warlock"], class = "WARLOCK", health = 10221, healthMax = 14960, power = 9855, powerMax = 9855, powerType = 0, spec = L["Demonology"]},
        ["arena5"] = {name = "Hydra", raceLoc = L["Undead"], classLoc = L["Priest"], class = "PRIEST", health = 11960, healthMax = 11960, power = 2515, powerMax = 10240, powerType = 0, spec = L["Discipline"]},
    }

    self.specBuffs = self:GetSpecBuffs()
    self.specSpells = self:GetSpecSpells()

    self.NS = GetSpellInfo(16188)
    self.POM = GetSpellInfo(12043)
    self.NF = GetSpellInfo(18095)
    self.SHADOWBOLT = GetSpellInfo(27209)
    self.INSTANT = {
        [GetSpellInfo(172)] = true,     -- Corruption
        [GetSpellInfo(2645)] = true,    -- Ghost Wolf
    }
    self.CAST_TIMES = {
        [GetSpellInfo(26985)] = 1.5,    -- Wrath
    }
    self.FD = GetSpellInfo(18708)
    self.SUMMON = {
        [GetSpellInfo(688)] = true,
        [GetSpellInfo(697)] = true,
        [GetSpellInfo(712)] = true,
        [GetSpellInfo(691)] = true,
        [GetSpellInfo(30146)] = true,
    }

    self.buttons = {}
    self.guids = {}
    self.curBracket = nil
    self.curUnit = 1
    self.lastInstance = nil

    self:SetupOptions()

    for k, v in self:IterModules() do
        self:Call(v, "Initialise") -- B.E > A.E :D
    end
end

function Gladdy:OnProfileChanged()
    self.db = self.dbi.profile

    self:HideFrame()
    self:ToggleFrame(3)
end

function Gladdy:OnEnable()
    self:RegisterEvent("PLAYER_ENTERING_WORLD")

    if (IsAddOnLoaded("Clique")) then
        for i = 1, 5 do
            self:CreateButton(i)
        end

        ClickCastFrames = ClickCastFrames or {}
        ClickCastFrames[self.buttons.arena1.secure] = true
        ClickCastFrames[self.buttons.arena2.secure] = true
        ClickCastFrames[self.buttons.arena3.secure] = true
        ClickCastFrames[self.buttons.arena4.secure] = true
        ClickCastFrames[self.buttons.arena5.secure] = true
    end

    if (not self.db.locked and self.db.x == 0 and self.db.y == 0) then
        self:Print(L["Welcome to Gladdy!"])
        self:Print(L["First run has been detected, displaying test frame."])
        self:Print(L["Valid slash commands are:"])
        self:Print(L["/gladdy ui"])
        self:Print(L["/gladdy test2-5"])
        self:Print(L["/gladdy hide"])
        self:Print(L["/gladdy reset"])
        self:Print(L["If this is not your first run please lock or move the frame to prevent this from happening."])

        self:HideFrame()
        self:ToggleFrame(3)
    end
end

function Gladdy:Test()
    for i = 1, self.curBracket do
        local unit = "arena" .. i
        if (not self.buttons[unit]) then
            self:CreateButton(i)
        end
        local button = self.buttons[unit]

        for k, v in pairs(self.testData[unit]) do
            button[k] = v
        end

        for k, v in self:IterModules() do
            self:Call(v, "Test", unit)
        end

        button:SetAlpha(1)
    end
end

function Gladdy:PLAYER_ENTERING_WORLD()
    self:Reset()

    local instance = select(2, IsInInstance())
    if (instance == "arena") then
        self:JoinedArena()
    elseif (instance ~= "arena" and self.lastInstance == "arena") then
        self:HideFrame()
    end
    self.lastInstance = instance
end

function Gladdy:Reset()
    self.guids = {}
    self.curBracket = nil
    self.curUnit = 1

    for k1, v1 in self:IterModules() do
        self:Call(v1, "Reset")
    end

    for k2 in pairs(self.buttons) do
        self:ResetUnit(k2)
    end
end

function Gladdy:ResetUnit(unit)
    local button = self.buttons[unit]
    if (not button) then return end

    button:SetAlpha(0)

    button._health = nil
    button._power = nil

    for k1, v1 in pairs(self.BUTTON_DEFAULTS) do
        button[k1] = v1
    end

    for k2, v2 in self:IterModules() do
        self:Call(v2, "ResetUnit", unit)
    end
end

function Gladdy:JoinedArena()
    self:RegisterEvent("UNIT_AURA")
    self:RegisterEvent("UNIT_HEALTH")
    self:RegisterEvent("UNIT_MANA", "UNIT_POWER")
    self:RegisterEvent("UNIT_ENERGY", "UNIT_POWER")
    self:RegisterEvent("UNIT_RAGE", "UNIT_POWER")
    self:RegisterEvent("UNIT_DISPLAYPOWER", "UNIT_POWER")
    self:RegisterEvent("UNIT_SPELLCAST_START")
    self:RegisterEvent("UNIT_SPELLCAST_STOP")
    self:RegisterEvent("UNIT_SPELLCAST_DELAYED")
    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    self:RegisterEvent("UNIT_SPELLCAST_FAILED", "UNIT_SPELLCAST_STOP")
    self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "UNIT_SPELLCAST_STOP")
    self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
    self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "UNIT_SPELLCAST_DELAYED")
    self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "UNIT_SPELLCAST_STOP")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("PLAYER_TARGET_CHANGED")
    self:RegisterEvent("PLAYER_FOCUS_CHANGED")
    self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
    self:RegisterEvent("UNIT_TARGET")

    self:ScheduleRepeatingTimer("Sync", 1, self)
    self:RegisterComm("Gladdy")

    for i = 1, MAX_BATTLEFIELD_QUEUES do
        local status, _, _, _, _, teamSize = GetBattlefieldStatus(i)
        if (status == "active" and teamSize > 0) then
            self.curBracket = teamSize
            break
        end
    end

    for i = 1, self.curBracket do
        if (not self.buttons["arena" .. i]) then
            self:CreateButton(i)
        end
    end

    self:SendMessage("JOINED_ARENA")
    self:UpdateFrame()
    self.frame:Show()

    CombatLogClearEntries()
end

function Gladdy:UNIT_AURA(event, uid)
    local button = self:GetButton(uid)
    if (not button) then return end

    local Auras = Gladdy.modules.Auras
    local auraName, auraIcon, auraExpTime
    local priority = 0

    local index = 1
    while (true) do
        local name, _, icon, _, _, expTime = UnitBuff(uid, index)
        if (not name) then break end

        self:AuraGain(button.unit, name)

        if (Auras.auras[name] and Auras.auras[name].priority >= (Auras.frames[button.unit].priority or 0)) then
            auraName = name
            auraIcon = icon
            auraExpTime = expTime or 0
            priority = Auras.auras[name].priority
        end

        index = index + 1
    end

    index = 1
    while (true) do
        local name, _, icon, _, _, _, expTime = UnitDebuff(uid, index)
        if (not name) then break end

        self:AuraGain(button.unit, name)

        if (Auras.auras[name] and Auras.auras[name].priority >= (Auras.frames[button.unit].priority or 0)) then
            auraName = name
            auraIcon = icon
            auraExpTime = expTime or 0
            priority = Auras.auras[name].priority
        end

        index = index + 1
    end

    if (auraName) then
        if (not auraExpTime) then
            if (auraName == Auras.frames[button.unit].name) then
                auraExpTime = Auras.frames[button.unit].timeLeft
            else
                auraExpTime = Auras.auras[name].duration
            end
        end

        self:SendMessage("AURA_GAIN", button.unit, auraName, auraIcon, auraExpTime, priority)
    else
        self:SendMessage("AURA_FADE", button.unit)
    end
end

function Gladdy:UNIT_HEALTH(event, uid)
    local button = self:GetButton(uid)
    if (not button) then return end

    if (not UnitIsDeadOrGhost(uid)) then
        button.health = UnitHealth(uid)
        button.healthMax = UnitHealthMax(uid)

        self:SendMessage("UNIT_HEALTH", button.unit, button.health, button.healthMax)
    else
        self:SendMessage("UNIT_DEATH", button.unit)
    end
end

function Gladdy:UNIT_POWER(event, uid)
    local button = self:GetButton(uid)
    if (not button) then return end

    if (not UnitIsDeadOrGhost(uid)) then
        button.power = UnitMana(uid)
        button.powerMax = UnitManaMax(uid)
        button.powerType = UnitPowerType(uid)

        self:SendMessage("UNIT_POWER", button.unit, button.power, button.powerMax, button.powerType)
    else
        self:SendMessage("UNIT_DEATH", button.unit)
    end
end

function Gladdy:UNIT_SPELLCAST_START(event, uid)
    local button = self:GetButton(uid)
    if (not button) then return end

    local spell, rank, displayName, icon, startTime, endTime = UnitCastingInfo(uid)
    local value = (endTime / 1000) - GetTime()
    local maxValue = (endTime - startTime) / 1000

    self:CastStart(button.unit, spell, icon, value, maxValue, "cast")
end

function Gladdy:UNIT_SPELLCAST_CHANNEL_START(event, uid)
    local button = self:GetButton(uid)
    if (not button) then return end

    local spell, rank, displayName, icon, startTime, endTime = UnitChannelInfo(uid)
    local value = (endTime / 1000) - GetTime()
    local maxValue = (endTime - startTime) / 1000

    self:CastStart(button.unit, spell, icon, value, maxValue, "channel")
end

function Gladdy:UNIT_SPELLCAST_SUCCEEDED(event, uid, spell)
    local button = self:GetButton(uid)
    if (not button) then return end

    self:CastSuccess(button.unit, spell)
end

function Gladdy:UNIT_SPELLCAST_DELAYED(event, uid)
    local button = self:GetButton(uid)
    if (not button) then return end

    local spell, rank, displayName, icon, startTime, endTime

    if (event == "UNIT_SPELLCAST_DELAYED") then
        spell, rank, displayName, icon, startTime, endTime = UnitCastingInfo(uid)
    else
        spell, rank, displayName, icon, startTime, endTime = UnitChannelInfo(uid)
    end

    local castBar = Gladdy.modules.Castbar.frames[button.unit]
    castBar.value = GetTime() - (startTime / 1000)
    castBar.maxValue = (endTime - startTime) / 1000
    castBar:SetMinMaxValues(0, castBar.maxValue)
end

function Gladdy:UNIT_SPELLCAST_STOP(event, uid)
    local button = self:GetButton(uid)
    if (not button) then return end

    self:SendMessage("CAST_STOP", button.unit)
end

function Gladdy:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
    local srcUnit = self.guids[sourceGUID]
    local destUnit = self.guids[destGUID]
    if (not srcUnit and not destUnit) then return end

    local events = {
        ["PARTY_KILL"] = "DEATH",
        ["UNIT_DIED"] = "DEATH",
        ["UNIT_DESTROYED"] = "DEATH",
        ["SWING_DAMAGE"] = "DAMAGE",
        ["RANGE_DAMAGE"] = "DAMAGE",
        ["SPELL_DAMAGE"] = "DAMAGE",
        ["SPELL_PERIODIC_DAMAGE"] = "DAMAGE",
        ["ENVIRONMENTAL_DAMAGE"] = "DAMAGE",
        ["DAMAGE_SHIELD"] = "DAMAGE",
        ["DAMAGE_SPLIT"] = "DAMAGE",
        ["SPELL_AURA_APPLIED"] = "BUFF",
        ["SPELL_PERIODIC_AURA_APPLIED"] = "BUFF",
        ["SPELL_AURA_APPLIED_DOSE"] = "BUFF",
        ["SPELL_PERIODIC_AURA_APPLIED_DOSE"] = "BUFF",
        ["SPELL_AURA_REFRESH"] = "REFRESH",
        ["SPELL_AURA_REMOVED"] = "FADE",
        ["SPELL_PERIODIC_AURA_REMOVED"] = "FADE",
        ["SPELL_AURA_REMOVED_DOSE"] = "FADE",
        ["SPELL_PERIODIC_AURA_REMOVED_DOSE"] = "FADE",
        ["SPELL_CAST_START"] = "CASTSTART",
        ["SPELL_SUMMON"] = "CASTSTART",
        ["SPELL_CREATE"] = "CASTSTART",
        ["SPELL_CAST_SUCCESS"] = "CASTSUCCESS",
        ["SPELL_CAST_FAILED"] = "CASTEND",
        ["SPELL_INTERRUPT"] = "INTERRUPT",
    }

    eventType = events[eventType]
    if (not eventType) then return end

    local t = ("%.1f"):format(GetTime())

    if (events[eventType] == "DEATH" and destUnit) then
        self:SendMessage("UNIT_DEATH", destUnit)
    elseif (events[eventType] == "DAMAGE") then
        local button = self.buttons[destUnit]
        if (not button) then return end

        button.damaged = t
    elseif (eventType == "BUFF" and destUnit) then
        local button = self.buttons[destUnit]
        if (not button) then return end

        local auraId, auraName = ...
        self:AuraGain(destUnit, auraName)

        local Auras = Gladdy.modules.Auras
        local aura = Auras.auras[auraName]

        local factor = self:Call("Diminishings", "Gain", destUnit, auraName)

        if (aura and aura.priority >= (Auras.frames[destUnit].priority or 0)) then
            local auraIcon = select(3, GetSpellInfo(auraId))
            local auraExpTime = aura.duration / (factor or 1)

            self:SendMessage("AURA_GAIN", destUnit, auraName, auraIcon, auraExpTime, aura.priority)
            button.spells[auraName] = t
        end
    elseif (eventType == "REFRESH" and destUnit) then
        local button = self.buttons[destUnit]
        if (not button) then return end

        local auraId, auraName = ...
        if (button.spells[auraName] and t > button.spells[auraName]) then
            self:AuraGain(destUnit, auraName)

            local Auras = Gladdy.modules.Auras
            local aura = Auras.auras[auraName]

            self:Call("Diminishings", "Fade", destUnit, auraName)
            local factor = self:Call("Diminishings", "Gain", destUnit, auraName)

            if (aura and aura.priority >= (Auras.frames[destUnit].priority or 0)) then
                local auraIcon = select(3, GetSpellInfo(auraId))
                local auraExpTime = aura.duration / (factor or 1)

                self:SendMessage("AURA_GAIN", destUnit, auraName, auraIcon, auraExpTime, aura.priority)
                button.spells[auraName] = t
            end
        end
    elseif (eventType == "FADE" and destUnit) then
        local button = self.buttons[destUnit]
        if (not button) then return end

        local auraId, auraName = ...
        self:AuraFade(destUnit, auraName)

        self:Call("Diminishings", "Fade", destUnit, auraName)

        local Auras = Gladdy.modules.Auras
        if (auraName == Auras.frames[destUnit].name) then
            self:SendMessage("AURA_FADE", destUnit)
            button.spells[auraName] = nil
        end
    elseif (eventType == "CASTSTART" and srcUnit) then
        local fromTarget = CombatLog_Object_IsA(sourceFlags, COMBATLOG_OBJECT_TARGET)
        local fromFocus = CombatLog_Object_IsA(sourceFlags, COMBATLOG_OBJECT_FOCUS)

        if (not fromTarget and not fromFocus) then
            local spellId, spellName = ...
            local icon = select(3, GetSpellInfo(spellId))
            local castTime = self.CAST_TIMES[spellName] or select(7, GetSpellInfo(spellId)) / 1000

            self:CastStart(srcUnit, spellName, icon, 0, castTime, "cast")
        end
    elseif (eventType == "CASTSUCCESS" and srcUnit) then
        local spellId, spellName = ...
        self:CastSuccess(srcUnit, spellName)
    elseif (eventType == "CASTEND" and srcUnit) then
        local fromTarget = CombatLog_Object_IsA(sourceFlags, COMBATLOG_OBJECT_TARGET)
        local fromFocus = CombatLog_Object_IsA(sourceFlags, COMBATLOG_OBJECT_FOCUS)

        if (not fromTarget and not fromFocus) then
            self:SendMessage("CAST_END", srcUnit)
        end
    elseif (eventType == "INTERRUPT" and srcUnit) then
        self:SendMessage("CAST_END", srcUnit)
    end
end

function Gladdy:PLAYER_TARGET_CHANGED()
    local guid = UnitGUID("target")
    if (guid and self:IsValid("target")) then
        self:UpdateGUID(guid, "target")
    end

    for k, v in pairs(self.buttons) do
        self:Call("Highlight", "Toggle", k, "target", guid and guid == v.guid)
    end
end

function Gladdy:PLAYER_FOCUS_CHANGED()
    local guid = UnitGUID("focus")
    if (guid and self:IsValid("focus")) then
        self:UpdateGUID(guid, "focus")
    end

    for k, v in pairs(self.buttons) do
        self:Call("Highlight", "Toggle", k, "focus", guid and guid == v.guid)
    end
end

function Gladdy:UPDATE_MOUSEOVER_UNIT()
    local guid = UnitGUID("mouseover")
    if (guid and self:IsValid("mouseover")) then
        self:UpdateGUID(guid, "mouseover")
    end
end

function Gladdy:UNIT_TARGET(event, uid)
    if (UnitIsPartyLeader(uid) and UnitName(uid) ~= UnitName("player")) then
        local unit = uid .. "target"
        local guid = UnitGUID(unit)
        if (guid and self:IsValid(unit)) then
            self:UpdateGUID(guid, unit)
        end

        for k, v in pairs(self.buttons) do
            self:Call("Highlight", "Toggle", k, "leader", guid and guid == v.guid)
        end
    end
end

function Gladdy:Sync()
    for k, v in pairs(self.buttons) do
        if (v.guid ~= "") then
            if (not v._health or not v._power or v.health ~= v._health or v.power ~= v._power) then
                local message = ("%s,%s,%s,%s,%s,%s,%d,%d,%d,%d,%d"):format(
                    v.name, v.guid, v.class, v.classLoc, v.raceLoc, v.spec,
                    v.health, v.healthMax, v.power, v.powerMax, v.powerType
                )

                v._health = v.health
                v._power = v.power

                self:SendCommMessage("Gladdy", message, "PARTY", nil, "ALERT")
            end
        end
    end
end

function Gladdy:OnCommReceived(prefix, message, dest, sender)
    if (prefix == "Gladdy" and sender ~= UnitName("player")) then
        local name, guid, class, classLoc, raceLoc, spec, health, healthMax, power, powerMax, powerType = strsplit(',', message)
        health, healthMax = tonumber(health), tonumber(healthMax)
        power, powerMax, powerType = tonumber(power), tonumber(powerMax), tonumber(powerType)

        local unit = self.guids[guid]
        if (not unit) then
            unit = self:EnemySpotted(name, guid, class, classLoc, raceLoc)
        end

        local button = self.buttons[unit]
        if (not button) then return end

        button.health = health
        button.healthMax = healthMax
        self:SendMessage("UNIT_HEALTH", unit, health, healthMax)

        button.power = power
        button.powerMax = powerMax
        button.powerType = powerType
        self:SendMessage("UNIT_POWER", unit, power, powerMax, powerType)

        if (spec ~= "") then
            self:DetectSpec(unit, spec)
        end
    end
end

function Gladdy:GetButton(uid)
    local guid = UnitGUID(uid)
    local unit = self.guids[guid]

    return self.buttons[unit]
end

function Gladdy:AuraGain(unit, aura)
    local button = self.buttons[unit]
    if (not button) then return end

    if (aura == self.NS) then
        button.ns = true
    elseif (aura == self.NF) then
        button.nf = true
    elseif (aura == self.POM) then
        button.pom = true
    elseif (aura == self.FD) then
        button.fd = true
    end

    self:Call("Announcements", "CheckDrink", unit, aura)
    self:DetectSpec(unit, self.specBuffs[aura])
end

function Gladdy:AuraFade(unit, aura)
    local button = self.buttons[unit]
    if (not button) then return end

    if (aura == self.NS) then
        button.ns = false
    elseif (aura == self.NF) then
        button.nf = false
    elseif (aura == self.POM) then
        button.pom = false
    elseif (aura == self.FD) then
        button.fd = false
    end
end

function Gladdy:CastStart(unit, spell, icon, value, maxValue, event)
    local button = self.buttons[unit]
    if (not button) then return end

    if (button.ns or button.pom or (button.nf and spell == self.SHADOWBOLT) or self.INSTANT[spell]) then
        self:CastSuccess(unit, spell)
        return
    elseif (button.fd and self.SUMMON[spell]) then
        maxValue = 0.5
    end

    self:SendMessage("CAST_START", unit, spell, icon, value, maxValue, event)
    self:DetectSpec(unit, self.specSpells[spell])
end

function Gladdy:CastSuccess(unit, spell)
    self:DetectSpec(unit, self.specSpells[spell])
end

function Gladdy:DetectSpec(unit, spec)
    local button = self.buttons[unit]
    if (not button or not spec or button.spec ~= "") then return end

    button.spec = spec
    self:SendMessage("UNIT_SPEC", unit, spec)
end

function Gladdy:IsValid(uid)
    if (UnitExists(uid) and UnitName(uid) and UnitIsPlayer(uid) and UnitCanAttack("player", uid) and not UnitIsCharmed(uid) and not UnitIsCharmed("player")) then
        return true
    end
end

function Gladdy:UpdateGUID(guid, uid)
    local unit = self.guids[guid]
    if (not unit) then
        local name = UnitName(uid)
        local classLoc, class = UnitClass(uid)
        local raceLoc = UnitRace(uid)

        unit = self:EnemySpotted(name, guid, class, classLoc, raceLoc)
    end

    self:UNIT_AURA(nil, uid)
    self:UNIT_HEALTH(nil, uid)
    self:UNIT_POWER(nil, uid)
end

function Gladdy:EnemySpotted(name, guid, class, classLoc, raceLoc)
    local unit = "arena" .. self.curUnit
    self.curUnit = self.curUnit + 1
    self.guids[guid] = unit

    local button = self.buttons[unit]
    if (not button) then return end

    button.name = name
    button.guid = guid
    button.class = class
    button.classLoc = classLoc
    button.raceLoc = raceLoc

    self:SendMessage("ENEMY_SPOTTED", unit)

    button:SetAlpha(1)

    return unit
end
