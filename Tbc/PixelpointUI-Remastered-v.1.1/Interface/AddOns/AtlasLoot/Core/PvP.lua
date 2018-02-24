local BabbleFaction = LibStub("LibBabble-Faction-3.0"):GetLookupTable();
local BabbleZone = LibStub("LibBabble-Zone-3.0"):GetLookupTable();
local BabbleInventory = LibStub("LibBabble-Inventory-3.0"):GetLookupTable();
local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

local ORANGE = "|cffFF8400";

function AtlasLootPvPMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Hide();
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    -- Alterac Valley Rewards
    AtlasLootMenuItem_1_Name:SetText(BabbleZone["Alterac Valley"]);
    AtlasLootMenuItem_1_Extra:SetText("");
    AtlasLootMenuItem_1_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Necklace_21");
    AtlasLootMenuItem_1.lootpage="AVMisc";
    AtlasLootMenuItem_1:Show();
    -- Arathi Basin Rewards
    AtlasLootMenuItem_2_Name:SetText(BabbleZone["Arathi Basin"]);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Amulet_07");
    AtlasLootMenuItem_2.lootpage="ABMENU";
    AtlasLootMenuItem_2:Show();
    -- Hellfire Peninsula Rewards
    AtlasLootMenuItem_4_Name:SetText(BabbleZone["Hellfire Peninsula"]);
    AtlasLootMenuItem_4_Extra:SetText(ORANGE..AL["Hellfire Fortifications"]);
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Misc_Token_HonorHold");
    AtlasLootMenuItem_4.lootpage="Hellfire";
    AtlasLootMenuItem_4:Show();
    -- Zangarmarsh Rewards
    AtlasLootMenuItem_5_Name:SetText(BabbleZone["Zangarmarsh"]);
    AtlasLootMenuItem_5_Extra:SetText(ORANGE..AL["Twin Spire Ruins"]);
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Spell_Nature_ElementalPrecision_1");
    AtlasLootMenuItem_5.lootpage="Zangarmarsh";
    AtlasLootMenuItem_5:Show();
    -- Honor System
    AtlasLootMenuItem_7_Name:SetText(AL["PvP Honor System"]);
    AtlasLootMenuItem_7_Extra:SetText("");
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Talisman_09");
    AtlasLootMenuItem_7.lootpage="HONORMENU";
    AtlasLootMenuItem_7:Show();
    -- Warsong Gulch Rewards
    AtlasLootMenuItem_16_Name:SetText(BabbleZone["Warsong Gulch"]);
    AtlasLootMenuItem_16_Extra:SetText("");
    AtlasLootMenuItem_16_Icon:SetTexture("Interface\\Icons\\INV_Misc_Rune_07");
    AtlasLootMenuItem_16.lootpage="WSGMENU";
    AtlasLootMenuItem_16:Show();
    -- Arathi Basin Armor Sets
    AtlasLootMenuItem_17_Name:SetText(AL["Arathi Basin Sets"]);
    AtlasLootMenuItem_17_Extra:SetText("");
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Amulet_07");
    AtlasLootMenuItem_17.lootpage="ABSets1";
    AtlasLootMenuItem_17:Show();
    -- Terokkar Forest Rewards
    AtlasLootMenuItem_19_Name:SetText(BabbleZone["Terokkar Forest"]);
    AtlasLootMenuItem_19_Extra:SetText(ORANGE..AL["Spirit Towers"]);
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_FrostwolfTrinket_04");
    AtlasLootMenuItem_19.lootpage="Terokkar";
    AtlasLootMenuItem_19:Show();
    -- Nagrand Rewards
    AtlasLootMenuItem_20_Name:SetText(BabbleZone["Nagrand"]);
    AtlasLootMenuItem_20_Extra:SetText(ORANGE..AL["Halaa"]);
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\INV_Misc_Rune_09");
    AtlasLootMenuItem_20.lootpage="Nagrand1";
    AtlasLootMenuItem_20:Show();
    -- Arena System
    AtlasLootMenuItem_22_Name:SetText(AL["Arena PvP System"]);
    AtlasLootMenuItem_22_Extra:SetText("");
    AtlasLootMenuItem_22_Icon:SetTexture("Interface\\Icons\\INV_Weapon_Crossbow_10");
    AtlasLootMenuItem_22.lootpage="ARENAMENU";
    AtlasLootMenuItem_22:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["PvP Rewards"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootPvPHonorSystemMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "PVPMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    -- PvP Accessories level 60
    AtlasLootMenuItem_1_Name:SetText(AL["PvP Accessories"]);
    AtlasLootMenuItem_1_Extra:SetText(ORANGE..AL["Level 60"]);
    AtlasLootMenuItem_1_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Talisman_09");
    AtlasLootMenuItem_1.lootpage="PvP60Accessories1";
    AtlasLootMenuItem_1:Show();
    -- PvP Armor Sets level 60
    AtlasLootMenuItem_2_Name:SetText(AL["PvP Armor Sets"]);
    AtlasLootMenuItem_2_Extra:SetText(ORANGE..AL["Level 60"]);
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Axe_02");
    AtlasLootMenuItem_2.lootpage="PVPSET";
    AtlasLootMenuItem_2:Show();
    -- PvP Weapons level 60
    AtlasLootMenuItem_16_Name:SetText(AL["PvP Weapons"]);
    AtlasLootMenuItem_16_Extra:SetText(ORANGE..AL["Level 60"]);
    AtlasLootMenuItem_16_Icon:SetTexture("Interface\\Icons\\INV_Weapon_Bow_08");
    AtlasLootMenuItem_16.lootpage="PVPWeapons1";
    AtlasLootMenuItem_16:Show();
    --PvP Accessories level 70
    AtlasLootMenuItem_4_Name:SetText(AL["PvP Accessories"]);
    AtlasLootMenuItem_4_Extra:SetText(ORANGE..AL["Level 70"]);
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Talisman_09");
    AtlasLootMenuItem_4.lootpage="PvP70Accessories1";
    AtlasLootMenuItem_4:Show();
    -- PvP ReputationSets
    AtlasLootMenuItem_5_Name:SetText(AL["PvP Reputation Sets"]);
    AtlasLootMenuItem_5_Extra:SetText(ORANGE..AL["Level 70"]);
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\INV_Axe_02");
    AtlasLootMenuItem_5.lootpage="PVP70RepSET";
    AtlasLootMenuItem_5:Show();
    -- PvP Non-set Epics
    AtlasLootMenuItem_19_Name:SetText(AL["PvP Non-Set Epics"]);
    AtlasLootMenuItem_19_Extra:SetText(ORANGE..AL["Level 70"]);
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_Boots_05");
    AtlasLootMenuItem_19.lootpage="PVP70NONSETEPICS";
    AtlasLootMenuItem_19:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["PvP Honor System"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootPvPArenaSystemMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "PVPMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    -- Arena PvP Armor Sets - Season 1
    AtlasLootMenuItem_1_Name:SetText(AL["Arena PvP Sets"]);
    AtlasLootMenuItem_1_Extra:SetText(ORANGE..AL["Season 1"]);
    AtlasLootMenuItem_1_Icon:SetTexture("Interface\\Icons\\INV_Mace_36");
    AtlasLootMenuItem_1.lootpage="ARENASET";
    AtlasLootMenuItem_1:Show();
    -- Arena PvP Armor Sets - Season 2
    AtlasLootMenuItem_2_Name:SetText(AL["Arena PvP Sets"]);
    AtlasLootMenuItem_2_Extra:SetText(ORANGE..AL["Season 2"]);
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Mace_36");
    AtlasLootMenuItem_2.lootpage="ARENA2SET";
    AtlasLootMenuItem_2:Show();
    -- Arena PvP Armor Sets - Season 3
    AtlasLootMenuItem_3_Name:SetText(AL["Arena PvP Sets"]);
    AtlasLootMenuItem_3_Extra:SetText(ORANGE..AL["Season 3"]);
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Mace_36");
    AtlasLootMenuItem_3.lootpage="ARENA3SET";
    AtlasLootMenuItem_3:Show();
    -- Arena PvP Armor Sets - Season 4
    AtlasLootMenuItem_4_Name:SetText(AL["Arena PvP Sets"]);
    AtlasLootMenuItem_4_Extra:SetText(ORANGE..AL["Season 4"]);
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Mace_36");
    AtlasLootMenuItem_4.lootpage="ARENA4SET";
    AtlasLootMenuItem_4:Show();
    -- Arena Weapons - Season 2
    AtlasLootMenuItem_17_Name:SetText(AL["Arena PvP Weapons"]);
    AtlasLootMenuItem_17_Extra:SetText(ORANGE..AL["Season 2"]);
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Weapon_Crossbow_10");
    AtlasLootMenuItem_17.lootpage="Arena2Weapons1";
    AtlasLootMenuItem_17:Show();
    -- Arena Weapons - Season 3
    AtlasLootMenuItem_18_Name:SetText(AL["Arena PvP Weapons"]);
    AtlasLootMenuItem_18_Extra:SetText(ORANGE..AL["Season 3"]);
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_Weapon_Crossbow_10");
    AtlasLootMenuItem_18.lootpage="Arena3Weapons1";
    AtlasLootMenuItem_18:Show();
    -- Arena Weapons - Season 4
    AtlasLootMenuItem_19_Name:SetText(AL["Arena PvP Weapons"]);
    AtlasLootMenuItem_19_Extra:SetText(ORANGE..AL["Season 4"]);
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_Weapon_Crossbow_10");
    AtlasLootMenuItem_19.lootpage="Arena4Weapons1";
    AtlasLootMenuItem_19:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Arena PvP System"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootPvPNonSetEpics()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "HONORMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    -- Cloth
    AtlasLootMenuItem_2_Name:SetText(BabbleInventory["Cloth"]);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Boots_Cloth_12");
    AtlasLootMenuItem_2.lootpage="PvP70NonSet2";
    AtlasLootMenuItem_2:Show();
    -- Leather
    AtlasLootMenuItem_17_Name:SetText(BabbleInventory["Leather"]);
    AtlasLootMenuItem_17_Extra:SetText("");
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Boots_08");
    AtlasLootMenuItem_17.lootpage="PvP70NonSet3";
    AtlasLootMenuItem_17:Show();
    -- Mail
    AtlasLootMenuItem_3_Name:SetText(BabbleInventory["Mail"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Boots_Plate_06");
    AtlasLootMenuItem_3.lootpage="PvP70NonSet4";
    AtlasLootMenuItem_3:Show();
    -- Plate
    AtlasLootMenuItem_18_Name:SetText(BabbleInventory["Plate"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_Boots_Plate_04");
    AtlasLootMenuItem_18.lootpage="PvP70NonSet5";
    AtlasLootMenuItem_18:Show();
    -- Accessories
    AtlasLootMenuItem_4_Name:SetText(AL["PvP Accessories"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Necklace_36");
    AtlasLootMenuItem_4.lootpage="PvP70NonSet1";
    AtlasLootMenuItem_4:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["PvP Non-Set Epics"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootWSGRewardsMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "PVPMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Warsong Gulch - Lvl 60 Rewards
    AtlasLootMenuItem_2_Name:SetText(AL["Level 60 Rewards"]);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Misc_Rune_07");
    AtlasLootMenuItem_2.lootpage="WSG60";
    AtlasLootMenuItem_2:Show();
    --Warsong Gulch - Lvl 50-59 Rewards
    AtlasLootMenuItem_17_Name:SetText(AL["Level 50-59 Rewards"]);
    AtlasLootMenuItem_17_Extra:SetText("");
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Misc_Rune_07");
    AtlasLootMenuItem_17.lootpage="WSG5059";
    AtlasLootMenuItem_17:Show();
    --Warsong Gulch - Lvl 40-49 Rewards
    AtlasLootMenuItem_3_Name:SetText(AL["Level 40-49 Rewards"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Misc_Rune_07");
    AtlasLootMenuItem_3.lootpage="WSG4049";
    AtlasLootMenuItem_3:Show();
    --Warsong Gulch - Lvl 30-39 Rewards
    AtlasLootMenuItem_18_Name:SetText(AL["Level 30-39 Rewards"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_Misc_Rune_07");
    AtlasLootMenuItem_18.lootpage="WSG3039";
    AtlasLootMenuItem_18:Show();
    --Warsong Gulch - Lvl 20-29 Rewards
    AtlasLootMenuItem_4_Name:SetText(AL["Level 20-29 Rewards"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Misc_Rune_07");
    AtlasLootMenuItem_4.lootpage="WSG2029";
    AtlasLootMenuItem_4:Show();
    --Warsong Gulch - Lvl 10-19 Rewards
    AtlasLootMenuItem_19_Name:SetText(AL["Level 10-19 Rewards"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_Misc_Rune_07");
    AtlasLootMenuItem_19.lootpage="WSG1019";
    AtlasLootMenuItem_19:Show();
    --Warsong Gulch - Misc Rewards
    AtlasLootMenuItem_5_Name:SetText(AL["Misc. Rewards"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\INV_Misc_Rune_07");
    AtlasLootMenuItem_5.lootpage="WSGMisc";
    AtlasLootMenuItem_5:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..BabbleZone["Warsong Gulch"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootABRewardsMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "PVPMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Arathi Basin - Lvl 60 Rewards
    AtlasLootMenuItem_2_Name:SetText(AL["Level 60 Rewards"]);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Amulet_07");
    AtlasLootMenuItem_2.lootpage="AB60";
    AtlasLootMenuItem_2:Show();
    --Arathi Basin - Lvl 50-59 Rewards
    AtlasLootMenuItem_17_Name:SetText(AL["Level 50-59 Rewards"]);
    AtlasLootMenuItem_17_Extra:SetText("");
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Amulet_07");
    AtlasLootMenuItem_17.lootpage="AB5059";
    AtlasLootMenuItem_17:Show();
    --Arathi Basin - Lvl 40-49 Rewards
    AtlasLootMenuItem_3_Name:SetText(AL["Level 40-49 Rewards"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Amulet_07");
    AtlasLootMenuItem_3.lootpage="AB40491";
    AtlasLootMenuItem_3:Show();
    --Arathi Basin - Lvl 30-39 Rewards
    AtlasLootMenuItem_18_Name:SetText(AL["Level 30-39 Rewards"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Amulet_07");
    AtlasLootMenuItem_18.lootpage="AB3039";
    AtlasLootMenuItem_18:Show();
    --Arathi Basin - Lvl 20-29 Rewards
    AtlasLootMenuItem_4_Name:SetText(AL["Level 20-29 Rewards"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Amulet_07");
    AtlasLootMenuItem_4.lootpage="AB20291";
    AtlasLootMenuItem_4:Show();
    --Arathi Basin - Misc Rewards
    AtlasLootMenuItem_19_Name:SetText(AL["Misc. Rewards"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Amulet_07");
    AtlasLootMenuItem_19.lootpage="ABMisc";
    AtlasLootMenuItem_19:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..BabbleZone["Arathi Basin"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

