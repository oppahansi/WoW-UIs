---------------------------------------------------
-- La Vendetta BossMods GUI Language File        --
-- GUI by LV|Nitram                              --
--                                               --
-- Translations by:                              --
--   LV|Nitram  -> EN                            --
--   LV|Tandanu -> DE                            --
--   LV|Tandanu -> fixed typos                   --
---------------------------------------------------

----------------------------------
-- Translation by Default -> EN --
----------------------------------
if (GetLocale() == "esES") then

-- DBM_GUI.lua for Bossmod List Frame (DBMBossModListFrame)

DBMGUI_DROPDOWN_LEVEL_1		= "Cruzada Ardiente";
DBMGUI_DROPDOWN_LEVEL_2		= "WoW Cl\195\161sico";


DBMGUI_DISABLE_ADDON			= "Desactivar AddOn";
DBMGUI_ENABLE_ADDON			= "Activar AddOn";
DBMGUI_STOP_ADDON				= "Detener AddOn";
DBMGUI_DISABLE_ANNOUNCE		= "Desactivar Anuncio";
DBMGUI_ENABLE_ANNOUNCE			= "Activar Anuncio";
DBMGUI_SHOW_DROPDOWNMENU		= "Opciones Adicionales";
DBMGUI_DROPDOWNMENU_TITLE		= "Boss Mod Menu";

-- DBMBossModFrame
DBMGUI_HIDE_OPTIONS				= "<< Opciones";
DBMGUI_SHOW_OPTIONS				= "Opciones >>";

-- Options Frame (DBMOptionsFrame)
if( DBM.VersionBeta ) then
	DBMGUI_OPTIONS					= "DBM v"..DBM.Version.." - "..DBM.VersionBeta;
else
	DBMGUI_OPTIONS					= "Opciones (GUI v"..DBMGUI_VERSION.." / Boss Mod v"..(DBM.BetaVersion or DBM.Version)..")";
end
DBMGUI_SIDEFRAME_TAB1				= "General";
DBMGUI_SIDEFRAME_TAB2				= "Barras";
DBMGUI_SIDEFRAME_TAB3				= "Avisos";
DBMGUI_SIDEFRAME_TAB4				= "Especiales";

-- DBMOptionsFramePage1
DBMGUI_TITLE_SYNCSETTINGS			= "Configuraci\195\179n de sincronizaci\195\179n";
DBMGUI_TITLE_MINIMAPBUTTON			= "Configuraci\195\179n Bot\195\179n Minimapa";
DBMGUI_TITLE_AGGROALERT			= "Preferencias Alerta Agro";
DBMGUI_CHECKBOX_SYNC_ENABLE			= "Activar sincronizaci\195\179n";
DBMGUI_BUTTON_VERSION_CHECK			= "Comprobar Versi\195\179n";
DBMGUI_BUTTON_VERSION_CHECK_FAILD		= "No hay otros AddOns Vendetta Boss Mod";
DBMGUI_BUTTON_STATUSBAR_SYNCINFO		= "Informaci\195\179n de sincronizaci\195\179n barra de Estado";
DBMGUI_BUTTON_STATUSBAR_SYNCINFO_FAILD 	= "No hay barras.";
DBMGUI_SLIDER_MINIMAP_1			= "Posici\195\179n";
DBMGUI_SLIDER_MINIMAP_2			= "Radio";
DBMGUI_CHECKBOX_MINIMAP			= "Mostrar Bot\195\179n minimapa";
DBMGUI_CHECKBOX_AGGROALERT_ENABLE		= "Activar alerta de agro";
DBMGUI_BUTTON_AGGROALERT_TEST			= "Probar alerta de agro";
DBMGUI_BUTTON_AGGROALERT_RESET			= "Reset preferencias";
DBMGUI_BUTTON_AGGROALERT_RESET_DONE		= "Alerta de agro ha sido reseteada";
DBMGUI_BUTTON_AGGROALERT_ENABLE_PARTY	= "Activar alerta de agro en mazmorras de 5 jugadores";
DBMGUI_CHECKBOX_AGGROALERT_PLAYSOUND	= "Sonido al ganar el agro";
DBMGUI_CHECKBOX_AGGROALERT_FLASH		= "Destello al ganar el agro";
DBMGUI_CHECKBOX_AGGROALERT_SHAKE		= "Zumbido al ganar el agro";
DBMGUI_CHECKBOX_AGGROALERT_SPECIALTEXT		= "Mostrar aviso especial";
DBMGUI_CHECKBOX_AGGROALERT_LOCALWARNING	= "Mostrar aviso como aviso local";
DBMGUI_BUTTON_MOVEABLEBAR			= "Barra Movible";
DBMGUI_BUTTON_DEFAULTS				= "Defecto";

