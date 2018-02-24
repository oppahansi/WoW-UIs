function FinderReminder_Locals_deDE()
FinderReminderLocals = {
	desc = "An Addon to remind finders to track the things they wish to find.",
	reminder = "Don't forget to turn on a tracking skill!",
	
	bghidemsg = "Hiding the reminder while in a battleground is now [%s].",
	
	trackingspells = {
		["Mineraliensuche"] = true,
		["Kräutersuche"] = true,
		["Schatzsucher"] = true,
		["Aufspüren der Wildtiere"] = true,
		["Humanoide aufspüren"] = true,
		["Untote aufspüren"] = true,
		["Verborgenes aufspüren"] = true,
		["Elementare aufspüren"] = true,
		["Dämonen aufspüren"] = true,
		["Riesen aufspüren"] = true,
		["Drachkin aufspüren"] = true,
        ["Untote spüren"] = true,
        ["Dämonen spüren"] = true,
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