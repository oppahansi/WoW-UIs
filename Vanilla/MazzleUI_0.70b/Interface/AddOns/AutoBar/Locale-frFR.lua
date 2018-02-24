--
-- AutoBar
-- http://www.wowace.com/wiki/AutoBar
-- Courtesy of Cinedelle
--

local L = AceLibrary("AceLocale-2.2"):new("AutoBar")

L:RegisterTranslations("frFR", function() return {
	    ["AUTOBAR"] = "AutoBar",
	    ["CONFIG_WINDOW"] = "Fen\195\170tre de configuration",
	    ["SLASHCMD_LONG"] = "/autobar",
	    ["SLASHCMD_SHORT"] = "/atb",
	    ["BUTTON"] = "Bouton",
	    ["EDITSLOT"] = "Editer l'emplacement",
	    ["VIEWSLOT"] = "Voir l'emplacement",
		["LOAD_ERROR"] = "|cff00ff00Erreur de chargement d'AutobarConfig. Assurez-vous qu'il soit pr\195\169sent et activ\195\169.|r Error: ",

		--  AutoBarConfig.lua
		["EMPTY"] = "Vide"; --AUTOBAR_CONFIG_EMPTY
		["AUTOBAR_CONFIG_SMARTSELFCAST"] = "Smart Self Cast";
		["AUTOBAR_CONFIG_REMOVECAT"] = "Effacer la cat\195\169gorie actuelle";
		["AUTOBAR_CONFIG_ROW"] = "Lignes";
		["AUTOBAR_CONFIG_COLUMN"] = "Colonnes";
		["AUTOBAR_CONFIG_GAPPING"] = "Espacement des icones";
		["AUTOBAR_CONFIG_ALPHA"] = "Transparence dee icones";
		["AUTOBAR_CONFIG_BUTTONWIDTH"] = "Largeur du bouton";
		["AUTOBAR_CONFIG_BUTTONHEIGHT"] = "Hauteur du bouton";
		["AUTOBAR_CONFIG_DOCKSHIFTX"] = "D\195\169calage gauche/droite";
		["AUTOBAR_CONFIG_DOCKSHIFTY"] = "D\195\169calage haut/bas";
		["AUTOBAR_CONFIG_WIDTHHEIGHTUNLOCKED"] = "Hauteur et Largeur \ndes boutons non proportionn\195\169";
		["AUTOBAR_CONFIG_HIDEKEYBINDING"] = "Cacher les raccourcis";
		["AUTOBAR_CONFIG_HIDECOUNT"] = "Cacher la quantit\195\169";
		["AUTOBAR_CONFIG_SHOWEMPTY"] = "Afficher les boutons vide";
		["AUTOBAR_CONFIG_SHOWCATEGORYICON"] = "Afficher les icones de cat\195\169gorie";
		["AUTOBAR_CONFIG_HIDETOOLTIP"] = "Cacher les bulles d'aides";
		["AUTOBAR_CONFIG_POPUPDIRECTION"] = "Orientation du \nd\195\169ploiement \ndes boutons";
		["AUTOBAR_CONFIG_POPUPDISABLE"] = "D\195\169sactive le d\195\169ploiement";
		["AUTOBAR_CONFIG_POPUPONSHIFT"] = "D\195\169ploiement uniquement \navec la touche Shift(MAJ)";
		["AUTOBAR_CONFIG_HIDEDRAGHANDLE"] = "cacher la poign\195\169 de d\195\169placement";
		["AUTOBAR_CONFIG_CTRLSHOWSDRAGHANDLE"] = "Ctrl Key Shows Drag Handle";
		["AUTOBAR_CONFIG_LOCKACTIONBARS"] = "Lock Action Bars\nwhen locking AutoBar";
		["AUTOBAR_CONFIG_PLAINBUTTONS"] = "Sans bordure";
		["AUTOBAR_CONFIG_NOPOPUP"] = "Pas de d\195\169ploiement";
		["AUTOBAR_CONFIG_ARRANGEONUSE"] = "R\195\169organise l'ordre \nlors d'une utilisation";
		["AUTOBAR_CONFIG_RIGHTCLICKTARGETSPET"] = "Clique droit cible le familier";
		["AUTOBAR_CONFIG_DOCKTONONE"] = "Aucun";
		["AUTOBAR_CONFIG_DOCKTOGBARS"] = "Seconde barre de Gbars";
		["AUTOBAR_CONFIG_DOCKTOMAIN"] = "Menu principale";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAME"] = "Fen\195\170tre de chat";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"] = "Menu des fen\195\170tre de chat";
		["AUTOBAR_CONFIG_DOCKTOACTIONBAR"] = "Barre d'action";
		["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"] = "Menu des boutons";
		["AUTOBAR_CONFIG_ALIGN"] = "Alignement des \nboutons";
		["AUTOBAR_CONFIG_NOTFOUND"] = "(Objet : non trouv\195\169 ";
		["AUTOBAR_CONFIG_SLOTEDITTEXT"] = " Set (cliquer pour \195\169diter)";
		["AUTOBAR_CONFIG_CHARACTER"] = "Personnage :";
		["AUTOBAR_CONFIG_SHARED"] = "Partag\195\169";
		["AUTOBAR_CONFIG_CLASS"] = "Classe";
		["AUTOBAR_CONFIG_BASIC"] = "Base";
		["AUTOBAR_CONFIG_USECHARACTER"] = "Utiliser le set personnage";
		["AUTOBAR_CONFIG_USESHARED"] = "Utiliser le set partag\195\169e";
		["AUTOBAR_CONFIG_USECLASS"] = "Utiliser le set de classe";
		["AUTOBAR_CONFIG_USEBASIC"] = "Utiliser le set de base";
		["AUTOBAR_CONFIG_HIDECONFIGTOOLTIPS"] = "Cacher les bulles d'aide \nde configuration";
		["AUTOBAR_CONFIG_OSKIN"] = "Utiliser oSkin";
		["AUTOBAR_CONFIG_CHARACTERLAYOUT"] = "Organisation pour le personnage";
		["AUTOBAR_CONFIG_SHAREDLAYOUT"] = "Organisation partag\195\169e";
		["AUTOBAR_CONFIG_SHARED1"] = "Partage 1";
		["AUTOBAR_CONFIG_SHARED2"] = "Partage 2";
		["AUTOBAR_CONFIG_SHARED3"] = "Partage 3";
		["AUTOBAR_CONFIG_SHARED4"] = "Partage 4";
		["AUTOBAR_CONFIG_EDITCHARACTER"] = "Editer le set personnage";
		["AUTOBAR_CONFIG_EDITSHARED"] = "Editer le set partag\195\169e";
		["AUTOBAR_CONFIG_EDITCLASS"] = "Editer le set de classe";
		["AUTOBAR_CONFIG_EDITBASIC"] = "Editer le set de base";

		-- AutoBarItemList
		["FISHING_LURES"] = "Fishing Lures",
		["FISHING_GEAR"] = "Fishing Gear",
		["FISHING_POLES"] = "Fishing Poles",
    }
