--[[
	BookOfCrafts Localization File

	Add-On developped by Ben a.k.a Blackdove (KirinTor Europe server), from Pandaren Empire Guild
--]]

	--[[
	é: \195\169
	ê: \195\170
	à: \195\160
	î: \195\174
	è: \195\168
	ë: \195\171
	ô: \195\180
	û: \195\187
	â: \195\162
	ç: \185\167
	ù: \195\185
	ä = \195\164
	Ä = \195\132
	ü = \195\188
	Ü = \195\156
	ö = \195\182
	Ö = \195\150
	ß = \195\159 
	pour une apostrophe : \226\128\153

	]]--



-- Addon version and data version
BC_VERSION                  = "1.12f"
BC_VERSION_DATA             = 1

-- Generic texts
BC_ADDON_ICON               = "Interface\\Icons\\INV_Misc_Book_02"
BC_ADDON_NAME               = "BookOfCrafts"
BC_DELETECHAR               = "Delete Info"
BC_CONFIRMDELETE            = "Confirm"


--BC_ERR_LEARN_RECIPE = string.gsub( ERR_LEARN_RECIPE_S, "(.+) : .+", "%1" )
BC_ERR_LEARN_RECIPE = string.gsub( ERR_LEARN_RECIPE_S, "%%s", "%(.+%)" )

--BC_ERR_SKILL_UP = string.gsub( ERR_SKILL_UP_SI, "(.+)%%s(.+)%%d(.*)", "%1%(.+%)%2%(%%d+%)%3" )
BC_ERR_SKILL_UP = string.gsub( ERR_SKILL_UP_SI, "%%s", "(.+)" )
BC_ERR_SKILL_UP = string.gsub( BC_ERR_SKILL_UP, "%%d", "(%%d+)" )