-- DBMOptionsFramePage2
DBMGUI_TITLE_STATUSBARS 			= "Configuraci\195\179n Estado de Barra Temporizador";
DBMGUI_TITLE_PIZZATIMER			= "Crear \"Temporizador Pizza\"";
DBMGUI_CHECKBOX_STATUSBAR_ENABLE		= "Activar barras de estado";
DBMGUI_CHECKBOX_STATUSBAR_FILLUP		= "Rellenar barras de estado";
DBMGUI_CHECKBOX_STATUSBAR_FLIPOVER		= "Expandir hacia arriba barras de estado";
DBMGUI_EDITBOX_PIZZATIMER_TEXT			= "Nombre";
DBMGUI_EDITBOX_PIZZATIMER_HOUR			= "Horas";
DBMGUI_EDITBOX_PIZZATIMER_MIN			= "Minutos";
DBMGUI_EDITBOX_PIZZATIMER_SEC			= "Segundos";
DBMGUI_CHECKBOX_PIZZATIMER_BROADCAST		= "Anunciar temporizador a la banda";
DBMGUI_BUTTON_PIZZATIMER_START			= "Comenzar temp.";

-- DBMOptionsFramePage3
DBMGUI_TITLE_RAIDWARNING			= "Avisos de banda";
DBMGUI_TITLE_SELFWARNING			= "Avisos Locales"; 
DBMGUI_DROPDOWN_RAIDWARNING_OPTION_1		= "Aviso de banda(Sonido por fecto)";
DBMGUI_DROPDOWN_RAIDWARNING_OPTION_2		= "BellTollNightElf (CT_Raid Sound)";
DBMGUI_DROPDOWN_RAIDWARNING_OPTION_3		= "Desactivar sonido aviso";
DBMGUI_DROPDOWN_RAIDWARNING_INFO_DISABLED	= "Sonido aviso banda desactivado";
DBMGUI_RAIDWARNING_EXAMPLE			= "*** Ejemplo Aviso Banda***";
DBMGUI_BUTTON_SOUND_TEST			= "Probar sonido";
DBMGUI_BUTTON_SHOW_EXAMPLE			= "Mostrar ejemplo";
DBMGUI_BUTTON_RAIDWARNING_RESET		= "Reset ventana";
DBMGUI_BUTTON_RAIDWARNING_RESET_DONE		= "Preferencias reseteadas con exito a defecto";

-- DBMOptionsFramePage4
DBMGUI_TITLE_SPECIALWARNING			= "Configuraci\195\179n Avisos Especiales";
DBMGUI_TITLE_SHAKESCREEN			= "Configuraci\195\179n efecto de zumbido en la pantalla";
DBMGUI_TITLE_FLASHEFFECT			= "Configuraci\195\179n efectos de destello";
DBMGUI_CHECKBOX_SPECWARNING_ENABLE		= "Activar avisos especiales";
DBMGUI_BUTTON_SPECWARNING_TEST			= "Probar aviso";
DBMGUI_BUTTON_SPECWARNING_EXAMPLE		= "Probar mensaje :)";
DBMGUI_SLIDER_SPECWARNING_DURATION		= "Duraci\195\179n";
DBMGUI_SLIDER_SPECWARNING_FADETIME		= "T. desaparici\195\179n";
DBMGUI_SLIDER_SPECWARNING_TEXTSIZE		= "Tama\195\177o texto";
DBMGUI_CHECKBOX_SHAKESCREEN_ENABLE		= "Activar efectos de zumbido";
DBMGUI_BUTTON_SHAKESCREEN_TEST			= "Probar zumbido";
DBMGUI_SLIDER_SHAKESCREEN_DURATION		= "Duraci\195\179n";
DBMGUI_SLIDER_SHAKESCREEN_INTENSITY		= "Intensidad";
DBMGUI_CHECKBOX_FLASHEFFECT_ENABLE		= "Activar efecto de destello";
DBMGUI_BUTTON_FLASHEFFECT_TEST			= "Probar destello";
DBMGUI_SLIDER_FLASHEFFECT_DURATION		= "Duraci\195\179n";
DBMGUI_SLIDER_FLASHEFFECT_FLASHES		= "Destellos";

-- DBMOptionsFramePage5
DBMGUI_ABOUTTITLE	= "Acerca de";
DBMGUI_ABOUTTEXT	= {
	"Deadly Boss Mods API (c) por DeadlyMinds Tandanu",
	"Deadly Boss Mods GUI (c) por La Vendetta Nitram",
	" ",
	"Gracias por usar nuestro AddOn.",
	" ",
	"                                  Visite",
	" ",
	"                   www.deadlyminds.net",
	" ",
	"                                   y",
	" ",
	"                 www.curse-gaming.com",
	" ",
	"Si tiene alguna sugerencia o informe de fallo, deja un comentario en www.curse-gaming.com o escribe en nuestros foros en www.deadlyminds.net",

};


