local GetSpellInfo = GetSpellInfo

local Gladdy = LibStub("Gladdy")
local L = Gladdy.L

function Gladdy:GetSpecBuffs()
    return {
        -- DRUID
        [GetSpellInfo(24858)] = L["Balance"],           -- Moonkin Form

        -- HUNTER
        [GetSpellInfo(34692)] = L["Beast Mastery"],     -- The Beast Within
        [GetSpellInfo(20895)] = L["Beast Mastery"],       -- Spirit Bond

        -- MAGE
        [GetSpellInfo(33405)] = L["Frost"],             -- Ice Barrier

        -- PALADIN
        [GetSpellInfo(31836)] = L["Holy"],              -- Light's Grace
        [GetSpellInfo(20375)] = L["Retribution"],       -- Seal of Command

        -- PRIEST
        [GetSpellInfo(15473)] = L["Shadow"],            -- Shadowform

        -- ROGUE
        [GetSpellInfo(36554)] = L["Subtlety"],          -- Shadowstep

        -- WARLOCK
        [GetSpellInfo(19028)] = L["Demonology"],        -- Soul Link
        [GetSpellInfo(30302)] = L["Destruction"],       -- Nether Protection

        -- WARRIOR
        [GetSpellInfo(29838)] = L["Arms"],              -- Second Wind
    }
end

function Gladdy:GetSpecSpells()
    return {
        -- DRUID
        [GetSpellInfo(33831)] = L["Balance"],           -- Force of Nature
        [GetSpellInfo(33983)] = L["Feral"],             -- Mangle (Cat)
        [GetSpellInfo(33987)] = L["Feral"],             -- Mangle (Bear)
        [GetSpellInfo(17007)] = L["Feral"],             -- Leader of the Pack
        [GetSpellInfo(18562)] = L["Restoration"],       -- Swiftmend

        -- HUNTER
        [GetSpellInfo(19577)] = L["Beast Mastery"],     -- Intimidation
        [GetSpellInfo(34490)] = L["Marksmanship"],      -- Silencing Shot
        [GetSpellInfo(27066)] = L["Marksmanship"],      -- Trueshot Aura
        [GetSpellInfo(27068)] = L["Survival"],          -- Wyvern Sting

        -- MAGE
        [GetSpellInfo(12042)] = L["Arcane"],            -- Arcane Power
        [GetSpellInfo(33043)] = L["Fire"],              -- Dragon's Breath
        [GetSpellInfo(33933)] = L["Fire"],              -- Blast Wave
        [GetSpellInfo(33405)] = L["Frost"],             -- Ice Barrier
        [GetSpellInfo(31687)] = L["Frost"],             -- Summon Water Elemental
        [GetSpellInfo(12472)] = L["Frost"],             -- Icy Veins
        [GetSpellInfo(11958)] = L["Frost"],             -- Cold Snap

        -- PALADIN
        [GetSpellInfo(33072)] = L["Holy"],              -- Holy Shock
        [GetSpellInfo(20216)] = L["Holy"],              -- Divine Favor
        [GetSpellInfo(31842)] = L["Holy"],              -- Divine Illumination
        [GetSpellInfo(32700)] = L["Protection"],        -- Avenger's Shield
        [GetSpellInfo(27170)] = L["Retribution"],       -- Seal of Command
        [GetSpellInfo(35395)] = L["Retribution"],       -- Crusader Strike
        [GetSpellInfo(20066)] = L["Retribution"],       -- Repentance

        -- PRIEST
        [GetSpellInfo(10060)] = L["Discipline"],        -- Power Infusion
        [GetSpellInfo(33206)] = L["Discipline"],        -- Pain Suppression
        [GetSpellInfo(33143)] = L["Holy"],              -- Blessed Resilience
        [GetSpellInfo(34861)] = L["Holy"],              -- Circle of Healing
        [GetSpellInfo(15473)] = L["Shadow"],            -- Shadowform
        [GetSpellInfo(34917)] = L["Shadow"],            -- Vampiric Touch

        -- ROGUE
        [GetSpellInfo(34413)] = L["Assassination"],     -- Mutilate
        [GetSpellInfo(13750)] = L["Combat"],            -- Adrenaline Rush
        [GetSpellInfo(14185)] = L["Subtlety"],          -- Preparation
        [GetSpellInfo(36554)] = L["Subtlety"],          -- Shadowstep

        -- SHAMAN
        [GetSpellInfo(16166)] = L["Elemental"],         -- Elemental Mastery
        [GetSpellInfo(30823)] = L["Enhancement"],       -- Shamanistic Rage
        [GetSpellInfo(17364)] = L["Enhancement"],       -- Stormstrike
        [GetSpellInfo(16190)] = L["Restoration"],       -- Mana Tide Totem
        [GetSpellInfo(32594)] = L["Restoration"],       -- Earth Shield

        -- WARLOCK
        [GetSpellInfo(30405)] = L["Affliction"],        -- Unstable Affliction
        [GetSpellInfo(30911)] = L["Affliction"],        -- Siphon Life
        [GetSpellInfo(30414)] = L["Destruction"],       -- Shadowfury

        -- WARRIOR
        [GetSpellInfo(30330)] = L["Arms"],              -- Mortal Strike
        [GetSpellInfo(12292)] = L["Arms"],              -- Death Wish
        [GetSpellInfo(30335)] = L["Fury"],              -- Bloodthirst
        [GetSpellInfo(12809)] = L["Protection"],        -- Concussion Blow
        [GetSpellInfo(30022)] = L["Protection"],        -- Devastation
        [GetSpellInfo(12975)] = L["Protection"],        -- Last Stand
    }
end