if( GetLocale()=="frFR" ) then

	--[[ French translation ]]--

	BC_ADDON_DESC                = "Aide \195\160 la gestion des comp\195\169tences d'artisanats de tous vos personnages."
	BC_ADDON_SHORT_DESC          = "Livre d'artisanats"

	BC_SKILL_MANUAL              = "Manuel : "
	BC_SKILL_FORMULA             = "Formule : "
	BC_SKILL_PATTERN             = "Patron : "
	BC_SKILL_PLANS               = "Plans : "
	BC_SKILL_RECIPE              = "Recette : "
	BC_SKILL_SCHEMATIC           = "Sch\195\169ma : "

	BC_SKILL_SPECIALS            = "| travail du cuir tribal | travail du cuir d'\195\169cailles de dragon | travail du cuir \195\169l\195\169mentaire | fabricant d'armes | fabriquant d'armures | ma\195\174tre fabriquant de haches | ma\195\174tre fabriquant d'\195\169p\195\169es | ma\195\174tre fabriquant de marteaux | ing\195\169nieur gnome | ing\195\169nieur gobelin |"

	BC_SKILL_REQUISITE           = "(.+) %((%d+)%) requis"
	BC_SKILL_REQUIRE_SPECIAL     = "Requiert"

	BC_SKILL_KNOWN               = "A d\195\169j\195\160 appris: "
	BC_SKILL_MAYLEARN            = "Peut apprendre : "
	BC_SKILL_WILLLEARN           = "Rang insuffisant : "
	BC_SKILL_INBANK              = "A la banque : "
	BC_SKILL_UNKNOWN_UNLEARNABLE = "Recette inutile"

	BC_CONFIG_INFO               = "Info"
	BC_CONFIG_TITLE              = "Livre d'artisanats"
	BC_CONFIG_TOOLTIPS           = "Tooltips"

	BC_TAB_OPTIONS               = "Options"
	BC_TAB_DATA                  = "Data"

	BC_MSG_USAGE                 = BC_ADDON_NAME.."usage:\n   /boc config - Ouvre l'\195\169cran de configuration:\n   /boc delete NOM - Efface les donn\195\169es du personnage NOM"
	BC_MSG_INITIALIZED           = BC_ADDON_NAME.." v"..BC_VERSION.." charg\195\169 (/boc pour les options)."

	-- WoW Key Bindings menu

	BINDING_HEADER_BCHEADER      = BC_ADDON_NAME.." v"..BC_VERSION
	BINDING_NAME_BCCONFIGDIALOG  = "Ouvre la fen\195\170tre de configuration"

	-- Check button labels

	BCUI_DropDownCharacters_Help                    = "Selectionner le personnage dont vous voudriez effacer les donn\195\169es"
	BCUI_CheckButton_SameFaction_Label              = "Afficher seulement les personnages de la m\195\170me faction"
	BCUI_CheckButton_SameFaction_Help               = "La recherche de personnages, pouvant apprendre ou \nconnaissant d\195\169j\195\160 une recette, est limit\195\169e \195\160 la m\195\170me \nfaction"
	BCUI_CheckButton_ShowSkillRank_Label            = "Montrer le niveau de comp\195\169tence"
	BCUI_CheckButton_ShowSkillRank_Help             = "Si l'option est activ\195\169e, le rang du personnagesera \nmontr\195\169 s'il peut apprendre la comp\195\169tence\n(le rang n'est pas montr\195\169 si d\195\169j\195\160 connu)"
	BCUI_Color_Tooltips_Label                       = "Couleur de fond"
	BCUI_Color_Tooltips_ColorSwatch_Help            = "D\195\169finit la couleur de fond du tooltip"
	BCUI_Color_TooltipsKnownBy_Label                = "Recette connue"
	BCUI_Color_TooltipsKnownBy_ColorSwatch_Help     = "D\195\169finit la couleur du texte pour les noms de ceux qui connaissent d\195\169j\195\160 la recette"
	BCUI_Color_TooltipsMayLearn_Label               = "Recette \195\160 apprendre"
	BCUI_Color_TooltipsMayLearn_ColorSwatch_Help    = "D\195\169finit la couleur du texte pour les noms de \nceux qui peuvent apprendre la recette"
	BCUI_Color_TooltipsRankTooHigh_Label            = "Recette Inaccessible"
	BCUI_Color_TooltipsRankTooHigh_ColorSwatch_Help = "D\195\169finit la couleur du texte pour les noms de \nceux pour qui la recette est encore inaccessible"
	BCUI_CheckButton_ShowChatMsg_Label              = "Verbose"
	BCUI_CheckButton_ShowChatMsg_Help               = "Affichage de messages informatifs dans la fen\195\170tre \nde t'chat"
	BCUI_CheckButton_ShowCurPlayer_Label            = "Lister aussi ce personnage"
	BCUI_CheckButton_ShowCurPlayer_Help             = "Affichage du nom du personnage courant dans les listes \ns'il peut apprendre une recette"
	BCUI_CheckButton_UseSideTooltip_Label           = "Utiliser tooltip ind\195\169pendant"
	BCUI_CheckButton_UseSideTooltip_Help            = "Les r\195\169sultats sont affich\195\169s dans un tooltip ind\195\169pendant \n au lieu de s'afficher dans le descriptif de la recette"

