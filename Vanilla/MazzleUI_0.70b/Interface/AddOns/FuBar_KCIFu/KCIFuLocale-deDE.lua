local L = AceLibrary("AceLocale-2.2"):new("KCIFu")

-- German Translation by Gamefaq
L:RegisterTranslations("deDE", function () return {
	["Caption"] = "KC Items",
	["ShortCaption"] = "KCI",
	["ClickTooltip"] = "Klicken um Linkview Fenster zu \195\182ffnen",
	
	-- Statistic --
	["Stats"] = "Statistik: Bekannte Items",
	["Stats_Items"] = "Gesammte Items",
	["Stats_Sell"] = "Verkaufs Preise",
	["Stats_Buy"] = "Kauf Preise",
	["Stats_NoItems"] = "Leere Datenbank...",
	
	-- Menu Items --
	["UseShortCaption"] = "Benutze Abk\195\188rzungen",
	
	-- Auction --
	["Menu_Auction"] = "Auktion",
	["Menu_Auction_Short"] = "Benutze Abk\195\188rzungen",
	["Menu_Auction_Bid"]   = "Zeige gegew\195\164rtiges Gebot",
	["Menu_Auction_Stats"] = "Zeige Item Statistiken",
	
	-- Broker --
	["Menu_Broker"] = "Broker",
	["Menu_Broker_AF"] = "Aktiviere das vorschlagen von Preisen",
	["Menu_Broker_AF_Mode"] = "Vorschlage Modus:",
	["Menu_Broker_AF_Mixed"]   = "Gemixt (Ged\195\164chtnis, Intelligent, H\195\164ndler, Kein)",
	["Menu_Broker_AF_Memory"]  = "Ged\195\164chtnis (basiert auf letztem bekannten Verkaufspreis)",
	["Menu_Broker_AF_Smart"]   = "Intelligent (basiert auf Durchschnittskurs im AH)",
	["Menu_Broker_AF_Vendor"]  = "H\195\164ndler (basiert auf H\195\164ndler Preisen)",
	["Menu_Broker_AF_None"]    = "Kein (schlage nur Verkaufspreis vor)",
	["Menu_Broker_AF_SkipMem"] = "\195\188berspringe \"Ged„chnis\" im \"Gemixt\" Modus",
	["Menu_Broker_Remdur"] = "Merke letzte Auktionsdauer (2/8/24 Std.)",
	["Menu_Broker_Cut"] = "Auktions Schnitt im \"Intelligent\" modus (%)",
	["Menu_Broker_Colorize"] = "F\195\164rbe Auktionen",
	["Menu_Broker_AHColors"] = "Auktion Farben:",
	["Menu_Broker_AHC_Known"] = "Bekannte Rezepte",
	["Menu_Broker_AHC_Sell"] = "H\195\164ndler w\195\188rde mehr bezahlen",
	["Menu_Broker_AHC_Buy"] = "Bester Verkaufspreis",
	["Menu_Broker_AHC_Min"] = "Bestes Gebot",
		
	-- Chatlink --
	["Menu_ChatLink"] = "Chatlink",
	["Menu_ChatLink_Enable"] = "Konvertiere [text] zu |cff00ff00[link]|r beim eintippen",
	
	["Menu_ItemInfo"] = "Item Info",
	["Menu_ItemInfo_Enable"] = "Zeige zus\195\164tzliche Informationen",
	
	-- Tooltip --
	["Menu_Tooltip"] = "Tooltip",
	["Menu_Tooltip_Mode"] = "Anzeige Modus:",
	["Menu_Tooltip_Separated"] = "Getrennt",
	["Menu_Tooltip_Merged"]    = "Vermischt",
	["Menu_Tooltip_Splitline"] = "Aufgeteilte Infos auf den Seiten",
	["Menu_Tooltip_Separate"] = "Trennen durch zus\195\164tzliche Zeile",
	["Menu_Tooltip_Moneyframe"] = "Geld als Symbole",
	
	-- SellValue -- 
	["Menu_SellValue"] = "Verkaufs Wert",
	["Menu_SellValue_Enable"] = "Zeige H\195\164ndler Preise",	
	["Menu_SellValue_Short"] = "Verwende kurze Beschreibungen",
	["Menu_SellValue_single"] = "Zeige Preise auch f\195\188r einzelne Items",
	
	["dummy"] = ''
} end)
