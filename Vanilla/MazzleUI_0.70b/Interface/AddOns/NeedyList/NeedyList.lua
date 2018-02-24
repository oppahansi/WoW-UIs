--------------------------------------------------------
-- Ralak's Needy List
-- a UI modification by Ralak of Kel'Thuzad
--------------------------------------------------------
NL_CURRENT_VERSION = 1.62;

NL_MAX_TOOLTIP_BUFFS = 16;
NL_MAX_TOOLTIP_DEBUFFS = 16;
NL_MAX_NEEDS = 12;
NL_MAX_UNITS = 18;
NL_NUM_VISIBLE_FRAMES = 0;
NL_ELAPSED = 0;
NL_REFRESH_TIME = 0.5;
NL_PRIORITIZED_NEEDS = {};
NL_PRIORITIES_WRITEABLE = true;
NL_NEEDY_UNITS = {};

NL_PLAYERCLASS = "";

NeedyListDetails = {
name = 'Ralak\'s Needy List',
description = 'Monitor needy units in your party or raid group.',
version = NL_CURRENT_VERSION,
releaseDate = 'March 28, 2006',
author = 'Carson Knittig',
email = 'needylist@gmail.com',
category = MYADDONS_CATEGORY_RAID,
frame = 'NLMainFrame',
optionsframe = 'NLConfigFrame'
};

NL_BUFF_SPELLS = {
	Priest = {
		Fortitude = { "Power Word: Fortitude", "Prayer of Fortitude", Icons={"Spell_Holy_WordFortitude","Spell_Holy_PrayerOfFortitude"}, Ranks={1,12,24,36,48,60} },
		ShadowProt = { "Shadow Protection", Icons={"Spell_Shadow_AntiShadow"}, Ranks={30,42,56} },
		PWShield = { "Power Word: Shield", Icons={"Spell_Holy_PowerWordShield"}, Ranks={6,12,18,24,30,36,42,48,54,60} },
        DivineSpirit = { "Divine Spirit", Icons={"Spell_Holy_HolyProtection", "Spell_Holy_DivineSpirit"}, Ranks={30,40,42,54} },
		FearWard = { "Fear Ward", Icons={"Spell_Holy_Excorcism"} },
		InnerFire = { "Inner Fire", Icons={"Spell_Holy_InnerFire"}, Ranks={12,20,30,40,50,60}, NoTarget=true },
		TouchOfWeakness = { "Touch of Weakness", Icons={"Spell_Shadow_DeadofNight"}, Ranks={10,20,30,40,50,60}, NoTarget=true },
		Feedback = { "Feedback", Icons={"Spell_Shadow_RitualOfSacrifice"}, Ranks={20,30,40,50,60}, NoTarget=true }
		},
	Druid = {
		Mark = {"Mark of the Wild", "Gift of the Wild", Icons={"Spell_Nature_Regeneration","Spell_Nature_Regeneration"}, Ranks = {1,10,20,30,40,50,60}},
		Thorns = {"Thorns", Icons={"Spell_Nature_Thorns"}, Ranks={6,14,24,34,44,54}},
		Clarity = {"Omen of Clarity", Icons={"Spell_Nature_CrystalBall"} },
		},
	Mage = {
		Intellect = {"Arcane Intellect", "Arcane Brilliance", Icons={"Spell_Holy_MagicalSentry","Spell_Holy_ArcaneIntellect"}, Ranks={1,14,28,42,56}},
		MageArmor = {"Mage Armor", Icons={"Spell_MageArmor"}, Ranks={34,46,58}, NoTarget=true},
		FrostArmor = {"Frost Armor", Icons={"Spell_Frost_FrostArmor02"}, Ranks={1,10,20}, NoTarget=true},
		IceArmor = {"Ice Armor", Icons={"Spell_Frost_FrostArmor02"}, Ranks={30,40,50,60}, NoTarget=true},
		AmplifyMagic = {"Amplify Magic", Icons={"Spell_Holy_FlashHeal"}, Ranks={18,30,42,54}},
		DampenMagic = {"Dampen Magic", Icons={"Spell_Nature_AbolishMagic"}, Ranks={12,24,36,48,60}},
		ManaShield = {"Mana Shield", Icons={"Spell_Shadow_DetectLesserInvisibility"}, Ranks={20,28,36,44,52,60}, NoTarget=true}
		},
	Paladin = {
		BlessMight = { "Blessing of Might", Icons={"Spell_Holy_FistOfJustice"}, Ranks={4,12,22,32,42,52} },
		BlessWisdom = {"Blessing of Wisdom", Icons={"Spell_Holy_SealOfWisdom"}, Ranks={14,24,34,44,54}},
		BlessKings = {"Blessing of Kings", Icons={"Spell_Magic_MageArmor"}},
		BlessSalvation = {"Blessing of Salvation", Icons={"Spell_Holy_SealOfSalvation"}},
		BlessLight = {"Blessing of Light", Icons={"Spell_Holy_PrayerOfHealing02"}, Ranks={40,50,60}},
		BlessSanctuary = {"Blessing of Sanctuary", Icons={"Spell_Nature_LightningShield"}, Ranks={20,30,40,50,60}},
		GreaterBlessMight = {"Greater Blessing of Might", Icons={"Spell_Holy_GreaterBlessingofKings"}, Ranks={52,60}},
		GreaterBlessWisdom = {"Greater Blessing of Wisdom", Icons={"Spell_Holy_GreaterBlessingofWisdom"}, Ranks={54,60}},
		GreaterBlessKings = {"Greater Blessing of Kings", Icons={"Spell_Magic_GreaterBlessingofKings"}},
		GreaterBlessLight = {"Greater Blessing of Light", Icons={"Spell_Holy_GreaterBlessingofLight"}},
		GreaterBlessSanctuary = {"Greater Blessing of Sanctuary", Icons={"Spell_Holy_GreaterBlessingofSanctuary"}},
		GreaterBlessSalvation = {"Greater Blessing of Salvation", Icons={"Spell_Holy_GreaterBlessingofSalvation"}},
		},
	Warlock = {
		Soulstone = {"Soulstone Resurrection", Icons={"Spell_Shadow_SoulGem"}},
		DemonSkin = {"Demon Skin", Icons={"Spell_Shadow_RagingScream"}, Ranks={1,10}, NoTarget=true},
		DemonArmor = {"Demon Armor", Icons={"Spell_Shadow_RagingScream"}, Ranks={20,30,40,50,60}, NoTarget=true},
		UnendingBreath = {"Unending Breath", Icons={"Spell_Shadow_DemonBreath"}},
		DetectLesserInvis = {"Detect Lesser Invisibility", Icons={"Spell_Shadow_DetectLesserInvisibility"}},
		DetectInvis = {"Detect Invisibility", Icons={"Spell_Shadow_DetectInvisibility"}},
		DetectGreaterInvis = {"Detect Greater Invisibility", Icons={"Spell_Shadow_DetectInvisibility"}},
		},
	Rogue = {
		DetectTraps = {"Detect Traps", Icons={"Ability_Spy"}, NoTarget=true}
		},
	Shaman = {
		LightningShield = {"Lightning Shield", Icons={"Spell_Nature_LightningShield"}, Ranks={8,16,24,32,40,48,56}, NoTarget=true},
		},
	Warrior = {
		BattleShout = {"Battle Shout", Icons={"Ability_Warrior_BattleShout"}, NoTarget=true},
		}
};

NL_ENCHANT_SPELLS = {
	Shaman = {
		Rockbiter = {"Rockbiter Weapon", Icon="Spell_Nature_RockBiter", Ranks={1,8,24,34,44,54}},
		Flametongue = {"Flametongue Weapon", Icon="Spell_Fire_FlameTounge", Ranks={10,18,26,36,46,56}},
		Frostbrand = {"Frostbrand Weapon", Icon="Spell_Frost_FrostBrand", Ranks={20,28,38,48,58}},
		Windfury = {"Windfury Weapon", Icon="Spell_Nature_Cyclone", Ranks={30,40,50,60}},
		},
	Rogue = {
		MainhandPoison = {"Mainhand Poison", Icon="Ability_Poisons"},
		OffhandPoison = {"Offhand Poison", Icon="Ability_Poisons"},
		}
};