end);


if (GetLocale() == "frFR") then

AUTOBAR_CHAT_MESSAGE1 = "La configuration pour ce personnage vient d'une ancienne version. Effacer. Aucune tentative de mise \195\160 jour n'a \195\169t\195\169 tent\195\169.";
AUTOBAR_CHAT_MESSAGE2 = "Mise \195\160 jour du bouton multi-objet #%d objet #%d afin d'utiliser l'ID \195\160 la place du nom de l'objet.";
AUTOBAR_CHAT_MESSAGE3 = "Mise à jour du bouton mono-objet #%d objet #%d afin d'utiliser l'ID \195\160 la place du nom de l'objet.";

--  AutoBar_Config.xml
AUTOBAR_CONFIG_VIEWTEXT = "Pour éditer un bouton, sélectionner le dans la section \nd'édition, en bas de la feuille Emplacements.";
AUTOBAR_CONFIG_SLOTVIEWTEXT = "Vue des sets combin\195\169s (non \195\169ditable)";
AUTOBAR_CONFIG_RESET = "R\195\169initialiser";
AUTOBAR_CONFIG_REVERT = "Inverser";
AUTOBAR_CONFIG_DONE = "OK";
AUTOBAR_CONFIG_DETAIL_CATEGORIES = "(Shift+Clique explore la cat\195\169gorie)";
AUTOBAR_CONFIG_DRAGHANDLE = "Bouton gauche maintenu pour d\195\169placer Autobar\nClique gauche pour v\195\169rouiller/d\195\169v\195\169rouiller\nClique droit pour les options";
AUTOBAR_CONFIG_EMPTYSLOT = "RAZ";
AUTOBAR_CONFIG_CLEARSLOT = "Bouton vide";
AUTOBAR_CONFIG_SETSHARED = "Partager le profile:";
AUTOBAR_CONFIG_SETSHAREDTIP = "S\195\169lectionner le profile partag\195\169 \195\160 utiliser pour ce personnage.\nLes modifications apport\195\169es \195\160 un profile partag\195\169 touchent tous les personnage l'utilisant";

