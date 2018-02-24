function Cooldowns_DefineSpells(class)
	local cooldowns
	local globalcooldowns = {
		["Will of the Forsaken"] = 1,
		["Talisman of Ephemeral Power"] = 1,
		["Zandalarian Hero Charm"] = 1,	
		["Talisman of Ascendance"] = 1,
		["Cannibalize"] = 1,
		["Berserking"] = 1,
		["War Stomp"] = 1,
		["Fetish of the Sand Reaver"] = 1,
	}
	local globallocaledata = {
		["Interface\\Icons\\INV_Misc_StoneTablet_11"] = {
			["name"] = "Talisman of Ephemeral Power",
			["duration"] = 90,
		},
		["Interface\\Icons\\INV_Jewelry_Necklace_13"] = {
			["name"] = "Zandalarian Hero Charm",
			["duration"] = 120,
		},
		["Interface\\Icons\\Spell_Shadow_RaiseDead"] = {
			["name"] = "Will of the Forsaken",
			["duration"] = 120,
		},
		["Interface\\Icons\\INV_Misc_Gem_Pearl_04"] = {
			["name"] = "Talisman of Ascendance",
			["duration"] = 60,
		},
		["Interface\\Icons\\Ability_Racial_Cannibalize"] = {
			["name"] = "Cannibalize",
			["duration"] = 120,
		},
		["Interface\\Icons\\Racial_Troll_Berserk"] = {
			["name"] = "Berserking",
			["duration"] = 10,
		},
		["Interface\\Icons\\Ability_WarStomp"] = {
			["name"] = "War Stomp",
			["duration"] = 120,
		},
		["Interface\\Icons\\INV_Misc_AhnQirajTrinket_03"] = {
			["name"] = "Fetish of the Sand Reaver",
			["duration"] = 180,
		},
	}
	if class == "WARLOCK" then
		cooldowns = {
			["Soulstone"] = 1,
			["Healthstone"] = 1, --not global because, unlike all other classes, the warlock can *do* something about the fact that it is no longer on CD
			["Spell Lock"] = 1,
			["Fel Domination"] = 1,
			["Death Coil"] = 1,
			["Shadowburn"] = 1,
			["Soul Fire"] = 1,
			["Conflagrate"] = 1,
			["Curse of Doom"] = 1,
		}
		localedata = {
			["Interface\\Icons\\INV_Misc_Orb_04"] = {
				["name"] = "Soulstone",
				["duration"] = 1800,
			},
			["Interface\\Icons\\Spell_Shadow_MindRot"] = {
				["name"] = "Spell Lock",
				["duration"] = 30,
			},
			["Interface\\Icons\\Spell_Nature_RemoveCurse"] = {
				["name"] = "Fel Domination",
				["duration"] = 900,
			},
			["Interface\\Icons\\INV_Stone_04"] = {
				["name"] = "Healthstone",
				["duration"] = 120,
			},
			["Interface\\Icons\\Spell_Shadow_DeathCoil"] = {
				["name"] = "Death Coil",
				["duration"] = 120,
			},
			["Interface\\Icons\\Spell_Shadow_ScourgeBuild"] = {
				["name"] = "Shadowburn",
				["duration"] = 15,
			},
			["Interface\\Icons\\Spell_Fire_Fireball02"] = {
				["name"] = "Soul Fire",
				["duration"] = 60,
			},
			["Interface\\Icons\\Spell_Shadow_AuraOfDarkness"] = {
				["name"] = "Curse of Doom",
				["duration"] = 60,
			},
			["Interface\\Icons\\Spell_Fire_Fireball"] = {
				["name"] = "Conflagrate",
				["duration"] = 10,
			},
		}
	elseif class == "DRUID" then
		cooldowns = {
			
		}
		localedata = {

		}
	elseif class == "PRIEST" then
		cooldowns = {
			
		}
		localedata = {

		}
	elseif class == "HUNTER" then
		cooldowns = {
			["Tranquilizing Shot"] = 1,
		}
		localedata = {
			["Interface\\Icons\\Spell_Nature_Drowsy"] = {
				["name"] = "Tranquilizing Shot",
				["duration"] = 20,
			},
		}
	elseif class == "MAGE" then
		cooldowns = {

		}
		localedata = {

		}
	elseif class == "WARRIOR" then
		cooldowns = {

		}
		localedata = {

		}	
	elseif class == "ROGUE" then
		cooldowns = {

		}
		localedata = {

		}	
	elseif class == "SHAMAN" then
		cooldowns = {

		}
		localedata = {

		}	
	elseif class == "PALADIN" then
		cooldowns = {

		}
		localedata = {

		}	
	end
	for index,value in pairs(globalcooldowns) do 
		cooldowns[index] = value
		globalcooldowns[index] = nil
	end
	for index,value in pairs(globallocaledata) do
		localedata[index] = value
		globallocaledata[index] = nil
	end
	return cooldowns,localedata
end

Cooldowns_CreateTimerGroup(
	"cooldown",{
		begin = {
			r = .2,
			g = 1.0,
			b = .2,
		},
		half = {
			r = 1.0,
			g = 1.0,
			b = .2,
		},
		final = {
			r = 1.0,
			g = .2,
			b = .2,
		},
	}
)
DoTimer_CreateTimerGroup(
	"cooldown",true,true,true,1,1,{
		begin = {
			r = .2,
			g = 1.0,
			b = .2,
		},
		half = {
			r = 1.0,
			g = 1.0,
			b = .2,
		},
		final = {
			r = 1.0,
			g = .2,
			b = .2,
		},
	}
)