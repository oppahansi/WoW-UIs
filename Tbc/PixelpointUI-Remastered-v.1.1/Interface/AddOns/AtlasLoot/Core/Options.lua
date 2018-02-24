--[[
Options.lua
Functions:
AtlasLootOptions_Init()
AtlasLootOptions_OnLoad()
AtlasLootOptions_SafeLinksToggle()
AtlasLootOptions_AllLinksToggle()
AtlasLootOptions_DefaultTTToggle()
AtlasLootOptions_LootlinkTTToggle()
AtlasLootOptions_ItemSyncTTToggle()
AtlasLootOptions_EquipCompareToggle()
AtlasLootOptions_OpaqueToggle()
AtlasLootOptions_ItemIDToggle()
AtlasLootOptions_ItemSpam()
AtlasLootOptions_LoDSpam()
AtlasLootOptions_LoDStartup()
]]

--Invoke libraries
local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

function AtlasLootOptions_Init()
    --Initialise all the check boxes on the options frame
    AtlasLootOptionsFrameSafeLinks:SetChecked(AtlasLoot.db.profile.SafeLinks);
	AtlasLootOptionsFrameAllLinks:SetChecked(AtlasLoot.db.profile.AllLinks);
	AtlasLootOptionsFrameDefaultTT:SetChecked(AtlasLoot.db.profile.DefaultTT);
	AtlasLootOptionsFrameLootlinkTT:SetChecked(AtlasLoot.db.profile.LootlinkTT);
	AtlasLootOptionsFrameItemSyncTT:SetChecked(AtlasLoot.db.profile.ItemSyncTT);
    AtlasLootOptionsFrameEquipCompare:SetChecked(AtlasLoot.db.profile.EquipCompare);
    AtlasLootOptionsFrameOpaque:SetChecked(AtlasLoot.db.profile.Opaque);
    AtlasLootOptionsFrameItemID:SetChecked(AtlasLoot.db.profile.ItemIDs);
    AtlasLootOptionsFrameItemSpam:SetChecked(AtlasLoot.db.profile.ItemSpam);
    AtlasLootOptionsFrameLoDSpam:SetChecked(AtlasLoot.db.profile.LoDNotify);
    AtlasLootOptionsFrameLoDStartup:SetChecked(AtlasLoot.db.profile.LoadAllLoDStartup);
    AtlasLootOptionsFrameHidePanel:SetChecked(AtlasLoot.db.profile.HidePanel);
    AtlasLootOptionsFrameMinimap:SetChecked(AtlasLoot.db.profile.MinimapButton);
end

function AtlasLootOptions_OnLoad()
    --Disable checkboxes of missing addons
    if( not LootLink_SetTooltip ) then
        AtlasLootOptionsFrameLootlinkTT:Disable();
        AtlasLootOptionsFrameLootlinkTTText:SetText(AL["|cff9d9d9dLootlink Tooltips|r"]);
    end
    if( not ItemSync ) then
        AtlasLootOptionsFrameItemSyncTT:Disable();
        AtlasLootOptionsFrameItemSyncTTText:SetText(AL["|cff9d9d9dItemSync Tooltips|r"]);
    end
    AtlasLootOptions_Init();
    temp=AtlasLoot.db.profile.SafeLinks;
    UIPanelWindows['AtlasLootOptionsFrame'] = {area = 'center', pushable = 0};
end

function AtlasLootOptions_SafeLinksToggle()
	if(AtlasLoot.db.profile.SafeLinks) then
		AtlasLoot.db.profile.SafeLinks = false;
	else
		AtlasLoot.db.profile.SafeLinks = true;
        AtlasLoot.db.profile.AllLinks = false;
	end
	AtlasLootOptions_Init();
end

function AtlasLootOptions_AllLinksToggle()
	if(AtlasLoot.db.profile.AllLinks) then
		AtlasLoot.db.profile.AllLinks = false;
	else
		AtlasLoot.db.profile.AllLinks = true;
        AtlasLoot.db.profile.SafeLinks = false;
	end
	AtlasLootOptions_Init();
end

function AtlasLootOptions_DefaultTTToggle()
	AtlasLoot.db.profile.DefaultTT = true;
    AtlasLoot.db.profile.LootlinkTT = false;
    AtlasLoot.db.profile.ItemSyncTT = false;
	AtlasLootOptions_Init();
end

function AtlasLootOptions_LootlinkTTToggle()
	AtlasLoot.db.profile.DefaultTT = false;
    AtlasLoot.db.profile.LootlinkTT = true;
    AtlasLoot.db.profile.ItemSyncTT = false;
	AtlasLootOptions_Init();
end

function AtlasLootOptions_ItemSyncTTToggle()
    AtlasLoot.db.profile.DefaultTT = false;
    AtlasLoot.db.profile.LootlinkTT = false;
    AtlasLoot.db.profile.ItemSyncTT = true;
	AtlasLootOptions_Init();
end

function AtlasLootOptions_OpaqueToggle()
    AtlasLoot.db.profile.Opaque=AtlasLootOptionsFrameOpaque:GetChecked();
    if (AtlasLoot.db.profile.Opaque) then
        AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 1);
    else
        AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 0.65);
    end
    AtlasLootOptions_Init();
end

function AtlasLootOptions_ItemSpam()
    if (AtlasLoot.db.profile.ItemSpam) then
        AtlasLoot.db.profile.ItemSpam = false;
    else
        AtlasLoot.db.profile.ItemSpam = true;
    end
    AtlasLootOptions_Init();
end

function AtlasLootOptions_LoDSpam()
    if (AtlasLoot.db.profile.LoDNotify) then
        AtlasLoot.db.profile.LoDNotify = false;
    else
        AtlasLoot.db.profile.LoDNotify = true;
    end
    AtlasLootOptions_Init();
end

function AtlasLootOptions_LoDStartup()
    if (AtlasLoot.db.profile.LoadAllLoDStartup) then
        AtlasLoot.db.profile.LoadAllLoDStartup = false;
    else
        AtlasLoot.db.profile.LoadAllLoDStartup = true;
    end
    AtlasLootOptions_Init();
end

function AtlasLootOptions_ItemIDToggle()
    AtlasLoot.db.profile.ItemIDs=AtlasLootOptionsFrameItemID:GetChecked();
    AtlasLootOptions_Init();
end
