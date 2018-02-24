KC_MOBILITY = {}


if( not ace:LoadTranslation("AddonName") ) then

KC_MOBILITY.NAME			= "KC_Mobility"

-- Chat handler locals
KC_MOBILITY.COMMANDS		= {"/kcm", "/kc_mobility"}

KC_MOBILITY.CMD_OPTIONS	= {
	{
    	option = "reset",
        desc   = "Usage:  /kcm reset <frame name>",
        method = "resetframe",
		input  = TRUE,
		args = {
		},
	},
}

KC_MOBILITY.FRAMELIST = {
	AuctionFrame		= "Auction House.",
	BankFrame		    = "Bank window.",
	CharacterFrame		= "Character / Pet / Reputation / Skills / Honor",
	ClassTrainerFrame   = "Class Trainer window",
	CraftFrame			= "Enchanting and BestTraining window.",
	FriendsFrame		= "Social window.",
	HonorFrame						= "HonorFrame", 
	InspectFrame		= "Inspection window.",
	MacroFrame			= "Macros window.",
	MailFrame			= "Mailbox.",
	MerchantFrame		= "Merchants.", 
	MultiBarBottomLeft				= "Bottom Left ActionBar",
	MultiBarBottomRight				= "Bottom Right ActionBar",
	MultiBarLeft					= "Right ActionBar 2",
	MultiBarRight					= "Right ActionBar",
	PaperDollFrame					= "PaperDoll",
	PetPaperDollFrame				= "PetPaperDollFrame", 
	PetStableFrame		= "Stable window.",
	QuestLogFrame		= "Quest Log",
	ReputationFrame					= "ReputationFrame",
	SkillFrame						= "SkillFrame",
	SpellBookFrame		= "Spell book.",
	TalentFrame			= "Talents.",
	TaxiFrame			= "Flight Paths",
	TradeFrame			= "Trade window.",
	TradeSkillFrame		= "Tradeskill window.",

}

end