-- Translations added v1.10
DBMGUI_SIDEFRAME_TAB5				= "Misc";
DBMGUI_SIDEFRAME_TAB6				= "Acerca de";

DBMGUI_SLIDER_STATUSBAR_COUNT			= "Contador de Barra";
DBMGUI_DROPDOWN_STATUSBAR_DESIGN_1		= "Dise\195\177o cl\195\161sico"; --wird überflüssig mit dem Verwenden des Namens aus der Tabelle
DBMGUI_DROPDOWN_STATUSBAR_DESIGN_2		= "Estilo moderno"; 
DBMGUI_DROPDOWN_STATUSBAR_EXAMPLE_BAR		= "Barra de ejemplo";

DBMGUI_TITLE_AUTORESPOND			= "Preferencias Auto-respuesta";
DBMGUI_CHECKBOX_AUTORESPOND_ENABLE		= "Rspuesta Autom\195\161tica a susurros durante luchas con jefes";
DBMGUI_CHECKBOX_AUTORESPOND_SHOW_WHISPERS	= "Mostrar susurros durante el combate";
DBMGUI_CHECKBOX_AUTORESPOND_INFORM_USER	= "Informarme acerca de susurros auto-respondidos";
DBMGUI_CHECKBOX_AUTORESPOND_HIDE_REPLY		= "Esconder respuestas autom\195\161ticas";

DBMGUI_EDITBOX_AUTORESPOND_TITLE		= "Mensaje durante lucha con jefes";
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_HEADER	= "Las siguientes secuencias ser\1951\161n\n reemplazadas automatic\191\161mente:";
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT1	= {"%P", "your name"};
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT2	= {"%B", "boss name"};
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT3	= {"%HP", "boss hp"};
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT4	= {"%ALIVE", "raid members alive"};
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT5	= {"%RAID", "raid members"};

-- Translations added v1.15
DBMGUI_CHECKBOX_ALLOW_STATUS_COMMAND		= "Permite a los usuarios preguntar acerca del estado de la lucha(susurrar \"status\")";
DBMGUI_CHECKBOX_SHOWCOMBATINFO			= "Muestra informaci\195\179n del combate como duraci\195\179n";

DBMGUI_TITLE_COMBATSYSTEM			= "Sistema de detecci\195\179n de Combate";
DBMGUI_BUTTON_STATUSBAR_FLASHONEND		= "Destello de barra al acabar el temporizador";
DBMGUI_BUTTON_STATUSBAR_AUTOCOLORBARS		= "Color de barra Din\195\161amico";

-- Translations added v1.20
DBMGUI_TITLE_RAIDOPTIONS			= "Opciones de Banda";
DBMGUI_CHECKBOX_HIDEPLAYERNAMESINRAIDS		= "Esconder nombres de jugadores al unirse a una Banda";
DBMGUI_CHECKBOX_ALLOWSYNCFROMOLDCLIENT		= "Aceptar sinc. de versiones antiguas";

-- Translation added v1.25
DBMGUI_CHECKBOX_ENABLE_RAIDWARNINGFRAME	= "Activar ventana de aviso de banda";
DBMGUI_CHECKBOX_ENABLE_SELFWARNINGFRAME	= "Activar ventana de autoaviso";

DBMGUI_BUTTON_LOADADDON			= "Cargar AddOn";
DBMGUI_FRAME_LOADADDON_DESCRIPTION		= {
	"Por favor entre en la zona para cargar los",
	"AddOns automaticamente. Si quieres cargarlos",
	"manualmente, click en \"Cargar AddOns\".",
	"Despues de esto los AddOns est\195\161n funcionando,",
	"pero usando memoria y CPU. Esta funci\195\179n es",
	"solo un truco de rendimiento porque no",
	"queremos cargar AddOns de mazmorras que no hacemos.",
};



-- added @ 1.12.06
DBMGUI_CHECKBOX_SHOWPULLSYNCINFO	= "Mostrar informaci\195\179n de sinc al pulear";

DBMGUI_TITLE_LOAD_ON_DEMAND		= "Cargar en opciones de demanda";
DBMGUI_CHECKBOX_LOAD_GUI_ONLOAD	= "Cargar GUI al identificar";	

-- added @ 13.12.06
DBMGUI_BUTTON_STATUSBAR_SHOW_ICON	= "Activar icono de barra de estado";
DBMGUI_BUTTON_STATUSBAR_ICON_SIDE	= "Mostrar icono a la dcha.";

--DBM_ERROR_TABS_FULL	= "La lista de pesta\195\177as de The boss mod est\195\161 llena, la \195\186ltima (%s) ser\195\161 escondida. Use el bot\195\179n \"Cargar Mods\" para mostrarla de nuevo.";

DBMGUI_BUTTON_LOADMODS	= "Cargar Mods";

end