NL_CURE_SPELLS = {
	Priest = {
		Disease = { "Cure Disease", "Abolish Disease", Icon="Spell_Holy_NullifyDisease" },
		Magic = { "Dispel Magic(Rank 1)", "Dispel Magic(Rank 2)", Icon="Spell_Holy_DispelMagic", CanTargetEnemy=true },
		Resurrection = { "Resurrection", Icon="Ability_Vanish", Ranks={10,22,34,46,58} },
		},
	Druid = {
		Poison = {"Cure Poison", "Abolish Poison", Icon="Spell_Nature_NullifyPoison"},
		Curse = {"Remove Curse", Icon="Spell_Nature_RemoveCurse"},
		Resurrection = { "Rebirth", Icon="Ability_Vanish", Ranks={20,30,40,50,60} },
		},
	Mage = {
		Curse = {"Remove Lesser Curse", Icon="Spell_Nature_RemoveCurse"},
		},
	Paladin = {
		Poison = {"Purify", "Cleanse", Icon="Spell_Nature_NullifyPoison"},
		Disease = {"Purify", "Cleanse", Icon="Spell_Nature_NullifyDisease"},
		Magic = {"Cleanse", Icon="Spell_Holy_DispelMagic"},
		Resurrection = { "Redemption", Icon="Ability_Vanish", Ranks={12,24,36,48,60}},
		},
	Shaman = {
		Poison = {"Cure Poison", Icon="Spell_Nature_NullifyPoison"},
		Disease = {"Cure Disease", Icon="Spell_Nature_NullifyDisease"},
		Resurrection = { "Ancestral Spirit", Icon="Ability_Vanish", Ranks={12,24,36,48,60}},
		}
};

NL_OTHER = {
	WellFed = {"Well Fed", Icon="Spell_Misc_Food"},
	Health = {"Health", Icon="Spell_Holy_Heal"},
	Mana = {"Mana", Icon="Spell_Nature_Lightning"}
};

NL_WEAKENED_SOUL = "Interface\\Icons\\Spell_Holy_AshesToAshes";
NL_BANISH = "Interface\\Icons\\Spell_Shadow_Cripple";
NL_PHASE_SHIFT = "Interface\\Icons\\Spell_Shadow_ImpPhaseShift"

NL_CLICK_INDICES = {LeftButton = 1, RightButton = 2, MiddleButton = 3, Button4 = 4, Button5 = 5};

NL_ICON_LOCATION = "Interface\\Icons\\";

NLMembersList = {};

