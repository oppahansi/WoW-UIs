local BabbleZone = LibStub("LibBabble-Zone-3.0"):GetLookupTable();
local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

local ORANGE = "|cffFF8400";

function AtlasLootWorldEventMenu()
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
    --Brewfest
    AtlasLootMenuItem_2_Name:SetText(AL["Brewfest"]);
    AtlasLootMenuItem_2_Extra:SetText(ORANGE..AL["Various Locations"]);
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Cask_04");
    AtlasLootMenuItem_2.lootpage="Brewfest1";
    AtlasLootMenuItem_2:Show();
    --Children's Week
    AtlasLootMenuItem_17_Name:SetText(AL["Children's Week"]);
    AtlasLootMenuItem_17_Extra:SetText(ORANGE..AL["Various Locations"]);
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\Ability_Hunter_BeastCall");
    AtlasLootMenuItem_17.lootpage="ChildrensWeek";
    AtlasLootMenuItem_17:Show();
    --Feast of Winter Veil
    AtlasLootMenuItem_3_Name:SetText(AL["Feast of Winter Veil"]);
    AtlasLootMenuItem_3_Extra:SetText(ORANGE..AL["Various Locations"]);
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Holiday_Christmas_Present_01");
    AtlasLootMenuItem_3.lootpage="Winterviel1";
    AtlasLootMenuItem_3:Show();
    --Hallow's End
    AtlasLootMenuItem_18_Name:SetText(AL["Hallow's End"]);
    AtlasLootMenuItem_18_Extra:SetText(ORANGE..AL["Various Locations"]);
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_Misc_Bag_28_Halloween");
    AtlasLootMenuItem_18.lootpage="Halloween1";
    AtlasLootMenuItem_18:Show();
    --Harvest Festival
    AtlasLootMenuItem_4_Name:SetText(AL["Harvest Festival"]);
    AtlasLootMenuItem_4_Extra:SetText(ORANGE..AL["Various Locations"]);
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Misc_Food_33");
    AtlasLootMenuItem_4.lootpage="HarvestFestival";
    AtlasLootMenuItem_4:Show();
    --Love is in the Air
    AtlasLootMenuItem_19_Name:SetText(AL["Love is in the Air"]);
    AtlasLootMenuItem_19_Extra:SetText(ORANGE..AL["Various Locations"]);
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_ValentinesBoxOfChocolates02");
    AtlasLootMenuItem_19.lootpage="Valentineday";
    AtlasLootMenuItem_19:Show();
    --Lunar Festival
    AtlasLootMenuItem_5_Name:SetText(AL["Lunar Festival"]);
    AtlasLootMenuItem_5_Extra:SetText(ORANGE..AL["Various Locations"]);
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\INV_Misc_ElvenCoins");
    AtlasLootMenuItem_5.lootpage="LunarFestival1";
    AtlasLootMenuItem_5:Show();
    --Midsummer Fire Festival
    AtlasLootMenuItem_20_Name:SetText(AL["Midsummer Fire Festival"]);
    AtlasLootMenuItem_20_Extra:SetText(ORANGE..AL["Various Locations"]);
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\INV_SummerFest_FireFlower");
    AtlasLootMenuItem_20.lootpage="MidsummerFestival";
    AtlasLootMenuItem_20:Show();
    --Noblegarden
    AtlasLootMenuItem_6_Name:SetText(AL["Noblegarden"]);
    AtlasLootMenuItem_6_Extra:SetText(ORANGE..AL["Various Locations"]);
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\INV_Egg_03");
    AtlasLootMenuItem_6.lootpage="Noblegarden";
    AtlasLootMenuItem_6:Show();
    --Bash'ir Landing Skyguard Raid
    AtlasLootMenuItem_8_Name:SetText(AL["Bash'ir Landing Skyguard Raid"]);
    AtlasLootMenuItem_8_Extra:SetText(ORANGE..BabbleZone["Blade's Edge Mountains"]);
    AtlasLootMenuItem_8_Icon:SetTexture("Interface\\Icons\\INV_Trinket_Naxxramas02");
    AtlasLootMenuItem_8.lootpage="BashirLanding";
    AtlasLootMenuItem_8:Show();
    --Elemental Invasion
    AtlasLootMenuItem_23_Name:SetText(AL["Elemental Invasion"]);
    AtlasLootMenuItem_23_Extra:SetText(ORANGE..AL["Various Locations"]);
    AtlasLootMenuItem_23_Icon:SetTexture("Interface\\Icons\\INV_DataCrystal03");
    AtlasLootMenuItem_23.lootpage="ElementalInvasion";
    AtlasLootMenuItem_23:Show();
    --Gurubashi Arena Booty Run
    AtlasLootMenuItem_9_Name:SetText(AL["Gurubashi Arena Booty Run"]);
    AtlasLootMenuItem_9_Extra:SetText(ORANGE..BabbleZone["Stranglethorn Vale"]);
    AtlasLootMenuItem_9_Icon:SetTexture("Interface\\Icons\\INV_Box_02");
    AtlasLootMenuItem_9.lootpage="GurubashiArena";
    AtlasLootMenuItem_9:Show();
    --Scourge Invasion
    AtlasLootMenuItem_24_Name:SetText(AL["Scourge Invasion"]);
    AtlasLootMenuItem_24_Extra:SetText(ORANGE..AL["Various Locations"]);
    AtlasLootMenuItem_24_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Talisman_13");
    AtlasLootMenuItem_24.lootpage="ScourgeInvasionEvent1";
    AtlasLootMenuItem_24:Show();
    --Shartuul
    AtlasLootMenuItem_10_Name:SetText(AL["Shartuul"]);
    AtlasLootMenuItem_10_Extra:SetText(ORANGE..BabbleZone["Blade's Edge Mountains"]);
    AtlasLootMenuItem_10_Icon:SetTexture("Interface\\Icons\\INV_Misc_Rune_04");
    AtlasLootMenuItem_10.lootpage="Shartuul";
    AtlasLootMenuItem_10:Show();
    --Stranglethorn Fishing Extravaganza
    AtlasLootMenuItem_25_Name:SetText(AL["Stranglethorn Fishing Extravaganza"]);
    AtlasLootMenuItem_25_Extra:SetText(ORANGE..BabbleZone["Stranglethorn Vale"]);
    AtlasLootMenuItem_25_Icon:SetTexture("Interface\\Icons\\INV_Fishingpole_02");
    AtlasLootMenuItem_25.lootpage="FishingExtravaganza";
    AtlasLootMenuItem_25:Show();
    --Abyssal Council
    AtlasLootMenuItem_12_Name:SetText(AL["Abyssal Council"]);
    AtlasLootMenuItem_12_Extra:SetText(ORANGE..BabbleZone["Silithus"]);
    AtlasLootMenuItem_12_Icon:SetTexture("Interface\\Icons\\INV_Staff_13");
    AtlasLootMenuItem_12.lootpage="ABYSSALMENU";
    AtlasLootMenuItem_12:Show();
    --Ethereum Prison
    AtlasLootMenuItem_27_Name:SetText(AL["Ethereum Prison"]);
    AtlasLootMenuItem_27_Extra:SetText("");
    AtlasLootMenuItem_27_Icon:SetTexture("Interface\\Icons\\INV_Misc_PunchCards_Prismatic");
    AtlasLootMenuItem_27.lootpage="ETHEREUMMENU";
    AtlasLootMenuItem_27:Show();
    --Skettis
    AtlasLootMenuItem_13_Name:SetText(AL["Skettis"]);
    AtlasLootMenuItem_13_Extra:SetText(ORANGE..BabbleZone["Terokkar Forest"]);
    AtlasLootMenuItem_13_Icon:SetTexture("Interface\\Icons\\Spell_Nature_NaturesWrath");
    AtlasLootMenuItem_13.lootpage="SKETTISMENU";
    AtlasLootMenuItem_13:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["World Events"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootSkettisMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "WORLDEVENTMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Darkscreecher Akkarai
    AtlasLootMenuItem_2_Name:SetText(AL["Darkscreecher Akkarai"]);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\Spell_Nature_NaturesWrath");
    AtlasLootMenuItem_2.lootpage="DarkscreecherAkkarai";
    AtlasLootMenuItem_2:Show();
    --Karrog
    AtlasLootMenuItem_17_Name:SetText(AL["Karrog"]);
    AtlasLootMenuItem_17_Extra:SetText("");
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_DataCrystal08");
    AtlasLootMenuItem_17.lootpage="Karrog";
    AtlasLootMenuItem_17:Show();
    --Gezzarak the Huntress
    AtlasLootMenuItem_3_Name:SetText(AL["Gezzarak the Huntress"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Misc_MonsterClaw_01");
    AtlasLootMenuItem_3.lootpage="GezzaraktheHuntress";
    AtlasLootMenuItem_3:Show();
    --Vakkiz the Windrager
    AtlasLootMenuItem_18_Name:SetText(AL["Vakkiz the Windrager"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_Misc_MonsterScales_13");
    AtlasLootMenuItem_18.lootpage="VakkiztheWindrager";
    AtlasLootMenuItem_18:Show();
    --Terokk
    AtlasLootMenuItem_4_Name:SetText(AL["Terokk"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Misc_Cape_08");
    AtlasLootMenuItem_4.lootpage="Terokk";
    AtlasLootMenuItem_4:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Skettis"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootEthereumPrisonMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "WORLDEVENTMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Armbreaker Huffaz
    AtlasLootMenuItem_2_Name:SetText(AL["Armbreaker Huffaz"]);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Ring_59");
    AtlasLootMenuItem_2.lootpage="ArmbreakerHuffaz";
    AtlasLootMenuItem_2:Show();
    --Fel Tinkerer Zortan
    AtlasLootMenuItem_17_Name:SetText(AL["Fel Tinkerer Zortan"]);
    AtlasLootMenuItem_17_Extra:SetText("");
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Boots_Chain_08");
    AtlasLootMenuItem_17.lootpage="FelTinkererZortan";
    AtlasLootMenuItem_17:Show();
    --Forgosh
    AtlasLootMenuItem_3_Name:SetText(AL["Forgosh"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Boots_05");
    AtlasLootMenuItem_3.lootpage="Forgosh";
    AtlasLootMenuItem_3:Show();
    --Gul'bor
    AtlasLootMenuItem_18_Name:SetText(AL["Gul'bor"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Necklace_29Naxxramas");
    AtlasLootMenuItem_18.lootpage="Gulbor";
    AtlasLootMenuItem_18:Show();
    --Malevus the Mad
    AtlasLootMenuItem_4_Name:SetText(AL["Malevus the Mad"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Boots_Chain_04");
    AtlasLootMenuItem_4.lootpage="MalevustheMad";
    AtlasLootMenuItem_4:Show();
    --Porfus the Gem Gorger
    AtlasLootMenuItem_19_Name:SetText(AL["Porfus the Gem Gorger"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_Boots_Cloth_01");
    AtlasLootMenuItem_19.lootpage="PorfustheGemGorger";
    AtlasLootMenuItem_19:Show();
    --Wrathbringer Laz-tarash
    AtlasLootMenuItem_5_Name:SetText(AL["Wrathbringer Laz-tarash"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\INV_Misc_Orb_01");
    AtlasLootMenuItem_5.lootpage="WrathbringerLaztarash";
    AtlasLootMenuItem_5:Show();
    --Bash'ir Landing Stasis Chambers
    AtlasLootMenuItem_20_Name:SetText(AL["Bash'ir Landing Stasis Chambers"]);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\INV_Trinket_Naxxramas02");
    AtlasLootMenuItem_20.lootpage="BashirStasisChambers";
    AtlasLootMenuItem_20:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Ethereum Prison"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootAbyssalCouncilMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "WORLDEVENTMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Templars
    AtlasLootMenuItem_2_Name:SetText(AL["Abyssal Council"].." - "..AL["Templars"]);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Talisman_05");
    AtlasLootMenuItem_2.lootpage="Templars";
    AtlasLootMenuItem_2:Show();
    --Dukes
    AtlasLootMenuItem_17_Name:SetText(AL["Abyssal Council"].." - "..AL["Dukes"]);
    AtlasLootMenuItem_17_Extra:SetText("");
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Ring_36");
    AtlasLootMenuItem_17.lootpage="Dukes";
    AtlasLootMenuItem_17:Show();
    --High Council
    AtlasLootMenuItem_3_Name:SetText(AL["Abyssal Council"].." - "..AL["High Council"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Staff_13");
    AtlasLootMenuItem_3.lootpage="HighCouncil";
    AtlasLootMenuItem_3:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Abyssal Council"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end
