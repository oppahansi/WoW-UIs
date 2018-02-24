-- -------------------------------------------- --
-- La Vendetta Boss Mods - french localization  --
-- -------------------------------------------- --

if (GetLocale() == "frFR") then	
	--classes
	DBM_MAGE = "Mage";
	DBM_PRIEST = "Pr\195\170tre";
	DBM_PALADIN = "Paladin";
	DBM_DRUID = "Druide";
	DBM_WARLOCK = "D\195\169moniste";
	DBM_ROGUE = "Voleur";
	DBM_HUNTER = "Chasseur";
	DBM_WARRIOR = "Guerrier";
	DBM_SHAMAN = "Chaman";
	
	--zone
	DBM_NAXX	= "Naxxramas";
	DBM_AQ40	= "Ahn'Qiraj";
	DBM_BWL	= "Repaire de l'Aile noire";
	DBM_MC		= "C\197\147ur du Magma";
	DBM_AQ20	= "Ruines d'Ahn'Qiraj";
	DBM_ZG 	= "Zul'Gurub";
	DBM_ONYXIAS_LAIR	= "Repaire d'Onyxia";
	DBM_DUSKWOOD		= "Bois de la p\195\169nombre";
	DBM_ASHENVALE		= "Ashenvale";
	DBM_FERALAS		= "Feralas";
	DBM_HINTERLANDS	= "Les Hinterlands";
	DBM_BLASTED_LANDS	= "Terres foudroy\195\169es";
	DBM_ARATHI			= "Bassin d'Arathi";
	DBM_WARSONG		= "Goulet des Chanteguerres";
	DBM_ALTERAC		= "Vallée d'Alterac";
	DBM_AZSHARA		= "Azshara";
	DBM_GRUULS_LAIR		= "Gruul's Lair";
	DBM_MAGS_LAIR		= "Magtheridon's Lair";
	
	--spells/buffs
	DBM_CHARGE = "Charge";
	DBM_FERALCHARGE = "Charge farouche";
	DBM_BLOODRAGE = "Rage sanguinaire";
	DBM_REDEMPTION = "Esprit de r\195\169demption";
	DBM_FEIGNDEATH	= "Feindre la mort";
	DBM_MINDCONTROL	= "Contr\195\180le mental";
	
	--create status bar timer localization table
DBM_SBT = {};

--key bindings
BINDING_HEADER_DBM 		= "La Vendetta Boss Mods";
BINDING_NAME_DBMTOGGLE 		= "Toggle GUI";

--OnLoad messages
DBM_LOADED			= "La Vendetta Boss Mods v%s par DeadlyMinds|Tandanu @ EU-Aegwynn et La Vendetta|Nitram @ EU-Azshara charg\195\169.";
DBM_MODS_LOADED		= "%s %s boss mods charg\195\169."

--Slash command messages
DBM_MOD_ENABLED		= "Boss mod activ\195\169.";
DBM_MOD_DISABLED		= "Boss mod d\195\169sactiv\195\169.";
DBM_ANNOUNCE_ENABLED		= "Annonce activ\195\169e.";
DBM_ANNOUNCE_DISABLED		= "Annonce d\195\169sactiv\195\169e.";
DBM_MOD_STOPPED		= "Tous les timers ont \195\169t\195\169 stopp\195\169s.";
DBM_MOD_INFO			= "Boss mod v%s par %s";
DBM_SLASH_HELP1		= " on/off";
DBM_SLASH_HELP2		= " Annonce on/off";
DBM_SLASH_HELP3		= " Stop";
DBM_SLASH_HELP4		= "Vous pouvez utiliser %s \195\170 la place de /%s.";
DBM_RANGE_CHECK		= "Joueurs \195\160 plus de 30m: ";
DBM_FOUND_CLIENTS		= "%s joueurs utilisant Vendetta Boss Mods trouv\195\169s";

