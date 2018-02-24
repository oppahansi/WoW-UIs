if not ace:LoadTranslation("FuBar_CombatInfoFuLocals") then

FuBar_CombatInfoFuLocals = {
	NAME = "CombatInfoFu",
	DESCRIPTION = "Combat stats in a central location.",
	COMMANDS = {"/fubarcombatinfofu", "/fbci"},
	CMD_OPTIONS = {},

	BLOCK_ICON="Interface\\Icons\\Ability_Defend.blp",
	CRIT_ICON="Interface\\Icons\\Ability_CriticalStrike.blp",
	DODGE_ICON="Interface\\Icons\\Spell_Nature_Invisibilty.blp",
	PARRY_ICON="Interface\\Icons\\Ability_Parry.blp",
	AP_ICON="Interface\\Icons\\Ability_Warrior_BattleShout.blp",
	RAP_ICON="Interface\\Icons\\Ability_TrueShot.blp",
	ARMOR_ICON="Interface\\Icons\\Spell_Nature_EnchantArmor.blp",
	ARMORPERC_ICON="Interface\\Icons\\Spell_Nature_EnchantArmor.blp",
	BUTTON_ICON="Interface\\Icons\\Ability_Rogue_FeignDeath.blp",
	AVOID_ICON="Interface\\Icons\\Spell_Nature_Invisibilty.blp",
	
	AP2DPS=14,
	
	EVENTS={"UNIT_INVENTORY_CHANGED",
		"UNIT_AURA",
		"UNIT_AURASTATE",
		"CHAT_MSG_SKILL",},
	DONT_PROCESS_UNIT={"raid","party","target",},

	MENU_BLOCK="BLOCK",
	MENU_CRIT="CRIT",
	MENU_DODGE="DODGE",
	MENU_PARRY="PARRY",
	MENU_ARMORPERC="ARMORPERC",
	MENU_ARMOR="ARMOR",
	MENU_AP="AP",
	MENU_RAP="RAP",
	MENU_AVOID="AVOID",
	MENU_RCRIT="RCRIT",
	
	LOCALE={},
	COUNTRY=GetLocale()
}

FuBar_CombatInfoFuLocals.CMD_OPTIONS = {
}

end