function NL_Msg(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

--------------------------------------------------------
-- NL_OnLoad
--------
-- Initialization of the Needy List modification
--------------------------------------------------------
function NL_OnLoad()
	-- Register Events
	NLMainFrame:RegisterEvent("UNIT_NAME_UPDATE");
	NLMainFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	NLMainFrame:RegisterEvent("UNIT_HEALTH");
	NLMainFrame:RegisterEvent("UNIT_MANA");
	NLMainFrame:RegisterEvent("UNIT_RAGE");
	NLMainFrame:RegisterEvent("UNIT_FOCUS");
	NLMainFrame:RegisterEvent("UNIT_ENERGY");
	NLMainFrame:RegisterEvent("UNIT_AURA");
	NLMainFrame:RegisterEvent("PARTY_MEMBERS_CHANGED");
	NLMainFrame:RegisterEvent("RAID_ROSTER_UPDATE");
	NLMainFrame:RegisterEvent("UNIT_PET");
	NLMainFrame:RegisterEvent("VARIABLES_LOADED");

	-- Add Slash Commands
	SlashCmdList["NLCONFIG"] = NL_Configure;
	SLASH_NLCONFIG1 = "/nlconfig";
	SlashCmdList["NLCURE"] = NL_CureTopNeed;
	SLASH_NLCURE1 = "/nlcure";
	SlashCmdList["NLSORT"] = NL_SortList;
	SLASH_NLSORT1 = "/nlsort";

	-- get this player's class so we know which buffs and debuffs to notify him/her of
	NL_PLAYERCLASS = UnitClass("player");
	--if( DEFAULT_CHAT_FRAME ) then
		--DEFAULT_CHAT_FRAME:AddMessage("Loaded Ralak's Needy List v"..NL_CURRENT_VERSION..".");
		--DEFAULT_CHAT_FRAME:AddMessage("Right-click the Needy List button or type /nlconfig for options.");
	--end
end

function NL_CheckIfEnabled()
	local bRaid = GetNumRaidMembers() > 0;
	local bParty = UnitExists("party1") and not bRaid;
	local bSolo = not ( bParty or bRaid );

	if (MazzleUI_Settings.NeedyListEnabled and( ( bRaid and NLConfig.UseInRaid == 1 ) or ( bParty and NLConfig.UseInParty == 1 ) or ( bSolo and NLConfig.UseWhenSolo == 1 ) ) ) then
		NL_Enable();
	else
		NL_Disable();
	end
end

function NL_Disable()
	NL_ENABLED = false;

	NLHeader:Hide();

	for i=1, NLConfig.MaxUnits do
		getglobal("NLMember" .. i):Hide();
	end
end

function NL_Enable()
	NL_ENABLED = true;

	NLHeader:Show();

	NLMember_CheckAllUnits();
end

function NL_Configure()
	NLConfigFrame:Show();
end

--------------------------------------------------------
-- NL_OnEvent
--------
-- General event handler for the Needy List modification
--------------------------------------------------------
function NL_OnEvent(event, arg1)
	--Player loaded completely
	if ( event == "UNIT_NAME_UPDATE" and arg1 == "player" ) or (event=="PLAYER_ENTERING_WORLD") then
		-- get the configs for this player
		NLConfig = NL_GetConfigForCurrentPlayer( false );

		NL_CheckIfEnabled();
		if( not NL_ENABLED ) then
			NL_Disable();
			return;
		end

		NLHeader:Show();

		NLMember_CheckAllUnits();

		return;
	end

	if( NLConfig == nil ) then
		return;
	end

	if( event == "PARTY_MEMBERS_CHANGED" or event == "RAID_ROSTER_UPDATE" ) then
		NL_CheckIfEnabled();
	end

	if( not NL_ENABLED ) then
		return;
	end

	-- if this is a stat or buff change on a unit
	if ( event == "UNIT_HEALTH" or event == "UNIT_MANA" or event == "UNIT_RAGE" or event == "UNIT_FOCUS" or event == "UNIT_ENERGY" or event == "UNIT_AURA" ) then
		if( event == "UNIT_AURA" ) then
			-- if it's the aura that changed, refresh the buff list, debuff list, and debuff type list for this unit
			NL_StoreAura( arg1 );
		end

		-- if I'm in a raid group, only use units with raid in their name
		local criteria;
		if( GetNumRaidMembers() > 0 ) then
			criteria = string.find( arg1, "raid" ) ~= nil;
		else
			criteria = string.find( arg1, "party" ) ~= nil or arg1 == "player" or arg1 == "pet";
		end

		-- if this player is in the raid or party, or is the default player
		if( criteria ) then
			-- if his/her health is less than max, add to list
			NL_CheckNeeds( arg1 );
		end

		return;
	end

	if( event == "UNIT_PET" ) then
		local criteria;
		local prefix;
		local suffix;
		if( GetNumRaidMembers() > 0 ) then
			criteria = string.find( arg1, "raid" ) ~= nil;
			prefix = "raid";
			suffix = string.sub( arg1, 5 );
		else
			-- the reason we only check the player here is because in a raid, the player is treated as a raid member as well as the player
			-- no sense updating twice!
			if( arg1 == "player" ) then
				NL_StoreAura( "pet" );
				NL_CheckNeeds( "pet" );
				return;
			else
				criteria = string.find( arg1, "party" ) ~= nil;
				prefix = "party";
				suffix = string.sub( arg1, 6 );
			end
		end

		-- if we're in a raid, check raid members
		-- if not, check party members, or do nothing if we already found the player
		if( criteria ) then
			local petUnit = prefix .. "pet" .. suffix;
			NL_StoreAura( petUnit );
			NL_CheckNeeds( petUnit );
		end
		return;
	end

	if( event == "PARTY_MEMBERS_CHANGED" or event == "RAID_ROSTER_UPDATE" ) then
		NLMember_CheckAllUnits();
		return;
	end

	if( event == "VARIABLES_LOADED" ) then
		-- Register the addon in myAddOns
		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(NeedyListDetails);
		end

		return;
	end
end

function NL_UnitPassesFilter( unit, filter )
	if( filter == nil or filter.Type == "Everyone" ) then
		return true;
	end

	if( filter.Type == "Units" ) then
	    local uName = UnitName( unit )
		if( string.find( filter.Names, uName ) ) then
			local foundName = string.sub( filter.Names, string.find( filter.Names, uName ) );
			if( string.find( foundName, "," ) ) then
				foundName = string.sub( foundName, string.find( foundName, "," ) - 1 );
			end
			if( foundName == uName ) then
--				NL_AddToList(unit, -1);
				return true;
			end
		end
	end

	-- if the filter is by party, use the unit name to determine which party and check if that party is being monitored
	-- party filter is only valid in raids, so if you're not in a raid, pretend filter is everyone
	if( filter.Type == "Parties" ) then
		if( string.find( unit, "raid" ) == nil ) then
			return true;
		end
		local raidIndex;
		if( string.find( unit, "raidpet" ) ~= nil ) then
			raidIndex = string.sub( unit, 8 );
		else
			raidIndex = string.sub( unit, 5 );
		end

		local name, rank, subgroup = GetRaidRosterInfo(raidIndex);

		if( filter.Names["Party " .. subgroup] ) then
			return true;
		end
	end

	if( filter.Type == "Classes" ) then
		if( string.find( unit, "pet" ) ~= nil ) then
			if( filter.Names[UnitCreatureType( unit )] ) then
				return true;
			end
		else
			if( filter.Names[UnitClass( unit )] ) then
				return true;
			end
		end
	end

	return false;
end

function NL_ClearNeedDetails(member)
	-- clear the need buttons in the needdetails frame
	if( NLMembersList[member] ) then
		local frameName = "NLMember" .. NLMembersList[member];
		for i=1, NL_MAX_NEEDS do
			getglobal(frameName .. "NeedsDetailsNeed" .. i):Hide();
		end
		getglobal(frameName .. "NeedsDetails"):Hide();
	end
end

function NL_ClearBuffDetails(member)
	-- clear the need buttons in the needdetails frame
	if( NLMembersList[member] ) then
		local frameName = "NLMember" .. NLMembersList[member];
		for i=1, NL_MAX_TOOLTIP_BUFFS do
			getglobal(frameName .. "BuffsDetailsBuff"..i):Hide();
		end
		getglobal(frameName .. "BuffsDetails"):Hide();
	end
end

function NL_ClearDebuffDetails(member)
	-- clear the need buttons in the needdetails frame
	if( NLMembersList[member] ) then
		local frameName = "NLMember" .. NLMembersList[member];
		for i=1, NL_MAX_TOOLTIP_DEBUFFS do
			getglobal(frameName .. "DebuffsDetailsDebuff"..i):Hide();
		end
		getglobal(frameName .. "DebuffsDetails"):Hide();
	end
end

function NL_StoreAura( member )
	local i = 1;
	local buff = UnitBuff(member, i);
	if( NL_CURRENT_BUFFS == nil ) then
		NL_CURRENT_BUFFS = {};
	end
	if( NL_CURRENT_DEBUFFS == nil ) then
		NL_CURRENT_DEBUFFS = {};
	end
	if( NL_CURRENT_DEBUFF_TYPES == nil ) then
		NL_CURRENT_DEBUFF_TYPES = {};
	end

	NL_CURRENT_BUFFS[member] = {};

	while( buff ~= nil ) do
		NL_CURRENT_BUFFS[member][buff] = true;
		i = i + 1;
		buff = UnitBuff(member, i);
	end

	i = 1;
	local debuff = UnitDebuff(member, i);
	NL_CURRENT_DEBUFFS[member] = {};
	NL_CURRENT_DEBUFF_TYPES[member] = {};

	while( debuff ~= nil ) do
		-- do not add the ignored debuffs to the debuff lists
		if( debuff ~= NL_ICON_LOCATION.."Spell_Holy_MindVision" ) then
			NL_CURRENT_DEBUFFS[member][debuff] = true;

			NL_BuffTooltipTextRight1:SetText(nil);
			NL_BuffTooltip:SetUnitDebuff( member, i );
			local debuffType = NL_BuffTooltipTextRight1:GetText();

			if( debuffType ) then
				if( NL_CURRENT_DEBUFF_TYPES[member][debuffType] ) then
					NL_CURRENT_DEBUFF_TYPES[member][debuffType] = NL_CURRENT_DEBUFF_TYPES[member][debuffType] + 1;
				else
					NL_CURRENT_DEBUFF_TYPES[member][debuffType] = 1;
				end
			end
		end

		i = i + 1;
		debuff = UnitDebuff(member, i);
	end
end

--------------------------------------------------------
-- NL_CheckNeeds
--------
-- Check if passed in unit has any needs.
--------------------------------------------------------
function NL_CheckNeeds( member )
    local uName = UnitName( member )
	-- first, make sure the unit exists
	if( not UnitExists( member ) or uName == "" or uName == nil or not UnitIsConnected( member ) ) then
		NL_RemoveFromList( member );
		return;
	end

	if( NL_CURRENT_BUFFS == nil ) then
		NL_CURRENT_BUFFS = {};
	end
	if( NL_CURRENT_DEBUFFS == nil ) then
		NL_CURRENT_DEBUFFS = {};
	end
	if( NL_CURRENT_DEBUFF_TYPES == nil ) then
		NL_CURRENT_DEBUFF_TYPES = {};
	end

	-- get the list of buffs (to improve efficiency of buff searching)
	local buffList = NL_CURRENT_BUFFS[member]; --NL_GetBuffList(member);
	-- get the list of debuffs (to improve efficiency of buff searching)
	local debuffList = NL_CURRENT_DEBUFFS[member]; --NL_GetDebuffLists(member);
	local debuffTypeList = NL_CURRENT_DEBUFF_TYPES[member];

	if( string.find( member, "pet" ) and ((buffList and buffList[NL_PHASE_SHIFT]) or (debuffList and debuffList[NL_BANISH] )) ) then
		NL_RemoveFromList( member );
		return;
	end

	local topPriorityNeed = -1;
	local needDetails = {needCount=0};

	for i = 0, NLConfig.NumNeeds - 1 do
		local CurrentNeed = NLConfig.Needs[i];
		if( CurrentNeed.Toggle == 1 and NL_UnitPassesFilter( member, CurrentNeed.Filter ) ) then
			local FoundNeed = false;
			if( UnitIsDead(member) or UnitIsGhost(member) ) then
				-- if unit is the player, then do not monitor resurrection need, because a) can't rez yourself  b) it's obvious when you need a rez
				if( CurrentNeed.Name == "Resurrection" ) then
					if( not UnitIsUnit( member, "player" ) ) then
						FoundNeed = true;
					end
				end
			else
				if( CurrentNeed.Name == "Health" ) then
					-- monitoring health
					if((UnitHealth(member) / UnitHealthMax(member) * 100) < CurrentNeed.Threshold or 
						((UnitHealth(member) / UnitHealthMax(member) * 100) < min(CurrentNeed.Threshold + 5,99) and NLMembersList[member] and
						NL_NEEDY_UNITS[member] and NLConfig.Needs[NL_NEEDY_UNITS[member]].Name == "Health" ) ) then
						-- needs health
						FoundNeed = true;
					end
				elseif( CurrentNeed.Name == "Mana" ) then
					-- monitoring mana
					if(((UnitMana(member) / UnitManaMax(member) * 100) < CurrentNeed.Threshold or 
						((UnitMana(member) / UnitManaMax(member) * 100) < min(CurrentNeed.Threshold + 5,99) and NLMembersList[member] and
						NL_NEEDY_UNITS[member] and NLConfig.Needs[NL_NEEDY_UNITS[member]].Name == "Mana" ) ) and 
						UnitPowerType(member) == 0 ) then
						-- needs mana
						FoundNeed = true;
					end
				elseif( CurrentNeed.Name == "WellFed" ) then
					if( not buffList[NL_ICON_LOCATION .. NL_OTHER.WellFed.Icon] ) then
						FoundNeed = true;
					end
				elseif( CurrentNeed.Type == "BUFF" and debuffList ) then
					if( not NL_FindInBuffList( CurrentNeed.Name, buffList ) ) then
						-- if the buff is power word shield, need to look for the weakened soul debuff before finding need
						if( CurrentNeed.Name == "PWShield" ) then
							if( not debuffList[NL_WEAKENED_SOUL] ) then
								FoundNeed = true;
							end
						else
							-- didn't find buff on unit, need it
							FoundNeed = true;
						end
					end
				elseif( CurrentNeed.Type == "ENCHANT" ) then
					local hasMainHandEnchant, mainHandExpiration, mainHandCharges,
						hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo()
					if( NL_PLAYERCLASS == "Shaman" ) then
						if( hasMainHandEnchant ~= 1 ) then
							FoundNeed = true;
						end
					elseif( NL_PLAYERCLASS == "Rogue" ) then
						if( ( CurrentNeed.Name == "MainhandPoison" and hasMainHandEnchant ~= 1 ) or
							( CurrentNeed.Name == "OffhandPoison" and hasOffHandEnchant ~= 1 ) ) then
							FoundNeed = true;
						end
					end
				elseif( CurrentNeed.Type == "DEBUFF" and debuffTypeList ) then
					if( debuffTypeList[CurrentNeed.Name] and debuffTypeList[CurrentNeed.Name] > 0 ) then
						-- found debuff on unit, this is the highest priority need
						FoundNeed = true;
					end
				end
			end

			if( FoundNeed == true ) then
				needDetails[needDetails.needCount] = {};
				needDetails[needDetails.needCount].Name = CurrentNeed.Name;
				needDetails.needCount = needDetails.needCount + 1;

				if( topPriorityNeed == -1 ) then
					topPriorityNeed = i;
				end
			end
		end
	end

	if( topPriorityNeed > -1 ) then
		if( NL_NEEDY_UNITS[member] ~= topPriorityNeed ) then
			if( NL_NEEDY_UNITS[member] ) then
				NL_DeleteUnitFromTable( member );
			end
			NL_InsertUnitIntoTable( topPriorityNeed, member );
		end
		
		local frame = NL_AddToList( member, topPriorityNeed );
		if( frame and needDetails.needCount > 0 and NLConfig.ShowNeeds == 1 ) then
			NL_AddNeedDetailsToFrame( frame, needDetails );
		end
		return true;
	else
		NL_ClearNeedDetails(member);
	end

	-- if we got this far, we didn't find a need
	
	if( NLConfig.Stickies and string.find( NLConfig.Stickies, uName ) ) then
		local foundName = string.sub( NLConfig.Stickies, string.find( NLConfig.Stickies, uName ) );
		if( string.find( foundName, "," ) ) then
			foundName = string.sub( foundName, string.find( foundName, "," ) - 1 );
		end
		if( foundName == uName ) then
			NL_AddToList(member, -1);
			return true;
		end
	end
	
	NL_RemoveFromList( member );
