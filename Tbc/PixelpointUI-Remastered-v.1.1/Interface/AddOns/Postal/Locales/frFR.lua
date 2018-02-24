if GetLocale() ~= "frFR" then return end

local L = AceLibrary("AceLocale-2.2"):new("Postal")

L:RegisterTranslations("frFR", function() return {
-- blackbook
	["Contacts"] = "Contacts",
	["Friends"] = "Amis",
	["Guild"] = "Guild",
	["Add Contact"] = "Ajouter un contact",
	["Remove Contact"] = "Supprimer un contact",
--express
	["|cffeda55fShift-Click|r to take the contents."] = "|cffeda55fMaj-Clic|r pour prendre le contenu.",
	["|cffeda55fCtrl-Click|r to return it to sender."] = "|cffeda55fCtrl-Clic|r pour retourner à l'exp\195\169diteur.",
	["|cffeda55fAlt-Click|r to send this item to %s."] = "|cffeda55fAlt-Clic|r pour envoyer cet objet \195\160 %s.",
--forward
	["Forward"] = "R\195\169expdier",
	["FW:"] = "Reexp:",
--openall
	["Open All"] = "Tout ouvrir",
--rake
	["Collected"] = "R\195\169cup\195\169r\195\169",
--select
	["Open"] = "Ouvrir",
	["Return"] = "Retour",
} end)