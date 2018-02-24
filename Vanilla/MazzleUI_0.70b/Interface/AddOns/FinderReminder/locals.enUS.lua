if(not Ace:LoadTranslation("FinderReminder")) then
FinderReminderLocals = {
	desc = "An Addon to remind finders to track the things they wish to find.",
	reminder = "Don't forget to turn on a tracking skill!",
	
	bghidemsg = "Hiding the reminder while in a battleground is now [%s].",
	
	trackingspells = {
		["Find Minerals"] = true,
		["Find Herbs"] = true,
		["Find Treasure"] = true,
		["Track Beasts"] = true,
		["Track Humanoids"] = true,
		["Track Undead"] = true,
		["Track Hidden"] = true,
		["Track Elementals"] = true,
		["Track Demons"] = true,
		["Track Giants"] = true,
		["Track Dragonkin"] = true,
        ["Sense Undead"] = true,
        ["Sense Demons"] = true,
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