end

--------------------------------------------------------
-- NL_GetMaxRankPlayerCanCast
--------
-- Gets the maximum rank of a specified spell that
-- the player can cast.
--------------------------------------------------------
function NL_GetMaxRankPlayerCanCast( spellName )
	local i = 1;
	local foundSpellName, foundSpellRank;
	local highestMatch = nil;

	repeat
		foundSpellName, foundSpellRank = GetSpellName(i, BOOKTYPE_SPELL);
		if( spellName == foundSpellName ) then
			if( foundSpellRank == nil ) then
				return nil;
			end
			highestMatch = tonumber(string.sub( foundSpellRank, 6 ));
		end
		i = i + 1;
	until not foundSpellName

	return highestMatch;
end

function NL_GetMaxRankUnitCanReceive( spellRanks, unit )
	local unitLevel = UnitLevel(unit);
	local i = 1;
	while spellRanks[i] and unitLevel + 10 >= spellRanks[i] do
		i = i + 1;
	end

	return i - 1;
end

function NL_CureNeedOnUnit( needName, unit, mousebutton )
	local spellName = nil;
	local spellRanks = nil;
	local spellCanTargetEnemy = false;
	local spellNeedsNoTarget = false;
	local isBuff = false;

	local clickIndex = NL_CLICK_INDICES[mousebutton];

	-- find a cure spell that I can cast for this problem based on the player's level
	if( NL_BUFF_SPELLS[NL_PLAYERCLASS] and NL_BUFF_SPELLS[NL_PLAYERCLASS][needName] ) then
		spellName = NL_BUFF_SPELLS[NL_PLAYERCLASS][needName][clickIndex];
		spellRanks = NL_BUFF_SPELLS[NL_PLAYERCLASS][needName].Ranks;
		spellCanTargetEnemy = NL_BUFF_SPELLS[NL_PLAYERCLASS][needName].CanTargetEnemy;
		spellNeedsNoTarget = NL_BUFF_SPELLS[NL_PLAYERCLASS][needName].NoTarget;
		isBuff = true;
	elseif( NL_CURE_SPELLS[NL_PLAYERCLASS] and NL_CURE_SPELLS[NL_PLAYERCLASS][needName] ) then
		-- it's a debuff, find the cure spell for it
		spellName = NL_CURE_SPELLS[NL_PLAYERCLASS][needName][clickIndex];
		spellRanks = NL_CURE_SPELLS[NL_PLAYERCLASS][needName].Ranks;
		spellCanTargetEnemy = NL_CURE_SPELLS[NL_PLAYERCLASS][needName].CanTargetEnemy;
	elseif( NL_ENCHANT_SPELLS[NL_PLAYERCLASS] and NL_ENCHANT_SPELLS[NL_PLAYERCLASS][needName] ) then
		if( NL_PLAYERCLASS == "Rogue" ) then
			return;
		end

		spellName = NL_ENCHANT_SPELLS[NL_PLAYERCLASS][needName][clickIndex];
		spellRanks = NL_ENCHANT_SPELLS[NL_PLAYERCLASS][needName].Ranks;
		spellCanTargetEnemy = NL_ENCHANT_SPELLS[NL_PLAYERCLASS][needName].CanTargetEnemy;
	elseif( needName == "Health" ) then
		if( NLConfig.HealSpells ) then
			spellName = NLConfig.HealSpells[clickIndex];
		end
	elseif( needName == "Mana" ) then
		spellName = "Innervate";
	end

	if( spellName ) then
		-- figure out the rank of the spell to cast based on level
		local hadTarget = false;
		local switchedTarget = false;
		local targetWasEnemy = false;
		local friendlyTargetName = "";
		if( not spellNeedsNoTarget and UnitExists( "target" ) ) then
			hadTarget = true;

			-- if an enemy is targeted and the spell can target an enemy, or unit is friendly, need to switch target
			if( ( UnitIsEnemy( "player", "target" ) and spellCanTargetEnemy ) or UnitIsFriend( "player", "target" ) ) then
				if( UnitIsEnemy( "player", "target" ) ) then
					targetWasEnemy = true;
				else
					friendlyTargetName = UnitName("target");
				end
				TargetUnit( unit );
				switchedTarget = true;
			end
		end

		-- cast the highest ranked spell based on player level
		if( string.sub( spellName, 0, 1 ) ~= "[" ) then
			-- message the person we're casting on, if notifications are enabled
			if( NLConfig.SpellNotify == 1 ) then
				--SendChatMessage( "I'm casting "..spellName.." on you.", "WHISPER", this.language, UnitName(unit) );
			end
			local validRank = NL_GetMaxRankPlayerCanCast( spellName );
			if( spellRanks and validRank ) then
				local allowedRank = validRank;
				if( isBuff ) then
					allowedRank = NL_GetMaxRankUnitCanReceive( spellRanks, unit );
				end
				if( validRank > 0 and allowedRank > 0 ) then
					-- cast the maximum rank of this spell
					CastSpellByName( spellName .. "(Rank " .. min(validRank,allowedRank) .. ")" );
				end
			elseif( validRank ) then
				CastSpellByName( spellName .. "(Rank " .. validRank .. ")" );
			else
				CastSpellByName( spellName );
			end
		else
			local bagNum, slotNum;
			local done = false;
			for bagNum = 0, NUM_BAG_FRAMES do
				local numSlots = GetContainerNumSlots(bagNum);
				for slotNum = 1, numSlots do
					local itemLink = GetContainerItemLink(bagNum, slotNum);
					local itemName = string.sub(spellName, 2, string.len(spellName) - 1);
					if( itemLink and string.find(itemLink, itemName) ) then
						UseContainerItem(bagNum, slotNum);
						done = true;
						break;
					end
				end
				if( done ) then
					break;
				end
			end
		end

		if( not spellNeedsNoTarget ) then
			if ( SpellIsTargeting() ) then
				SpellTargetUnit(unit);
			else
				if( hadTarget == false ) then
					ClearTarget();
				elseif( switchedTarget ) then
					if( targetWasEnemy ) then
						TargetLastEnemy();
					else
						TargetByName(friendlyTargetName);
					end
				end
			end
		end
	end
