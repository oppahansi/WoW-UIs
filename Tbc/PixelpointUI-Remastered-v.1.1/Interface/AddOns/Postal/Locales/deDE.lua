if GetLocale() ~= "deDE" then return end

local L = AceLibrary("AceLocale-2.2"):new("Postal")

L:RegisterTranslations("deDE", function() return {
--main
	["Module Options"] = "Modul Optionen",
	["Opening Speed"] = "Öffnungsgeschwindigkeit",
	["The time in seconds between opening each mail/item/money. Setting this to a very fast speed may disconnect you while opening mail."] = "Die Zeit in Sekunden zwischen dem öffnen einzelner Mails/Items/Geld. Das einstellen dieses Werts auf einen sehr schnelle Geschwindigkeit kann einen Disconnect vom Server zur Folge haben beim öffnen der Post.",
--blackbook
	["BlackBook"] = "SchwarzesBuch",
	["A Black Book to write down your addresses."] = "Ein Schwarzes Buch zum eintragen deiner Adresssen.",
	["Contacts"] = "Kontakt",
	["Friends"] = "Freunde",
	["Guild"] = "Gilde",
	["Add Contact"] = "Kontakt hinzufügen",
	["Remove Contact"] = "Kontakt entfernen",
	["Part %d"] = "Teil %d",
--dejavu
	["DejaVu"] = "DejaVu",
	["Autofills the last recipient in the To: field."] = "Automatisches einfügen des letztens Emfängers in das 'Senden an' Feld.",
--express
	["Express"] = "Express",
	["Mouse click short cuts for mail."] = "Maus Klick Schnelltasten für Mails.",
	["|cffeda55fShift-Click|r to take the contents."] = "|cffeda55fShift+Linkslick|r um Gegenstand zu entnehmen.",
	["|cffeda55fCtrl-Click|r to return it to sender."] = "|cffeda55fStrg+Linksklick|r um Gegenstand zurück zusenden.",
	["|cffeda55fAlt-Click|r to send this item to %s."] = "|cffeda55fAlt+Linksklick|r um Gegenstand an %s zusenden.",

	["Express options"] = "Express Optionen",
	["Options for the Express module"] = "Optionen für das Express Module.",
	["Enable Alt-Click to send mail"] = "Aktiviere Alt-Klick um Mails zu Senden.",
	["If this option is on, Alt-Clicking an item in your bags will send it instantly to the player in the To: field"] = "Wenn diese Option an ist wird Alt-Klicken auf ein Item in deinem Inventar es sofort an den Spieler senden der im 'Senden an' Feld eingetragen ist.",
	["Auto-Send on Alt-Click"] = "Auto-Senden bei Alt-Klick",
	["With this option on, Postal will mail an item as soon as it is attached if there is a recipient filled in."] = "Wenn diese Option an ist, wird Postal Items sofort beim hinzufügen an Nachrichten abschicken wenn der Empfänger bereits eingetragen ist.",
--forward
	["Forward"] = "Weiterleiten",
	["Forward a message. (Currently Broken)"] = "Weiterleiten einer Nachricht. (Gegenwärtig Defekt)",
	["FW:"] = "AW:",
--openall
	["OpenAll"] = "ÖffneAlles",
	["A button that collects all attachments and coins from mail."] = "Eine Taste die alle Anhänge und Geld von Nachrichten entnimmt.",
	["Open All"] = "Alle Öffnen",
	["Some Messages May Have Been Skipped."] = "Einige Nachrichten können Ausgelassen worden sein.",
	["In Progress"] = "In Bearbeitung",
	["Insufficient Bag Space"] = "Nicht genügend Taschenplätze vorhanden!",
	["Processing Message"] = "Bearbeite Nachricht",

	["OpenAll options"] = "ÖffneAlles Optionen",
	["Options for the OpenAll module"] = "Optionen für das ÖffneAlles Module.",
	["AH-related mail"] = "AH-betreffende Nachrichten",
	["Options for AH-related mail"] = "Optionen für AH-betreffende Nachrichten",
	["Open all Auction cancelled mail"] = "Öffne alle 'Auktion abgebrochen' Nachrichten",
	["If this option is off, Postal will skip opening Auction cancelled mails"] = "Wenn diese Options aus ist wird Postal Nachrichten über abgebrochenen Auktionen überspringen beim öffnen.",
	["Open all Auction expired mail"] = "Öffne alle 'Auktion abgelaufen' Nachrichten",
	["If this option is off, Postal will skip opening Auction expired mails"] = "Wenn diese Options aus ist wird Postal Nachrichten über abgelaufenen Auktionen überspringen beim öffnen.",
	["Open all Outbid on mail"] = "Öffne alle 'Überboten' Nachrichten",
	["If this option is off, Postal will skip opening Outbid on mails"] = "Wenn diese Options aus ist wird Postal Nachrichten über Überbotene Auktionen überspringen beim öffnen.",
	["Open all Sale Pending mail"] = "Öffne alle 'Ausstehender Verkauf' Nachrichten",
	["If this option is off, Postal will skip opening Sale Pending mails"] = "Wenn diese Options aus ist wird Postal Nachrichten über ausstehende Verkäufe überspringen beim öffnen.",
	["Open all Auction successful mail"] = "Öffne alle 'Auktion erfolgreich' Nachrichten",
	["If this option is off, Postal will skip opening Auction successful mails"] = "Wenn diese Options aus ist wird Postal Nachrichten über erfolgreiche Auktionen überspringen beim öffnen.",
	["Open all Auction won mail"] = "Öffne alle 'Auktion gewonnen' Nachrichten",
	["If this option is off, Postal will skip opening Auction won mails"] = "Wenn diese Options aus ist wird Postal Nachrichten über gewonnene Auktionen überspringen beim öffnen.",
	["Non-AH related mail"] = "Nicht-AH betreffende Nachrichten",
	["Options for non-AH related mail"] = "Optionen für Nicht-AH betreffende Nachrichten.",
	["Open all mail with attachments"] = "Öffne alle Nachrichten mit Anhängen",
	["If this option is off, Postal will skip opening mails from players that has attachments"] = "Wenn diese Options aus ist wird Postal Nachrichten von Spielern mit Anhängen überspringen beim öffnen.",
	["Other options"] = "Weitere Optionen",
	["Verbose mode"] = "Informations Modus",
	["If this option is on, Postal will spam the chat with messages while opening mail"] = "Wenn diese Option an ist wird Postal den Chat mit Informationen zuspammen 'was es grade tut' beim öffnen von Nachrichten.",
--rake
	["Rake"] = "Rechnen",
	["Prints the amount of money collect during a mail session."] = "Gibt im Chat aus wieviel Gold bei einer Nachrichten Sitzung am Briefkasten entnommen wurde.",
	["Collected"] = "Gesammelt",
--select
	["Select"] = "Auswahl",
	["Add check boxes to the inbox for multiple mail operations."] = "Fügt dem Posteingang Auswahl Felder hinzu für zusätzliche Bearbeitungsmöglichkeiten der Nachrichten.",
	["Open"] = "Öffnen",
	["Return"] = "Zurück",
	["COD"] = "COD",
	["Skipping"] = "Überspringe",

	["Select options"] = "Auswahl Optionen",
	["Options for the Select module"] = "Optionen für das Wählen Modul.",
--tradeblock
	["TradeBlock"] = "HandelsBlock",
	["Block incoming trade requests while in a mail session."] = "Blockt eingehende Handelsversuche von Spielern solange der Briefkasten geöffnet ist.",
--wire
	["Wire"] = "AutoGold",
	["Set subject field to value of coins sent if subject is blank."] = "Trägt im Betreff Feld die Menge an Gold ein das versendet wird wenn kein Betreff eingetragen wurde.",
	["^%[%d+g %d+s %d+c%]$"] = "^%[%d+g %d+s %d+c%]$",
	["^%[%d+s %d+c%]$"] = "^%[%d+s %d+c%]$",
	["^%[%d+c%]$"] = "^%[%d+c%]$",
} end)

