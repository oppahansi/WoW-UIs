local addon, ns = ...

ChatFontNormal:SetFont(NAMEPLATE_FONT, 14, "THINOUTLINE") 

ns.Config = {
	tweaks = {		
		fadeframe 		= false,	--Enable/Disable fading of frame when u mouseover
									--The memory leak was actually caused by tainting issues I didnt see. DOH!
									--So enabling fadeframe will still cause a slight memory increase, but not as drastic as before.
		channelflash 	= true, 	--Flash tabs when you receive custom channel messages
		filterbar		= false,	--False hides the black bar with filters on the combat log.  True keeps original functionality
		im_alpha		= false,	 --Enable/disable fading the editbox for non focues frames when IM chatstyle is enabled
	},
	blacklist = { --Disables all formatting on certain chat frames.
		[ChatFrame2]	= true,		--Combat Log
	},
	font = { 						--False/invalid values inherit ChatFontNormal values
		enabled			= true,		--Enables/disables custom chatframe font settings.  Enabling will most likely break any font replacing addons affecting chatframes
		name 			= false, 	
		size 			= 12,		
		outline 		= 'thin', 	--'thin', 'thick', or 'none'. 
		shadow = {
			enabled		= false,		--Enable/Disable custom shadowing
			color		= {0, 0, 0, 1},	--r, g, b, alpha (set alpha to 0 to hide the shadow)
			offset		= {1, -1},		--x, y
		},
	},
	editbox = {
		enabled 		= true,		--Enable/Disable module		
		docking = {
			location 	= 'top',	--'top', 'bottom'.  Defaults to 'bottom' if an invalid value
			position = {			
				--These positions only apply if the editbox is docked at the top
				--The values are in relation to the chat tabs
				--Accepted values: 'above', 'center', 'below'
				classic = 'center',	--Defaults to 'center' if false/invalid
				im		= 'above', 	--This is the position if IM style chat is enabled. Defaults to 'above' if false/invalid
			},
			offset		= 25,		--Positive values move it up, Negative values move it down.  Defaults to 0
		},
		textures = {
			--Setting these values to false will hide the textures
			--Setting these values to true will use original textures
			--You may also set a color to it using the format {r, g, b}
			normal		= {0, 0, 0}, 	--Enable/Disable normal editbox background texture
			focus		= true, 		--Enable/disable focus texture (the colored border)
			alpha		= 0,       	--False uses default alpha
		},
		font = { 					--False/invalid values inherit ChatFontNormal values
			enabled		= false,	--Enable/disable custom editbox font settings.  Enabling will most likely break any font replacing addons affecting editboxes
			name		= false,	
			size 		= false, 
			outline 	= 'thin',	--'thin', 'thick', or 'none'. 
			shadow = {
				enabled		= false,		--Enables/disables custom shadowing
				color		= {0, 0, 0, 1},	--r, g, b, alpha (set alpha to 0 to hide the shadow)
				offset		= {1, -1},		--x, y
			},
		},		
	},	
	tabs = {
		enabled 		= true, 	--Enable/disable tabs module
		font = { 					--False/Invalid values inherit GameFontNormalSmall values
			enabled		= true,		--Enable/disable custom tab font settings.  Enabling will most likely break any font replacing addons affecting tabs
			name		= false,	
			size 		= 12, 
			outline 	= 'thin',	--'thin', 'thick', or 'none'. This is the outline used for below
			shadow = {
				enabled		= false,		--Enable/disable custom shadowing
				color		= {0, 0, 0, 1},	--r, g, b, alpha (set alpha to 0 to hide the shadow)
				offset		= {1, -1},		--x, y
			},
		},
		flash = {
			--There's actually 2 textures for flash
			--One is that blue flash that takes up most of the tab
			--The 2nd is that orange glow at the bottom
			texture 	= false,	--Enable/Disable flash texture
			glow 		= false, 	--Enable/disable glow
			text 		= true,  	--Whether to use the flash color below			
		},		
		color = {
			--The color logic is:
			--(current|default)->Hover->Flash->Normal
			--Format: {r, g, b, alpha, outlined}
			--RGB values are between 0 and 1
			default = { --Non selected frame
				normal 	= {1, 1, 1, 0, true},
				hover 	= {1, 1, 1, 1, true},
				flash 	= {1, 0, 0, 0.5, true}, --Won't be used if config.tabs.flash.text is set to false
			},
			current = { --Selected frame
				normal 	= {0, 0.8, 1, 0, true},
				hover 	= {0, 0.8, 1, 1, true},
				flash 	= {1, 0, 0, 0.5, true}, --Really this should never be used, as tabs dont flash if u have them selected.
			},
		},
	},
	url = {
		enabled 		= true,
		color 			= {1, 1, 85/255}, --Setting to false will not color them
	},
	copychat = {
		enabled 		= false,
		showbutton 		= false, 		--Automatically shown if timestamps are hidden and copychat is enabled
	},
	timestamps = {
		enabled 		= true,			--Enable/Disable timestamp module.  Disabling doesnt hide the blizzard timestamps.
		custom			= false, 		--Allows a custom timestamp format.  Setting the timestamps in interface options will override this.
										--Set to false to use option set in Interface options.
		seperator		= '| ',			--Seperator between timestamp and text (ie. 12:00:00| text)
		color			= {1, 1, 1}, 	--Setting to false will not color them
	},
	battlenet = { --more config options soon to come.
		enabled 		= true,			--Enable/Disable module, this only disables options set below.
		color   		= {0, 1, 0},	--Battlenet names, setting this to false will not color them
	},
	formats = {
		seperator		= false, 	--Replaces the colon between the channel+player and message.  Any string will work
									--ie. If the replacement string was '>'
									--[G] Player: message => [G] Player> message
									--When false it reverts to ':'
		brackets = {
			name 		= false,	--Enable/disable name brackets
			channel 	= false,		--Enable/disable channel brackets
			url 		= false,		--Enable/disable url brackets
		},
	},			
	stickyChannels = {
		['say'] 				= true,
		['yell'] 				= false,
		['party'] 				= true,
		['guild'] 				= true,
		['officer'] 			= true,
		['raid'] 				= true,
		['raid_warning'] 		= false,
		['battleground'] 		= true,
		['whisper'] 			= false,
		['bn_whisper'] 			= true,
		['bn_conversation'] 	= true,
		['channel'] 			= true,
	},
	replaces = {
		--Setting any of these to false will revert them to their original form
		['say'] 				= 'S',
		['yell'] 				= 'Y',
		['party'] 				= 'P',
		['party_leader'] 		= 'PL',
		['party_guide'] 		= 'DG',
		['guild'] 				= 'G',
		['officer'] 			= 'O',
		['raid'] 				= 'R',
		['raid_leader'] 		= 'RL',
		['raid_warning'] 		= 'RW',
		['battleground'] 		= 'BG',
		['battleground_leader'] = 'BL',
		['whisper'] 			= 'W From', --Incoming tells	
		['whisper_inform'] 		= 'W To', 	--Outgoing tells
		['channel'] 			= '#', 		--# is replaced by the channel number
		['bn_whisper'] 			= 'BW From',
		['bn_whisper_inform'] 	= 'BW To',		
		['bn_conversation'] 	= 'BN:#', 
		--For Battnet conversations:
		--# = The channel number
		--? = The conversation number
		--Example: [11. Conversation][Name]: Text
		--With brackets on channel and no brackets on name
		--format: 'BN:#' = [BN:11] Name: Text
		--format: 'BN-?' = [BN-1] Name: Text
	},
	colorByClass = {
		['say'] 				= true,
		['emote'] 				= true,
		['yell'] 				= true,
		['guild'] 				= true,
		['guild_officer'] 		= true,
		['guild_achievement'] 	= true,
		['achievement'] 		= true,
		['whisper'] 			= true,
		['party'] 				= true,
		['party_leader'] 		= true,
		['raid'] 				= true,
		['raid_leader'] 		= true,
		['raid_warning'] 		= true,
		['battleground'] 		= true,
		['battleground_leader'] = true,
		['channel'] 			= true,
	},
}