elseif( GetLocale()=="deDE" ) then

	--[[ German translation ]]--

	BC_ERR_LEARN_RECIPE          = string.gsub( ERR_LEARN_RECIPE_S, "%%s", "%(.+%)" )
	BC_ERR_SKILL_UP              = string.gsub( ERR_SKILL_UP_SI, "%%1%$s", "(.+)" )
	BC_ERR_SKILL_UP              = string.gsub( BC_ERR_SKILL_UP, "%%2%$d", "(%%d+)" )

	BC_ADDON_DESC                = "Unterst\195\188tzt Sie bei der Verwaltung der Fertigkeiten aller Charaktere."
	BC_ADDON_SHORT_DESC          = "Buch der Fertigkeiten"


	BC_SKILL_MANUAL              = "Handbuch: "
	BC_SKILL_FORMULA             = "Formel: "
	BC_SKILL_PATTERN             = "Muster: "
	BC_SKILL_PLANS               = "Pl\195\164ne: "
	BC_SKILL_RECIPE              = "Rezept: "
	BC_SKILL_SCHEMATIC           = "Bauplan: "

	BC_SKILL_SPECIALS            = "| R\195\188stungsschmied | Waffenschmied | Schwertschmiedemeister | Axtschmiedemeister | Hammerschmiedemeister | Goblin-Ingenieur | Gnomen-Ingenieur | Stammeslederverarbeitung | Elementarlederverarbeitung | Drachenschuppenlederverarbeitung |"

	BC_SKILL_REQUISITE           = "Ben\195\182tigt (.+) %((%d+)%)"
	BC_SKILL_REQUIRE_SPECIAL     = "Ben\195\182tigt"

	BC_SKILL_KNOWN               = "Bereits bekannt: "
	BC_SKILL_MAYLEARN            = "Gleich erlernbar: "
	BC_SKILL_WILLLEARN           = "Sp\195\164ter erlernbar: "
	BC_SKILL_INBANK              = "In bank: "
	BC_SKILL_UNKNOWN_UNLEARNABLE = "Nicht erlernbar / Fertigkeit noch nicht erlernt"

	BC_CONFIG_INFO               = "Information"
	BC_CONFIG_TITLE              = "Buch der Fertigkeiten"
	BC_CONFIG_TOOLTIPS           = "Tooltips"

	BC_TAB_OPTIONS               = "Einstellungen"
	BC_TAB_DATA                  = "Daten"

	BC_MSG_USAGE                 = BC_ADDON_NAME.." Aufruf:\n   /boc config - \195\150ffnet das Konfigurationsfenster von BoC\n   /boc delete NAME - L\195\182scht die gesammelten Daten des Charakters: NAME";
	BC_MSG_INITIALIZED           = BC_ADDON_NAME.." v"..BC_VERSION.." wurde geladen (/boc um das Konfigurationsfenster zu \195\182ffnen)."

	-- WoW Key Bindings menu

	BINDING_HEADER_BCHEADER      = BC_ADDON_NAME.." v"..BC_VERSION
	BINDING_NAME_BCCONFIGDIALOG  = "Konfigurationsfenster \195\182ffnen"

	-- Check button labels

	BCUI_DropDownCharacters_Help                    = "W\195\164hlen Sie die Charakter Daten aus, die sie l\195\182schen m\195\182chten"
	BCUI_CheckButton_SameFaction_Label              = "Nur Charakter der eigenen Fraktion\nanzeigen"
	BCUI_CheckButton_SameFaction_Help               = "Die Suche nach alternativen Charaktern, die eine\nFertigkeit kennen oder erlernen k\195\182nnen, ist auf\ndie eigene Fraktion beschr\195\164nkt."
	BCUI_CheckButton_ShowSkillRank_Label            = "Fertigkeitsr\195\164nge anzeigen"
	BCUI_CheckButton_ShowSkillRank_Help             = "Den Rang wann eine Fertigkeit erlernt werden kann\nneben dem Namen anzeigen (nicht f\195\188r Fertigkeiten\ndie bereits bekannt sind)."
	BCUI_Color_Tooltips_Label                       = "Tooltip Farbe"
	BCUI_Color_Tooltips_ColorSwatch_Help            = "Farbe f\195\188r den Tooltip-Text ausw\195\164hlen."
	BCUI_CheckButton_ShowChatMsg_Label              = "Chat Nachrichten detailierter\nanzeigen"
	BCUI_CheckButton_ShowChatMsg_Help               = "Informative Nachrichten als Chat\nNachrichten anzeigen"
	BCUI_CheckButton_ShowCurPlayer_Label            = "Auch diesen Charakter bei der\nAuswertung miteinbeziehen"
	BCUI_CheckButton_ShowCurPlayer_Help             = "Auch diesen Charakter zum Tooltip\nhinzuf\195\188gen"
	BCUI_Color_TooltipsKnownBy_Label                = "Bereits bekannt"
	BCUI_Color_TooltipsKnownBy_ColorSwatch_Help     = "Definiert die Farbe mit der die Charaktere der \nEinstufung \"Bereits bekannt\" angezeigt werden"
	BCUI_Color_TooltipsMayLearn_Label               = "Gleich erlernbar"
	BCUI_Color_TooltipsMayLearn_ColorSwatch_Help    = "Definiert die Farbe mit der die Charaktere der \nEinstufung \"Gleich erlernbar\" angezeigt werden"
	BCUI_Color_TooltipsRankTooHigh_Label            = "Sp\195\164ter erlernbar"
	BCUI_Color_TooltipsRankTooHigh_ColorSwatch_Help = "Definiert die Farbe mit der die Charaktere der \nEinstufung \"Sp\195\164ter erlernbar\" angezeigt werden"
	BCUI_CheckButton_UseSideTooltip_Label           = "Seitlichen Tooltip benutzen"
	BCUI_CheckButton_UseSideTooltip_Help            = "Ergebnisse werden in einem seperaten seitlichen \nTooltip angezeigt"