AUTOBAR_CONFIG_TAB_SLOTS = "Emplacements";
AUTOBAR_CONFIG_TAB_BAR = "Barre";
AUTOBAR_CONFIG_TAB_BUTTONS = "Boutons";
AUTOBAR_CONFIG_TAB_POPUP = "D\195\169ploiement";
AUTOBAR_CONFIG_TAB_PROFILE = "Profile";

AUTOBAR_TOOLTIP1 = " (Qauntit\195\169 : ";
AUTOBAR_TOOLTIP2 = " [Objet personnalis\195\169]";
AUTOBAR_TOOLTIP3 = " [En combat seulement]";
AUTOBAR_TOOLTIP4 = " [En champs de bataille seulement]";
AUTOBAR_TOOLTIP5 = " [Hors-combat seulement]";
AUTOBAR_TOOLTIP6 = " [Utilisation limit\195\169]";
AUTOBAR_TOOLTIP7 = " [Cooldown]";
AUTOBAR_TOOLTIP8 = "\n(Clique gauche pour application sur l'arme main droite\nClique droit pour application sur l'arme main gauche)";

AUTOBAR_CONFIG_DOCKTO = "Attacher \195\160 :";
AUTOBAR_CONFIG_USECHARACTERTIP = "Les objets de ce set de personnage sont spécifique à ce personnage.";
AUTOBAR_CONFIG_USESHAREDTIP = "Les objets d'un set partag\195\169 sont partag\195\169s par les personnages utilisant le m\195\170me set partag\195\169.\nLe set sp\195\169cifique peut \195\170tre d\195\169sign\195\169 dans l'onglet Profile.";
AUTOBAR_CONFIG_USECLASSTIP = "Les objets d'un set de classe sont partag\195\169s par les personnages de même classe utilisant le set de classe.";
AUTOBAR_CONFIG_USEBASICTIP = "Les objets du set de base sont partag\195\169s par les personnages utilisant le set de base.";
AUTOBAR_CONFIG_CHARACTERLAYOUTTIP = "Les modifications de l'organisation visuelle ne touchent que ce personnage.";
AUTOBAR_CONFIG_SHAREDLAYOUTTIP = "Les modifications de l'organisation visuelle touchent tous les personnage utilisant le même profile partag\195\169.";
AUTOBAR_CONFIG_TIPOVERRIDE = "Les boutons de ce set sont prioritaires sur les boutons des sets inf\195\169rieurs.\n";
AUTOBAR_CONFIG_TIPOVERRIDDEN = "Les boutons de ce set seront cacher par les sets supérieurs.\n";
AUTOBAR_CONFIG_TIPAFFECTSCHARACTER = "Les modifications ne touchent que ce personnage.";
AUTOBAR_CONFIG_TIPAFFECTSALL = "Les modifications touchent tous les personnages.";
AUTOBAR_CONFIG_SETUPSINGLE = "Configuration unique";
AUTOBAR_CONFIG_SETUPSHARED = "Configuration partag\195\169e";
AUTOBAR_CONFIG_SETUPSTANDARD = "Configuration standard";
AUTOBAR_CONFIG_SETUPBLANKSLATE = "Remise \195\160 blanc";
AUTOBAR_CONFIG_SETUPSINGLETIP = "Cliquer pour obtenir une configuration de personnage unique, similaire à Autobar classique.";
AUTOBAR_CONFIG_SETUPSHAREDTIP = "Cliquer pour obtenir une configuration partag\195\169.\nActive les sets partag\195\169s et sp\195\169cifiques \195\160 un personnage.";
AUTOBAR_CONFIG_SETUPSTANDARDTIP = "Active l'\195\169diton et l'utilisation de tous les sets.";
AUTOBAR_CONFIG_SETUPBLANKSLATETIP = "Efface l'ensemble des boutons des sets partag\195\169s et de personnages.";
AUTOBAR_CONFIG_RESETSINGLETIP = "Cliquer pour r\195\169initialiser la configuration de personnage unique.";
AUTOBAR_CONFIG_RESETSHAREDTIP = "Cliquer pour r\195\169initialiser la configuration partag\195\169.\nLe set de classe est copi\195\169 vers le set de personnage.\nLe set par d\195\169faut est copi\195\169 vers le set partag\195\169.";
AUTOBAR_CONFIG_RESETSTANDARDTIP = "Cliquer pour r\195\169initialiser la configuration standard.\nLes boutons de classe sont dans le set de classe.\nLes boutons par d\195\169faut sont dans le set de base.\nLes sets partag\195\169s et de personnages sont r\195\169initialis\195\169s.";

