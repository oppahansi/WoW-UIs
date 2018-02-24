if GetLocale() ~= "esES" then return end

local L = AceLibrary("AceLocale-2.2"):new("Postal")

L:RegisterTranslations("esES", function() return {
-- blackbook
	["Contacts"] = "Contactos",
	["Friends"] = "Amigos",
	["Guild"] = "Hermandad",
	["Add Contact"] = "A\195\177adir Contacto",
	["Remove Contact"] = "Eliminar Contacto",
--express
	["|cffeda55fShift-Click|r to take the contents."] = "|cffeda55fMay\195\186sculas-Clic|r para coger el contenido",
	["|cffeda55fCtrl-Click|r to return it to sender."] = "|cffeda55fCtrl-Clic|r para devolverlo al que te lo ha enviado",
	["|cffeda55fAlt-Click|r to send this item to %s."] = "|cffeda55fAlt-Clic|r para enviar este objeto a %s",
--forward
	["Forward"] = "Reenv\195\173o",
	["FW:"] = "RV:",
--openall
	["Open All"] = "Abrir Todo",
--rake
	["Collected"] = "Recogido",
--select
	["Open"] = "Abrir",
	["Return"] = "Devolver",
} end)