NL_NEED_FRAME_LEFT_INDENT = 20
NL_NEED_FRAME_TOP_INDENT = 30
NL_NEED_FRAME_SPACING = 25

NLNeedFrameName = "NLConfigNeedsFrame";
NLMainFrameName = "NLConfigFrame";

NLClassLists = {
{ Alliance="Warrior", Horde="Warrior" },
{ Alliance="Priest", Horde="Priest" },
{ Alliance="Rogue", Horde="Rogue" },
{ Alliance="Mage", Horde="Mage" },
{ Alliance="Hunter", Horde="Hunter" },
{ Alliance="Druid", Horde="Druid" },
{ Alliance="Warlock", Horde="Warlock" },
{ Alliance="Paladin", Horde="Shaman" },
{ Alliance="Beast", Horde="Beast" },
{ Alliance="Demon", Horde="Demon" },
};

--------------------------------------------------------
-- NL_GetConfigForCurrentPlayer
--------
-- Get the configuration for this player.
--------------------------------------------------------
function NL_GetConfigForCurrentPlayer( doDefaults )
	if( NL_CONFIGS == nil ) then
		NL_CONFIGS = {};
	end

	local sName = UnitName("player") .. " " .. GetCVar("realmName");

	if( doDefaults or NL_CONFIGS[sName] == nil or NL_CONFIGS[sName].Version == nil ) then
		NL_CONFIGS[sName] = {};
		NL_CONFIGS[sName].ShowHealth = 1;
		NL_CONFIGS[sName].ShowMana = 0;
		NL_CONFIGS[sName].Stickies = "";
		NL_CONFIGS[sName].Needs = {};
		NL_CONFIGS[sName].FrameWidth = 80;
		NL_CONFIGS[sName].Version = 1;

		local NeedsList = NL_CONFIGS[sName].Needs;
		local numNeeds = 0;

		NeedsList[numNeeds] = {Name="Health",Toggle=1,BGColor={r = 1.0, g = 0.0, b = 0.0, opacity = 0.8},Threshold=75,Filter={Type="Everyone"}};
		numNeeds = numNeeds + 1;

		if( NL_PLAYERCLASS == "Priest" or NL_PLAYERCLASS == "Paladin" ) then
			NeedsList[numNeeds] = {Name="Magic",Type="DEBUFF",Toggle=1,BGColor={r = 1.0, g = 0.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;
		end

		if( NL_PLAYERCLASS == "Shaman" or NL_PLAYERCLASS == "Druid" or NL_PLAYERCLASS == "Paladin" ) then
			NeedsList[numNeeds] = {Name="Poison",Type="DEBUFF",Toggle=1,BGColor={r = 1.0, g = 1.0, b = 0.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;
		end

		if( NL_PLAYERCLASS == "Shaman" or NL_PLAYERCLASS == "Priest" or NL_PLAYERCLASS == "Paladin" ) then
			NeedsList[numNeeds] = {Name="Disease",Type="DEBUFF",Toggle=1,BGColor={r = 0.0, g = 1.0, b = 0.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;
		end

		if( NL_PLAYERCLASS == "Mage" or NL_PLAYERCLASS == "Druid" ) then
			NeedsList[numNeeds] = {Name="Curse",Type="DEBUFF",Toggle=1,BGColor={r = 0.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;
		end

		-- for priests specifically
		if( NL_PLAYERCLASS == "Priest" ) then
			NeedsList[numNeeds] = {Name="Fortitude",Type="BUFF",Toggle=1,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="ShadowProt",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 0.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="PWShield",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 0.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			if( UnitFactionGroup( "player" ) == "Horde" ) then
				NeedsList[numNeeds] = {Name="DivineSpirit",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8},Filter={Type="Classes",Names={Priest=true,Mage=true,Hunter=true,Warlock=true,Druid=true,Shaman=true,Demon=true}}};
			else
				NeedsList[numNeeds] = {Name="DivineSpirit",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8},Filter={Type="Classes",Names={Priest=true,Mage=true,Hunter=true,Warlock=true,Druid=true,Paladin=true,Demon=true}}};
			end
			numNeeds = numNeeds + 1;

			if( UnitRace("player") == "Dwarf" ) then
				NeedsList[numNeeds] = {Name="FearWard",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 1.0, b = 0.5, opacity = 0.8},Filter={Type="Everyone"}};
				numNeeds = numNeeds + 1;
			end
		end

		-- for druids specifically
		if( NL_PLAYERCLASS == "Druid" ) then
			NeedsList[numNeeds] = {Name="Mark",Type="BUFF",Toggle=1,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="Thorns",Type="BUFF",Toggle=0,BGColor={r = 0.0, g = 1.0, b = 0.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;
		end

		-- for paladins specifically
		if( NL_PLAYERCLASS == "Paladin" ) then
			NeedsList[numNeeds] = {Name="BlessMight",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="BlessWisdom",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8},Filter={Type="Classes",Names={Priest=true,Mage=true,Hunter=true,Warlock=true,Druid=true,Paladin=true,Demon=true}}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="BlessKings",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="BlessSalvation",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="BlessLight",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="BlessSanctuary",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;
		end

		-- for mages specifically
		if( NL_PLAYERCLASS == "Mage" ) then
			if( UnitFactionGroup( "player" ) == "Horde" ) then
				NeedsList[numNeeds] = {Name="Intellect",Type="BUFF",Toggle=1,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Classes",Names={Priest=true,Mage=true,Hunter=true,Warlock=true,Druid=true,Shaman=true,Demon=true}}};
			else
				NeedsList[numNeeds] = {Name="Intellect",Type="BUFF",Toggle=1,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Classes",Names={Priest=true,Mage=true,Hunter=true,Warlock=true,Druid=true,Paladin=true,Demon=true}}};
			end
			numNeeds = numNeeds + 1;
		end

		-- for warlocks specifically
		if( NL_PLAYERCLASS == "Warlock" ) then
			NeedsList[numNeeds] = {Name="Soulstone",Type="BUFF",Toggle=1,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;
		end

		NL_CONFIGS[sName].NumNeeds = numNeeds;
		NL_CONFIGS[sName].MaxUnits = 10;
		NL_CONFIGS[sName].Version = 1;
	end

	-- added in version 1.3
	if( doDefaults or NL_CONFIGS[sName].Version < 1.3 ) then
		if( NL_PLAYERCLASS == "Priest" ) then
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="InnerFire",Type="BUFF",Toggle=1,BGColor={r = 1.0, g = 0.5, b = 0.5, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
		end
	end

	-- added in version 1.32
	if( doDefaults or NL_CONFIGS[sName].Version < 1.32 ) then
		-- for rogues specifically
		if( NL_PLAYERCLASS == "Rogue" ) then
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="DetectTraps",Type="BUFF",Toggle=1,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
		end

		if( NL_PLAYERCLASS == "Priest" or NL_PLAYERCLASS == "Druid" or NL_PLAYERCLASS == "Paladin" or NL_PLAYERCLASS == "Shaman" ) then
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="Resurrection",Toggle=1,BGColor={r = 0.5, g = 0.5, b = 0.5, opacity = 0.8},Filter={Type="Everyone"}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
		end
	end

	-- added in version 1.4
	if( doDefaults or NL_CONFIGS[sName].Version < 1.4 ) then
		-- for mages specifically
		if( NL_PLAYERCLASS == "Mage" ) then
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="MageArmor",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="FrostArmor",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="IceArmor",Type="BUFF",Toggle=1,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="DampenMagic",Type="BUFF",Toggle=0,BGColor={r = 0.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="AmplifyMagic",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 0.5, b = 0.0, opacity = 0.8},Filter={Type="Everyone"}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="ManaShield",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
		end

		if( NL_PLAYERCLASS == "Warlock" ) then
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="DemonArmor",Type="BUFF",Toggle=1,BGColor={r = 1.0, g = 0.0, b = 0.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="DemonSkin",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 0.0, b = 0.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="UnendingBreath",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="DetectLesserInvis",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="DetectInvis",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="DetectGreaterInvis",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
		end

		NL_CONFIGS[sName].UseCastParty = 1;
		NL_CONFIGS[sName].DisableNeedyList = 0;
		NL_CONFIGS[sName].ShowHealthNum = 0;
	end

	if( doDefaults or NL_CONFIGS[sName].Version < 1.42 ) then
		if( NL_PLAYERCLASS == "Shaman" ) then
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="LightningShield",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="Rockbiter",Type="ENCHANT",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 0.5, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="Flametongue",Type="ENCHANT",Toggle=0,BGColor={r = 1.0, g = 0.5, b = 0.5, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="Frostbrand",Type="ENCHANT",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="Windfury",Type="ENCHANT",Toggle=0,BGColor={r = 0.75, g = 0.75, b = 0.75, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
		end

		if( NL_PLAYERCLASS == "Rogue" ) then
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="MainhandPoison",Type="ENCHANT",Toggle=0,BGColor={r = 0.0, g = 1.0, b = 0.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="OffhandPoison",Type="ENCHANT",Toggle=0,BGColor={r = 0.0, g = 1.0, b = 0.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
		end

		if( NL_PLAYERCLASS == "Priest" and UnitRace("player") == "Undead" ) then
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="TouchOfWeakness",Type="BUFF",Toggle=0,BGColor={r = 0.0, g = 1.0, b = 0.5, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
		end

		NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="WellFed",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 0.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
		NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;

		NL_CONFIGS[sName].DisableNeedyList = nil;
		NL_CONFIGS[sName].UseWhenSolo = 1;
		NL_CONFIGS[sName].UseInParty = 1;
		NL_CONFIGS[sName].UseInRaid = 1;
	end

	if( doDefaults or NL_CONFIGS[sName].Version < 1.5 ) then
		if( NL_PLAYERCLASS == "Warrior" ) then
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="BattleShout",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 0.5, b = 0.5, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
		end

		NL_CONFIGS[sName].AutoSort = 1;
	end

	if( doDefaults or NL_CONFIGS[sName].Version < 1.51 ) then
		NL_CONFIGS[sName].Stickies = string.gsub(NL_CONFIGS[sName].Stickies, " ", "");
	end

	if( doDefaults or NL_CONFIGS[sName].Version < 1.55 ) then
		if( NL_PLAYERCLASS == "Priest" and UnitRace("player") == "Human" ) then
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="Feedback",Type="BUFF",Toggle=0,BGColor={r = 0.8, g = 0.0, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
		end

		if( NL_PLAYERCLASS == "Druid" ) then
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="Clarity",Type="BUFF",Toggle=0,BGColor={r = 0.4, g = 0.4, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
		end
	end

	if( doDefaults or NL_CONFIGS[sName].Version < 1.58 ) then
		NL_CONFIGS[sName].ShowTooltips = 1;
		NL_CONFIGS[sName].LargeNeedIcons = 1;
	end

	if( doDefaults or NL_CONFIGS[sName].Version < 1.6 ) then
		if( NL_PLAYERCLASS == "Paladin" ) then
			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="GreaterBlessMight",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;

			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="GreaterBlessWisdom",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8},Filter={Type="Classes",Names={Priest=true,Mage=true,Hunter=true,Warlock=true,Druid=true,Paladin=true,Demon=true}}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;

			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="GreaterBlessKings",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;

			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="GreaterBlessSalvation",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;

			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="GreaterBlessLight",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;

			NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="GreaterBlessSanctuary",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
		end
	end

	if( doDefaults or NL_CONFIGS[sName].Version < 1.61 ) then
		if( NL_PLAYERCLASS == "Druid" ) then
			if( UnitFactionGroup( "player" ) == "Horde" ) then
				NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="Mana",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8},Threshold=25,Filter={Type="Classes",Names={Priest=true,Mage=true,Hunter=true,Warlock=true,Druid=true,Shaman=true,Demon=true}}};
			else
				NL_CONFIGS[sName].Needs[NL_CONFIGS[sName].NumNeeds] = {Name="Mana",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8},Threshold=25,Filter={Type="Classes",Names={Priest=true,Mage=true,Hunter=true,Warlock=true,Druid=true,Paladin=true,Demon=true}}};
			end
			NL_CONFIGS[sName].NumNeeds = NL_CONFIGS[sName].NumNeeds + 1;
		end
	end

	NL_CONFIGS[sName].Version = NL_CURRENT_VERSION;

	if( NL_CONFIGS[sName].ShowNeeds == nil ) then
		NL_CONFIGS[sName].ShowNeeds = 1;
	end
	if( NL_CONFIGS[sName].ShowBuffs == nil ) then
		NL_CONFIGS[sName].ShowBuffs = 0;
	end
	if( NL_CONFIGS[sName].ShowHealBuffs == nil ) then
		NL_CONFIGS[sName].ShowHealBuffs = 0;
	end
	if( NL_CONFIGS[sName].ShowDebuffs == nil ) then
		NL_CONFIGS[sName].ShowDebuffs = 0;
	end
	if( NL_CONFIGS[sName].SwapNeedsAndDetails == nil ) then
		NL_CONFIGS[sName].SwapNeedsAndDetails = 0;
	else
		-- change the anchor points on all the needs and details frames
		if( NL_CONFIGS[sName].SwapNeedsAndDetails == 1 ) then
			for i=1, NL_CONFIGS[sName].MaxUnits do
				getglobal("NLMember" .. i .. "BuffsDetails"):ClearAllPoints();
				getglobal("NLMember" .. i .. "BuffsDetails"):SetPoint("BOTTOMLEFT", "NLMember" .. i, "BOTTOMRIGHT", -5, 0);
				getglobal("NLMember" .. i .. "DebuffsDetails"):ClearAllPoints();
				getglobal("NLMember" .. i .. "DebuffsDetails"):SetPoint("BOTTOMLEFT", "NLMember" .. i .. "BuffsDetails", "BOTTOMRIGHT", -5, 0);
				getglobal("NLMember" .. i .. "NeedsDetails"):ClearAllPoints();
				getglobal("NLMember" .. i .. "NeedsDetails"):SetPoint("BOTTOMRIGHT", "NLMember" .. i, "BOTTOMLEFT", 5, 0);
			end
		end
	end
	if( NL_CONFIGS[sName].InvertList == nil ) then
		NL_CONFIGS[sName].InvertList = 0;
	else
		-- change the anchor points on all the needs and details frames
		if( NL_CONFIGS[sName].InvertList == 1 ) then
			getglobal("NLMember1"):ClearAllPoints();
			getglobal("NLMember1"):SetPoint("BOTTOMLEFT", "NLHeader", "TOPLEFT", 0, -4);
			for i=2, NL_MAX_UNITS do
				getglobal("NLMember" .. i):ClearAllPoints();
				getglobal("NLMember" .. i):SetPoint("BOTTOMLEFT", "NLMember" .. i - 1, "TOPLEFT", 0, -4);
			end
		end
	end

	return NL_CONFIGS[sName];
end

function NL_InitializeConfigFrame()
	getglobal(NLMainFrameName .. "_CheckButtonUseWhenSolo"):SetChecked(NLConfig.UseWhenSolo);
	getglobal(NLMainFrameName .. "_CheckButtonUseInParty"):SetChecked(NLConfig.UseInParty);
	getglobal(NLMainFrameName .. "_CheckButtonUseInRaid"):SetChecked(NLConfig.UseInRaid);
	getglobal(NLMainFrameName .. "_CheckButtonShowHealth"):SetChecked(NLConfig.ShowHealth);
	getglobal(NLMainFrameName .. "_CheckButtonShowMana"):SetChecked(NLConfig.ShowMana);
	getglobal(NLMainFrameName .. "_CheckButtonShowNeeds"):SetChecked(NLConfig.ShowNeeds);
	getglobal(NLMainFrameName .. "_CheckButtonShowBuffs"):SetChecked(NLConfig.ShowBuffs);
	getglobal(NLMainFrameName .. "_CheckButtonShowHealBuffs"):SetChecked(NLConfig.ShowHealBuffs);
	getglobal(NLMainFrameName .. "_CheckButtonShowDebuffs"):SetChecked(NLConfig.ShowDebuffs);
	getglobal(NLMainFrameName .. "_CheckButtonSwapNeedsAndDetails"):SetChecked(NLConfig.SwapNeedsAndDetails);
	getglobal(NLMainFrameName .. "_CheckButtonUseCastParty"):SetChecked(NLConfig.UseCastParty);
	getglobal(NLMainFrameName .. "_CheckButtonShowHealthNum"):SetChecked(NLConfig.ShowHealthNum);
	getglobal(NLMainFrameName .. "_CheckButtonShowHealthLost"):SetChecked(NLConfig.ShowHealthLost);
	getglobal(NLMainFrameName .. "_CheckButtonAutoSort"):SetChecked(NLConfig.AutoSort);
	getglobal(NLMainFrameName .. "_CheckButtonInvertList"):SetChecked(NLConfig.InvertList);
	getglobal(NLMainFrameName .. "_CheckButtonShowTooltips"):SetChecked(NLConfig.ShowTooltips);
	getglobal(NLMainFrameName .. "_CheckButtonLargeNeedIcons"):SetChecked(NLConfig.LargeNeedIcons);
	getglobal(NLMainFrameName .. "_CheckButtonSpellNotify"):SetChecked(NLConfig.SpellNotify);
	getglobal(NLMainFrameName .. "_SliderFrameWidth"):SetValue(NLConfig.FrameWidth);
	getglobal(NLMainFrameName .. "_SliderMaxUnits"):SetValue(NLConfig.MaxUnits);
	getglobal(NLMainFrameName .. "_StickyNames"):SetText(NLConfig.Stickies);
end

function NL_SaveConfig()
	if( getglobal(NLMainFrameName .. "_CheckButtonUseWhenSolo"):GetChecked() == nil ) then
		NLConfig.UseWhenSolo = 0;
	else
		NLConfig.UseWhenSolo = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonUseInParty"):GetChecked() == nil ) then
		NLConfig.UseInParty = 0;
	else
		NLConfig.UseInParty = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonUseInRaid"):GetChecked() == nil ) then
		NLConfig.UseInRaid = 0;
	else
		NLConfig.UseInRaid = 1;
	end

	NL_CheckIfEnabled();

	if( getglobal(NLMainFrameName .. "_CheckButtonShowHealth"):GetChecked() == nil ) then
		NLConfig.ShowHealth = 0;
	else
		NLConfig.ShowHealth = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonShowMana"):GetChecked() == nil ) then
		NLConfig.ShowMana = 0;
	else
		NLConfig.ShowMana = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonShowNeeds"):GetChecked() == nil ) then
		NLConfig.ShowNeeds = 0;
	else
		NLConfig.ShowNeeds = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonShowBuffs"):GetChecked() == nil ) then
		NLConfig.ShowBuffs = 0;
	else
		NLConfig.ShowBuffs = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonShowHealBuffs"):GetChecked() == nil ) then
		NLConfig.ShowHealBuffs = 0;
	else
		NLConfig.ShowHealBuffs = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonShowDebuffs"):GetChecked() == nil ) then
		NLConfig.ShowDebuffs = 0;
	else
		NLConfig.ShowDebuffs = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonUseCastParty"):GetChecked() == nil ) then
		NLConfig.UseCastParty = 0;
	else
		NLConfig.UseCastParty = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonShowHealthNum"):GetChecked() == nil ) then
		NLConfig.ShowHealthNum = 0;
	else
		NLConfig.ShowHealthNum = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonShowHealthLost"):GetChecked() == nil ) then
		NLConfig.ShowHealthLost = 0;
	else
		NLConfig.ShowHealthLost = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonAutoSort"):GetChecked() == nil ) then
		NLConfig.AutoSort = 0;
	else
		NLConfig.AutoSort = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonSpellNotify"):GetChecked() == nil ) then
		NLConfig.SpellNotify = 0;
	else
		NLConfig.SpellNotify = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonShowTooltips"):GetChecked() == nil ) then
		NLConfig.ShowTooltips = 0;
	else
		NLConfig.ShowTooltips = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonLargeNeedIcons"):GetChecked() == nil ) then
		NLConfig.LargeNeedIcons = 0;
	else
		NLConfig.LargeNeedIcons = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonSwapNeedsAndDetails"):GetChecked() == nil ) then
		-- change the anchor points on all the needs and details frames
		for i=1, NLConfig.MaxUnits do
			getglobal("NLMember" .. i .. "BuffsDetails"):ClearAllPoints();
			getglobal("NLMember" .. i .. "BuffsDetails"):SetPoint("BOTTOMRIGHT", "NLMember" .. i, "BOTTOMLEFT", 5, 0);
			getglobal("NLMember" .. i .. "DebuffsDetails"):ClearAllPoints();
			getglobal("NLMember" .. i .. "DebuffsDetails"):SetPoint("BOTTOMRIGHT", "NLMember" .. i .. "BuffsDetails", "BOTTOMLEFT", 5, 0);
			getglobal("NLMember" .. i .. "NeedsDetails"):ClearAllPoints();
			getglobal("NLMember" .. i .. "NeedsDetails"):SetPoint("BOTTOMLEFT", "NLMember" .. i, "BOTTOMRIGHT", -5, 0);
		end
		NLConfig.SwapNeedsAndDetails = 0;
	else
		-- change the anchor points on all the needs and details frames
		for i=1, NLConfig.MaxUnits do
			getglobal("NLMember" .. i .. "BuffsDetails"):ClearAllPoints();
			getglobal("NLMember" .. i .. "BuffsDetails"):SetPoint("BOTTOMLEFT", "NLMember" .. i, "BOTTOMRIGHT", -5, 0);
			getglobal("NLMember" .. i .. "DebuffsDetails"):ClearAllPoints();
			getglobal("NLMember" .. i .. "DebuffsDetails"):SetPoint("BOTTOMLEFT", "NLMember" .. i .. "BuffsDetails", "BOTTOMRIGHT", -5, 0);
			getglobal("NLMember" .. i .. "NeedsDetails"):ClearAllPoints();
			getglobal("NLMember" .. i .. "NeedsDetails"):SetPoint("BOTTOMRIGHT", "NLMember" .. i, "BOTTOMLEFT", 5, 0);
		end
		NLConfig.SwapNeedsAndDetails = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonInvertList"):GetChecked() == nil ) then
		getglobal("NLMember1"):ClearAllPoints();
		getglobal("NLMember1"):SetPoint("TOPLEFT", "NLHeader", "BOTTOMLEFT", 0, 4);
		for i=2, NL_MAX_UNITS do
			getglobal("NLMember" .. i):ClearAllPoints();
			getglobal("NLMember" .. i):SetPoint("TOPLEFT", "NLMember" .. i - 1, "BOTTOMLEFT", 0, 4);
		end
		NLConfig.InvertList = 0;
	else
		getglobal("NLMember1"):ClearAllPoints();
		getglobal("NLMember1"):SetPoint("BOTTOMLEFT", "NLHeader", "TOPLEFT", 0, -4);
		for i=2, NL_MAX_UNITS do
			getglobal("NLMember" .. i):ClearAllPoints();
			getglobal("NLMember" .. i):SetPoint("BOTTOMLEFT", "NLMember" .. i - 1, "TOPLEFT", 0, -4);
		end
		NLConfig.InvertList = 1;
	end

	NLConfig.FrameWidth = getglobal(NLMainFrameName .. "_SliderFrameWidth"):GetValue();
	NLConfig.MaxUnits = getglobal(NLMainFrameName .. "_SliderMaxUnits"):GetValue();
	NLConfig.Stickies = string.gsub( getglobal(NLMainFrameName .. "_StickyNames"):GetText(), " ", "" );

	if( NL_ENABLED ) then
		NLHeader:Hide();
		NLHeader:Show();
	end
end

function NL_InitializeConfigSpellsFrame()
	if( not NLConfig.HealSpells ) then
		return;
	end

	if( NLConfig.HealSpells[1] ) then
		getglobal("NLConfigSpellsFrameHeal1"):SetText(NLConfig.HealSpells[1]);
	else
		getglobal("NLConfigSpellsFrameHeal1"):SetText("");
	end
	if( NLConfig.HealSpells[2] ) then
		getglobal("NLConfigSpellsFrameHeal2"):SetText(NLConfig.HealSpells[2]);
	else
		getglobal("NLConfigSpellsFrameHeal2"):SetText("");
	end
	if( NLConfig.HealSpells[3] ) then
		getglobal("NLConfigSpellsFrameHeal3"):SetText(NLConfig.HealSpells[3]);
	else
		getglobal("NLConfigSpellsFrameHeal3"):SetText("");
	end
	if( NLConfig.HealSpells[4] ) then
		getglobal("NLConfigSpellsFrameHeal4"):SetText(NLConfig.HealSpells[4]);
	else
		getglobal("NLConfigSpellsFrameHeal4"):SetText("");
	end
	if( NLConfig.HealSpells[5] ) then
		getglobal("NLConfigSpellsFrameHeal5"):SetText(NLConfig.HealSpells[5]);
	else
		getglobal("NLConfigSpellsFrameHeal5"):SetText("");
	end
end

function NL_SaveSpellsConfig()
	if( not NLConfig.HealSpells ) then
		NLConfig.HealSpells = {};
	end
	if( getglobal("NLConfigSpellsFrameHeal1"):GetText() == "" ) then
		NLConfig.HealSpells[1] = nil;
	else
		NLConfig.HealSpells[1] = getglobal("NLConfigSpellsFrameHeal1"):GetText();
	end
	if( getglobal("NLConfigSpellsFrameHeal2"):GetText() == "" ) then
		NLConfig.HealSpells[2] = nil;
	else
		NLConfig.HealSpells[2] = getglobal("NLConfigSpellsFrameHeal2"):GetText();
	end
	if( getglobal("NLConfigSpellsFrameHeal3"):GetText() == "" ) then
		NLConfig.HealSpells[3] = nil;
	else
		NLConfig.HealSpells[3] = getglobal("NLConfigSpellsFrameHeal3"):GetText();
	end
	if( getglobal("NLConfigSpellsFrameHeal4"):GetText() == "" ) then
		NLConfig.HealSpells[4] = nil;
	else
		NLConfig.HealSpells[4] = getglobal("NLConfigSpellsFrameHeal4"):GetText();
	end
	if( getglobal("NLConfigSpellsFrameHeal5"):GetText() == "" ) then
		NLConfig.HealSpells[5] = nil;
	else
		NLConfig.HealSpells[5] = getglobal("NLConfigSpellsFrameHeal5"):GetText();
	end
end

function NL_InitializeConfigNeedsFrame()
	-- loop through all allowed need monitors for this char
	for i = 0, NLConfig.NumNeeds - 1 do
		local CurrentNeed = NLConfig.Needs[i];
		if( CurrentNeed == nil ) then
			return;
		end

		if( CurrentNeed.Name == "Health" ) then
			NLConfigNeedsFrameNeedHealth_EditBox:SetNumber( CurrentNeed.Threshold );
		end

		if( CurrentNeed.Name == "Mana" ) then
			NLConfigNeedsFrameNeedMana_EditBox:SetNumber( CurrentNeed.Threshold );
		end

		local frame = getglobal(NLNeedFrameName .. "Need" .. CurrentNeed.Name);

		frame:SetPoint("TOPLEFT", NLNeedFrameName, "TOPLEFT", NL_NEED_FRAME_LEFT_INDENT, -NL_NEED_FRAME_TOP_INDENT - i * NL_NEED_FRAME_SPACING );
		getglobal(NLNeedFrameName .. "Need" .. CurrentNeed.Name .. "_CheckButton"):SetChecked(CurrentNeed.Toggle);

		frame.r = CurrentNeed.BGColor.r;
		frame.g = CurrentNeed.BGColor.g;
		frame.b = CurrentNeed.BGColor.b;
		getglobal(NLNeedFrameName .. "Need" .. CurrentNeed.Name .. "_ColorSwatchNormalTexture"):SetVertexColor( frame.r, frame.g, frame.b );
		frame.swatchFunc = function() NLConfig_SetColor(CurrentNeed.Name); end;
		frame.cancelFunc = function() NLConfig_CancelColor(CurrentNeed.Name); end;

		getglobal(NLNeedFrameName .. "Need" .. CurrentNeed.Name):Show();
		getglobal(NLNeedFrameName .. "Need" .. CurrentNeed.Name).Priority = i;

		if( CurrentNeed.Filter ~= nil ) then
			getglobal(NLNeedFrameName .. "Need" .. CurrentNeed.Name).Filter = CurrentNeed.Filter;
		end
	end
end

function NL_SaveNeedsConfig()
	-- if the frame's priority doesn't match the need priority, update the need priority
	for i = 0, NLConfig.NumNeeds - 1 do
		local frame = getglobal( NLNeedFrameName .. "Need" .. NLConfig.Needs[i].Name );
		-- move the frame that was
		if( frame.Priority ~= i ) then
			local tempNeed = NLConfig.Needs[frame.Priority];
			NLConfig.Needs[frame.Priority] = NLConfig.Needs[i];
			NLConfig.Needs[i] = tempNeed;
			i = i - 1;
		end
	end

	for i = 0, NLConfig.NumNeeds - 1 do
		local CurrentNeed = NLConfig.Needs[i];
		if( CurrentNeed == nil ) then
			return;
		end

		if( CurrentNeed.Name == "Health" ) then
			 CurrentNeed.Threshold = getglobal(NLNeedFrameName .. "NeedHealth_EditBox"):GetNumber();
		end

		if( CurrentNeed.Name == "Mana" ) then
			 CurrentNeed.Threshold = getglobal(NLNeedFrameName .. "NeedMana_EditBox"):GetNumber();
		end

		if( getglobal(NLNeedFrameName .. "Need" .. CurrentNeed.Name .. "_CheckButton"):GetChecked() == nil ) then
			CurrentNeed.Toggle = 0;
		else
			CurrentNeed.Toggle = 1;
		end

		local frame = getglobal( NLNeedFrameName .. "Need" .. CurrentNeed.Name );

		CurrentNeed.BGColor.r = frame.r;
		CurrentNeed.BGColor.g = frame.g;
		CurrentNeed.BGColor.b = frame.b;

		if( getglobal( NLNeedFrameName .. "Need" .. CurrentNeed.Name ).Filter ~= nil ) then
			CurrentNeed.Filter = getglobal(NLNeedFrameName .. "Need" .. CurrentNeed.Name).Filter;
		end
	end
end

function NL_OpenColorPicker(button)
	CloseMenus();
	if ( not button ) then
		button = this;
	end
	ColorPickerFrame.func = button.swatchFunc;
	ColorPickerFrame:SetColorRGB(button.r, button.g, button.b);
	ColorPickerFrame.previousValues = {r = button.r, g = button.g, b = button.b, opacity = button.opacity};
	ColorPickerFrame.cancelFunc = button.cancelFunc;
	ColorPickerFrame:Show();
end

function NLConfig_SetColor(needName)
	local frame = getglobal( NLNeedFrameName .. "Need" .. needName );
	local r,g,b = ColorPickerFrame:GetColorRGB();
	getglobal( NLNeedFrameName .. "Need" .. needName .. "_ColorSwatchNormalTexture"):SetVertexColor(r,g,b);
	frame.r = r;
	frame.g = g;
	frame.b = b;
end

function NLConfig_CancelColor(needName)
	local frame = getglobal( NLNeedFrameName .. "Need" .. needName );
	local CurrentNeed = NLConfig.Needs[frame.Priority];

	frame.r = CurrentNeed.BGColor.r;
	frame.g = CurrentNeed.BGColor.g;
	frame.b = CurrentNeed.BGColor.b;
	getglobal( NLNeedFrameName .. "Need" .. needName .. "_ColorSwatchNormalTexture"):SetVertexColor( frame.r, frame.g, frame.b );
end

function NL_SwapNeedFrames( frame1, frame2 )
	-- swap these frames
	local tempPriority = frame1.Priority;
	frame1.Priority = frame2.Priority;
	frame2.Priority = tempPriority;

	frame1:SetPoint("TOPLEFT", NLNeedFrameName, "TOPLEFT", NL_NEED_FRAME_LEFT_INDENT, -NL_NEED_FRAME_TOP_INDENT - frame1.Priority * NL_NEED_FRAME_SPACING );
	frame2:SetPoint("TOPLEFT", NLNeedFrameName, "TOPLEFT", NL_NEED_FRAME_LEFT_INDENT, -NL_NEED_FRAME_TOP_INDENT - frame2.Priority * NL_NEED_FRAME_SPACING );
end

function NL_PopulateUnitFilterFrame( filter )
	if( filter == nil or filter.Type ~= "Units" ) then
		return;
	end

	if( filter.Names ~= nil ) then
		NLFilterListFrameUnitsSubframeNames:SetText( filter.Names );
	else
		NLFilterListFrameUnitsSubframeNames:SetText( "" );
	end
end

function NL_PopulatePartyFilterFrame( filter )
	if( filter == nil or filter.Type ~= "Parties" ) then
		return;
	end

	if( filter.Names == nil ) then
		filter.Names = {};
	end

	for i=1, 8 do
		local frame = getglobal( "NLFilterListFramePartiesSubframeParty" .. i );
		if( filter.Names["Party "..i] ) then
			frame:SetBackdropColor(0.5, 0.5, 1, 1);
			frame.Flagged = true;
		else
			frame:SetBackdropColor(0, 0, 0.5, 1);
			frame.Flagged = false;
		end
	end
end

function NL_SelectAllPartyFilterFrame()
	for i=1, 8 do
		local frame = getglobal( "NLFilterListFramePartiesSubframeParty" .. i );
		frame:SetBackdropColor(0.5, 0.5, 1, 1);
		frame.Flagged = true;
		getglobal(NLFilterListFrame.NeedFrame).Filter.Names[ getglobal( frame:GetName() .. "Text" ):GetText() ] = true;
	end
end

function NL_SelectNonePartyFilterFrame()
	for i=1, 8 do
		local frame = getglobal( "NLFilterListFramePartiesSubframeParty" .. i );
		frame:SetBackdropColor(0, 0, 0.5, 1);
		frame.Flagged = false;
		getglobal(NLFilterListFrame.NeedFrame).Filter.Names[ getglobal( frame:GetName() .. "Text" ):GetText() ] = false;
	end
end

function NL_PopulateClassFilterFrame( filter )
	if( filter == nil or filter.Type ~= "Classes" ) then
		return;
	end

	if( filter.Names == nil ) then
		filter.Names = {};
	end

	for i = 1, 10 do
		local class = NLClassLists[i][UnitFactionGroup("player")];
		local frame = getglobal( "NLFilterListFrameClassesSubframe" .. class );
		if( filter.Names[class] ) then
			frame:SetBackdropColor(0.5, 0.5, 1, 1);
			frame.Flagged = true;
		else
			frame:SetBackdropColor(0, 0, 0.5, 1);
			frame.Flagged = false;
		end
		frame:Show();
	end
end

function NL_SelectAllClassFilterFrame()
	for i = 1, 10 do
		local class = NLClassLists[i][UnitFactionGroup("player")];
		local frame = getglobal( "NLFilterListFrameClassesSubframe" .. class );
		frame:SetBackdropColor(0.5, 0.5, 1, 1);
		frame.Flagged = true;
	end
end

function NL_SelectNoneClassFilterFrame()
	for i = 1, 10 do
		local class = NLClassLists[i][UnitFactionGroup("player")];
		local frame = getglobal( "NLFilterListFrameClassesSubframe" .. class );
		frame:SetBackdropColor(0, 0, 0.5, 1);
		frame.Flagged = false;
	end
end