end

function NL_AddNeedDetailsToFrame( frame, needDetails )
	local needFrameIndex = 1;

	-- maximum is currently 10
	if( needDetails.needCount > NL_MAX_NEEDS ) then
		needDetails.needCount = NL_MAX_NEEDS;
	end

	for i=0, needDetails.needCount - 1 do
		local iconName = "";
		if( NL_BUFF_SPELLS[NL_PLAYERCLASS] and NL_BUFF_SPELLS[NL_PLAYERCLASS][needDetails[i].Name] ) then
			iconName = NL_BUFF_SPELLS[NL_PLAYERCLASS][needDetails[i].Name].Icons[1];
		elseif( NL_CURE_SPELLS[NL_PLAYERCLASS] and NL_CURE_SPELLS[NL_PLAYERCLASS][needDetails[i].Name] ) then
			iconName = NL_CURE_SPELLS[NL_PLAYERCLASS][needDetails[i].Name].Icon;
		elseif( NL_ENCHANT_SPELLS[NL_PLAYERCLASS] and NL_ENCHANT_SPELLS[NL_PLAYERCLASS][needDetails[i].Name] ) then
			iconName = NL_ENCHANT_SPELLS[NL_PLAYERCLASS][needDetails[i].Name].Icon;
		elseif( NL_OTHER[needDetails[i].Name] ) then
			iconName = NL_OTHER[needDetails[i].Name].Icon;
		end

		if( iconName ~= "" ) then
			local needFrame = getglobal(frame:GetName() .. "NeedsDetailsNeed"..needFrameIndex);
			if( NLConfig.LargeNeedIcons == 1 ) then
				getglobal(frame:GetName() .. "NeedsDetailsNeed"..needFrameIndex):SetWidth( 22 );
				getglobal(frame:GetName() .. "NeedsDetailsNeed"..needFrameIndex):SetHeight( 22 );
			else
				getglobal(frame:GetName() .. "NeedsDetailsNeed"..needFrameIndex):SetWidth( 15 );
				getglobal(frame:GetName() .. "NeedsDetailsNeed"..needFrameIndex):SetHeight( 15 );
			end
			needFrame:SetNormalTexture(NL_ICON_LOCATION .. iconName);
			needFrame.NeedName = needDetails[i].Name;
			needFrame:Show();
			if( needFrame == NL_MOUSE_OVER_FRAME ) then
				NL_MouseOverNeedButton(needFrame);
			end
			needFrameIndex = needFrameIndex + 1;
		end
	end

	for i=needFrameIndex, NL_MAX_NEEDS - 1 do
		getglobal(frame:GetName() .. "NeedsDetailsNeed"..i):Hide();
	end

	if( NLConfig.LargeNeedIcons == 1 ) then
		getglobal(frame:GetName() .. "NeedsDetails"):SetWidth( needDetails.needCount * 24 + 8 );
		getglobal(frame:GetName() .. "NeedsDetails"):SetHeight( 32 );
		getglobal(frame:GetName() .. "NeedsDetailsNeed1"):SetPoint( "TOPLEFT", frame:GetName() .. "NeedsDetails", "TOPLEFT", 5, -5 - ((getglobal(frame:GetName() .. "NeedsDetails"):GetHeight() - 32) / 2) );
	else
		getglobal(frame:GetName() .. "NeedsDetails"):SetWidth( needDetails.needCount * 17 + 15 );
		getglobal(frame:GetName() .. "NeedsDetails"):SetHeight( min( frame:GetHeight(), 32 ) );
		getglobal(frame:GetName() .. "NeedsDetailsNeed1"):SetPoint( "TOPLEFT", frame:GetName() .. "NeedsDetails", "TOPLEFT", 9, -9 - ((getglobal(frame:GetName() .. "NeedsDetails"):GetHeight() - 32) / 2) );
	end
	getglobal(frame:GetName() .. "NeedsDetails"):Show();
end

function NL_FindInBuffList( needName, buffList )

	if( NL_BUFF_SPELLS[ NL_PLAYERCLASS ] ) then
		if( NL_BUFF_SPELLS[ NL_PLAYERCLASS ][needName] ) then
			if( NL_BUFF_SPELLS[ NL_PLAYERCLASS ][needName].Icons[1] and buffList[NL_ICON_LOCATION..NL_BUFF_SPELLS[ NL_PLAYERCLASS ][needName].Icons[1]] ) then
				return true;
			elseif( NL_BUFF_SPELLS[ NL_PLAYERCLASS ][needName].Icons[2] and buffList[NL_ICON_LOCATION..NL_BUFF_SPELLS[ NL_PLAYERCLASS ][needName].Icons[2]] ) then
				return true;
			end
		end
	end

	return false;
end

--------------------------------------------------------
-- NL_AddToList
--------
-- Add the passed in unit to the needy list, or refresh
-- that unit if it's already in the list.
--------------------------------------------------------
function NL_AddToList(member, needIndex)
    local uName = UnitName(member)
	if( not UnitExists(member) or uName == nil or uName == "" or uName == "Unknown Entity" ) then
		return;
	end

	local frame = nil;
	local nextAvailableSlot = -1;

	-- first find out if this player is already being displayed, if not, find the next available frame for it
	if( not NLMembersList[member] ) then
		if( NL_NUM_VISIBLE_FRAMES >= NLConfig.MaxUnits ) then
			return;
		end

		for i=1, NLConfig.MaxUnits do
			if( getglobal("NLMember" .. i).Unit == nil ) then
				NL_NUM_VISIBLE_FRAMES = NL_NUM_VISIBLE_FRAMES + 1;
				frame = getglobal("NLMember"..i);
				frame.Unit = member;
				getglobal(frame:GetName() .. "Name"):SetText( string.sub(uName,1,NLConfig.FrameWidth/8) );
				NLMembersList[member] = i;
				frame:Show();
				break;
			end
		end
	else
		frame = getglobal("NLMember"..NLMembersList[member]);
	end

	if( frame ) then
		if( NLMembersList[member] <= NLConfig.MaxUnits ) then
			if( frame.Unit ~= member or getglobal(frame:GetName() .. "Name"):GetText() ~= string.sub(uName,1,NLConfig.FrameWidth/8) ) then
				NLMembersList[member] = nil;
				frame.Unit = nil;
				frame:Hide();
			else
				NL_UpdateBuffs( member );
				NL_UpdateDebuffs( member );
				NL_UpdateUnit( member );
			end
		end

		if( needIndex == -1 ) then
			frame:SetBackdropColor( 0, 0, 1, 0.5 );
		elseif( NLConfig.Needs[needIndex] ~= nil ) then
			frame:SetBackdropColor(NLConfig.Needs[needIndex].BGColor.r, NLConfig.Needs[needIndex].BGColor.g, NLConfig.Needs[needIndex].BGColor.b, 0.8);
		end
	end

	return frame;
end

function NL_InsertUnitIntoTable( topPriorityNeed, unit )
	if( NL_PRIORITIES_WRITEABLE == true ) then
		local t = NL_PRIORITIZED_NEEDS[topPriorityNeed];
		-- don't add stickies to the table
		if( NLConfig.Stickies and NLConfig.Stickies ~= "" ) then
			local tempStickies = NLConfig.Stickies;
			while string.find( tempStickies, "," ) do
				-- get the next name (everything before the comma)
				if( string.sub( tempStickies, 1, string.find( tempStickies, "," ) - 1 ) == UnitName(unit) ) then
					return;
				end
				tempStickies = string.sub( tempStickies, string.find( tempStickies, "," ) + 1 );
			end
			if( tempStickies == UnitName(unit) ) then
				return;
			end
		end

		table.insert( t, unit );
		NL_NEEDY_UNITS[unit] = topPriorityNeed;
	end
