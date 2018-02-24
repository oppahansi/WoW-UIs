function FinderReminder_Locals_frFR()
FinderReminderLocals = {
	desc = "An Addon to remind finders to track the things they wish to find.",
	reminder = "Don't forget to turn on a tracking skill!",
	
	bghidemsg = "Hiding the reminder while in a battleground is now [%s].",
	
	trackingspells = {
		["Découverte de gisements"] = true,
		["Découverte d'herbes"] = true,
		["Découverte de trésors"] = true,
		["Pistage des Bêtes"] = true,
		["Pistage des Humanoïdes"] = true,
		["Pistage des Morts-Vivants"] = true,
		["Pistage des Camouflés"] = true,
		["Pistage des Elémentaires"] = true,
		["Pistage des Démons"] = true,
		["Pistage des Géants"] = true,
		["Pistage des Draconiens"] = true,
        ["Détection des morts-vivants"] = true,
        ["Détection des démons"] = true
	},
	
	cmdOptions = {
		{
			option = "hideinbg",
			desc = "Toggle hiding reminders while in a battle ground",
			method = "ToggleBG",
		},	
	}
	
}
end

ace:RegisterGlobals{
	version 	= 1.0,
	ACEG_ON 	= "On",
	ACEG_OFF	= "Off",
}