else
	--[[ Generic translation ]]--

	BC_ADDON_DESC                = "Helps managing trade skills for all your characters."
	BC_ADDON_SHORT_DESC          = "Book of crafts"

	BC_SKILL_MANUAL              = "Manual: "
	BC_SKILL_FORMULA             = "Formula: "
	BC_SKILL_PATTERN             = "Pattern: "
	BC_SKILL_PLANS               = "Plans: "
	BC_SKILL_RECIPE              = "Recipe: "
	BC_SKILL_SCHEMATIC           = "Schematic: "

	BC_SKILL_SPECIALS            = "| tribal leatherworking | dragonscale leatherworking | elemental leatherworking | weaponsmith | armorsmith | master axesmith | master swordsmith | master hammersmith | gnomish engineer | goblin engineer |"

	BC_SKILL_REQUISITE           = "Requires (.+) %((%d+)%)"
	BC_SKILL_REQUIRE_SPECIAL     = "Requires"

	BC_SKILL_KNOWN               = "Already known : "
	BC_SKILL_MAYLEARN            = "May learn : "
	BC_SKILL_WILLLEARN           = "Rank too high : "
	BC_SKILL_INBANK              = "In bank: "
	BC_SKILL_UNKNOWN_UNLEARNABLE = "Unuseful recipe"

	--BC_SKILL_NOTKNOWN             = "Known by no other character"
	--BC_SKILL_MAYBELEARNTBY        = "May learn : "
	--BC_SKILL_MAYBENOTBELEARNT     = "May not be learnt by an other character"

	BC_CONFIG_INFO               = "Info"
	BC_CONFIG_TITLE              = "Book of Crafts"
	BC_CONFIG_TOOLTIPS           = "Tooltips"

	BC_TAB_OPTIONS               = "Options"
	BC_TAB_DATA                  = "Donn\195\169es"

	BC_MSG_USAGE                 = BC_ADDON_NAME.."usage:\n   /boc config - Opens configuration screen\n   /boc delete NAME - Delete character NAME data"
	BC_MSG_INITIALIZED           = BC_ADDON_NAME.." v"..BC_VERSION.." is loaded (/boc)"

	-- WoW Key Bindings menu

	BINDING_HEADER_BCHEADER     = BC_ADDON_NAME.." v"..BC_VERSION
	BINDING_NAME_BCCONFIGDIALOG = "Open Configuration dialog"


	-- Check button labels
	BCUI_DropDownCharacters_Help                    = "Select character data to delete"
	BCUI_CheckButton_SameFaction_Label              = "Only display characters \nfrom same faction"
	BCUI_CheckButton_SameFaction_Help               = "Search for alternative characters, who know or who\nmay learn a selected recipe, is limited to same\nfaction"
	BCUI_CheckButton_ShowSkillRank_Label            = "Show skill rank"
	BCUI_CheckButton_ShowSkillRank_Help             = "If option is checked, a character skill rank will \nbe shown next to his name if he may learn skill\n(not for Already known lists)"
	BCUI_Color_Tooltips_Label                       = "Tooltip color"
	BCUI_Color_Tooltips_ColorSwatch_Help            = "Define color for tooltip text"
	BCUI_CheckButton_ShowChatMsg_Label              = "Verbose"
	BCUI_CheckButton_ShowChatMsg_Help               = "Show misc. information as chat messages"
	BCUI_CheckButton_ShowCurPlayer_Label            = "Display current character \nin results"
	BCUI_CheckButton_ShowCurPlayer_Help             = "Add also this player name to tooltip lists"
	BCUI_Color_TooltipsKnownBy_Label                = "Known recipe"
	BCUI_Color_TooltipsKnownBy_ColorSwatch_Help     = "Defines color used to display characters who know selected \nrecipe"
	BCUI_Color_TooltipsMayLearn_Label               = "Learnable recipe"
	BCUI_Color_TooltipsMayLearn_ColorSwatch_Help    = "Defines color used to display character who may lears \nselected recipe"
	BCUI_Color_TooltipsRankTooHigh_Label            = "Rank too high"
	BCUI_Color_TooltipsRankTooHigh_ColorSwatch_Help = "Defines color used to display character for whom recipe \nrank is too high"
	BCUI_CheckButton_UseSideTooltip_Label           = "Use side tooltip"
	BCUI_CheckButton_UseSideTooltip_Help            = "Results are displayed in a side tooltip instead of inside \nthe recipe description"

end
