local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");
local BabbleFaction = LibStub("LibBabble-Faction-3.0"):GetLookupTable();

local ORANGE = "|cffFF8400";

function AtlasLootRepMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    getglobal("AtlasLootItemsFrame_BACK"):Hide();
    --Rep Factions Azeroth Pre-BC
    AtlasLootMenuItem_2_Name:SetText(AL["Factions - Azeroth"]);
    AtlasLootMenuItem_2_Extra:SetText(ORANGE..AL["Pre-Burning Crusade"]);
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Talisman_08");
    AtlasLootMenuItem_2.lootpage="REPMENU_AZEROTHPREBC";
    AtlasLootMenuItem_2:Show();
    --Rep Factions Outland
    AtlasLootMenuItem_3_Name:SetText(AL["Factions - Outland"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Misc_Foot_Centaur");
    AtlasLootMenuItem_3.lootpage="REPMENU_OUTLAND";
    AtlasLootMenuItem_3:Show();
    --Rep Factions Azeroth Post-BC
    AtlasLootMenuItem_17_Name:SetText(AL["Factions - Azeroth"]);
    AtlasLootMenuItem_17_Extra:SetText(ORANGE..AL["Post-Burning Crusade"]);
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\Ability_Warrior_ShieldMastery");
    AtlasLootMenuItem_17.lootpage="REPMENU_AZEROTHPOSTBC";
    AtlasLootMenuItem_17:Show();
    --Rep Factions Shattrath City
    AtlasLootMenuItem_18_Name:SetText(AL["Factions - Shattrath City"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Spell_Holy_ChampionsBond");
    AtlasLootMenuItem_18.lootpage="REPMENU_SHATTRATH";
    AtlasLootMenuItem_18:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Factions"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootRepMenu_AzerothPreBC()
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
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "REPMENU";
    --Argent Dawn
    AtlasLootMenuItem_2_Name:SetText(BabbleFaction["Argent Dawn"]);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Talisman_08");
    AtlasLootMenuItem_2.lootpage="Argent1";
    AtlasLootMenuItem_2:Show();
    --Bloodsail Pirates
    AtlasLootMenuItem_17_Name:SetText(BabbleFaction["Bloodsail Buccaneers"]);
    AtlasLootMenuItem_17_Extra:SetText("");
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Helmet_66");
    AtlasLootMenuItem_17.lootpage="Bloodsail1";
    AtlasLootMenuItem_17:Show();
    --Brood of Nozdormu
    AtlasLootMenuItem_3_Name:SetText(BabbleFaction["Brood of Nozdormu"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Ring_40");
    AtlasLootMenuItem_3.lootpage="AQBroodRings";
    AtlasLootMenuItem_3:Show();
    --Cenarion Hold
    AtlasLootMenuItem_18_Name:SetText(BabbleFaction["Cenarion Circle"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_Chest_Plate07");
    AtlasLootMenuItem_18.lootpage="Cenarion1";
    AtlasLootMenuItem_18:Show();
    --Darkmoon Faire
    AtlasLootMenuItem_4_Name:SetText(BabbleFaction["Darkmoon Faire"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Misc_Ticket_Tarot_Maelstrom_01");
    AtlasLootMenuItem_4.lootpage="Darkmoon1";
    AtlasLootMenuItem_4:Show();
    --The Defilers
    AtlasLootMenuItem_19_Name:SetText(BabbleFaction["The Defilers"]);
    AtlasLootMenuItem_19_Extra:SetText(ORANGE..BabbleFaction["Horde"]);
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Amulet_07");
    AtlasLootMenuItem_19.lootpage="Defilers";
    AtlasLootMenuItem_19:Show();
    --Frostwolf Clan
    AtlasLootMenuItem_5_Name:SetText(BabbleFaction["Frostwolf Clan"]);
    AtlasLootMenuItem_5_Extra:SetText(ORANGE..BabbleFaction["Horde"]);
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_FrostwolfTrinket_01");
    AtlasLootMenuItem_5.lootpage="Frostwolf1";
    AtlasLootMenuItem_5:Show();
    --Gelkis Clan Centaur
    AtlasLootMenuItem_20_Name:SetText(BabbleFaction["Gelkis Clan Centaur"]);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\INV_Misc_Head_Centaur_01");
    AtlasLootMenuItem_20.lootpage="GelkisClan1";
    AtlasLootMenuItem_20:Show();
    --Hydraxian Waterlords
    AtlasLootMenuItem_6_Name:SetText(BabbleFaction["Hydraxian Waterlords"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Spell_Frost_SummonWaterElemental_2");
    AtlasLootMenuItem_6.lootpage="WaterLords1";
    AtlasLootMenuItem_6:Show();
    --The League of Arathor
    AtlasLootMenuItem_21_Name:SetText(BabbleFaction["The League of Arathor"]);
    AtlasLootMenuItem_21_Extra:SetText(ORANGE..BabbleFaction["Alliance"]);
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Amulet_07");
    AtlasLootMenuItem_21.lootpage="LeagueofArathor";
    AtlasLootMenuItem_21:Show();
    --Magram Clan Centaur
    AtlasLootMenuItem_7_Name:SetText(BabbleFaction["Magram Clan Centaur"]);
    AtlasLootMenuItem_7_Extra:SetText("");
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Misc_Head_Centaur_01");
    AtlasLootMenuItem_7.lootpage="MagramClan1";
    AtlasLootMenuItem_7:Show();
    --Stormpike Guard
    AtlasLootMenuItem_22_Name:SetText(BabbleFaction["Stormpike Guard"]);
    AtlasLootMenuItem_22_Extra:SetText(ORANGE..BabbleFaction["Alliance"]);
    AtlasLootMenuItem_22_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_StormPikeTrinket_01");
    AtlasLootMenuItem_22.lootpage="Stormpike1";
    AtlasLootMenuItem_22:Show();
    --Thorium Brotherhood
    AtlasLootMenuItem_8_Name:SetText(BabbleFaction["Thorium Brotherhood"]);
    AtlasLootMenuItem_8_Extra:SetText("");
    AtlasLootMenuItem_8_Icon:SetTexture("Interface\\Icons\\INV_Ingot_Mithril");
    AtlasLootMenuItem_8.lootpage="Thorium1";
    AtlasLootMenuItem_8:Show();
    --Timbermaw Hold
    AtlasLootMenuItem_23_Name:SetText(BabbleFaction["Timbermaw Hold"]);
    AtlasLootMenuItem_23_Extra:SetText("");
    AtlasLootMenuItem_23_Icon:SetTexture("Interface\\Icons\\INV_Misc_Horn_01");
    AtlasLootMenuItem_23.lootpage="Timbermaw";
    AtlasLootMenuItem_23:Show();
    --The Wintersaber Trainers
    AtlasLootMenuItem_9_Name:SetText(BabbleFaction["Wintersaber Trainers"]);
    AtlasLootMenuItem_9_Extra:SetText(ORANGE..BabbleFaction["Alliance"]);
    AtlasLootMenuItem_9_Icon:SetTexture("Interface\\Icons\\Ability_Mount_PinkTiger");
    AtlasLootMenuItem_9.lootpage="Wintersaber1";
    AtlasLootMenuItem_9:Show();
    --Zandalar Tribe
    AtlasLootMenuItem_24_Name:SetText(BabbleFaction["Zandalar Tribe"]);
    AtlasLootMenuItem_24_Extra:SetText("");
    AtlasLootMenuItem_24_Icon:SetTexture("Interface\\Icons\\INV_Misc_Coin_08");
    AtlasLootMenuItem_24.lootpage="Zandalar1";
    AtlasLootMenuItem_24:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootRepMenu_AzerothPostBC()
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
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "REPMENU";
    --Keepers of Time
    AtlasLootMenuItem_2_Name:SetText(BabbleFaction["Keepers of Time"]);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\Ability_Warrior_VictoryRush");
    AtlasLootMenuItem_2.lootpage="KeepersofTime1";
    AtlasLootMenuItem_2:Show();
    --The Scale of the Sands
    AtlasLootMenuItem_17_Name:SetText(BabbleFaction["The Scale of the Sands"]);
    AtlasLootMenuItem_17_Extra:SetText("");
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Misc_MonsterScales_13");
    AtlasLootMenuItem_17.lootpage="ScaleSands1";
    AtlasLootMenuItem_17:Show();
    --The Tranquillien
    AtlasLootMenuItem_3_Name:SetText(BabbleFaction["Tranquillien"]);
    AtlasLootMenuItem_3_Extra:SetText(ORANGE..BabbleFaction["Horde"]);
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Misc_Bandana_03");
    AtlasLootMenuItem_3.lootpage="Tranquillien1";
    AtlasLootMenuItem_3:Show();
    --The Violet Eye
    AtlasLootMenuItem_18_Name:SetText(BabbleFaction["The Violet Eye"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Ability_Warrior_ShieldMastery");
    AtlasLootMenuItem_18.lootpage="VioletEye1";
    AtlasLootMenuItem_18:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Factions - Azeroth"].." : "..AL["Post-Burning Crusade"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootRepMenu_Outland()
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
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "REPMENU";
    --The Ashtongue Deathsworn
    AtlasLootMenuItem_2_Name:SetText(BabbleFaction["Ashtongue Deathsworn"]);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Misc_Gem_Pearl_05");
    AtlasLootMenuItem_2.lootpage="Ashtongue1";
    AtlasLootMenuItem_2:Show();
    --Cenarion Expedition
    AtlasLootMenuItem_17_Name:SetText(BabbleFaction["Cenarion Expedition"]);
    AtlasLootMenuItem_17_Extra:SetText("");
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Misc_Ammo_Arrow_02");
    AtlasLootMenuItem_17.lootpage="CExpedition1";
    AtlasLootMenuItem_17:Show();
    --The Consortium
    AtlasLootMenuItem_3_Name:SetText(BabbleFaction["The Consortium"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Weapon_Shortblade_31");
    AtlasLootMenuItem_3.lootpage="Consortium1";
    AtlasLootMenuItem_3:Show();
    --Honor Hold
    AtlasLootMenuItem_18_Name:SetText(BabbleFaction["Honor Hold"]);
    AtlasLootMenuItem_18_Extra:SetText(ORANGE..BabbleFaction["Alliance"]);
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_BannerPVP_02");
    AtlasLootMenuItem_18.lootpage="HonorHold1";
    AtlasLootMenuItem_18:Show();
    --Kurenai
    AtlasLootMenuItem_4_Name:SetText(BabbleFaction["Kurenai"]);
    AtlasLootMenuItem_4_Extra:SetText(ORANGE..BabbleFaction["Alliance"]);
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Misc_Foot_Centaur");
    AtlasLootMenuItem_4.lootpage="Kurenai1";
    AtlasLootMenuItem_4:Show();
    --The Mag'har
    AtlasLootMenuItem_19_Name:SetText(BabbleFaction["The Mag'har"]);
    AtlasLootMenuItem_19_Extra:SetText(ORANGE..BabbleFaction["Horde"]);
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_Misc_Foot_Centaur");
    AtlasLootMenuItem_19.lootpage="Maghar1";
    AtlasLootMenuItem_19:Show();
    --Netherwing
    AtlasLootMenuItem_5_Name:SetText(BabbleFaction["Netherwing"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Ability_Mount_Netherdrakepurple");
    AtlasLootMenuItem_5.lootpage="Netherwing1";
    AtlasLootMenuItem_5:Show();
    --Ogri'la
    AtlasLootMenuItem_20_Name:SetText(BabbleFaction["Ogri'la"]);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\INV_DataCrystal01");
    AtlasLootMenuItem_20.lootpage="Ogrila1";
    AtlasLootMenuItem_20:Show();
    --Sporeggar
    AtlasLootMenuItem_6_Name:SetText(BabbleFaction["Sporeggar"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\INV_Mushroom_10");
    AtlasLootMenuItem_6.lootpage="Sporeggar1";
    AtlasLootMenuItem_6:Show();
    --Thrallmar
    AtlasLootMenuItem_21_Name:SetText(BabbleFaction["Thrallmar"]);
    AtlasLootMenuItem_21_Extra:SetText(ORANGE..BabbleFaction["Horde"]);
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_BannerPVP_01");
    AtlasLootMenuItem_21.lootpage="Thrallmar1";
    AtlasLootMenuItem_21:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Factions - Outland"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootRepMenu_Shattrath()
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
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "REPMENU";
    --The Aldor
    AtlasLootMenuItem_2_Name:SetText(BabbleFaction["The Aldor"]);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\Spell_Holy_SealOfSalvation");
    AtlasLootMenuItem_2.lootpage="Aldor1";
    AtlasLootMenuItem_2:Show();
    --The Lower City
    AtlasLootMenuItem_17_Name:SetText(BabbleFaction["Lower City"]);
    AtlasLootMenuItem_17_Extra:SetText("");
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\Ability_Rogue_MasterOfSubtlety");
    AtlasLootMenuItem_17.lootpage="LowerCity1";
    AtlasLootMenuItem_17:Show();
    --The Scryers
    AtlasLootMenuItem_3_Name:SetText(BabbleFaction["The Scryers"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\Spell_Holy_ChampionsBond");
    AtlasLootMenuItem_3.lootpage="Scryer1";
    AtlasLootMenuItem_3:Show();
    --The Sha'tar
    AtlasLootMenuItem_18_Name:SetText(BabbleFaction["The Sha'tar"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Spell_Nature_LightningOverload");
    AtlasLootMenuItem_18.lootpage="Shatar1";
    AtlasLootMenuItem_18:Show();
    --Sha'tari Skyguard
    AtlasLootMenuItem_4_Name:SetText(BabbleFaction["Sha'tari Skyguard"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Misc_Ribbon_01");
    AtlasLootMenuItem_4.lootpage="Skyguard1";
    AtlasLootMenuItem_4:Show();
    --Shattered Sun Offensive
    AtlasLootMenuItem_19_Name:SetText(BabbleFaction["Shattered Sun Offensive"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_Misc_Statue_04");
    AtlasLootMenuItem_19.lootpage="SunOffensive1";
    AtlasLootMenuItem_19:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Factions - Shattrath City"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end