--  AutoBarConfig.lua
AUTOBAR_TOOLTIP9 = "Bouton multi cat\195\169gorie\n";
AUTOBAR_TOOLTIP10 = " (Objet personnalis\195\169 par ID)";
AUTOBAR_TOOLTIP11 = "\n(ID de l'objet inconnu)";
AUTOBAR_TOOLTIP12 = " (Objet personnalis\195\169 par nom)";
AUTOBAR_TOOLTIP13 = "Bouton de cat\195\169gorie unique\n\n";
AUTOBAR_TOOLTIP14 = "\nPas utilisable directement.";
AUTOBAR_TOOLTIP15 = "\nCible une arme\n(Clique gauche pour l'arme main droite\nClique droit pour l'arme main gauche)";
AUTOBAR_TOOLTIP16 = "\nCiblé.";
AUTOBAR_TOOLTIP17 = "\nHors-combat seulement.";
AUTOBAR_TOOLTIP18 = "\nCombat seulement.";
AUTOBAR_TOOLTIP19 = "\nLocalisation: ";
AUTOBAR_TOOLTIP20 = "\nUtilisation limit\195\169 : "
AUTOBAR_TOOLTIP21 = "Requi\195\168re une restauration de PV";
AUTOBAR_TOOLTIP22 = "Requi\195\168re une restauration de mana";
AUTOBAR_TOOLTIP23 = "Bouton pour objet unique\n\n";

--  AutoBarItemList.lua
AUTOBAR_ALTERACVALLEY = "Vall\195\169e d'Alterac";
AUTOBAR_WARSONGGULCH = "Goulet des Warsong";
AUTOBAR_ARATHIBASIN = "Bassin d'Arathi";
AUTOBAR_AHN_QIRAJ = "Ahn'Qiraj";
AUTOBAR_BWL = "Rep\195\168re de l'aile noire";

AUTOBAR_CLASS_CUSTOM = "Personnaliser";
AUTOBAR_CLASS_CLEAR = "Clear this Slot";
AUTOBAR_CLASS_BANDAGES = "Bandages";
AUTOBAR_CLASS_ALTERAC_BANDAGE = "Bandages d'Alterac";
AUTOBAR_CLASS_WARSONG_BANDAGE = "Bandages de Warsong";
AUTOBAR_CLASS_ARATHI_BANDAGE = "Bandages d'Arathi";
AUTOBAR_CLASS_UNGORORESTORE = "Cristal de restauration - Un'Goro";