end

function NL_DeleteUnitFromTable( unit )
	if( NL_PRIORITIES_WRITEABLE == true ) then
		local t = NL_PRIORITIZED_NEEDS[NL_NEEDY_UNITS[unit]];
		for i=1, table.getn( t ) do
			if( t[i] == unit ) then
				table.remove(t, i);
				NL_NEEDY_UNITS[unit] = nil;
			end
		end
	end
end

--------------------------------------------------------
-- NL_RemoveFromList
--------
-- Remove unit from needy list.
--------------------------------------------------------
function NL_RemoveFromList(member)
	if( NL_NEEDY_UNITS[member] ) then
		NL_DeleteUnitFromTable( member );
	end

	if( NLMembersList[member] ) then
		local frame = getglobal("NLMember"..NLMembersList[member]);
		frame:Hide();
		NL_ClearNeedDetails(member)
		NL_ClearBuffDetails(member);
		NL_ClearDebuffDetails(member);
		frame.Unit = nil;
		NLMembersList[member] = nil;

		NL_NUM_VISIBLE_FRAMES = NL_NUM_VISIBLE_FRAMES - 1;

		-- if we just freed up the last slot, need to check all units to fill this newly freed slot
		if( NLConfig.MaxUnits - 1 == NL_NUM_VISIBLE_FRAMES and NLConfig.AutoSort == 0 ) then
			NL_FillEmptiedSlots();
		end
	end
end

function NL_FillEmptiedSlots()
	if( NL_NUM_VISIBLE_FRAMES >= NLConfig.MaxUnits ) then
		return;
	end

	-- if it's a raid, check all raid# and raid#pet
	if( GetNumRaidMembers() > 0 ) then
		-- in a raid, so just go through all raid members and pets
		for i = 1, 40 do
			if( UnitExists( "raid" .. i ) ) then
				NL_StoreAura( "raid" .. i );
				NL_CheckNeeds( "raid" .. i );
			end
			if( UnitExists( "raidpet" .. i ) ) then
				NL_StoreAura( "raidpet" .. i );
				NL_CheckNeeds( "raidpet" .. i );
			end

			if( NL_NUM_VISIBLE_FRAMES >= NLConfig.MaxUnits ) then
				return;
			end
		end
	else
		if( UnitExists( "player" ) ) then
			NL_StoreAura( "player" );
			NL_CheckNeeds( "player" );
		end
		if( UnitExists( "pet" ) ) then
			NL_StoreAura( "pet" );
			NL_CheckNeeds( "pet" );
		end

		for i = 1, 4 do
			if( UnitExists( "party" .. i ) ) then
				NL_StoreAura( "party" .. i );
				NL_CheckNeeds( "party" .. i );
			end
			if( UnitExists( "partypet" .. i ) ) then
				NL_StoreAura( "partypet" .. i );
				NL_CheckNeeds( "partypet" .. i );
			end

			if( NL_NUM_VISIBLE_FRAMES >= NLConfig.MaxUnits ) then
				return;
			end
		end
	end
end

--------------------------------------------------------
-- NL_UpdateUnit
--------
-- Update the unit in the passed in frame.
--------------------------------------------------------
function NL_UpdateUnit(id)
	if( not NLMembersList[id] ) then
		return;
	end

	local frame = getglobal("NLMember" .. NLMembersList[id]);
	if( NLConfig.ShowHealthNum == 1 ) then
		if( NLConfig.ShowHealthLost == 1 ) then
			getglobal(frame:GetName() .. "HealthNum"):SetText(UnitHealth(id)-UnitHealthMax(id));
		else
			getglobal(frame:GetName() .. "HealthNum"):SetText(UnitHealth(id) .. "/" .. UnitHealthMax(id));
		end
		getglobal(frame:GetName() .. "HealthNum"):Show();
	elseif( getglobal(frame:GetName() .. "HealthNum"):IsVisible() ) then
		getglobal(frame:GetName() .. "HealthNum"):Hide();
	end

	if( UnitIsDead(id) or UnitIsGhost(id) ) then
		getglobal(frame:GetName() .. "HPBar"):Hide();
		getglobal(frame:GetName() .. "MPBar"):Hide();
		if( NLConfig.ShowHealth == 1 and NLConfig.ShowMana == 1 ) then
			if( UnitIsDead(id) ) then
				getglobal(frame:GetName() .. "Status"):SetText("Dead");
			else
				getglobal(frame:GetName() .. "Status"):SetText("Ghost");
			end
			getglobal(frame:GetName() .. "Status"):Show();
		end
		return;
	else
		getglobal(frame:GetName() .. "Status"):Hide();
		if( NLConfig.ShowHealth == 1 ) then
			getglobal(frame:GetName() .. "HPBar"):Show();
		end
		-- determine the color for the power bar
		local info = ManaBarColor[UnitPowerType(id)];
		getglobal(frame:GetName() .. "MPBar"):SetStatusBarColor(info.r, info.g, info.b);
		if( NLConfig.ShowMana == 1 ) then
			getglobal(frame:GetName() .. "MPBar"):Show();
		end
	end

	-- set the name in the frame
	local percent = floor(UnitHealth(id) / UnitHealthMax(id) * 100);
	local maxHealth = UnitHealthMax(id);
	if ( percent and percent > 0 ) then
		if ( percent > 100 ) then
			percent = 100;
		end
		getglobal(frame:GetName() .. "HPBar"):SetValue(percent);
		local hppercent = percent/100;
		local r, g;
		if ( hppercent > 0.5 and hppercent <= 1) then
			g = 1;
			r = (1.0 - hppercent) * 2;
		elseif ( hppercent >= 0 and hppercent <= 0.5 ) then
			r = 1.0;
			g = hppercent * 2;
		else
			r = 0;
			g = 1;
		end
		getglobal(frame:GetName() .. "HPBar"):SetStatusBarColor(r, g, 0);
	end

	-- get the class of the player and update the mana bar appropriately
	if( UnitManaMax(id) == 0 ) then
		getglobal(frame:GetName() .. "MPBar"):SetValue(0);
	else
		local percent = floor(UnitMana(id) / UnitManaMax(id) * 100);
		getglobal(frame:GetName() .. "MPBar"):SetValue(percent);
	end
end

--------------------------------------------------------
-- NL_UpdateBuffs
--------
-- Update the buffs for the unit in the passed in frame.
--------------------------------------------------------
function NL_UpdateBuffs(unit)
	if( not UnitExists(unit) ) then
		return;
	end

	if( not NLMembersList[unit] ) then
		return;
	end

	local frame = "NLMember" .. NLMembersList[unit];

	if( NLConfig.ShowBuffs == 0 and NLConfig.ShowHealBuffs == 0 ) then
		getglobal(frame .. "BuffsDetails"):SetWidth( 5 );
		return;
	end

	local buff;
	local numBuffs = 0;
	local index = 1;
	for i=1, NL_MAX_TOOLTIP_BUFFS do
		buff = UnitBuff(unit, i);
		if ( buff and (NLConfig.ShowBuffs == 1 or (NLConfig.ShowHealBuffs == 1 and 
			(buff == NL_ICON_LOCATION .. "Spell_Nature_Rejuvenation" or
			buff == NL_ICON_LOCATION .. "Spell_Nature_ResistNature" or
			buff == NL_ICON_LOCATION .. "Spell_Holy_Renew" )
			) ) ) then
			getglobal(frame .. "BuffsDetailsBuff"..index):SetNormalTexture(buff);
			getglobal(frame .. "BuffsDetailsBuff"..index):Show();
			getglobal(frame .. "BuffsDetailsBuff"..index):SetID(index);
			if( getglobal(frame .. "BuffsDetailsBuff"..index) == NL_MOUSE_OVER_FRAME ) then
				GameTooltip:SetUnitBuff( getglobal(frame).Unit, i );
			end
			index = index + 1;
			numBuffs = numBuffs + 1;
		end
	end
	for i=index, NL_MAX_TOOLTIP_BUFFS do
		getglobal(frame .. "BuffsDetailsBuff"..i):Hide();
	end

	getglobal(frame .. "BuffsDetailsBuff1"):SetPoint( "TOPLEFT", frame .. "BuffsDetails", "TOPLEFT", 9, -9 - ((getglobal(frame .. "BuffsDetails"):GetHeight() - 32) / 2) );
	getglobal(frame .. "BuffsDetails"):SetHeight( min( getglobal(frame):GetHeight(), 32 ) );
	-- Size the tooltip
	if ( numBuffs > 0 ) then
		getglobal(frame .. "BuffsDetails"):SetWidth( (numBuffs * 17) + 15 );
		getglobal(frame .. "BuffsDetails"):Show();
	else
		getglobal(frame .. "BuffsDetails"):SetWidth( 5 );
		getglobal(frame .. "BuffsDetails"):Hide();
	end