--Sync options
DBM_SOMEONE_SET_SYNC_CHANNEL	= "%s a chang\195\169 le sync channel en: %s";
DBM_SET_SYNC_CHANNEL		= "Sync channel chang\195\169 en: %s";
DBM_CHANNEL_NOT_SET		= "Aucun channel, impossible de cr\195\169er un broadcast.";
DBM_NEED_LEADER		= "Vous devez \195\170tre promu ou chef du raid pour broadcast le channel!";
DBM_NEED_LEADER_STOP_ALL	= "Vous devez \195\170tre promu ou chef du raid pour utiliser cette fonction!";
DBM_ALL_STOPPED		= "Tous les timers ont \195\169t\195\169 stopp\195\169s.";
DBM_REC_STOP_ALL		= "Commande d'arr\195\170t g\195\169n\195\169ral re\195\135ue de %s.";

--Update dialog
DBM_UPDATE_DIALOG		= "Votre version de <La Vendetta Boss Mods> est p\195\169rim\195\169e!\n%s et %s ont la version %s.\nMerci de visiter www.deadlybossmods.com afin d'obtenir la derni\195\168re version.";
DBM_REQ_PATCHNOTES		= "Requ\195\170te des notes de mise-\195\170-jour en cours %s...Chargement, attendez s'il vous plaît.";
DBM_SHOW_PATCHNOTES		= "Afficher les notes de mise-\195\170-jour";
DBM_PATCHNOTES			= "Notes de mise-\195\170-jour";
DBM_COPY_PASTE_URL		= "Copier & coller l'URL";
DBM_COPY_PASTE_NOW		= "Appuyez sur CTRL-C afin de copier l'URL dans le presse-papier";

--Status Bar Timers
DBM_SBT_TIMELEFT				= "Temps restant:";
DBM_SBT_TIMEELAPSED			= "Temps \195\169coul\195\169:";
DBM_SBT_TOTALTIME				= "Temps total:";
DBM_SBT_REPETITIONS			= "R\195\169p\195\169titions:";
DBM_SBT_INFINITE				= "infinie";
DBM_SBT_BOSSMOD				= "Boss mod:";
DBM_SBT_STARTEDBY				= "D\195\169marr\195\169 par:";
DBM_SBT_RIGHTCLICK				= "Click droit sur la barre pour la masquer.";
DBM_SBT_LEFTCLICK				= "Shift + Click gauche sur la barre pour l'annoncer";
DBM_TIMER_IS_ABOUT_TO_EXPIRE	= "<ATTENTION !> Le timer de \"%s\" va bientôt terminer!";
DBM_BAR_STYLE_DEFAULT			= "Default";
DBM_BAR_STYLE_MODERN			= "Modern";
DBM_BAR_STYLE_CLOUDS			= "Clouds";
DBM_BAR_STYLE_PERL				= "Perl";


--Combat messages
DBM_BOSS_ENGAGED			= "%s engag\195\169. Bonne chance et HF! :)";
DBM_BOSS_SYNCED_BY			= "(Commande de synchro reçue de %s)";
DBM_BOSS_DOWN				= "%s down apr\195\168s %s!";
DBM_COMBAT_ENDED			= "Combat termin\195\169 apr\195\168s %s.";
DBM_DEFAULT_BUSY_MSG		= "%P est occup\195\169. (En combat contre %B - %HP - %ALIVE/%RAID personnes en vie) Vous serrez inform\195\169 apr\195\168s le combat!";
DBM_RAID_STATUS_WHISPER	= "%B - %HP - %ALIVE/%RAID personnes en vie.";
DBM_SEND_STATUS_INFO		= "Whispez \"status\" pour recevoir le status du raid.";
DBM_AUTO_RESPOND_SHORT		= "R\195\169ponse automatique envoy\195\169e.";
DBM_AUTO_RESPOND_LONG		= "R\195\169ponse automatique envoy\195\169e \195\170 %s";
DBM_MISSED_WHISPERS		= "Whisps manqu\195\169s durant le combat:";
DBM_SHOW_MISSED_WHISPER	= "|Hplayer:%1\$s|h[%1\$s]|h: %2\$s";
DBM_BALCONY_PHASE			= "<ATTENTION !>Passage en phase #%s";