AUTOBAR_CLASS_ANTIVENOM = "Anti-Venin";
AUTOBAR_CLASS_AGILITYPOTIONS = "Potions agilit\195\169";
AUTOBAR_CLASS_STRENGTHPOTIONS = "Potions de force";
AUTOBAR_CLASS_FORTITUDEPOTIONS = "Potions de robustesse";
AUTOBAR_CLASS_INTELLECTPOTIONS = "Potions d'intelligence";
AUTOBAR_CLASS_WISDOMPOTIONS = "Potions de sagesse";
AUTOBAR_CLASS_DEFENSEPOTIONS = "Potions de d\195\169fense";
AUTOBAR_CLASS_TROLLBLOODPOTIONS = "Potions de sang de troll";
AUTOBAR_CLASS_SCROLLOFAGILITY = "Parchemin d'agilit\195\169";
AUTOBAR_CLASS_SCROLLOFINTELLECT = "Parchemin d'intelligence";
AUTOBAR_CLASS_SCROLLOFPROTECTION = "Parchemin de protection";
AUTOBAR_CLASS_SCROLLOFSPIRIT = "Parchemin d'esprit";
AUTOBAR_CLASS_SCROLLOFSTAMINA = "Parchemin d'endurance";
AUTOBAR_CLASS_SCROLLOFSTRENGTH = "Parchemin de force";
AUTOBAR_CLASS_BUFF_ATTACKPOWER = "Buff de puissance d'attaque";
AUTOBAR_CLASS_BUFF_ATTACKSPEED = "Buff de vitesse d'attaque";
AUTOBAR_CLASS_BUFF_DODGE = "Buff d'esquive";
AUTOBAR_CLASS_BUFF_FROST = "Buff de r\195\169sistance au froid";
AUTOBAR_CLASS_BUFF_FIRE = "Buff de r\195\169sistance au feu";

AUTOBAR_CLASS_HEALPOTIONS = "Potions de soin";
AUTOBAR_CLASS_PVP6HEALPOTIONS = "Potions de soin - JcJ grade 6";
AUTOBAR_CLASS_HEALTHSTONE = "Pierre de soin";
AUTOBAR_CLASS_WHIPPER_ROOT = "Tubercule de navetille";
AUTOBAR_CLASS_BATTLEGROUNDHEALPOTIONS = "Potions de soin des champs de bataille";
AUTOBAR_CLASS_MANAPOTIONS = "Potions de mana";
AUTOBAR_CLASS_PVP6MANAPOTIONS = "Potions de mana - JcJ grade 6";
AUTOBAR_CLASS_MANASTONE = "Pierres de mana";
AUTOBAR_CLASS_BATTLEGROUNDMANAPOTIONS = "Potions de mana des champs de bataille";
AUTOBAR_CLASS_DREAMLESS_SLEEP = "Sommeil sans r\195\170ve";
AUTOBAR_CLASS_NIGHT_DRAGONS_BREATH = "Souffle de dragon nocturne";
AUTOBAR_CLASS_REJUVENATION_POTIONS = "Potions de r\195\169g\195\169n\195\169ration";

AUTOBAR_CLASS_BATTLESTANDARD = "Etendard de bataille";
AUTOBAR_CLASS_BATTLESTANDARDAV = "Etendard de bataille (VA)";
AUTOBAR_CLASS_DEMONIC_DARK_RUNES = "Runes d\195\169moniaques et t\195\169n\195\169breuses";
AUTOBAR_CLASS_ARCANE_PROTECTION = "Protection contre l'arcane";
AUTOBAR_CLASS_FIRE_PROTECTION = "Protection contre le feu";
AUTOBAR_CLASS_FROST_PROTECTION = "Protection contre le givre";
AUTOBAR_CLASS_NATURE_PROTECTION = "Protection contre la nature";
AUTOBAR_CLASS_SHADOW_PROTECTION = "Protection contre l'ombre";
AUTOBAR_CLASS_SPELL_PROTECTION = "Protection contre les sorts";
AUTOBAR_CLASS_HOLY_PROTECTION = "Protection contre le sacr\195\169";
AUTOBAR_CLASS_INVULNERABILITY_POTIONS = "Potions d'invuln\195\169rabilit\195\169";
AUTOBAR_CLASS_FREE_ACTION_POTION = "Potions de libre action";

