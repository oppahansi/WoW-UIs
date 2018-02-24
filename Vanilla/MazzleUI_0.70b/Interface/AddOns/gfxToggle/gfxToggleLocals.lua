gfxToggle = {}

-- German Localization
	function gfxToggle_Locals_deDE()
	
		gfxToggle.Const = {
		
			Commands = {"/gfxt", "/gfxtoggle"},

			CmdOptions	=	{
				{ option 	= "save",
					desc		=	"Speichert pers\195\182nliche Grafik-Einstellungen.",
					method	= "Save",
					input		=	TRUE,
					args		= {
						{	option	=	"low",
							desc		=	"Speichert Einstellungen: '|cff00ff00Niedrig|r'.\nWeltdarstellungs-"..
												", Shader- und Misc-Einstellungen im WoW-Grafikmen\195\188 vornehmen und mit Klick auf den OK-Button best\195\164tigen." ..
												"Danach 'gfxt save low' eingeben.",
						},
						{	option	=	"medium",
							desc		=	"Speichert Einstellungen: '|cffffff00Mittel|r'.\nWeltdarstellungs-"..
												", Shader- und Misc-Einstellungen im WoW-Grafikmen\195\188 vornehmen und mit Klick auf den OK-Button best\195\164tigen." ..
												"Danach 'gfxt save medium' eingeben.",
						},
						{	option	=	"high",
							desc		=	"Speichert Einstellungen: '|cffff0000Hoch|r'.\nVor dem Ausf\195\188hren Weltdarstellungs-"..
												", Shader- und Misc-Einstellungen im WoW-Grafikmen\195\188 vornehmen und mit Klick auf den OK-Button best\195\164tigen." ..
												"Danach 'gfxt save high' eingeben.",
						}
					}
				},
				{	option	=	"auto",
					desc		=	"Schaltet beim Zonenwechsel automatisch zwischen den gespeicherten Einstelllungen um. (Greift auf Zonendatenbank zu.)",
					method	=	"Auto"
				},
				{	option	=	"medium",
					desc		=	"Aktiviert das Benutzen der Einstellung: '|cffffff00Mittel|r'.",
					method	=	"TogMed"
				},		
				{	option	=	"toggle",
					desc		=	"Manuelles Umschalten zwischen '|cff00ff00Niedrig|r', '|cffffff00Mittel|r' (wenn aktiviert mit '/gfxt medium') und '|cffff0000Hoch|r'.",
					method	=	"Toggle"
				},
				{	option	=	"addl",
					desc		=	"'addl' Speichert die aktuelle Zone für die Einstellung: '|cff00ff00Niedrig|r'. 'addl Name' speichert die angegebene Zone.",
					method	=	"AddL",
				},
				{	option	=	"addm",
					desc		=	"'addm' Speichert die aktuelle Zone für die Einstellung: '|cffffff00Mittel|r'. 'addm Name' speichert die angegebene Zone.",
					method	=	"AddM",
				},
				{	option	=	"del",
					desc		=	"'del' entfernt die aktuelle Zone aus der Datenbank. 'del Name' entfernt die angegebene Zone.",
					method	=	"Del",
					args		=	{
						{	option 	= "all",
							desc		=	"Entfernt alle gespeicherten Zonen aus der Datenbank."
						}
					}
				},
				{	option	=	"list",
					desc		=	"Zeigt alle gespeicherten Zonen an.",
					method	=	"List"
				},
				{	option	=	"mute",
					desc		=	"Schaltet Meldungen aus/an.",
					method	=	"Mute"
				},
				{	option	=	"delay",
					desc		=	"Hiermit kann eine Verz\195\182gerung f\195\188r das automatische Umschalten eingestellt werden."..
										"(Grundeinstellung: [|cfff5f5305|r] Sekunden)",
					method	=	"Delay",
					input = TRUE
				},
				{	option	=	"m2faster",
					desc		=	"Ein- oder Ausschalten der Blizzard M2Faster-Funktion zur Verbesserung der ".. 
										"Performance in \195\188berf\195\188llten Gegenden. Grundeinstellung ist: ".."|cff00ff00An|r",
					method	=	"m2faster"
				},
				{	option	=	"restartgx",
					desc		=	"Erlaubt oder unterbindet Reset des Grafiktreibers (ben\195\182tigt f\195\188r VSync).",
					method	=	"Vsyn",
					args		=	{
						{	option	=	"help",
							desc		=	"F\195\188r das Umschalten von VSync, Tripplebuffer und Weiche Maussteuerung muss der "..
												"Grafikkarten-Treiber neu initialisiert werden. Bei Initialisierung wird kurz vom Spiel "..
												"auf den Desktop und wieder zur\195\188ck ins Spiel gewechselt. Der Vorgang dauert ca. 1-2"..
												" Sekunden. Mit diesem Befehl wird das Umschalten dieser Einstellungen generell erlaubt oder verboten."..
												" Grundeinstellung ist: ".."|cffff5050Aus|r" 
						}
					}
				},
				{	option	=	"reset",
					desc		=	"Setzt alle Optionen auf ihre Standardwerte zur\195\188ck. Achtung: Diese Aktion kann nicht r\195\188ckg\195\164ngig gemacht werden!",
					method	=	"Reset",
					args		=	{
						{	option	=	"help",
							desc		=	"Um wirklich alle Einstellungen zur\195\188ckzusetzen bitte 'reset CONFIRM' eingeben."..
												"\nAchtung: Diese Aktion kann nicht r\195\188ckg\195\164ngig gemacht werden!"
						},
						{	option	=	"CONFIRM",
							desc		=	"Setzt die Optionen auf ihre Standardwerte zur\195\188r\195\188ck. Zonen werden nicht gel\195\164scht. siehe 'del'-Befehl"
						}
					}
				}
			},
			
-- Chat Msg --
			Chat = {
				Mute					=	"Stumm",
				GxR						=	"RestartGX",
				Auto					=	"Auto-Modus",
				Med						= "Mittel",
				OhtLo					=	"Grafik-Einstellungen: '|cff00ff00Niedrig|r' ",
				OhtMed				=	"Grafik-Einstellungen: '|cffffff00Mittel|r' ",
				OhtHi					=	"Grafik-Einstellungen: '|cffff0000Hoch|r' ",
				OhtDefLo			=	"Grafik-Einstellungen: '|cff00ff00Niedrig|r' (Standardwert) \n" ..
												"Zum Speichern neuer Werte '/gfxt save low' ausf\195\188hren.",
				OhtDefMed			=	"Grafik-Einstellungen: '|cffffff00Mittel|r' (Standardwert) \n" ..
												"Zum Speichern neuer Werte '/gfxt save medium' ausf\195\188hren.",				
				OhtDefHi			=	"Grafik-Einstellungen: '|cffff0000Hoch|r' (Standardwert) \n" .. 
												"Zum Speichern neuer Werte '/gfxt save high' ausf\195\188hren.",
				SaveLo				=	"Grafik-Einstellungen: '|cff00ff00Niedrig|r' gespeichert.",
				SaveMed				=	"Grafik-Einstellungen: '|cffffff00Mittel|r' gespeichert.",
				SaveHi				=	"Grafik-Einstellungen: '|cffff0000Hoch|r' gespeichert.",
				Exists				=	"Eintrag bereits vorhanden, bitte zuerst l\195\182schen.",
				NotThere			=	"Eintrag nicht vorhanden.",
				NoEntry				=	"Es wurden keine Eintr\195\164ge gefunden.",
				Added					=	"' wurde hinzugef\195\188gt.",
				MedAdd				=	"Bitte beachten: Der Auto-Modus wird erst zu 'Mittel' umschalten, wenn die Option '/gfxt medium' aktiviert wurde.",
				Deleted				=	"' wurde entfernt.",
				DelAll				=	"Alle Eintr\195\164ge entfernt.",
				Found					=	" Eintr\195\164ge gefunden.",
				FoundOne			=	" Eintrag gefunden.",
				ZoneDb				=	"Gespeicherte Zonen",
				ZonesRestored	= "Zonendatenbank wiederhergestellt.",
				LowZones			= "Zonen 'Niedrig'",
				MedZones			= "Zonen 'Mittel'",
				m2faster	    = "M2Faster",
				Delay					= "Verz\195\182gerung",
				Update   			= "Es ist ein Update erforderlich. Bitte '/gfxt reset CONFIRM' ausf\195\188hren.",
				Reload        = "Um sicher zu gehen, dass die neuen Einstellungen wirksam sind, entweder den Char erneut einloggen oder" ..
												"'/console ReloadUI' eingeben."
			},
		}

