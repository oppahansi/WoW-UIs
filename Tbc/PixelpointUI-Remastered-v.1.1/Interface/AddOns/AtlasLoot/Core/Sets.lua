local BabbleClass = LibStub("LibBabble-Class-3.0"):GetLookupTable();
local BabbleZone = LibStub("LibBabble-Zone-3.0"):GetLookupTable();
local BabbleInventory = LibStub("LibBabble-Inventory-3.0"):GetLookupTable();
local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

local RED = "|cffff0000";
local ORANGE = "|cffFF8400";

function AtlasLootSetMenu()
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
    --World Epics
    AtlasLootMenuItem_2_Name:SetText(AL["BoE World Epics"]);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Sword_76");
    AtlasLootMenuItem_2.lootpage="WORLDEPICS";
    AtlasLootMenuItem_2:Show();
    --Pre 60 Sets
    AtlasLootMenuItem_3_Name:SetText(AL["Pre 60 Sets"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Sword_43");
    AtlasLootMenuItem_3.lootpage="PRE60SET";
    AtlasLootMenuItem_3:Show();
    --Legendaries
    AtlasLootMenuItem_4_Name:SetText(AL["Legendary Items"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Staff_Medivh");
    AtlasLootMenuItem_4.lootpage="Legendaries";
    AtlasLootMenuItem_4:Show();
    --Rare Mounts
    AtlasLootMenuItem_5_Name:SetText(AL["Rare Mounts"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\INV_Misc_QirajiCrystal_05");
    AtlasLootMenuItem_5.lootpage="RareMounts1";
    AtlasLootMenuItem_5:Show();
    --Tabards
    AtlasLootMenuItem_6_Name:SetText(AL["Tabards"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\INV_Shirt_GuildTabard_01");
    AtlasLootMenuItem_6.lootpage="Tabards1";
    AtlasLootMenuItem_6:Show();
    --Hard Mode Tokens
    AtlasLootMenuItem_7_Name:SetText(AL["Badge of Justice Rewards"]);
    AtlasLootMenuItem_7_Extra:SetText("");
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\Spell_Holy_ChampionsBond");
    AtlasLootMenuItem_7.lootpage="70TOKENMENU";
    AtlasLootMenuItem_7:Show();
    --Upper Deck Card Game Items
    AtlasLootMenuItem_8_Name:SetText(AL["Upper Deck Card Game Items"]);
    AtlasLootMenuItem_8_Extra:SetText("");
    AtlasLootMenuItem_8_Icon:SetTexture("Interface\\Icons\\INV_Misc_Ticket_Tarot_Madness");
    AtlasLootMenuItem_8.lootpage="CardGame1";
    AtlasLootMenuItem_8:Show();
    --PvP Rewards
    AtlasLootMenuItem_10_Name:SetText(AL["PvP Rewards"]);
    AtlasLootMenuItem_10_Extra:SetText("");
    AtlasLootMenuItem_10_Icon:SetTexture("Interface\\Icons\\INV_Axe_02");
    AtlasLootMenuItem_10.lootpage="PVPMENU";
    AtlasLootMenuItem_10:Show();
    --ZG Class Sets
    AtlasLootMenuItem_17_Name:SetText(AL["Zul'Gurub Sets"]);
    AtlasLootMenuItem_17_Extra:SetText("");
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Necklace_19");
    AtlasLootMenuItem_17.lootpage="ZGSET";
    AtlasLootMenuItem_17:Show();
    --AQ20 Class Sets
    AtlasLootMenuItem_18_Name:SetText(AL["Ruins of Ahn'Qiraj Sets"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Ring_AhnQiraj_03");
    AtlasLootMenuItem_18.lootpage="AQ20Sets1";
    AtlasLootMenuItem_18:Show();
    --AQ40 Class Sets
    AtlasLootMenuItem_19_Name:SetText(AL["Temple of Ahn'Qiraj Sets"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_Sword_59");
    AtlasLootMenuItem_19.lootpage="AQ40Sets1";
    AtlasLootMenuItem_19:Show();
    --Dungeon Set 1/2
    AtlasLootMenuItem_21_Name:SetText(AL["Dungeon 1/2 Sets"]);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Chest_Chain_03");
    AtlasLootMenuItem_21.lootpage="T0SET";
    AtlasLootMenuItem_21:Show();
    --Dungeon Set 3
    AtlasLootMenuItem_22_Name:SetText(AL["Dungeon 3 Sets"]);
    AtlasLootMenuItem_22_Extra:SetText("");
    AtlasLootMenuItem_22_Icon:SetTexture("Interface\\Icons\\INV_Helmet_15");
    AtlasLootMenuItem_22.lootpage="DS3SET";
    AtlasLootMenuItem_22:Show();
    --Tier 1/2 Sets
    AtlasLootMenuItem_23_Name:SetText(AL["Tier 1/2 Sets"]);
    AtlasLootMenuItem_23_Extra:SetText("");
    AtlasLootMenuItem_23_Icon:SetTexture("Interface\\Icons\\INV_Pants_Mail_03");
    AtlasLootMenuItem_23.lootpage="T1T2SET";
    AtlasLootMenuItem_23:Show();
    --Tier 3 Sets
    AtlasLootMenuItem_24_Name:SetText(AL["Tier 3 Sets"]);
    AtlasLootMenuItem_24_Extra:SetText("");
    AtlasLootMenuItem_24_Icon:SetTexture("Interface\\Icons\\INV_Pants_Cloth_05");
    AtlasLootMenuItem_24.lootpage="T3SET";
    AtlasLootMenuItem_24:Show();
    --Tier 4 Sets
    AtlasLootMenuItem_25_Name:SetText(AL["Tier 4 Sets"]);
    AtlasLootMenuItem_25_Extra:SetText("");
    AtlasLootMenuItem_25_Icon:SetTexture("Interface\\Icons\\INV_Shoulder_14");
    AtlasLootMenuItem_25.lootpage="T4SET";
    AtlasLootMenuItem_25:Show();
    --Tier 5 Sets
    AtlasLootMenuItem_26_Name:SetText(AL["Tier 5 Sets"]);
    AtlasLootMenuItem_26_Extra:SetText("");
    AtlasLootMenuItem_26_Icon:SetTexture("Interface\\Icons\\INV_Crown_01");
    AtlasLootMenuItem_26.lootpage="T5SET";
    AtlasLootMenuItem_26:Show();
    -- Tier 6 Sets
    AtlasLootMenuItem_27_Name:SetText(AL["Tier 6 Sets"]);
    AtlasLootMenuItem_27_Extra:SetText("");
    AtlasLootMenuItem_27_Icon:SetTexture("Interface\\Icons\\INV_Gauntlets_63");
    AtlasLootMenuItem_27.lootpage="T6SET";
    AtlasLootMenuItem_27:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Collections"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootWorldEpicsMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "SETMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Lvl 70 BoE World Epics
    AtlasLootMenuItem_2_Name:SetText(AL["Level 70"]);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Sword_76");
    AtlasLootMenuItem_2.lootpage="WorldEpics4";
    AtlasLootMenuItem_2:Show();
    --Lvl 50-60 BoE World Epics
    AtlasLootMenuItem_17_Name:SetText(AL["Level 50-60"]);
    AtlasLootMenuItem_17_Extra:SetText("");
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Amulet_01");
    AtlasLootMenuItem_17.lootpage="WorldEpics3";
    AtlasLootMenuItem_17:Show();
    --Lvl 40-49 BoE World Epics
    AtlasLootMenuItem_3_Name:SetText(AL["Level 40-49"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Staff_29");
    AtlasLootMenuItem_3.lootpage="WorldEpics2";
    AtlasLootMenuItem_3:Show();
    --Lvl 30-39 BoE World Epics
    AtlasLootMenuItem_18_Name:SetText(AL["Level 30-39"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Ring_15");
    AtlasLootMenuItem_18.lootpage="WorldEpics1";
    AtlasLootMenuItem_18:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["BoE World Epics"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end
    
function AtlasLoot70TokenMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "SETMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Hard Mode: Cloth
    AtlasLootMenuItem_2_Name:SetText(BabbleInventory["Cloth"]);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\Spell_Holy_ChampionsBond");
    AtlasLootMenuItem_2.lootpage="HardModeCloth";
    AtlasLootMenuItem_2:Show();
    --Hard Mode: Leather
    AtlasLootMenuItem_17_Name:SetText(BabbleInventory["Leather"]);
    AtlasLootMenuItem_17_Extra:SetText("");
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\Spell_Holy_ChampionsBond");
    AtlasLootMenuItem_17.lootpage="HardModeLeather";
    AtlasLootMenuItem_17:Show();
    --Hard Mode: Mail
    AtlasLootMenuItem_3_Name:SetText(BabbleInventory["Mail"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\Spell_Holy_ChampionsBond");
    AtlasLootMenuItem_3.lootpage="HardModeMail";
    AtlasLootMenuItem_3:Show();
    --Hard Mode: Plate
    AtlasLootMenuItem_18_Name:SetText(BabbleInventory["Plate"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Spell_Holy_ChampionsBond");
    AtlasLootMenuItem_18.lootpage="HardModePlate";
    AtlasLootMenuItem_18:Show();
    --Hard Mode Tokens: FR Gear
    AtlasLootMenuItem_4_Name:SetText(AL["Fire Resistance Gear"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\Spell_Holy_ChampionsBond");
    AtlasLootMenuItem_4.lootpage="HardModeResist";
    AtlasLootMenuItem_4:Show();
    --Hard Mode Tokens: Cloaks
    AtlasLootMenuItem_19_Name:SetText(BabbleInventory["Back"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\Spell_Holy_ChampionsBond");
    AtlasLootMenuItem_19.lootpage="HardModeCloaks";
    AtlasLootMenuItem_19:Show();
    --Hard Mode Tokens: Relics
    AtlasLootMenuItem_6_Name:SetText(BabbleInventory["Relic"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Spell_Holy_ChampionsBond");
    AtlasLootMenuItem_6.lootpage="HardModeRelic";
    AtlasLootMenuItem_6:Show();
    --Hard Mode Tokens: Accessories
    AtlasLootMenuItem_21_Name:SetText(AL["Arena Reward"]);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\Spell_Holy_ChampionsBond");
    AtlasLootMenuItem_21.lootpage="HardModeArena";
    AtlasLootMenuItem_21:Show();
    --Hard Mode Tokens: Weapons
    AtlasLootMenuItem_8_Name:SetText(AL["Weapons"]);
    AtlasLootMenuItem_8_Extra:SetText("");
    AtlasLootMenuItem_8_Icon:SetTexture("Interface\\Icons\\Spell_Holy_ChampionsBond");
    AtlasLootMenuItem_8.lootpage="HardModeWeapons";
    AtlasLootMenuItem_8:Show();
    --Hard Mode Tokens: Accessories
    AtlasLootMenuItem_23_Name:SetText(AL["Accessories"]);
    AtlasLootMenuItem_23_Extra:SetText("");
    AtlasLootMenuItem_23_Icon:SetTexture("Interface\\Icons\\Spell_Holy_ChampionsBond");
    AtlasLootMenuItem_23.lootpage="HardModeAccessories";
    AtlasLootMenuItem_23:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Badge of Justice Rewards"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootPRE60SetMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "SETMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --The Deadmines - Defias Leather
    AtlasLootMenuItem_2_Name:SetText(AL["Defias Leather"]);
    AtlasLootMenuItem_2_Extra:SetText(ORANGE..BabbleZone["The Deadmines"]);
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Pants_12");
    AtlasLootMenuItem_2.lootpage="VWOWDeadmines";
    AtlasLootMenuItem_2:Show();
    --Wailing Caverns - Embrace of the Viper
    AtlasLootMenuItem_3_Name:SetText(AL["Embrace of the Viper"]);
    AtlasLootMenuItem_3_Extra:SetText(ORANGE..BabbleZone["Wailing Caverns"]);
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Shirt_16");
    AtlasLootMenuItem_3.lootpage="VWOWWailingC";
    AtlasLootMenuItem_3:Show();
    --Scarlet Monastery - Chain of the Scarlet Crusade
    AtlasLootMenuItem_4_Name:SetText(AL["Chain of the Scarlet Crusade"]);
    AtlasLootMenuItem_4_Extra:SetText(ORANGE..BabbleZone["Scarlet Monastery"]);
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Gauntlets_19");
    AtlasLootMenuItem_4.lootpage="VWOWScarletM";
    AtlasLootMenuItem_4:Show();
    --Blackrock Depths - The Gladiator
    AtlasLootMenuItem_5_Name:SetText(AL["The Gladiator"]);
    AtlasLootMenuItem_5_Extra:SetText(ORANGE..BabbleZone["Blackrock Depths"]);
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\INV_Helmet_01");
    AtlasLootMenuItem_5.lootpage="VWOWBlackrockD";
    AtlasLootMenuItem_5:Show();
    --Ironweave Battlesuit
    AtlasLootMenuItem_6_Name:SetText(AL["Ironweave Battlesuit"]);
    AtlasLootMenuItem_6_Extra:SetText(ORANGE..AL["Various Locations"]);
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\INV_Boots_Cloth_05");
    AtlasLootMenuItem_6.lootpage="VWOWIronweave";
    AtlasLootMenuItem_6:Show();
    --Stratholme - The Postmaster
    AtlasLootMenuItem_7_Name:SetText(AL["The Postmaster"]);
    AtlasLootMenuItem_7_Extra:SetText(ORANGE..BabbleZone["Stratholme"]);
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Boots_02");
    AtlasLootMenuItem_7.lootpage="VWOWStrat";
    AtlasLootMenuItem_7:Show();
    --Scholomance - Cloth - Necropile Raiment
    AtlasLootMenuItem_8_Name:SetText(AL["Necropile Raiment"]);
    AtlasLootMenuItem_8_Extra:SetText(ORANGE..BabbleZone["Scholomance"]);
    AtlasLootMenuItem_8_Icon:SetTexture("Interface\\Icons\\INV_Shoulder_02");
    AtlasLootMenuItem_8.lootpage="VWOWScholo";
    AtlasLootMenuItem_8:Show();
    --Scholomance - Leather - Cadaverous Garb
    AtlasLootMenuItem_9_Name:SetText(AL["Cadaverous Garb"]);
    AtlasLootMenuItem_9_Extra:SetText(ORANGE..BabbleZone["Scholomance"]);
    AtlasLootMenuItem_9_Icon:SetTexture("Interface\\Icons\\INV_Belt_16");
    AtlasLootMenuItem_9.lootpage="VWOWScholo";
    AtlasLootMenuItem_9:Show();
    --Scholomance - Mail - Bloodmail Regalia
    AtlasLootMenuItem_10_Name:SetText(AL["Bloodmail Regalia"]);
    AtlasLootMenuItem_10_Extra:SetText(ORANGE..BabbleZone["Scholomance"]);
    AtlasLootMenuItem_10_Icon:SetTexture("Interface\\Icons\\INV_Gauntlets_26");
    AtlasLootMenuItem_10.lootpage="VWOWScholo";
    AtlasLootMenuItem_10:Show();
    --Scholomance - Plate - Deathbone Guardian
    AtlasLootMenuItem_11_Name:SetText(AL["Deathbone Guardian"]);
    AtlasLootMenuItem_11_Extra:SetText(ORANGE..BabbleZone["Scholomance"]);
    AtlasLootMenuItem_11_Icon:SetTexture("Interface\\Icons\\INV_Belt_12");
    AtlasLootMenuItem_11.lootpage="VWOWScholo";
    AtlasLootMenuItem_11:Show();
    --Scourge Invasion
    AtlasLootMenuItem_12_Name:SetText(AL["Scourge Invasion"]);
    AtlasLootMenuItem_12_Extra:SetText(ORANGE..AL["Various Locations"]);
    AtlasLootMenuItem_12_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Talisman_13");
    AtlasLootMenuItem_12.lootpage="VWOWScourgeInvasion";
    AtlasLootMenuItem_12:Show();
    --Spider's Kiss
    AtlasLootMenuItem_17_Name:SetText(AL["Spider's Kiss"]);
    AtlasLootMenuItem_17_Extra:SetText(ORANGE..BabbleZone["Lower Blackrock Spire"]);
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Weapon_ShortBlade_16");
    AtlasLootMenuItem_17.lootpage="VWOWSpiderKiss";
    AtlasLootMenuItem_17:Show();
    --Dal'Rend's Arms
    AtlasLootMenuItem_18_Name:SetText(AL["Dal'Rend's Arms"]);
    AtlasLootMenuItem_18_Extra:SetText(ORANGE..BabbleZone["Upper Blackrock Spire"]);
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_Sword_43");
    AtlasLootMenuItem_18.lootpage="VWOWDalRend";
    AtlasLootMenuItem_18:Show();
    --Zul'Gurub Rings
    AtlasLootMenuItem_19_Name:SetText(AL["Zul'Gurub Rings"]);
    AtlasLootMenuItem_19_Extra:SetText(ORANGE..BabbleZone["Zul'Gurub"]);
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_Bijou_Orange");
    AtlasLootMenuItem_19.lootpage="VWOWZulGurub";
    AtlasLootMenuItem_19:Show();
    --Primal Blessing
    AtlasLootMenuItem_20_Name:SetText(AL["Primal Blessing"]);
    AtlasLootMenuItem_20_Extra:SetText(ORANGE..BabbleZone["Zul'Gurub"]);
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\INV_Weapon_Hand_01");
    AtlasLootMenuItem_20.lootpage="VWOWZulGurub";
    AtlasLootMenuItem_20:Show();
    --The Twin Blades of Hakkari
    AtlasLootMenuItem_21_Name:SetText(AL["The Twin Blades of Hakkari"]);
    AtlasLootMenuItem_21_Extra:SetText(ORANGE..BabbleZone["Zul'Gurub"]);
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Sword_55");
    AtlasLootMenuItem_21.lootpage="VWOWZulGurub";
    AtlasLootMenuItem_21:Show();
    --Shard of the Gods
    AtlasLootMenuItem_22_Name:SetText(AL["Shard of the Gods"]);
    AtlasLootMenuItem_22_Extra:SetText(ORANGE..AL["Various Locations"]);
    AtlasLootMenuItem_22_Icon:SetTexture("Interface\\Icons\\INV_Misc_MonsterScales_15");
    AtlasLootMenuItem_22.lootpage="VWOWShardOfGods";
    AtlasLootMenuItem_22:Show();
    --Spirit of Eskhandar
    AtlasLootMenuItem_23_Name:SetText(AL["Spirit of Eskhandar"]);
    AtlasLootMenuItem_23_Extra:SetText(ORANGE..AL["Various Locations"]);
    AtlasLootMenuItem_23_Icon:SetTexture("Interface\\Icons\\INV_Misc_MonsterClaw_04");
    AtlasLootMenuItem_23.lootpage="VWOWSpiritofEskhandar";
    AtlasLootMenuItem_23:Show();
    --Latro's Flurry
    AtlasLootMenuItem_25_Name:SetText(AL["Latro's Flurry"]);
    AtlasLootMenuItem_25_Extra:SetText(ORANGE..AL["World Drop"]);
    AtlasLootMenuItem_25_Icon:SetTexture("Interface\\Icons\\INV_Sword_76");
    AtlasLootMenuItem_25.lootpage="TBCSets";
    AtlasLootMenuItem_25:Show();
    --The Twin Stars
    AtlasLootMenuItem_26_Name:SetText(AL["The Twin Stars"]);
    AtlasLootMenuItem_26_Extra:SetText(ORANGE..AL["World Drop"]);
    AtlasLootMenuItem_26_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Necklace_36");
    AtlasLootMenuItem_26.lootpage="TBCSets";
    AtlasLootMenuItem_26:Show();
    --The Twin Blades of Azzinoth
    AtlasLootMenuItem_27_Name:SetText(AL["The Twin Blades of Azzinoth"]);
    AtlasLootMenuItem_27_Extra:SetText(ORANGE..BabbleZone["Black Temple"]);
    AtlasLootMenuItem_27_Icon:SetTexture("Interface\\Icons\\INV_Weapon_Glave_01");
    AtlasLootMenuItem_27.lootpage="TBCSets";
    AtlasLootMenuItem_27:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Pre 60 Sets"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootZGSetMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "SETMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Druid
    AtlasLootMenuItem_3_Name:SetText(BabbleClass["Druid"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\Spell_Nature_Regeneration");
    AtlasLootMenuItem_3.lootpage="ZGDruid";
    AtlasLootMenuItem_3:Show();
    --Mage
    AtlasLootMenuItem_4_Name:SetText(BabbleClass["Mage"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\Spell_Frost_IceStorm");
    AtlasLootMenuItem_4.lootpage="ZGMage";
    AtlasLootMenuItem_4:Show();
    --Priest
    AtlasLootMenuItem_5_Name:SetText(BabbleClass["Priest"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Spell_Holy_PowerWordShield");
    AtlasLootMenuItem_5.lootpage="ZGPriest";
    AtlasLootMenuItem_5:Show();
    --Shaman
    AtlasLootMenuItem_6_Name:SetText(BabbleClass["Shaman"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Spell_FireResistanceTotem_01");
    AtlasLootMenuItem_6.lootpage="ZGShaman";
    AtlasLootMenuItem_6:Show();
    --Warrior
    AtlasLootMenuItem_7_Name:SetText(BabbleClass["Warrior"]);
    AtlasLootMenuItem_7_Extra:SetText("");
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Shield_05");
    AtlasLootMenuItem_7.lootpage="ZGWarrior";
    AtlasLootMenuItem_7:Show();
    --Hunter
    AtlasLootMenuItem_18_Name:SetText(BabbleClass["Hunter"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Ability_Hunter_RunningShot");
    AtlasLootMenuItem_18.lootpage="ZGHunter";
    AtlasLootMenuItem_18:Show();
    --Paladin
    AtlasLootMenuItem_19_Name:SetText(BabbleClass["Paladin"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\Spell_Holy_SealOfMight");
    AtlasLootMenuItem_19.lootpage="ZGPaladin";
    AtlasLootMenuItem_19:Show();
    --Rogue
    AtlasLootMenuItem_20_Name:SetText(BabbleClass["Rogue"]);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\Ability_BackStab");
    AtlasLootMenuItem_20.lootpage="ZGRogue";
    AtlasLootMenuItem_20:Show();
    --Warlock
    AtlasLootMenuItem_21_Name:SetText(BabbleClass["Warlock"]);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Pants_Cloth_05");
    AtlasLootMenuItem_21.lootpage="ZGWarlock";
    AtlasLootMenuItem_21:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Zul'Gurub Sets"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootPVPSetMenu()
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
    --Druid
    AtlasLootMenuItem_3_Name:SetText(BabbleClass["Druid"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\Spell_Nature_Regeneration");
    AtlasLootMenuItem_3.lootpage="PVPDruid";
    AtlasLootMenuItem_3:Show();
    --Mage
    AtlasLootMenuItem_4_Name:SetText(BabbleClass["Mage"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\Spell_Frost_IceStorm");
    AtlasLootMenuItem_4.lootpage="PVPMage";
    AtlasLootMenuItem_4:Show();
    --Priest
    AtlasLootMenuItem_5_Name:SetText(BabbleClass["Priest"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Spell_Holy_PowerWordShield");
    AtlasLootMenuItem_5.lootpage="PVPPriest";
    AtlasLootMenuItem_5:Show();
    --Shaman
    AtlasLootMenuItem_6_Name:SetText(BabbleClass["Shaman"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Spell_FireResistanceTotem_01");
    AtlasLootMenuItem_6.lootpage="PVPShaman";
    AtlasLootMenuItem_6:Show();
    --Warrior
    AtlasLootMenuItem_7_Name:SetText(BabbleClass["Warrior"]);
    AtlasLootMenuItem_7_Extra:SetText("");
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Shield_05");
    AtlasLootMenuItem_7.lootpage="PVPWarrior";
    AtlasLootMenuItem_7:Show();
    --Hunter
    AtlasLootMenuItem_18_Name:SetText(BabbleClass["Hunter"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Ability_Hunter_RunningShot");
    AtlasLootMenuItem_18.lootpage="PVPHunter";
    AtlasLootMenuItem_18:Show();
    --Paladin
    AtlasLootMenuItem_19_Name:SetText(BabbleClass["Paladin"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\Spell_Holy_SealOfMight");
    AtlasLootMenuItem_19.lootpage="PVPPaladin";
    AtlasLootMenuItem_19:Show();
    --Rogue
    AtlasLootMenuItem_20_Name:SetText(BabbleClass["Rogue"]);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\Ability_BackStab");
    AtlasLootMenuItem_20.lootpage="PVPRogue";
    AtlasLootMenuItem_20:Show();
    --Warlock
    AtlasLootMenuItem_21_Name:SetText(BabbleClass["Warlock"]);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Pants_Cloth_05");
    AtlasLootMenuItem_21.lootpage="PVPWarlock";
    AtlasLootMenuItem_21:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["PvP Armor Sets"]..": "..AL["Level 60"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootPVP70RepSetMenu()
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
    --Druid
    AtlasLootMenuItem_3_Name:SetText(BabbleClass["Druid"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\Spell_Nature_Regeneration");
    AtlasLootMenuItem_3.lootpage="PVP70RepDruid";
    AtlasLootMenuItem_3:Show();
    --Mage
    AtlasLootMenuItem_4_Name:SetText(BabbleClass["Mage"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\Spell_Frost_IceStorm");
    AtlasLootMenuItem_4.lootpage="PVP70RepMage";
    AtlasLootMenuItem_4:Show();
    --Priest
    AtlasLootMenuItem_5_Name:SetText(BabbleClass["Priest"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Spell_Holy_PowerWordShield");
    AtlasLootMenuItem_5.lootpage="PVP70RepPriest";
    AtlasLootMenuItem_5:Show();
    --Shaman
    AtlasLootMenuItem_6_Name:SetText(BabbleClass["Shaman"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Spell_FireResistanceTotem_01");
    AtlasLootMenuItem_6.lootpage="PVP70RepShaman";
    AtlasLootMenuItem_6:Show();
    --Warrior
    AtlasLootMenuItem_7_Name:SetText(BabbleClass["Warrior"]);
    AtlasLootMenuItem_7_Extra:SetText("");
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Shield_05");
    AtlasLootMenuItem_7.lootpage="PVP70RepWarrior";
    AtlasLootMenuItem_7:Show();
    --Hunter
    AtlasLootMenuItem_18_Name:SetText(BabbleClass["Hunter"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Ability_Hunter_RunningShot");
    AtlasLootMenuItem_18.lootpage="PVP70RepHunter";
    AtlasLootMenuItem_18:Show();
    --Paladin
    AtlasLootMenuItem_19_Name:SetText(BabbleClass["Paladin"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\Spell_Holy_SealOfMight");
    AtlasLootMenuItem_19.lootpage="PVP70RepPaladin";
    AtlasLootMenuItem_19:Show();
    --Rogue
    AtlasLootMenuItem_20_Name:SetText(BabbleClass["Rogue"]);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\Ability_BackStab");
    AtlasLootMenuItem_20.lootpage="PVP70RepRogue";
    AtlasLootMenuItem_20:Show();
    --Warlock
    AtlasLootMenuItem_21_Name:SetText(BabbleClass["Warlock"]);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Pants_Cloth_05");
    AtlasLootMenuItem_21.lootpage="PVP70RepWarlock";
    AtlasLootMenuItem_21:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["PvP Reputation Sets"]..": "..AL["Level 70"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootARENASetMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "ARENAMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Druid
    AtlasLootMenuItem_3_Name:SetText(BabbleClass["Druid"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\Spell_Nature_Regeneration");
    AtlasLootMenuItem_3.lootpage="ArenaDruid";
    AtlasLootMenuItem_3:Show();
    --Mage
    AtlasLootMenuItem_4_Name:SetText(BabbleClass["Mage"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\Spell_Frost_IceStorm");
    AtlasLootMenuItem_4.lootpage="ArenaMage";
    AtlasLootMenuItem_4:Show();
    --Priest
    AtlasLootMenuItem_5_Name:SetText(BabbleClass["Priest"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Spell_Holy_PowerWordShield");
    AtlasLootMenuItem_5.lootpage="ArenaPriest";
    AtlasLootMenuItem_5:Show();
    --Shaman
    AtlasLootMenuItem_6_Name:SetText(BabbleClass["Shaman"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Spell_FireResistanceTotem_01");
    AtlasLootMenuItem_6.lootpage="ArenaShaman";
    AtlasLootMenuItem_6:Show();
    --Warrior
    AtlasLootMenuItem_7_Name:SetText(BabbleClass["Warrior"]);
    AtlasLootMenuItem_7_Extra:SetText("");
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Shield_05");
    AtlasLootMenuItem_7.lootpage="ArenaWarrior";
    AtlasLootMenuItem_7:Show();
    --Hunter
    AtlasLootMenuItem_18_Name:SetText(BabbleClass["Hunter"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Ability_Hunter_RunningShot");
    AtlasLootMenuItem_18.lootpage="ArenaHunter";
    AtlasLootMenuItem_18:Show();
    --Paladin
    AtlasLootMenuItem_19_Name:SetText(BabbleClass["Paladin"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\Spell_Holy_SealOfMight");
    AtlasLootMenuItem_19.lootpage="ArenaPaladin";
    AtlasLootMenuItem_19:Show();
    --Rogue
    AtlasLootMenuItem_20_Name:SetText(BabbleClass["Rogue"]);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\Ability_BackStab");
    AtlasLootMenuItem_20.lootpage="ArenaRogue";
    AtlasLootMenuItem_20:Show();
    --Warlock
    AtlasLootMenuItem_21_Name:SetText(BabbleClass["Warlock"]);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Pants_Cloth_05");
    AtlasLootMenuItem_21.lootpage="ArenaWarlock";
    AtlasLootMenuItem_21:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Arena PvP Sets"]..": "..AL["Season 1"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootARENA2SetMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "ARENAMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Druid
    AtlasLootMenuItem_3_Name:SetText(BabbleClass["Druid"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\Spell_Nature_Regeneration");
    AtlasLootMenuItem_3.lootpage="Arena2Druid";
    AtlasLootMenuItem_3:Show();
    --Mage
    AtlasLootMenuItem_4_Name:SetText(BabbleClass["Mage"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\Spell_Frost_IceStorm");
    AtlasLootMenuItem_4.lootpage="Arena2Mage";
    AtlasLootMenuItem_4:Show();
    --Priest
    AtlasLootMenuItem_5_Name:SetText(BabbleClass["Priest"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Spell_Holy_PowerWordShield");
    AtlasLootMenuItem_5.lootpage="Arena2Priest";
    AtlasLootMenuItem_5:Show();
    --Shaman
    AtlasLootMenuItem_6_Name:SetText(BabbleClass["Shaman"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Spell_FireResistanceTotem_01");
    AtlasLootMenuItem_6.lootpage="Arena2Shaman";
    AtlasLootMenuItem_6:Show();
    --Warrior
    AtlasLootMenuItem_7_Name:SetText(BabbleClass["Warrior"]);
    AtlasLootMenuItem_7_Extra:SetText("");
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Shield_05");
    AtlasLootMenuItem_7.lootpage="Arena2Warrior";
    AtlasLootMenuItem_7:Show();
    --Hunter
    AtlasLootMenuItem_18_Name:SetText(BabbleClass["Hunter"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Ability_Hunter_RunningShot");
    AtlasLootMenuItem_18.lootpage="Arena2Hunter";
    AtlasLootMenuItem_18:Show();
    --Paladin
    AtlasLootMenuItem_19_Name:SetText(BabbleClass["Paladin"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\Spell_Holy_SealOfMight");
    AtlasLootMenuItem_19.lootpage="Arena2Paladin";
    AtlasLootMenuItem_19:Show();
    --Rogue
    AtlasLootMenuItem_20_Name:SetText(BabbleClass["Rogue"]);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\Ability_BackStab");
    AtlasLootMenuItem_20.lootpage="Arena2Rogue";
    AtlasLootMenuItem_20:Show();
    --Warlock
    AtlasLootMenuItem_21_Name:SetText(BabbleClass["Warlock"]);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Pants_Cloth_05");
    AtlasLootMenuItem_21.lootpage="Arena2Warlock";
    AtlasLootMenuItem_21:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Arena PvP Sets"]..": "..AL["Season 2"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootARENA3SetMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "ARENAMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Druid
    AtlasLootMenuItem_3_Name:SetText(BabbleClass["Druid"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\Spell_Nature_Regeneration");
    AtlasLootMenuItem_3.lootpage="Arena3Druid";
    AtlasLootMenuItem_3:Show();
    --Mage
    AtlasLootMenuItem_4_Name:SetText(BabbleClass["Mage"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\Spell_Frost_IceStorm");
    AtlasLootMenuItem_4.lootpage="Arena3Mage";
    AtlasLootMenuItem_4:Show();
    --Priest
    AtlasLootMenuItem_5_Name:SetText(BabbleClass["Priest"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Spell_Holy_PowerWordShield");
    AtlasLootMenuItem_5.lootpage="Arena3Priest";
    AtlasLootMenuItem_5:Show();
    --Shaman
    AtlasLootMenuItem_6_Name:SetText(BabbleClass["Shaman"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Spell_FireResistanceTotem_01");
    AtlasLootMenuItem_6.lootpage="Arena3Shaman";
    AtlasLootMenuItem_6:Show();
    --Warrior
    AtlasLootMenuItem_7_Name:SetText(BabbleClass["Warrior"]);
    AtlasLootMenuItem_7_Extra:SetText("");
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Shield_05");
    AtlasLootMenuItem_7.lootpage="Arena3Warrior";
    AtlasLootMenuItem_7:Show();
    --Hunter
    AtlasLootMenuItem_18_Name:SetText(BabbleClass["Hunter"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Ability_Hunter_RunningShot");
    AtlasLootMenuItem_18.lootpage="Arena3Hunter";
    AtlasLootMenuItem_18:Show();
    --Paladin
    AtlasLootMenuItem_19_Name:SetText(BabbleClass["Paladin"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\Spell_Holy_SealOfMight");
    AtlasLootMenuItem_19.lootpage="Arena3Paladin";
    AtlasLootMenuItem_19:Show();
    --Rogue
    AtlasLootMenuItem_20_Name:SetText(BabbleClass["Rogue"]);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\Ability_BackStab");
    AtlasLootMenuItem_20.lootpage="Arena3Rogue";
    AtlasLootMenuItem_20:Show();
    --Warlock
    AtlasLootMenuItem_21_Name:SetText(BabbleClass["Warlock"]);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Pants_Cloth_05");
    AtlasLootMenuItem_21.lootpage="Arena3Warlock";
    AtlasLootMenuItem_21:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Arena PvP Sets"]..": "..AL["Season 3"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootARENA4SetMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "ARENAMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Druid
    AtlasLootMenuItem_3_Name:SetText(BabbleClass["Druid"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\Spell_Nature_Regeneration");
    AtlasLootMenuItem_3.lootpage="Arena4Druid";
    AtlasLootMenuItem_3:Show();
    --Mage
    AtlasLootMenuItem_4_Name:SetText(BabbleClass["Mage"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\Spell_Frost_IceStorm");
    AtlasLootMenuItem_4.lootpage="Arena4Mage";
    AtlasLootMenuItem_4:Show();
    --Priest
    AtlasLootMenuItem_5_Name:SetText(BabbleClass["Priest"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Spell_Holy_PowerWordShield");
    AtlasLootMenuItem_5.lootpage="Arena4Priest";
    AtlasLootMenuItem_5:Show();
    --Shaman
    AtlasLootMenuItem_6_Name:SetText(BabbleClass["Shaman"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Spell_FireResistanceTotem_01");
    AtlasLootMenuItem_6.lootpage="Arena4Shaman";
    AtlasLootMenuItem_6:Show();
    --Warrior
    AtlasLootMenuItem_7_Name:SetText(BabbleClass["Warrior"]);
    AtlasLootMenuItem_7_Extra:SetText("");
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Shield_05");
    AtlasLootMenuItem_7.lootpage="Arena4Warrior";
    AtlasLootMenuItem_7:Show();
    --Hunter
    AtlasLootMenuItem_18_Name:SetText(BabbleClass["Hunter"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Ability_Hunter_RunningShot");
    AtlasLootMenuItem_18.lootpage="Arena4Hunter";
    AtlasLootMenuItem_18:Show();
    --Paladin
    AtlasLootMenuItem_19_Name:SetText(BabbleClass["Paladin"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\Spell_Holy_SealOfMight");
    AtlasLootMenuItem_19.lootpage="Arena4Paladin";
    AtlasLootMenuItem_19:Show();
    --Rogue
    AtlasLootMenuItem_20_Name:SetText(BabbleClass["Rogue"]);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\Ability_BackStab");
    AtlasLootMenuItem_20.lootpage="Arena4Rogue";
    AtlasLootMenuItem_20:Show();
    --Warlock
    AtlasLootMenuItem_21_Name:SetText(BabbleClass["Warlock"]);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Pants_Cloth_05");
    AtlasLootMenuItem_21.lootpage="Arena4Warlock";
    AtlasLootMenuItem_21:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Arena PvP Sets"]..": "..AL["Season 4"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootT0SetMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "SETMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Druid
    AtlasLootMenuItem_3_Name:SetText(BabbleClass["Druid"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\Spell_Nature_Regeneration");
    AtlasLootMenuItem_3.lootpage="T0Druid";
    AtlasLootMenuItem_3:Show();
    --Mage
    AtlasLootMenuItem_4_Name:SetText(BabbleClass["Mage"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\Spell_Frost_IceStorm");
    AtlasLootMenuItem_4.lootpage="T0Mage";
    AtlasLootMenuItem_4:Show();
    --Priest
    AtlasLootMenuItem_5_Name:SetText(BabbleClass["Priest"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Spell_Holy_PowerWordShield");
    AtlasLootMenuItem_5.lootpage="T0Priest";
    AtlasLootMenuItem_5:Show();
    --Shaman
    AtlasLootMenuItem_6_Name:SetText(BabbleClass["Shaman"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Spell_FireResistanceTotem_01");
    AtlasLootMenuItem_6.lootpage="T0Shaman";
    AtlasLootMenuItem_6:Show();
    --Warrior
    AtlasLootMenuItem_7_Name:SetText(BabbleClass["Warrior"]);
    AtlasLootMenuItem_7_Extra:SetText("");
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Shield_05");
    AtlasLootMenuItem_7.lootpage="T0Warrior";
    AtlasLootMenuItem_7:Show();
    --Hunter
    AtlasLootMenuItem_18_Name:SetText(BabbleClass["Hunter"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Ability_Hunter_RunningShot");
    AtlasLootMenuItem_18.lootpage="T0Hunter";
    AtlasLootMenuItem_18:Show();
    --Paladin
    AtlasLootMenuItem_19_Name:SetText(BabbleClass["Paladin"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\Spell_Holy_SealOfMight");
    AtlasLootMenuItem_19.lootpage="T0Paladin";
    AtlasLootMenuItem_19:Show();
    --Rogue
    AtlasLootMenuItem_20_Name:SetText(BabbleClass["Rogue"]);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\Ability_BackStab");
    AtlasLootMenuItem_20.lootpage="T0Rogue";
    AtlasLootMenuItem_20:Show();
    --Warlock
    AtlasLootMenuItem_21_Name:SetText(BabbleClass["Warlock"]);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Pants_Cloth_05");
    AtlasLootMenuItem_21.lootpage="T0Warlock";
    AtlasLootMenuItem_21:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Dungeon 1/2 Sets"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootDS3SetMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "SETMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Hallowed Set
    AtlasLootMenuItem_2_Name:SetText(AL["Hallowed Raiment"]);
    AtlasLootMenuItem_2_Extra:SetText(ORANGE..BabbleInventory["Cloth"]);
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\Spell_Holy_InnerFire");
    AtlasLootMenuItem_2.lootpage="DS3Cloth";
    AtlasLootMenuItem_2:Show();
    --Incanter Set
    AtlasLootMenuItem_17_Name:SetText(AL["Incanter's Regalia"]);
    AtlasLootMenuItem_17_Extra:SetText(ORANGE..BabbleInventory["Cloth"]);
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\Ability_Creature_Cursed_04");
    AtlasLootMenuItem_17.lootpage="DS3Cloth";
    AtlasLootMenuItem_17:Show();
    --Mana-Etched Set
    AtlasLootMenuItem_3_Name:SetText(AL["Mana-Etched Regalia"]);
    AtlasLootMenuItem_3_Extra:SetText(ORANGE..BabbleInventory["Cloth"]);
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Elemental_Mote_Nether");
    AtlasLootMenuItem_3.lootpage="DS3Cloth";
    AtlasLootMenuItem_3:Show();
    --Oblivion Set
    AtlasLootMenuItem_18_Name:SetText(AL["Oblivion Raiment"]);
    AtlasLootMenuItem_18_Extra:SetText(ORANGE..BabbleInventory["Cloth"]);
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Ability_Creature_Cursed_03");
    AtlasLootMenuItem_18.lootpage="DS3Cloth";
    AtlasLootMenuItem_18:Show();
    --Assassination Set
    AtlasLootMenuItem_5_Name:SetText(AL["Assassination Armor"]);
    AtlasLootMenuItem_5_Extra:SetText(ORANGE..BabbleInventory["Leather"]);
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Ability_Rogue_SinisterCalling");
    AtlasLootMenuItem_5.lootpage="DS3Leather";
    AtlasLootMenuItem_5:Show();
    --Moonglade Set
    AtlasLootMenuItem_20_Name:SetText(AL["Moonglade Raiment"]);
    AtlasLootMenuItem_20_Extra:SetText(ORANGE..BabbleInventory["Leather"]);
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\Spell_Holy_SealOfRighteousness");
    AtlasLootMenuItem_20.lootpage="DS3Leather";
    AtlasLootMenuItem_20:Show();
    --Wastewalker Set
    AtlasLootMenuItem_6_Name:SetText(AL["Wastewalker Armor"]);
    AtlasLootMenuItem_6_Extra:SetText(ORANGE..BabbleInventory["Leather"]);
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Ability_Hunter_RapidKilling");
    AtlasLootMenuItem_6.lootpage="DS3Leather";
    AtlasLootMenuItem_6:Show();
    --Beast Lord Set
    AtlasLootMenuItem_8_Name:SetText(AL["Beast Lord Armor"]);
    AtlasLootMenuItem_8_Extra:SetText(ORANGE..BabbleInventory["Mail"]);
    AtlasLootMenuItem_8_Icon:SetTexture("Interface\\Icons\\Ability_Hunter_Pet_Wolf");
    AtlasLootMenuItem_8.lootpage="DS3Mail";
    AtlasLootMenuItem_8:Show();
    --Desolation Set
    AtlasLootMenuItem_23_Name:SetText(AL["Desolation Battlegear"]);
    AtlasLootMenuItem_23_Extra:SetText(ORANGE..BabbleInventory["Mail"]);
    AtlasLootMenuItem_23_Icon:SetTexture("Interface\\Icons\\Ability_FiegnDead");
    AtlasLootMenuItem_23.lootpage="DS3Mail";
    AtlasLootMenuItem_23:Show();
    --Tidefury Set
    AtlasLootMenuItem_9_Name:SetText(AL["Tidefury Raiment"]);
    AtlasLootMenuItem_9_Extra:SetText(ORANGE..BabbleInventory["Mail"]);
    AtlasLootMenuItem_9_Icon:SetTexture("Interface\\Icons\\INV_Helmet_70");
    AtlasLootMenuItem_9.lootpage="DS3Mail";
    AtlasLootMenuItem_9:Show();
    --Bold Set
    AtlasLootMenuItem_11_Name:SetText(AL["Bold Armor"]);
    AtlasLootMenuItem_11_Extra:SetText(ORANGE..BabbleInventory["Plate"]);
    AtlasLootMenuItem_11_Icon:SetTexture("Interface\\Icons\\Spell_Fire_EnchantWeapon");
    AtlasLootMenuItem_11.lootpage="DS3Plate";
    AtlasLootMenuItem_11:Show();
    --Doomplate Set
    AtlasLootMenuItem_26_Name:SetText(AL["Doomplate Battlegear"]);
    AtlasLootMenuItem_26_Extra:SetText(ORANGE..BabbleInventory["Plate"]);
    AtlasLootMenuItem_26_Icon:SetTexture("Interface\\Icons\\INV_Helmet_08");
    AtlasLootMenuItem_26.lootpage="DS3Plate";
    AtlasLootMenuItem_26:Show();
    --Righteous Set
    AtlasLootMenuItem_12_Name:SetText(AL["Righteous Armor"]);
    AtlasLootMenuItem_12_Extra:SetText(ORANGE..BabbleInventory["Plate"]);
    AtlasLootMenuItem_12_Icon:SetTexture("Interface\\Icons\\INV_Hammer_02");
    AtlasLootMenuItem_12.lootpage="DS3Plate";
    AtlasLootMenuItem_12:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Dungeon 3 Sets"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootT1T2SetMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "SETMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Druid
    AtlasLootMenuItem_3_Name:SetText(BabbleClass["Druid"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\Spell_Nature_Regeneration");
    AtlasLootMenuItem_3.lootpage="T1T2Druid";
    AtlasLootMenuItem_3:Show();
    --Mage
    AtlasLootMenuItem_4_Name:SetText(BabbleClass["Mage"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\Spell_Frost_IceStorm");
    AtlasLootMenuItem_4.lootpage="T1T2Mage";
    AtlasLootMenuItem_4:Show();
    --Priest
    AtlasLootMenuItem_5_Name:SetText(BabbleClass["Priest"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Spell_Holy_PowerWordShield");
    AtlasLootMenuItem_5.lootpage="T1T2Priest";
    AtlasLootMenuItem_5:Show();
    --Shaman
    AtlasLootMenuItem_6_Name:SetText(BabbleClass["Shaman"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Spell_FireResistanceTotem_01");
    AtlasLootMenuItem_6.lootpage="T1T2Shaman";
    AtlasLootMenuItem_6:Show();
    --Warrior
    AtlasLootMenuItem_7_Name:SetText(BabbleClass["Warrior"]);
    AtlasLootMenuItem_7_Extra:SetText("");
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Shield_05");
    AtlasLootMenuItem_7.lootpage="T1T2Warrior";
    AtlasLootMenuItem_7:Show();
    --Hunter
    AtlasLootMenuItem_18_Name:SetText(BabbleClass["Hunter"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Ability_Hunter_RunningShot");
    AtlasLootMenuItem_18.lootpage="T1T2Hunter";
    AtlasLootMenuItem_18:Show();
    --Paladin
    AtlasLootMenuItem_19_Name:SetText(BabbleClass["Paladin"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\Spell_Holy_SealOfMight");
    AtlasLootMenuItem_19.lootpage="T1T2Paladin";
    AtlasLootMenuItem_19:Show();
    --Rogue
    AtlasLootMenuItem_20_Name:SetText(BabbleClass["Rogue"]);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\Ability_BackStab");
    AtlasLootMenuItem_20.lootpage="T1T2Rogue";
    AtlasLootMenuItem_20:Show();
    --Warlock
    AtlasLootMenuItem_21_Name:SetText(BabbleClass["Warlock"]);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Pants_Cloth_05");
    AtlasLootMenuItem_21.lootpage="T1T2Warlock";
    AtlasLootMenuItem_21:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Tier 1/2 Sets"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootT3SetMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "SETMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Druid
    AtlasLootMenuItem_3_Name:SetText(BabbleClass["Druid"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\Spell_Nature_Regeneration");
    AtlasLootMenuItem_3.lootpage="T3Druid";
    AtlasLootMenuItem_3:Show();
    --Mage
    AtlasLootMenuItem_4_Name:SetText(BabbleClass["Mage"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\Spell_Frost_IceStorm");
    AtlasLootMenuItem_4.lootpage="T3Mage";
    AtlasLootMenuItem_4:Show();
    --Priest
    AtlasLootMenuItem_5_Name:SetText(BabbleClass["Priest"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Spell_Holy_PowerWordShield");
    AtlasLootMenuItem_5.lootpage="T3Priest";
    AtlasLootMenuItem_5:Show();
    --Shaman
    AtlasLootMenuItem_6_Name:SetText(BabbleClass["Shaman"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Spell_FireResistanceTotem_01");
    AtlasLootMenuItem_6.lootpage="T3Shaman";
    AtlasLootMenuItem_6:Show();
    --Warrior
    AtlasLootMenuItem_7_Name:SetText(BabbleClass["Warrior"]);
    AtlasLootMenuItem_7_Extra:SetText("");
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Shield_05");
    AtlasLootMenuItem_7.lootpage="T3Warrior";
    AtlasLootMenuItem_7:Show();
    --Hunter
    AtlasLootMenuItem_18_Name:SetText(BabbleClass["Hunter"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Ability_Hunter_RunningShot");
    AtlasLootMenuItem_18.lootpage="T3Hunter";
    AtlasLootMenuItem_18:Show();
    --Paladin
    AtlasLootMenuItem_19_Name:SetText(BabbleClass["Paladin"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\Spell_Holy_SealOfMight");
    AtlasLootMenuItem_19.lootpage="T3Paladin";
    AtlasLootMenuItem_19:Show();
    --Rogue
    AtlasLootMenuItem_20_Name:SetText(BabbleClass["Rogue"]);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\Ability_BackStab");
    AtlasLootMenuItem_20.lootpage="T3Rogue";
    AtlasLootMenuItem_20:Show();
    --Warlock
    AtlasLootMenuItem_21_Name:SetText(BabbleClass["Warlock"]);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Pants_Cloth_05");
    AtlasLootMenuItem_21.lootpage="T3Warlock";
    AtlasLootMenuItem_21:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Tier 3 Sets"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootT4SetMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "SETMENU";
    --Druid
    AtlasLootMenuItem_3_Name:SetText(BabbleClass["Druid"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\Spell_Nature_Regeneration");
    AtlasLootMenuItem_3.lootpage="T4Druid";
    AtlasLootMenuItem_3:Show();
    --Mage
    AtlasLootMenuItem_4_Name:SetText(BabbleClass["Mage"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\Spell_Frost_IceStorm");
    AtlasLootMenuItem_4.lootpage="T4Mage";
    AtlasLootMenuItem_4:Show();
    --Priest
    AtlasLootMenuItem_5_Name:SetText(BabbleClass["Priest"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Spell_Holy_PowerWordShield");
    AtlasLootMenuItem_5.lootpage="T4Priest";
    AtlasLootMenuItem_5:Show();
    --Shaman
    AtlasLootMenuItem_6_Name:SetText(BabbleClass["Shaman"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Spell_FireResistanceTotem_01");
    AtlasLootMenuItem_6.lootpage="T4Shaman";
    AtlasLootMenuItem_6:Show();
    --Warrior
    AtlasLootMenuItem_7_Name:SetText(BabbleClass["Warrior"]);
    AtlasLootMenuItem_7_Extra:SetText("");
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Shield_05");
    AtlasLootMenuItem_7.lootpage="T4Warrior";
    AtlasLootMenuItem_7:Show();
    --Hunter
    AtlasLootMenuItem_18_Name:SetText(BabbleClass["Hunter"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Ability_Hunter_RunningShot");
    AtlasLootMenuItem_18.lootpage="T4Hunter";
    AtlasLootMenuItem_18:Show();
    --Paladin
    AtlasLootMenuItem_19_Name:SetText(BabbleClass["Paladin"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\Spell_Holy_SealOfMight");
    AtlasLootMenuItem_19.lootpage="T4Paladin";
    AtlasLootMenuItem_19:Show();
    --Rogue
    AtlasLootMenuItem_20_Name:SetText(BabbleClass["Rogue"]);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\Ability_BackStab");
    AtlasLootMenuItem_20.lootpage="T4Rogue";
    AtlasLootMenuItem_20:Show();
    --Warlock
    AtlasLootMenuItem_21_Name:SetText(BabbleClass["Warlock"]);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Pants_Cloth_05");
    AtlasLootMenuItem_21.lootpage="T4Warlock";
    AtlasLootMenuItem_21:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Tier 4 Sets"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootT5SetMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "SETMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Druid
    AtlasLootMenuItem_3_Name:SetText(BabbleClass["Druid"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\Spell_Nature_Regeneration");
    AtlasLootMenuItem_3.lootpage="T5Druid";
    AtlasLootMenuItem_3:Show();
    --Mage
    AtlasLootMenuItem_4_Name:SetText(BabbleClass["Mage"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\Spell_Frost_IceStorm");
    AtlasLootMenuItem_4.lootpage="T5Mage";
    AtlasLootMenuItem_4:Show();
    --Priest
    AtlasLootMenuItem_5_Name:SetText(BabbleClass["Priest"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Spell_Holy_PowerWordShield");
    AtlasLootMenuItem_5.lootpage="T5Priest";
    AtlasLootMenuItem_5:Show();
    --Shaman
    AtlasLootMenuItem_6_Name:SetText(BabbleClass["Shaman"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Spell_FireResistanceTotem_01");
    AtlasLootMenuItem_6.lootpage="T5Shaman";
    AtlasLootMenuItem_6:Show();
    --Warrior
    AtlasLootMenuItem_7_Name:SetText(BabbleClass["Warrior"]);
    AtlasLootMenuItem_7_Extra:SetText("");
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Shield_05");
    AtlasLootMenuItem_7.lootpage="T5Warrior";
    AtlasLootMenuItem_7:Show();
    --Hunter
    AtlasLootMenuItem_18_Name:SetText(BabbleClass["Hunter"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Ability_Hunter_RunningShot");
    AtlasLootMenuItem_18.lootpage="T5Hunter";
    AtlasLootMenuItem_18:Show();
    --Paladin
    AtlasLootMenuItem_19_Name:SetText(BabbleClass["Paladin"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\Spell_Holy_SealOfMight");
    AtlasLootMenuItem_19.lootpage="T5Paladin";
    AtlasLootMenuItem_19:Show();
    --Rogue
    AtlasLootMenuItem_20_Name:SetText(BabbleClass["Rogue"]);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\Ability_BackStab");
    AtlasLootMenuItem_20.lootpage="T5Rogue";
    AtlasLootMenuItem_20:Show();
    --Warlock
    AtlasLootMenuItem_21_Name:SetText(BabbleClass["Warlock"]);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Pants_Cloth_05");
    AtlasLootMenuItem_21.lootpage="T5Warlock";
    AtlasLootMenuItem_21:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Tier 5 Sets"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootT6SetMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "SETMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Druid
    AtlasLootMenuItem_3_Name:SetText(BabbleClass["Druid"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\Spell_Nature_Regeneration");
    AtlasLootMenuItem_3.lootpage="T6Druid";
    AtlasLootMenuItem_3:Show();
    --Mage
    AtlasLootMenuItem_4_Name:SetText(BabbleClass["Mage"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\Spell_Frost_IceStorm");
    AtlasLootMenuItem_4.lootpage="T6Mage";
    AtlasLootMenuItem_4:Show();
    --Priest
    AtlasLootMenuItem_5_Name:SetText(BabbleClass["Priest"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Spell_Holy_PowerWordShield");
    AtlasLootMenuItem_5.lootpage="T6Priest";
    AtlasLootMenuItem_5:Show();
    --Shaman
    AtlasLootMenuItem_6_Name:SetText(BabbleClass["Shaman"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Spell_FireResistanceTotem_01");
    AtlasLootMenuItem_6.lootpage="T6Shaman";
    AtlasLootMenuItem_6:Show();
    --Warrior
    AtlasLootMenuItem_7_Name:SetText(BabbleClass["Warrior"]);
    AtlasLootMenuItem_7_Extra:SetText("");
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Shield_05");
    AtlasLootMenuItem_7.lootpage="T6Warrior";
    AtlasLootMenuItem_7:Show();
    --Hunter
    AtlasLootMenuItem_18_Name:SetText(BabbleClass["Hunter"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Ability_Hunter_RunningShot");
    AtlasLootMenuItem_18.lootpage="T6Hunter";
    AtlasLootMenuItem_18:Show();
    --Paladin
    AtlasLootMenuItem_19_Name:SetText(BabbleClass["Paladin"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\Spell_Holy_SealOfMight");
    AtlasLootMenuItem_19.lootpage="T6Paladin";
    AtlasLootMenuItem_19:Show();
    --Rogue
    AtlasLootMenuItem_20_Name:SetText(BabbleClass["Rogue"]);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\Ability_BackStab");
    AtlasLootMenuItem_20.lootpage="T6Rogue";
    AtlasLootMenuItem_20:Show();
    --Warlock
    AtlasLootMenuItem_21_Name:SetText(BabbleClass["Warlock"]);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Pants_Cloth_05");
    AtlasLootMenuItem_21.lootpage="T6Warlock";
    AtlasLootMenuItem_21:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Tier 6 Sets"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end