end

function NL_UpdateDebuffs(unit)
	if( not UnitExists(unit) ) then
		return;
	end

	if( not NLMembersList[unit] ) then
		return;
	end

	local frame = "NLMember" .. NLMembersList[unit];

	if( NLConfig.ShowDebuffs == 0 ) then
		getglobal(frame .. "DebuffsDetails"):SetWidth( 5 );
		return;
	end

	local buff;
	local numDebuffs = 0;
	local index = 1;
	for i=1, NL_MAX_TOOLTIP_DEBUFFS do
		buff = UnitDebuff(unit, i);
		
		if ( buff ) then
			getglobal(frame .. "DebuffsDetailsDebuff"..index):SetNormalTexture(buff);
			getglobal(frame .. "DebuffsDetailsDebuff"..index):Show();
			getglobal(frame .. "DebuffsDetailsDebuff"..index):SetID(index);
			if( getglobal(frame .. "DebuffsDetailsDebuff"..index) == NL_MOUSE_OVER_FRAME ) then
				GameTooltip:SetUnitDebuff( getglobal(frame).Unit, i );
			end
			index = index + 1;
			numDebuffs = numDebuffs + 1;
		end
	end
	for i=index, NL_MAX_TOOLTIP_DEBUFFS do
		getglobal(frame .. "DebuffsDetailsDebuff"..i):Hide();
	end

	getglobal(frame .. "DebuffsDetailsDebuff1"):SetPoint( "TOPLEFT", frame .. "DebuffsDetails", "TOPLEFT", 9, -9 - ((getglobal(frame .. "DebuffsDetails"):GetHeight() - 32) / 2) );
	getglobal(frame .. "DebuffsDetails"):SetHeight( min( getglobal(frame):GetHeight(), 32 ) );
	-- Size the tooltip
	if ( numDebuffs > 0 ) then
		getglobal(frame .. "DebuffsDetails"):SetWidth( (numDebuffs * 17) + 15 );
		getglobal(frame .. "DebuffsDetails"):Show();
	else
		getglobal(frame .. "DebuffsDetails"):SetWidth( 5 );
		getglobal(frame .. "DebuffsDetails"):Hide();
	end
end

function NL_SetTooltipOwner( frame, anchor )
	if( NLConfig.ShowTooltips == 1 ) then
		GameTooltip:SetOwner(frame, anchor);
	else
		GameTooltip:Hide();
	end
end

--------------------------------------------------------
-- NLMember_OnEnter
--------
-- OnEnter event for the member frame.
--------------------------------------------------------
function NLMember_OnEnter(frame)
	NL_SetTooltipOwner( frame, "ANCHOR_TOPLEFT" );

	-- show the right-click option
--	if( getglobal( frame:GetName() .. "Details" ):IsVisible() ) then
--		GameTooltip:SetText("Right click to hide details.");
--	else
--		GameTooltip:SetText("Right click to show details.");
--	end
	-- if we'd prefer the tooltip to show the unit details rather than the right-click option, use the following instead
	GameTooltip:SetUnit( frame.Unit );
end

--------------------------------------------------------
-- NLMember_OnLeave
--------
-- OnLeave event for the member frame.
--------------------------------------------------------
function NLMember_OnLeave(frame)
	GameTooltip:Hide();
end

--------------------------------------------------------
-- NLMember_OnClick
--------
-- OnClick event for the member frame.
--------------------------------------------------------
function NLMember_OnClick(button, frame)
	if( NLConfig.UseCastParty == 1 and CastParty_OnClickByUnit ~= nil ) then
		CastParty_OnClickByUnit( button, frame.Unit );
	else
		if ( button == "LeftButton" ) then
			-- determine which unit was clicked
			if ( SpellIsTargeting() ) then
				SpellTargetUnit(frame.Unit);
			elseif ( CursorHasItem() ) then
				DropItemOnUnit(frame.Unit);
			else
				TargetUnit(frame.Unit);
			end
		else
			if( SpellIsTargeting() ) then
				SpellStopTargeting();
				return;
			end
		end
	end
end

function NL_AddParty()
    local partyString = UnitName("player")
    for _,member in {"party1","party2","party3","party4","pet"} do
        if (UnitExists(member)) then
            local uName = UnitName(member)
            partyString = partyString..","..uName
        end
    end
    NLConfigFrame_StickyNames:SetText(partyString)
end

function NLMember_AddStickyUnit( member )
	-- loop through all units, looking specifically for the one with this name
	if( GetNumRaidMembers() > 0 ) then
		-- in a raid, so just go through all raid members and pets
		for i = 1, 40 do
			if( UnitExists( "raid" .. i ) and UnitName( "raid" .. i ) == member ) then
				NL_AddToList( "raid" .. i, -1 );
				NL_StoreAura( "raid" .. i );
				NL_CheckNeeds( "raid" .. i );
			end
			if( UnitExists( "raidpet" .. i ) and UnitName( "raidpet" .. i ) == member ) then
				NL_AddToList( "raidpet" .. i, -1 );
				NL_StoreAura( "raidpet" .. i );
				NL_CheckNeeds( "raidpet" .. i );
			end
		end
	else
		if( UnitExists( "player" ) and UnitName( "player" ) == member ) then
			NL_AddToList( "player", -1 );
			NL_StoreAura( "player" );
			NL_CheckNeeds( "player" );
		end
		if( UnitExists( "pet" ) and UnitName( "pet" ) == member ) then
			NL_AddToList( "pet", -1 );
			NL_StoreAura( "pet" );
			NL_CheckNeeds( "pet" );
		end

		for i = 1, 4 do
			if( UnitExists( "party" .. i ) and UnitName( "party" .. i ) == member ) then
				NL_AddToList( "party" .. i, -1 );
				NL_StoreAura( "party" .. i );
				NL_CheckNeeds( "party" .. i );
			end
			if( UnitExists( "partypet" .. i ) and UnitName( "partypet" .. i ) == member ) then
				NL_AddToList( "partypet" .. i, -1 );
				NL_StoreAura( "partypet" .. i );
				NL_CheckNeeds( "partypet" .. i );
			end
		end
	end
end

function NLMember_CheckAllUnits()
	for i=1, NL_MAX_UNITS do
		getglobal("NLMember" .. i):Hide();
		NL_ClearNeedDetails(getglobal("NLMember" .. i).Unit);
		NL_ClearBuffDetails(getglobal("NLMember" .. i).Unit);
		NL_ClearDebuffDetails(getglobal("NLMember" .. i).Unit);
		getglobal("NLMember" .. i .. "Name"):SetText( nil );
		if( getglobal("NLMember" .. i).Unit ~= nil ) then
			if( NLMembersList[getglobal("NLMember" .. i).Unit] ) then
				NLMembersList[getglobal("NLMember" .. i).Unit] = nil;
			end
			NLMembersList[getglobal("NLMember" .. i).Unit] = nil;
			getglobal("NLMember" .. i).Unit = nil;
		end
	end
	NL_NUM_VISIBLE_FRAMES = 0;

	NL_NEEDY_UNITS = {};
	NL_PRIORITIZED_NEEDS = {};
	for i=0, NLConfig.NumNeeds - 1 do
		NL_PRIORITIZED_NEEDS[i] = {};
	end

	-- first go through all stickies in order
	NL_PRIORITIES_WRITEABLE = false;
	if( NLConfig.Stickies and NLConfig.Stickies ~= "" ) then
		local tempStickies = NLConfig.Stickies;

		while string.find( tempStickies, "," ) do
			-- get the next name (everything before the comma)
			local nextName = string.sub( tempStickies, 1, string.find( tempStickies, "," ) - 1 );
			NLMember_AddStickyUnit( nextName );
			tempStickies = string.sub( tempStickies, string.find( tempStickies, "," ) + 1 );
		end

		NLMember_AddStickyUnit( tempStickies );
	end
	NL_PRIORITIES_WRITEABLE = true;

	-- make a second pass, checking need of all units
	NL_FillEmptiedSlots();