-- Register Globals -- 
		ace:RegisterGlobals({
			version							=	2.0,
			translation					=	"deDE",
			ACEG_ON  						= "|cff00ff00An|r",
			ACEG_OFF 						= "|cffff5050Aus|r",
			ACEG_DISPLAY_OPTION	=	"[|cfff5f530%s|r]",
			ACEG_MAP_ONOFF			=	{[0]="|cffff5050Aus|r",[1]="|cff00ff00An|r"},
			ACEG_MAP_SAVED			=	{[0]="|cffff5050nicht gespeichert|r",[1]="|cff00ff00gespeichert|r"},
			ACEG_RESETINFO			=	"Bist du dir sicher? Bitte '%s reset CONFIRM' eingeben um fortzufahren.",
			ACEG_DORESET				=	"Alle Optionen wurden auf ihre Standardwerte zur\195\188ckgesetzt."
		})

-- Bindings --
		BINDING_HEADER_GFX			=	"gfxToggle"
		BINDING_NAME_GFX_TOGGLE	=	"Grafik umschalten"
		BINDING_NAME_GFX_AUTO		=	"Auto-Modus"

-- End of German Localization --
	end
	
-- English Localization
	if not ace:LoadTranslation("gfxToggle") then
	
		gfxToggle.Const = {
		
			Commands = {"/gfxt", "/gfxtoggle"},
	
			CmdOptions = {
				{ option 	= "save",
					desc		=	"Saves your custom settings.",
					method	= "Save",
					input		=	TRUE,
					args		= {
						{	option	=	"low",
							desc		=	"Saves settings for '|cff00ff00Low|r'.\nGo to WoW Graphic-Options and select"..
												"  the World Appearance, Shaders and Misc settings, after that click on the Ok-Button then type '/gfxt save low'",
						},
						{	option	=	"medium",
							desc		=	"Saves settings for '|cffffff00Medium|r'.\nGo to WoW Graphic-Options and select"..
												"  the World Appearance, Shaders and Misc settings, after that click on the Ok-Button then type '/gfxt save medium'",
						},
						{	option	=	"high",
							desc		=	"Saves settings for '|cffff0000High|r'.\nGo to WoW Graphic-Options and select"..
												"  the World Appearance, Shaders and Misc settings, after that click on the Ok-Button then type '/gfxt save high'",
						}
					}
				},	
				{	option	=	"auto",
					desc		=	"Toggles automatically between the saved settings. (Checks for zone database.)",
					method	=	"Auto"
				},
				{	option	=	"medium",
					desc		=	"Does allow you the use of the settings: '|cffffff00Medium|r'.",
					method	=	"TogMed"
				},		
				{	option	=	"toggle",
					desc		=	"Toggles between '|cff00ff00Low|r', '|cffffff00Medium|r' (if turned on by '/gfxt medium') and '|cffff0000High|r'.",
					method	=	"Toggle"
				},	
				{	option	=	"addl",
					desc		=	"'addl' saves the current zone for setting: '|cff00ff00Low|r'. 'addl Name' saves the specified zone.",
					method	=	"AddL",
				},
				{	option	=	"addm",
					desc		=	"'addm' saves the current zone for setting: '|cffffff00Medium|r'. 'addm Name' saves the specified zone.",
					method	=	"AddM",
				},
				{	option	=	"del",
					desc		=	"'del' deletes the current zone from database. 'del Name' deletes the specified zone.",
					method	=	"Del",
					args		=	{
						{	option	=	"all",
							desc		=	"Deletes all saved zones from the database.",
						}
					}
				},
				{	option	=	"list",
					desc		=	"Lists all saved zones.",
					method	=	"List"
				},
				{	option	=	"mute",
					desc		=	"Toggles message output off/on",
					method	=	"Mute"
				},
				{	option	=	"m2faster",
					desc		=	"Enables or disables the use of Blizzard's M2Faster-Function to improve".. 
										" performance in crowded areas. Default is: ".."|cff00ff00On|r",
					method	=	"m2faster"
				},
				{	option	=	"delay",
					desc		=	"Let you set a delay for the Auto-Mode. (Default: [|cfff5f5305|r] seconds)",
					method	=	"Delay",
					input = TRUE
				},
				{	option	=	"restartgx",
					desc		=	"Allows or disallows re-initialising of the graphics driver (needed for VSync).",
					method	=	"Vsyn",
					args		=	{
						{	option	=	"help",
							desc		=	"To switch VSync, Tripplebuffer and Smooth Mouse the game has to restart the graphics. "..
												"While it does the restart, it'll switch to the desktop and back to game after a "..
												"duration of 1-2 seconds. By using this command you allow switching these settings. "..
												"Default is: |cffff5050Off|r."
						}
					}
				},
				{	option	=	"reset",
					desc		=	"Resets all settings to their defaults.",
					method	=	"Reset",
					args		=	{
						{	option	=	"help",
							desc		=	"This option will allow you to reset your settings to their defaults."..
												"\nTo do this type '/gfxt reset CONFIRM' so that the AddOn will know you've"..
												" read this information."
						},
						{	option	=	"CONFIRM",
							desc		=	"This option will reset all of your settings to their defaults except the zones database (see 'del' command)"
						},
					}
				}	
			},
			
-- Chat Options --
			Chat = {
				Mute					=	"Mute",
				GxR						=	"RestartGX",
				Auto					=	"Auto-Mode",
				Med						= "Medium",
				OhtLo					=	"GFX set to: '|cff00ff00Low|r' ",
				OhtMed				=	"GFX set to: '|cffffff00Medium|r' ",
				OhtHi					=	"GFX set to: '|cffff0000High|r' ",
				OhtDefLo			=	"GFX set to: '|cff00ff00Low|r' (default) \n" .. "Use '/gfxt save' to save custom settings.",
				OhtDefMed			=	"GFX set to: '|cffffff00Medium|r' (default) \n" .. "Use '/gfxt save' to save custom settings.",
				OhtDefHi			=	"GFX set to: '|cffff0000High|r' (default) \n" .. "Use '/gfxt save' to save custom settings.",
				SaveLo				=	"Settings '|cff00ff00Low|r' saved.",
				SaveMed				=	"Settings '|cffffff00Medium|r' saved.",
				SaveHi				=	"Settings '|cffff0000High|r' saved.",
				Exists				=	"Entry already exists, please delete it before.",
				NotThere			=	"Entry not found.",
				NoEntry				=	"No entries were found.",
				Added					=	"' has been added.",
				MedAdd				= "Please notice: Auto-Toggle will only switch to Medium when you have activated the option '/gfxt medium' before.",
				Deleted				=	"' has been deleted.",
				DelAll				=	"All entries have been deleted.",
				Found					=	" Entries found.",
				FoundOne			=	" Entry found.",
				ZonesRestored	=	"Zone database restored.",
				LowZones			= "Zones 'Low'",
				MedZones			= "Zones 'Medium'",
				ZoneDb				=	"Saved Zones",
				m2faster	    = "M2Faster",
				Delay					= "Delay",
				Update   			= "Update needed. Please type '/gfxt reset CONFIRM' to reset options.",
				Reload        = "To make sure the new settings are active either relog or type '/console ReloadUI'."
			},
		}
		
-- Register Globals -- 
		ace:RegisterGlobals({
			version							=	2.0,
			ACEG_ON  					  = "|cff00ff00On|r",
			ACEG_OFF 						= "|cffff5050Off|r",
			ACEG_DISPLAY_OPTION	=	"[|cfff5f530%s|r]",
			ACEG_MAP_ONOFF			=	{[0]="|cffff5050Off|r",[1]="|cff00ff00On|r"},
			ACEG_MAP_SAVED			=	{[0]="|cffff5050not saved|r",[1]="|cff00ff00saved|r"},
			ACEG_RESETINFO 			= "Are you sure?  Please type '%s reset confirm' to proceed.",
			ACEG_DORESET				=	"All option defaults have been restored.",
		})
	
-- Declare the Bindings.--
		BINDING_HEADER_GFX			=	"gfxToggle"
		BINDING_NAME_GFX_TOGGLE	=	"Toggle graphics"
		BINDING_NAME_GFX_AUTO		=	"Auto-Mode"

-- End of English Localization --
	end