AUTOBAR_CLASS_HEARTHSTONE = "Pierre de foyer";
AUTOBAR_CLASS_WATER = "Eau";
AUTOBAR_CLASS_WATER_PERCENT = "Eau : % mana gain";
AUTOBAR_CLASS_WATER_CONJURED = "Eau : Mage Conjured";
AUTOBAR_CLASS_WATER_SPIRIT = "Eau : Spirit Bonus";
AUTOBAR_CLASS_RAGEPOTIONS = "Potions de Rage";
AUTOBAR_CLASS_ENERGYPOTIONS = "Potions d'\195\169nergie";
AUTOBAR_CLASS_SWIFTNESSPOTIONS = "Swiftness Potions";
AUTOBAR_CLASS_SOULSHARDS = "Fragment d'\195\162mes";
AUTOBAR_CLASS_ARROWS = "Fl\195\168ches";
AUTOBAR_CLASS_BULLETS = "Balles";
AUTOBAR_CLASS_THROWNWEAPON = "Armes de jet";
AUTOBAR_CLASS_FOOD = "Nourriture : Aucun Bonus";
AUTOBAR_CLASS_FOOD_PERCENT = "Nourriture : gain de vie en %";
AUTOBAR_CLASS_FOOD_PET_BREAD = "Nourriture : Pain pour familier";
AUTOBAR_CLASS_FOOD_PET_CHEESE = "Nourriture : Fromage pour familier";
AUTOBAR_CLASS_FOOD_PET_FISH = "Nourriture : Poisson pour familier";
AUTOBAR_CLASS_FOOD_PET_FRUIT = "Nourriture : Fruit pour familier";
AUTOBAR_CLASS_FOOD_PET_FUNGUS = "Nourriture : Champignon pour familier";
AUTOBAR_CLASS_FOOD_PET_MEAT = "Nourriture : Viande pour familier";
AUTOBAR_CLASS_FOOD_COMBO= "Combo Nouriture et eau";
AUTOBAR_CLASS_FOOD_CONJURED = "Nourriture : Conjur\195\169 par les Mages";
AUTOBAR_CLASS_FOOD_STAMINA = "Nourriture : Bonus d'endurance";
AUTOBAR_CLASS_FOOD_AGILITY = "Nourriture : Bonus d'agilit\195\169";
AUTOBAR_CLASS_FOOD_MANAREGEN = "Nourriture : Bonus de r\195\169g\195\169n\195\169ration de mana";
AUTOBAR_CLASS_FOOD_HPREGEN = "Nourriture : Bonus de r\195\169g\195\169n\195\169ration de PV";
AUTOBAR_CLASS_FOOD_STRENGTH = "Nourriture : Bonus de force";
AUTOBAR_CLASS_FOOD_INTELLIGENCE = "Nourriture : Bonus d'intelligence";
AUTOBAR_CLASS_FOOD_ARATHI = "Nourriture : Bassin d'Arathi";
AUTOBAR_CLASS_FOOD_WARSONG = "Nourriture : Goulet des Warsong";
AUTOBAR_CLASS_SHARPENINGSTONES = "Pierres \195\160 aiguiser";
AUTOBAR_CLASS_WEIGHTSTONE = "Contre-poids";
AUTOBAR_CLASS_POISON_CRIPPLING = "Poison affaiblissant";
AUTOBAR_CLASS_POISON_DEADLY = "Poison mortel";
AUTOBAR_CLASS_POISON_INSTANT = "Poison instantan\195\169";
AUTOBAR_CLASS_POISON_MINDNUMBING = "Poison de distraction mentale";
AUTOBAR_CLASS_POISON_WOUND = "Poison douloureux";
AUTOBAR_CLASS_EXPLOSIVES = "Explosifs d'ing\195\169ni\195\169rie";
AUTOBAR_CLASS_MOUNTS = "Monture";
AUTOBAR_CLASS_MOUNTS_QIRAJI = "Monture : Qiraji";
AUTOBAR_CLASS_MANA_OIL = "Huile d'enchantement : R\195\169g\195\169n\195\169ration de mana";
AUTOBAR_CLASS_WIZARD_OIL = "Huile d'enchantement : Damage/Healing Bonus";

end