--Misc stuff
DBM_YOU					= "Vous";
DBM_ARE 				= "subissez";
DBM_IS						= "est";
DBM_OR						= "ou";
DBM_AND					= "et";
DBM_UNKNOWN			 		= "inconnu";
DBM_LOCAL					= "local";
DBM_DEFAULT_DESCRIPTION			= "Description non disponible.";
DBM_SEC					= "sec";
DBM_MIN					= "min";
DBM_SECOND					= "second";
DBM_SECONDS					= "seconds";
DBM_MINUTES					= "minutes";
DBM_MINUTE					= "minute";
DBM_HIT					= "coup";
DBM_HITS					= "coups";
DBM_CRIT					= "crit";
DBM_CRITS					= "crits";
DBM_MISS					= "manqu\195\169";
DBM_DODGE					= "esquiv\195\169";
DBM_PARRY					= "parr\195\169";
DBM_FROST					= "Givre";
DBM_ARCANE					= "Arcane";
DBM_FIRE					= "Feu";
DBM_HOLY					= "Sacr\195\169";
DBM_NATURE					= "Nature";
DBM_SHADOW					= "Ombre";
DBM_CLOSE					= "Fermer";
DBM_AGGRO_FROM					= "Prise d'aggro de ";
DBM_SET_ICON					= "Mettre icone";
DBM_SEND_WHISPER				= "Whisper";
DBM_DEAD					= "Mort";
DBM_OFFLINE					= "Hors-ligne";
DBM_PHASE					= "Phase %s";
DBM_WAVE					= "Vague %s";


--12.1.06
-- Translations added v1.05
DBMGUI_DISTANCE_FRAME_TITLE		= "Distance";
DBMGUI_DISTANCE_FRAME_TEXT		= "Trop proches:";

DBMGUI_INFOFRAME_TOOLTIP_TITLE		= "Info Frame";
DBMGUI_INFOFRAME_TOOLTIP_TEXT		= "Click droit pour d\195\169placer / Shift + CLick droit pour cacher";

DBMGUI_STATUSBAR_WIDTH_SLIDER		= "Largeur Barre";
DBMGUI_STATUSBAR_SCALE_SLIDER		= "Scale Barre";

DBMGUI_BUTTON_RANGECHECK		= "Port\195\169e";
DBMGUI_TOOLTIP_RANGECHECK_TITLE	= "V\195\169rification de port\195\169e";
DBMGUI_TOOLTIP_RANGECHECK_TEXT		= "V\195\169rification de port\195\169e montrant tous les joueurs hors de port\195\169e de vous (\195\170 plus de 30 m\195\168tres).";

DBMGUI_BUTTON_DISTANCEFRAME		= "Distance";
DBMGUI_TOOLTIP_DISTANCEFRAME_TITLE	= "Distance";
DBMGUI_TOOLTIP_DISTANCEFRAME_TEXT	= "Active ou D\195\169sactive la V\195\169rification de DIstance, qui permet de savoir quels joueurs sont trop proches de vous (Moins de 10m). Cette otpion est tr\195\168s utile pour les encounters de C'thun ou de Huhuran.";

DBM_AZUREGOS_NAME			= "Azuregos";
DBM_OUTDOOR_YSONDRE		= "Ysondre";
DBM_OUTDOOR_EMERISS		= "Emeriss";
DBM_OUTDOOR_TAERAR		= "Taerar";
DBM_OUTDOOR_LETHON		= "Lethon";

--18.3.07
DBM_HEAVY_NW_BANDAGE	= "Bandage épais en tisse-néant";
end