end

function NL_MouseOverNeedButton(frame)
	NL_SetTooltipOwner(frame:GetParent():GetParent(), "ANCHOR_TOPLEFT");
	local tooltipText = "";
	if( NL_BUFF_SPELLS[NL_PLAYERCLASS] and NL_BUFF_SPELLS[NL_PLAYERCLASS][frame.NeedName] and NL_BUFF_SPELLS[NL_PLAYERCLASS][frame.NeedName][1] ) then
		if( NL_BUFF_SPELLS[NL_PLAYERCLASS] and NL_BUFF_SPELLS[NL_PLAYERCLASS][frame.NeedName] ) then
			if( NL_BUFF_SPELLS[NL_PLAYERCLASS][frame.NeedName][1] ) then
				tooltipText = "Left-click to cast " .. NL_BUFF_SPELLS[NL_PLAYERCLASS][frame.NeedName][1] .. ".";
			end
			if( NL_BUFF_SPELLS[NL_PLAYERCLASS][frame.NeedName][2] ) then
				tooltipText = tooltipText .. "\nRight-click to cast " .. NL_BUFF_SPELLS[NL_PLAYERCLASS][frame.NeedName][2] .. ".";
			end
		end
	elseif( NL_ENCHANT_SPELLS[NL_PLAYERCLASS] and NL_ENCHANT_SPELLS[NL_PLAYERCLASS][frame.NeedName] and NL_ENCHANT_SPELLS[NL_PLAYERCLASS][frame.NeedName][1] ) then
		if( NL_PLAYERCLASS == "Rogue" ) then
			tooltipText =  "Needs " .. NL_ENCHANT_SPELLS[NL_PLAYERCLASS][frame.NeedName][1] .. ".";
		else
			tooltipText = "Needs " .. NL_ENCHANT_SPELLS[NL_PLAYERCLASS][frame.NeedName][1] .. ".\nClick here to fix.";
		end
	elseif( frame.NeedName == "Resurrection" ) then
		if( NL_CURE_SPELLS[NL_PLAYERCLASS] and NL_CURE_SPELLS[NL_PLAYERCLASS].Resurrection ) then
			tooltipText = "Left-click to cast " .. NL_CURE_SPELLS[NL_PLAYERCLASS].Resurrection[1] .. ".";
		end
	elseif( frame.NeedName == "WellFed" ) then
		tooltipText = "Needs to be well fed.";
	elseif( frame.NeedName == "Health" ) then
		tooltipText = "Needs healing.";
		if( NLConfig.HealSpells ) then
			if( NLConfig.HealSpells[1] ) then
				tooltipText = tooltipText .. "\nLeft-click to cast " .. NLConfig.HealSpells[1] .. ".";
			end
			if( NLConfig.HealSpells[2] ) then
				tooltipText = tooltipText .. "\nRight-click to cast " .. NLConfig.HealSpells[2] .. ".";
			end
			if( NLConfig.HealSpells[3] ) then
				tooltipText = tooltipText .. "\nMiddle-click to cast " .. NLConfig.HealSpells[3] .. ".";
			end
			if( NLConfig.HealSpells[4] ) then
				tooltipText = tooltipText .. "\nClick button 4 to cast " .. NLConfig.HealSpells[4] .. ".";
			end
			if( NLConfig.HealSpells[5] ) then
				tooltipText = tooltipText .. "\nClick button 5 to cast " .. NLConfig.HealSpells[5] .. ".";
			end
		end
		if( tooltipText == "Needs healing." ) then
			tooltipText = tooltipText .. "\nUse 'Configure Spells' from the configuration window to add heal spells.";
		end
	elseif( frame.NeedName == "Mana" ) then
		tooltipText = "Needs mana.\nLeft-click to cast Innervate.";
	else
		tooltipText = "Needs cure for " .. frame.NeedName .. ".";
		if( NL_CURE_SPELLS[NL_PLAYERCLASS] and NL_CURE_SPELLS[NL_PLAYERCLASS][frame.NeedName] ) then
			if( NL_CURE_SPELLS[NL_PLAYERCLASS][frame.NeedName][1] ) then
				tooltipText = tooltipText .. "\nLeft-click to cast " .. NL_CURE_SPELLS[NL_PLAYERCLASS][frame.NeedName][1] .. ".";
			end
			if( NL_CURE_SPELLS[NL_PLAYERCLASS][frame.NeedName][2] ) then
				tooltipText = tooltipText .. "\nRight-click to cast " .. NL_CURE_SPELLS[NL_PLAYERCLASS][frame.NeedName][2] .. ".";
			end
		end
	end
	GameTooltip:SetText( tooltipText );
end

function NL_OnUpdate( elapsed )
	if( NLConfig and NLConfig.AutoSort == 1 and NL_ENABLED and not NL_MOUSE_IN_FRAME ) then
		NL_ELAPSED = NL_ELAPSED + elapsed;

		if( NL_ELAPSED > NL_REFRESH_TIME ) then
			-- update the list
			NL_SortList();
			NL_ELAPSED = 0;
		end
	end
end

function NL_SortList()
	NL_PRIORITIES_WRITEABLE = false;

	local numFrame = 1;

	-- first go through all stickies in order
	if( NLConfig.Stickies and NLConfig.Stickies ~= "" ) then
		local tempStickies = NLConfig.Stickies;

		while string.find( tempStickies, "," ) do
			-- get the next name (everything before the comma)
			if( getglobal("NLMember"..numFrame).Unit and UnitName(getglobal("NLMember"..numFrame).Unit) == string.sub( tempStickies, 1, string.find( tempStickies, "," ) - 1 ) ) then
				numFrame = numFrame + 1;
			end
			tempStickies = string.sub( tempStickies, string.find( tempStickies, "," ) + 1 );
		end

		if( getglobal("NLMember"..numFrame).Unit and UnitName(getglobal("NLMember"..numFrame).Unit) == tempStickies ) then
			numFrame = numFrame + 1;
		end
	end
	
	-- go through the prioritized table of needs and do a checkneeds on each unit to ensure they should still be there
	for i=0, NLConfig.NumNeeds - 1 do
		if( NL_PRIORITIZED_NEEDS[i] and table.getn(NL_PRIORITIZED_NEEDS[i]) > 0 ) then
			-- if it's the 'health' need, and the threshold is less than 100 (meaning the units should NEVER have the exact same % of health)
			-- sort them by health!
			if( NLConfig.Needs[i] and NLConfig.Needs[i].Name == "Health" and NLConfig.Needs[i].Threshold < 100 ) then
				table.sort( NL_PRIORITIZED_NEEDS[i], NL_CompareHealthFunc );
			end
			for j=1, table.getn(NL_PRIORITIZED_NEEDS[i]) do
				if( numFrame <= NLConfig.MaxUnits ) then
					if( getglobal("NLMember"..numFrame).Unit ~= NL_PRIORITIZED_NEEDS[i][j] ) then
						NL_RemoveFromList( getglobal("NLMember"..numFrame).Unit );
						NL_RemoveFromList( NL_PRIORITIZED_NEEDS[i][j] );
						NL_CheckNeeds(NL_PRIORITIZED_NEEDS[i][j]);
					end
					numFrame = numFrame + 1;
				end
			end
		end
	end
	NL_PRIORITIES_WRITEABLE = true;
end

function NL_CompareHealthFunc( unit1, unit2 )
	return UnitHealth(unit1)/UnitHealthMax(unit1) < UnitHealth(unit2)/UnitHealthMax(unit2);
end

function NL_CureTopNeed()
	if( NLMember1.Unit and NLMember1NeedsDetailsNeed1:IsVisible() and NLMember1NeedsDetailsNeed1.NeedName ) then
		NL_CureNeedOnUnit( NLMember1NeedsDetailsNeed1.NeedName, NLMember1.Unit, "LeftButton" );
	end
end
