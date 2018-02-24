--[[--------------------------------------------------
003_Alliance_30to40.lua
Authors: mrmr
Version: 1.04.2
------------------------------------------------------
Description: Guide Serie - 003 From Lvl 30 to Lvl 40
    1.04.1
        -- First Release
            Alliance's Guide
            from level 30 to lever 40
    1.04.2
    	-- no changes in here for this revision
------------------------------------------------------
Connection:
--]]--------------------------------------------------

Table_003_Alliance_30to40 = {
-----------30-31 Hillsbrad Foothills
	--[301] = {
	[3031] = {
		title = "30-31 Hillsbrad Foothills",
		--n = "30-31 Hillsbrad Foothills",
		--pID = 210, nID = 302,
		--itemCount = 13,
		items = {
			[1] = { str = "30-31 Hillsbrad Foothills" },
			[2] = { str = "Run into southshore at 49,52 and grab the FP", x = 49, y = 52, zone = "Hillsbrad Foothills" },
			[3] = { str = "Stop at the barn east of the FP, accept Costly Menace" },
			[4] = { str = "Go to the house in front of the barn, turn in  Southshore  SKIP the next part " },
			[5] = { str = "Go in front of the Inn, accept Hints of a New Plague " },
			[6] = { str = "Go in the Inn, make it your home, then accept  Down the Coast ." },
			[7] = { str = "In front of the town hall, accept  Crushridge Bounty  " },
			[8] = { str = "Go in the town hall, accept Syndicate Assassins" },
			[9] = { str = "Go just SW of Southshore and do  Down the Coast  on the shore, killing murlocs. Turn it in at the Inn when you’re done, accept  Farren's Proof pt.1" },
			[10] = { str = "Do  Farren's Proof pt.1  again on the shore, if I’m not 31 by the time I’m done getting heads, I grind till I am." },
			[11] = { str = "Go back to the Inn, turn in  Farren's Proof pt.1  accept  Farren’s Proof pt.2  hand that in just out front of the Inn, accept  Farren’s Proof pt.3  Go back into the Inn, hand it in accept Stormwind ho! " },
			[12] = { str = "Go do Stormwind ho!  just SE of the dock now, kill the naga along the shore." },
			[13] = { str = "Go back to the Inn hand in Stormwind ho! , accept  Reassignment " },
		}
	},

-----------31-31 Alterac Mountains
	--[302] = {
	[3131] = {
		title = "31-31 Alterac Mountains",
		--n = "31-31 Alterac Mountains",
		--pID = 301, nID = 303,
		--itemCount = 8,
		items = {
			[1] = { str = "31-31 Alterac Mountains" },
			[2] = { str = "Run up into Alterac Mountains near the AV entrance around 64,38 and kill lions for Costly Menace They’re all along the southern border near AV. I usually get all mine in front and West of AV", x = 64, y = 38, zone = "Alterac Mountains" },
			[3] = { str = "Go east of AV and do  Syndicate Assassins  at the camp around 55,67. There is a camp close to AV but this one has a quest you can grab near the tents on the table. Clear the camp and touch the syndicate document, accept  Foreboding Plans  and  Encrypted Letter", x = 55, y = 67, zone = "Alterac Mountains" },
			[4] = { str = "Hearth to Southshore" },
			[5] = { str = "Go into the town hall, turn in  Syndicate Assassins  and  Foreboding Plans  accept  Noble Deaths " },
			[6] = { str = "Stop at the house North of the Inn, turn in  Encrypted Letter  accept  Letter to Stormpike" },
			[7] = { str = "Go to the barn and turn in  Costly Menace" },
			[8] = { str = "Fly to Refuge Point" },
		}
	},

-----------31-32 Arathi Highlands
	--[303] = {
	[3132] = {
		title = "31-32 Arathi Highlands",
		--n = "31-32 Arathi Highlands",
		--pID = 302, nID = 304,
		--itemCount = 10,
		items = {
			[1] = { str = "31-32 Arathi Highlands" },
			[2] = { str = "Accept  Northfold Manor  grind to it at 33,27 I grind here until I’m 32", x = 33, y = 27, zone = "Arathi Highlands" },
			[3] = { str = "Hearth to Southshore, Fly to Refuge point, turn in  Northfold Manor  Fly to IF" },
			[4] = { str = "Go to the hall of explorers at 69,20 in IF accept  Reclaimers' Business in Desolace  then go turn in  Letter to Stormpike  accept  Further Mysteries ", x = 69, y = 20, zone = "Arathi Highlands" },
			[5] = { str = "Accept  The Brassbolts Brothers  in The Hall of Arms at 72,93 then get new Skills", x = 72, y = 93, zone = "Arathi Highlands" },
			[6] = { str = "Make IF your home at 18,51 Buy some Bloodstone Ore for a quest later in STV. If there is none check the AH in Booty Bay", x = 18, y = 51, zone = "Arathi Highlands" },
			[7] = { str = "Fly to SW" },
			[8] = { str = "Go to the Keep at 72,15 and hand in  Reassignment", x = 72, y = 15, zone = "Stormwind City" },
			[9] = { str = "Go to 39,27 in the Cathedral and hand in  Cleansing the Eye", x = 39, y = 27, zone = "Stormwind City" },
			[10] = { str = "Fly to Duskwood, then run to 44,66 and go south into STV", x = 44, y = 66, zone = "Duskwood" }
		}
	},

-----------32-32 Stranglethorn Vale
	--[304] = {
	[3232] = {
		title = "32-32 Stranglethorn Vale",
		--n = "32-32 Stranglethorn Vale",
		--pID = 303, nID = 305,
		--itemCount = 19,
		items = {
			[1] = { str = "32-32 Stranglethorn Vale" },
			[2] = { str = "Run to the Rebel Camp at 37,3 its just west after you enter.", x = 37, y = 3, zone = "Stranglethorn Vale" },
			[3] = { str = "Accept  The Second Rebellion  and  Bad Medicine" },
			[4] = { str = "Then Accept  Krazek's Cookery" },
			[5] = { str = "Go to Nessingway’s at 35,10 and accept  Welcome to the Jungle  then turn it in behind you. This opens the 3 quest givers here.", x = 35, y = 10, zone = "Stranglethorn Vale" },
			[6] = { str = "Now Accept  Raptor Mastery pt.1   Panther Mastery pt.1   Tiger Mastery pt.1  Don’t accept the page-collecting quest until you have all the pages." },
			[7] = { str = "Do  Panther Mastery pt.1  &  Tiger Mastery pt.1  Tigers are just behind Nessingway’s, and the Panthers are to the east some but centralized around 41,9", x = 41, y = 9, zone = "Stranglethorn Vale" },
			[8] = { str = "Go to 44,10 and do  The Second Rebellion  and the Kurzen supply crate at 44,9 in front of the Inn for  Bad Medicine  the remedies are a low drop from medicine men.", x = 44, y = 10, zone = "Stranglethorn Vale" },
			[9] = { str = "Run back up to the rebel camp at 37,3 Turn in  The Second Rebellion  and  Bad Medicine  SKIP  Special Forces.", x = 37, y = 3, zone = "Stranglethorn Vale" },
			[10] = { str = "Go back to Nessingway’s at 35,10 and hand in  Panther Mastery pt.1  &  Tiger Mastery pt.1  accept  Panther Mastery pt.2  &  Tiger Mastery pt.2.", x = 35, y = 10, zone = "Stranglethorn Vale" },
			[11] = { str = "Kill Stranglethorn Tigers for around 29,10 for  Tiger Mastery pt.2 and the Panthers around 28,12 for  Panther Mastery pt.2.", x = 29, y = 10, zone = "Stranglethorn Vale" },
			[12] = { str = "Kill Stranglethorn Raptors for 26,15  Raptor Mastery pt.1", x = 26, y = 15, zone = "Stranglethorn Vale" },
			[13] = { str = "Go back to Nessingway’s at 35,10 and turn in  Tiger Mastery pt.2 ,  Panther Mastery pt.2 , and  Raptor Mastery pt.1 . Accept  Tiger Mastery pt.3 ,  Panther Mastery pt.3  and  Raptor Mastery pt.2 ", x = 35, y = 10, zone = "Stranglethorn Vale" },
			[14] = { str = "Run to Booty Bay and get the FP." },
			[15] = { str = "Turn in  Krazek's Cookery  on the top floor of the inn, accept and hand back in (the bloodstone ores)  Favor for Krazek  then accept  Return to Corporal Kaleb  (this quest gives you your first helm) also accept  Investigate the Camp  and  Supplies to Private Thorsen " },
			[16] = { str = "Get on the Boat to Rachet" },
			[17] = { str = "Grab the FP" },
			[18] = { str = "Now for a little bit of a run through horde territory. Run all the way south in the barrens to the great lift and take it down into 1k needles. Jump off if you get attacked." },
			[19] = { str = "Run all the way south in the barrens to the great lift and take it down into 1k needles. Jump off if you get attacked." },
		}
	},

-----------32-33 Thousand Needles (Shimmering Flats)
	--[305] = {
	[3233] = {
		title = "32-33 Thousand Needles (Shimmering Flats)",
		--n = "32-33 Thousand Needles (Shimmering Flats)",		
		--pID = 304, nID = 306,
		--itemCount = 19,
		items = {
			[1] = { str = "32-33 Thousand Needles (Shimmering Flats)" },
			[2] = { str = "Now Get the FP on the west side of this zone at 8,18, it’s just inside Feralas. This will save a lot of time later on.", x = 8, y = 18, zone = "Thousand Needles" },
			[3] = { str = "You should be close to level 33 so grind to it on your way to Shimmering Flats." },
			[4] = { str = "Go to 78,77 and turn in  The Brassbolts Brothers  accept  Hardened Shells  and  Salt Flat Venom ", x = 78, y = 77, zone = "Thousand Needles" },
			[5] = { str = "Go a little beside these guys and grab  Rocket Car Parts ,  Wharfmaster Dizzywig  and  Hemet Nesingwary" },
			[6] = { str = "Go east to 80,75 and accept  Load Lightening", x = 80, y = 75, zone = "Thousand Needles" },
			[7] = { str = "Go to 81,77 and accept  A Bump in the Road ", x = 81, y = 77, zone = "Thousand Needles" },
			[8] = { str = "Now the car parts for  Rocket Car Parts  are scattered all over here, so grab them as you quest. The Buzzards for  Load Lightening  are all over as well so kill one if you see it." },
			[9] = { str = "Start off by going south and killing gazers and crystalhide at 76,87 for  A Bump in the Road ", x = 76, y = 87, zone = "Thousand Needles" },
			[10] = { str = "Kill scorpions at 71,74 and north of here for  Salt Flat Venom ", x = 71, y = 74, zone = "Thousand Needles" },
			[11] = { str = "Kill Basilisks around 73,59 for  A Bump in the Road", x = 73, y = 59, zone = "Thousand Needles" },
			[12] = { str = "Kill Turtles at 82,54 for  Hardened Shells", x = 82, y = 54, zone = "Thousand Needles" },
			[13] = { str = "Stop at 86,66 and do  Load Lightening", x = 86, y = 66, zone = "Thousand Needles" },
			[14] = { str = "Run back to 77,77 turn in  Rocket Car Parts", x = 77, y = 77, zone = "Thousand Needles" },
			[15] = { str = "Go to the 2 npc’s next east of here and hand in  Salt Flat Venom  and  Hardened Shells  then accept  Martek the Exiled" },
			[16] = { str = "Run east to 80,75 turn in  Load Lightening  accept  Goblin Sponsorship pt.1", x = 80, y = 75, zone = "Thousand Needles" },
			[17] = { str = "Go to 81,77 and turn in  A Bump in the Road", x = 81, y = 77, zone = "Thousand Needles" },
			[18] = { str = "Run south into Tanaris and Grab the FP at Gadgetzan" },
			[19] = { str = "Hearth back to IF and fly to Menethil Harbor, get on the boat to Theramore, Get FP and either fly to Stonetalon Mountains or go back and reboat to Darkshore." },
		}
	},

-----------33-33 Stonetalon Mountains
	--[306] = {
	[3333] = {
		title = "33-33 Stonetalon Mountains",
		--n = "33-33 Stonetalon Mountains",
		--pID = 305, nID = 307,
		--itemCount = 2,
		items = {
			[1] = { str = "33-33 Stonetalon Mountains" },
			[2] = { str = "Accept  Reclaiming the Charred Vale  in front of the moonwell then go do it in the Charred Vale at 32,66 while going towards Desolace ", x = 32, y = 66, zone = "Stonetalon Mountains" },
		}
	},

-----------33-35 Desolace
	--[307] = {
	[3335] = {
		title = "33-35 Desolace",
		--n = "33-35 Desolace",
		--pID = 306, nID = 308,
		--itemCount = 38,
		items = {
			[1] = { str = "33-35 Desolace" },
			[2] = { str = "Make Nijel’s Point your home then fly back to Stonetalon and hand in  Reclaiming the Charred Vale  SKIP the next part." },
			[3] = { str = "Hearth back to Desolace" },
			[4] = { str = "Go south of the Inn, hand in  Reclaimers' Business in Desolace  accept  Reagents for Reclaimers Inc pt.1  and  The Karnitol Shipwreck pt.1 " },
			[5] = { str = "I SKIP both of the faction centaur quests. It’s just a useless grind for 2 quests that aren’t worth it." },
			[6] = { str = "Accept  Centaur Bounty" },
			[7] = { str = "Go south a little bit more and accept  Vahlarriel's Search pt.1" },
			[8] = { str = "Run west to 56,17  Vahlarriel's Search pt.1  accept  Vahlarriel’s Search pt.2", x = 56, y = 17, zone = "Desolace" },
			[9] = { str = "Run east to Sargeron around 75,20 and kill the demons for  Reagents for Reclaimers Inc pt.1", x = 75, y = 20, zone = "Desolace" },
			[10] = { str = "Run back to Nijel’s, hand in  Vahlarriel’s Search pt.2  accept  Vahlarriel’s Search pt.3" },
			[11] = { str = "Run up a bit more, turn in  Reagents for Reclaimers Inc pt.1  accept  Reagents for Reclaimers Inc pt.2" },
			[12] = { str = "Now start grinding on the scorps and other stuff for  Reagents for Reclaimers Inc pt.2  as you head to 62,38 and accept  Bone Collector  since the scorps are a low drop rate just kill them as you’re running around", x = 62, y = 38, zone = "Desolace" },
			[13] = { str = "Run east until you’re at kolkar village around 72,45. Kill them for  Centaur Bounty  If you’re not 34 when done with this, grind until you are", x = 72, y = 45, zone = "Desolace" },
			[14] = { str = "Grind down to 60,61 and accept  Kodo Roundup  This is a unique quest where you tame a kodo at the GY then bring it back until you have 5.", x = 60, y = 61, zone = "Desolace" },
			[15] = { str = "If you see the pack of aged kodo’s running around kill 3 of them for  Reagents for Reclaimers Inc pt.2  if not you can find some inside the kodo graveyard." },
			[16] = { str = "Go to the Kodo Graveyard around 51,58. Do  Bone Collector  everytime you come to pick up a kodo for roundup.", x = 51, y = 58, zone = "Desolace" },
			[17] = { str = "Once you’re done with  Kodo Roundup  hand it in and run NW of the GY towards the water. Killing scorps if you still need them." },
			[18] = { str = "Grab  Sceptre of Light  at 38,27 near the big tower", x = 38, y = 27, zone = "Desolace" },
			[19] = { str = "Go south on the beach to 36,30 and finish  The Karnitol Shipwreck pt.1  accept  The Karnitol Shipwreck pt.2  then accept  Claim Rackmore's Treasure!  from Rackmore’s log. If your quest log is full drop centaur bounty.", x = 36, y = 30, zone = "Desolace" },
			[20] = { str = "Kill Drysnaps in the waters right here for the silver key of  Claim Rackmore's Treasure!  and The Slitherblades just North of here for the golden key." },
			[21] = { str = "Run up to Thunder Axe Fortress at 56,29 and go in the main building in the center and turn in  Vahlarriel’s Search pt.3  at 54,26 accept  Search for Tyranis", x = 54, y = 26, zone = "Desolace" },
			[22] = { str = "Run out and right, kill a seer up in a tower for  Sceptre of Light" },
			[23] = { str = "Go to the building west of the entrance at 53,29 kill Tyranis Malem for  Search for Tyranis  then turn it back in inside the main building. Clear the way in the main building to the right because an escort is next.", x = 53, y = 29, zone = "Desolace" },
			[24] = { str = "Accept the escort quest  Return to Vahlarriel  DON’T attack anything unless it hits or or she’ll ignore it and keep walking. The reason it seems is melee just follow her, only the mages can hit her to start combat." },
			[25] = { str = "Go to 62,38 and turn in  Bone Collector", x = 62, y = 38, zone = "Desolace" },
			[26] = { str = "Run back to 38,27 and turn in  Sceptre of Light  accept  Book of the Ancients", x = 38, y = 27, zone = "Desolace" },
			[27] = { str = "Swim all the way NW on the map to Ranazjar Isle and open the chest at 30,9 for  Claim Rackmore's Treasure!", x = 30, y = 9, zone = "Desolace" },
			[28] = { str = "Go to the back of the island and clear all around the serpent statue at 28,7. You’re gonna do  Book of the Ancients  This quest bugs if you do not click the gem in your inventory and then on the statue. Don’t just click on the statue. He’s 38 but super easy.", x = 28, y = 7, zone = "Desolace" },
			[29] = { str = "Swim back to 38,27 and turn in  Book of the Ancients", x = 38, y = 27, zone = "Desolace" },
			[30] = { str = "Hearth to Nijel’s" },
			[31] = { str = "Go south of the Inn and turn in  Reagents for Reclaimers Inc pt.2  SKIP pt.3 for now, and  The Karnitol Shipwreck pt.2  SKIP the rest." },
			[32] = { str = "Go south a bit more, turn in  Centaur Bounty " },
			[33] = { str = "Finally turn in  Return to Vahlarriel" },
			[34] = { str = "You should be within 2 bars to 35 now. I grind down on the Centaurs at Gelkis Village at 37,80 until 35", x = 37, y = 80, zone = "Desolace" },
			[35] = { str = "Head south into Feralas to get the FP, this will again save more time later on." },
			[36] = { str = "Get on the Boat at 43,42 and grab the FP in Feathermoon. Fly to Theramore, then to Rachet.", x = 43, y = 42, zone = "Desolace" },
			[37] = { str = "Go to the engineer hut at 62,36 and hand in  Goblin Sponsorship pt.1  accept  Goblin Sponsorship pt.2  Then run out on the dock and hand in  Wharfmaster Dizzywig  accept  Parts for Kravel ", x = 62, y = 36, zone = "Desolace" },
			[38] = { str = "Get on the boat to Booty Bay" },
		}
	},

-----------35-36 Stranglethorn Vale
	--[308] = {
	[3536] = {
		title = "35-36 Stranglethorn Vale",
		--n = "35-36 Stranglethorn Vale",
		--pID = 307, nID = 309,
		--itemCount = 38,
		items = {
			[1] = { str = "35-36 Stranglethorn Vale" },
			[2] = { str = "Hand in  Goblin Sponsorship pt.2  as you get off the boat, accept  Goblin Sponsorship pt.3" },
			[3] = { str = "Go in the Inn make BB your home, Accept  Singing Blue Shards" },
			[4] = { str = "Accept  Hostile Takeover  and  Bloodscalp Ears" },
			[5] = { str = "Accept  The Haunted Isle  and turn it in just outside the door, accept  The Stone of the Tides  Then turn in  Goblin Sponsorship pt.3  accept  Goblin Sponsorship pt.4 " },
			[6] = { str = "Go into the shop Tan-Your-Hide Leatherworks and accept  Supply and Demand  (it’s down the ramp from the FP)" },
			[7] = { str = "Go around 48,21 and Kill Shadowmaw Panthers for  Panther Mastery pt.3", x = 48, y = 21, zone = "Stranglethorn Vale" },
			[8] = { str = "Run west to the Venture Co. Base Camp at 43,18 and Kill the goblins here for  Hostile Takeover  while you climb the Operations Tower behind the base for  Goblin Sponsorship pt.4  You’re going to climb it and kill Foreman Cozzle for his key.", x = 43, y = 18, zone = "Stranglethorn Vale" },
			[9] = { str = "If you still don’t have all the crystals kill the goblins until you do, then enter the tiny shack next to the base at 43,20 and open the chest to get the blueprints for  Goblin Sponsorship pt.4", x = 43, y = 20, zone = "Stranglethorn Vale" },
			[10] = { str = "Kill Lashtail Raptors around 37,22 for  Raptor Mastery pt.2", x = 37, y = 22, zone = "Stranglethorn Vale" },
			[11] = { str = "Kill Elter Tigers around 33,18 for  Tiger Mastery pt.3 ", x = 33, y = 18, zone = "Stranglethorn Vale" },
			[12] = { str = "Run towards Nessingways and kill the crocs in the river around it for  Supply and Demand" },
			[13] = { str = "Go to Nessingways and turn in  Tiger Mastery pt.3 ,  Panther Mastery pt.3 ,  Raptor Mastery pt.2 , and  Hemet Nesingwary , Accept  Tiger Mastery pt.4   Panther Mastery pt.4  and   Raptor Mastery pt.3 " },
			[14] = { str = "Run back south to the top of the hill at 32,17 and kill Sin’Dall for  Tiger Mastery pt.4  then turn it back in at Nessingways", x = 32, y = 17, zone = "Stranglethorn Vale" },
			[15] = { str = "Go up to the rebel camp at 37,3 and hand in  Supplies to Private Thorsen , If he’s not here look south of the camp, if you save him when he patrols you can also get  Jungle Secrets  then u turn that in at the camp and get  Bookie Herod ", x = 37, y = 3, zone = "Stranglethorn Vale" },
			[16] = { str = "Hand in  Return to Corporal Kaleb  get your helm" },
			[17] = { str = "Accept  Special Forces " },
			[18] = { str = "Go to the Inn looking building at 43,9 touch the book on the 2nd floor and hand in  Bookie Herod  accept  The Hidden Key ", x = 43, y = 9, zone = "Stranglethorn Vale" },
			[19] = { str = "Go in the cave at 45,7 and kill the mobs in here for  Special Forces  and make your way to the chest for  Bookie Herod , it’s down the first fork, only 1 level down then in the boxes. Accept  The Spy Revealed!  (Easy from here)", x = 45, y = 7, zone = "Stranglethorn Vale" },
			[20] = { str = "Now grind back out since you should be close to 36. Once your out go back to the rebel camp." },
			[21] = { str = "Hand in  Special Forces  SKIP the next part" },
			[22] = { str = "Hand in  The Spy Revealed!  accept  Patrol Schedules  turn around and hand that in and accept  Report to Doren  then turn around again and hand that back in (told you it was easy)" },
			[23] = { str = "You should definitely be 36 by now. We’ll get skills soon" },
			[24] = { str = "Go south toward the GY, then go west north of the river and kill basalisks for  Singing Blue Shards  if you don’t get them all now don’t worry there is more south." },
			[25] = { str = "Kill Bloodscalp at 29,19 for  Bloodscalp Ears  You’ll probably have to clear it 2-3 times. They’re easy", x = 29, y = 19, zone = "Stranglethorn Vale" },
			[26] = { str = "Kill Basalisks to finish  Singing Blue Shards  just west of here above the shore." },
			[27] = { str = "Run south on the Island till it says complete for  The Stone of the Tides  Go back up and kill basalisks if needed." },
			[28] = { str = "Hearth to BB" },
			[29] = { str = "Turn in  Singing Blue Shards  SKIP the next for now" },
			[30] = { str = "Go upstairs turn in  Investigate the Camp ,  Bloodscalp Ears" },
			[31] = { str = "Go just outside, turn in  The Stone of the Tides  and  Goblin Sponsorship pt.4  Accept  Water Elementals  and  Goblin Sponsorship pt.5 " },
			[32] = { str = "Go into the shop Tan-Your-Hide Leatherworks and turn in  Supply and Demand  (it’s down the ramp from the FP) accept  Some assembly required " },
			[33] = { str = "I’m half way to 37 at this point" },
			[34] = { str = "Fly to IF get new skills then fly to Menethil Harbor, make it your home, and boat to Theramore" },
			[35] = { str = "If you’re first aid is at 225 go do  Triage  then fly to Gadgetzan" },
			[36] = { str = "Run out to Shimmering Flats at 77,77 and turn in  Parts for Kravel  accept  Delivery to the Gnomes  then turn around and hand it in", x = 77, y = 77, zone = "Stranglethorn Vale" },
			[37] = { str = "Go a little East and hand in  Goblin Sponsorship pt.5  accept  The Eighteenth Pilot  then hand it in 2 feet away, accept  Razzeric's Tweaking" },
			[38] = { str = "Grab  The Rumormonger  at 77,77 then Hearth to Menethil Harbor", x = 77, y = 77, zone = "Stranglethorn Vale" },
		}
	},

-----------36-37 Alterac Mountains
 	--[309] = {
 	[3637] = {
		title = "36-37 Alterac Mountains",
		--n = "36-37 Alterac Mountains",
		--pID = 308, nID = 310,
		--itemCount = 10,
		items = {
			[1] = { str = "36-37 Alterac Mountains" },
			[2] = { str = "Go to the Town Hall and turn in  Further Mysteries  accept  Dark Council  and  Noble Deaths" },
			[3] = { str = "Make Southshore your home" },
			[4] = { str = "Run into Alterac Mountains to 47,55 and kill ogres for  Crushridge Bounty", x = 47, y = 55, zone = "Alterac Mountains" },
			[5] = { str = "Grind up to Strahnbrad around 60,43 and kill the syndicate and grab their rings for  Noble Deaths  You can also kill shadow mages here for  Dark Council   which is easier than killing them in the camps later", x = 60, y = 43, zone = "Alterac Mountains" },
			[6] = { str = "Grind your way west to to the house at 39,16 and kill Nagaz for  Dark Council . I take out the first camp you come across then grind anything in my way west that’s not in a camp. ", x = 39, y = 16, zone = "Alterac Mountains" },
			[7] = { str = "You wanna be at least 2 bars from 37, if so hearth to SS" },
			[8] = { str = "Run across from the Inn, turn in  Crushridge Bounty  SKIP the next" },
			[9] = { str = "Go in the Inn, turn in  Dark Council  and  Noble Deaths" },
			[10] = { str = "Fly to Arathi Highlands" },
		}
	},

-----------37-38 Arathi Highlands
	--[310] = {
	[3738] = {
	    title = "37-38 Arathi Highlands",
	    --n = "37-38 Arathi Highlands",
	    --pID = 309, nID = 311,
	    --itemCount = 28,
	    items = {
			[1] = { str = "37-38 Arathi Highlands" },
			[2] = { str = "Accept  Worth Its Weight In Gold" },
			[3] = { str = "Run to 62,33 touch the crystal and accept  The Princess Trapped", x = 62, y = 33, zone = "Arathi Highlands" },
			[4] = { str = "Go just east of Hammerfall to 80,40. (Load up on bloodstone ore here, you can sell it for a few g per 4 in BB) This is a tree, behind it is the path up to the cave to kill kobolds for  The Princess Trapped  If you get them all before the end of the cave you have to continue to the end to hand it in by touching Iridescent Shards and accept  Stones of Binding ", x = 80, y = 40, zone = "Arathi Highlands" },
			[5] = { str = "You should be just about ¼ through this level when you exit the cave." },
			[6] = { str = "Go to the circle of east binding, just west of Hammerfall at 80,36 and grab the cresting key from the rock.", x = 80, y = 36, zone = "Arathi Highlands" },
			[7] = { str = "Stop at 60,53 and hand in  Hints of a New Plague? Pt.1  accept  Hints of a New Plague? Pt.2  If you see the courier kill him. Simply send your pet in get aggro, when he’s hurt some multi shot some off of him. He’s easy, just feign and let pet die once courier is dead. The courier walks between refuge and tarren mill.", x = 60, y = 53, zone = "Arathi Highlands" },
			[8] = { str = "Kill the trolls all around the lake at 67,69 for  Worth Its Weight In Gold  you can get tusks and medicine bags off the guys here, to get the dagger you have to kill Shadow Hunters in the cave at 68,74", x = 68, y = 74, zone = "Arathi Highlands" },
			[9] = { str = "Go to the circle of outer binding at 52,50 and grab the thundering key from the rock.", x = 52, y = 50, zone = "Arathi Highlands" },
			[10] = { str = "Go to refuge point and hand in  Worth Its Weight In Gold  this opens up  Wand Over Fist  from another NPC" },
			[11] = { str = "Go do  Wand Over Fist  by killing Coldrage in the cave at 53,77 (follow the left path) run back to Refuge hand it in, SKIP the rest", x = 53, y = 77, zone = "Arathi Highlands" },
			[12] = { str = "Go to the circle of west binding at 25,30 and grab the burning key from the rock.", x = 25, y = 30, zone = "Arathi Highlands" },
			[13] = { str = "I found the courier at this point on the road (varies since he travels)" },
			[14] = { str = "Go to the circle of inner binding at 36,57 and turn in  Stones of Binding  on the rock, SKIP the rest.", x = 36, y = 57, zone = "Arathi Highlands" },
			[15] = { str = "Run SW of here, there is a path that leads behind Stromgarde at 31,64 follow it around to the cave path at 21,75", x = 31, y = 64, zone = "Arathi Highlands" },
			[16] = { str = "Swim over to the ship and accept  Land HO!  then turn around and hand it in." },
			[17] = { str = "Accept  Deep Sea Salvage" },
			[18] = { str = "Go by the fire accept  Drowned Sorrows  and  Sunken Treasure pt.1 " },
			[19] = { str = "Do  Sunken Treasure pt.1  by escorting him right behind you in the cave. Turn it in, accept  Sunken Treasure pt.2" },
			[20] = { str = "Go down south near the sunken ships, around 24,84 and do  Sunken Treasure pt.2  (use goggles to find them easy),  Drowned Sorrows  (nagas), and  Deep Sea Salvage  (2 on each ship)", x = 24, y = 84, zone = "Arathi Highlands" },
			[21] = { str = "Turn in  Deep Sea Salvage  on the dock" },
			[22] = { str = "Turn in  Drowned Sorrows  next to the fire, then   Sunken Treasure pt.2  accept  Sunken Treasure pt.3" },
			[23] = { str = "Hand that in on the dock accept  Sunken Treasure pt.4" },
			[24] = { str = "Run back towards Go’Shek Farm, if you haven’t found the courier yet abandon quest and hearth to SS. If so go to 60,53 and hand in  Hints of a New Plague? Pt.2  accept  Hints of a New Plague? Pt.3  then turn it right back in accept  Hints of a New Plague? Pt.4", x = 60, y = 53, zone = "Arathi Highlands" },
			[25] = { str = "Escort her when done turn it back in  and accept “Hints of a New Plague? Pt.5” Grind until youre 3500 to 38" },
			[26] = { str = "Hearth to Southshore" },
			[27] = { str = "Turn in “Hints of a New Plague? Pt.5” just outside the Inn" },
			[28] = { str = "Fly to Stormwind for new skills and get the quest Morgan Stern from Angus Stern at 41 89, then fly to Menethil and boat to Theramore", x = 41, y = 89, zone = "Stormwind" },
		}
	},

-----------38-38 Dustwallow Marsh
	--[311] = {
	[3838] = {
		title = "38-38 Dustwallow Marsh",
		--n = "38-38 Dustwallow Marsh",
		--pID = 310, nID = 312,
		--itemCount = 30,
		items = {
			[1] = { str = "38-38 Dustwallow Marsh" },
			[2] = { str = "Run up near the Inn, accept “They Call Him Smiling Jim”" },
			[3] = { str = "Go in the Inn, accept “Mudrock Soup and Bugs” and make Theramore your home. " },
			[4] = { str = "Go to the 2nd floor of the castle behind the Inn, not the tower, turn in “They Call Him Smiling Jim” This gives you hints about some quests at the old Inn near the Barrens." },
			[5] = { str = "Buy 3 soothing spices from the trade supplies person in the houst at 66,51 (for upcoming quest) ", x = 66, y = 51, zone = "Dustwallow Marsh" },
			[6] = { str = "Just as you exit Theramore, go right and kill Mudrock turtles along the shore for “Mudrock Soup and Bugs”" },
			[7] = { str = "Go to the house at 55,26 and accept “Soothing Spices” then turn it right back in, accept “Jarl Needs eyes”", x = 55, y = 26, zone = "Dustwallow Marsh" },
			[8] = { str = "Touch the mound of dirt beside the house, accept “The Orc Report”" },
			[9] = { str = "Run over to Darkmist Cavern at 32,23 and kill spiders inside and outside for “Jarl Needs eyes” They drop 1-2 every kill", x = 32, y = 23, zone = "Dustwallow Marsh" },
			[10] = { str = "Stop at 35,38 and grab “Hungry!”", x = 35, y = 38, zone = "Dustwallow Marsh" },
			[11] = { str = "Go to 29,47, the shady rest inn, and grab these 3 quests, touch the hoofrints just out front “Suspicious Hoofprints” the badge on the board laying on the floorboards (it’s a tiny badge) “Lieutenant Paval Reethe pt.1” and the shield over the fireplace “The Black Shield pt.1” ", x = 29, y = 47, zone = "Dustwallow Marsh" },
			[12] = { str = "Run over to 54,56 and open the shipping crate for “Razzeric's Tweaking”", x = 54, y = 56, zone = "Dustwallow Marsh" },
			[13] = { str = "Hearth to Theramore" },
			[14] = { str = "Turn in “Mudrock Soup and Bugs” in front of you, accept “… and bugs” " },
			[15] = { str = "Go to the docks at the tower and turn in “The Orc Report” accept “Captain Vimes” Run in the castle behind the Inn and turn it in" },
			[16] = { str = "Turn in “Lieutenant Paval Reethe pt.1” accept “Lieutenant Paval Reethe pt.2” " },
			[17] = { str = " Turn in “The Black Shield pt.1” accept “The Black Shield pt.2” " },
			[18] = { str = "Turn in “Suspicious Hoofprints” accept " },
			[19] = { str = "Turn around and hand in “Lieutenant Paval Reethe pt.2” accept “Daelin's Men” then turn around hand it in accept “The Deserters pt.1”" },
			[20] = { str = "Go to the blacksmith house, turn in “The Black Shield pt.2” accept “The Black Shield pt.3” go turn it in back up in the castle" },
			[21] = { str = " Run out to 55,26 and turn in “Jarl Needs eyes” SKIP the next", x = 55, y = 26, zone = "Dustwallow Marsh" },
			[22] = { str = "Go just NE of here and kill murlocs for “Hungry!”" },
			[23] = { str = "Stop at 46,17 and clear some raptors until you’re 50% or more into 39, then accept “Stinky's Escape” just follow him, and kill what attacks him. Really easy.", x = 46, y = 17, zone = "Dustwallow Marsh" },
			[24] = { str = "Stop at 35,38 turn in “Hungry!”", x = 35, y = 38, zone = "Dustwallow Marsh" },
			[25] = { str = "Go to the tower at 35,53 and attack Balos Jacken, at ¼ life he’ll become friendly and then turn in “The Deserters pt.1” accept “The Deserters pt.2” ", x = 35, y = 53, zone = "Dustwallow Marsh" },
			[26] = { str = "Die so you end up near Theramore" },
			[27] = { str = "Turn in “Stinky's Escape” in the Inn " },
			[28] = { str = "Go up in the castle, turn in “The Deserters pt.2”" },
			[29] = { str = "Fly to Gadgetzan and run up to the Shimmering Flats to 80,76 turn in “Razzeric's Tweaking” accept “Safety First pt.1” turn it in in Gadget and accept “Safety First pt.2” then run back to the flats and hand it in", x = 80, y = 76, zone = "Dustwallow Marsh" },
			[30] = { str = "Hearth to Theramore and fly to Rachet, get on the boat to BB" },
		}
	},

-----------38-40 Stranglethorn Vale
	--[312] = {
	[3840] = {
		title = "38-40 Stranglethorn Vale",
		--n = "38-40 Stranglethorn Vale",
		--pID = 311, nID = 401,
		--itemCount = 38,
		items = {
			[1] = { str = "38-40 Stranglethorn Vale" },
			[2] = { str = "Run towards the Inn, accept “The Bloodsail Buccaneers pt.1” halfway" },
			[3] = { str = "Go in the building next to the half boat upside down, accept “Scaring Shaky”" },
			[4] = { str = "Go in the Inn, make it your home, accept “Venture Company Mining”" },
			[5] = { str = "Go upstairs, turn in “The Rumormonger” accept “Dream Dust In the Swamp” and “Skullsplitter Tusks”" },
			[6] = { str = "Go just outside, hand in “Sunken Treasure pt.4” SKIP the next" },
			[7] = { str = "Go to around 33,39 and kill raptors for  “Raptor Mastery pt.3”", x = 33, y = 39, zone = "Stranglethorn Vale" },
			[8] = { str = "Kill Snapjaw Crocolisks from the stream at 38,30 to the lake at 41,19 for “Some assembly required”", x = 38, y = 30, zone = "Stranglethorn Vale" },
			[9] = { str = "Go to the Island at 20,23 and kill elementals for “Water Elementals” You should be close to 39 by now, either grind on the elementals or raptors and basalisks around 33,39", x = 20, y = 23, zone = "Stranglethorn Vale" },
			[10] = { str = "Once you’re 39, grind your way east to the road then to 41,41 and kill the goblins for “Venture Company Mining”", x = 41, y = 41, zone = "Stranglethorn Vale" },
			[11] = { str = "Run up to the camps around 42,37 and do “Skullsplitter Tusks”", x = 42, y = 37, zone = "Stranglethorn Vale" },
			[12] = { str = "Now you’re gonna have to find Bhag'thera for “Panther Mastery pt.4” she is anywhere between just north of Mosh’ogg at 49,25 to just north of the ZG entrance at 48,17 she’s elite. Easy way to do it is lay immolation trap and run her into it, once pet gets half health fear it and keep attacking it", x = 48, y = 25, zone = "Stranglethorn Vale" },
			[13] = { str = "Hearth back to BB" },
			[14] = { str = " Turn in “Venture Company Mining”" },
			[15] = { str = "Go upstairs, turn in “Skullsplitter Tusks”" },
			[16] = { str = "Walk outside, turn in “Water Elementals” SKIP the next" },
			[17] = { str = "Go into the shop Tan-Your-Hide Leatherworks and turn in”" },
			[18] = { str = "Go into the shop Tan-Your-Hide Leatherworks and turn in “Some assembly required” accept “Excelsior”" },
			[19] = { str = "Go out of BB and turn left to the camp of pirates at 27,69 and touch the letter on the barrel, turn in “The Bloodsail Buccaneers pt.1” accept “The Bloodsail Buccaneers pt.2”", x = 27, y = 69, zone = "Stranglethorn Vale" },
			[20] = { str = "Go kill gorillas around 32,65 just NE of BB for “Scaring Shaky”", x = 32, y = 65, zone = "Stranglethorn Vale" },
			[21] = { str = "Run back to BB" },
			[22] = { str = "Turn right after the tunnel, turn in “Scaring Shaky” accept “Return to MacKinley”" },
			[23] = { str = "Follow the lower dock towards the Inn, turn in “The Bloodsail Buccaneers pt.2” acept “The Bloodsail Buccaneers pt.3”" },
			[24] = { str = "Go In the house across from the half ship, turn in “Return to MacKinley” accept “Voodoo Dues”" },
			[25] = { str = "Go up top the Inn, accept “Up To Snuff” " },
			[26] = { str = "Go just outside, turn in “The Bloodsail Buccaneers pt.3” accept “The Bloodsail Buccaneers pt.4”" },
			[27] = { str = "You should have close to all the STV pages, if not buy the few that you need. You don’t need 1-27 they go in this order. 1,4,6,8,10,11,14,16,18,20,21,24,25,26,27" },
			[28] = { str = "Go up near Grom’Gol, search the shore there for the 38 elite croc for “Excelsior” stay away from the base or the guards will get you" },
			[29] = { str = "Run up to Nessingways at 35,10 and turn in “Raptor Mastery pt.3” and “Panther Mastery pt.4”  accept “Raptor Mastery pt.4”", x = 35, y = 10, zone = "Stranglethorn Vale" },
			[30] = { str = "Accept “The Green Hills of Stranglethorn” then turn it in" },
			[31] = { str = "You should be at lest 25% or less to 40 now go grind on basalisks and raptors around 33,39 until you’re 40.", x = 33, y = 39, zone = "Stranglethorn Vale" },
			[32] = { str = "Hearth to BB" },
			[33] = { str = "Go into the shop Tan-Your-Hide Leatherworks and turn in “Excelsior”" },
			[34] = { str = "Now fly to IF and accept Ironband Wants You from Prospector Stormpike at 74 11, and either to Darnassus to get your new skills and your mount, or get skills in IF and prepare for a few badlands quests by buying a frost oil and a gyrochronatom (don’t by a gyro if you can’t find a frost oil) Then a healing potion and lesser invisibility potion. Again don’t get either of the potions if you can’t get a frost oil or gyro.", x = 74, y = 11, zone = "Iron Forge" },
			[35] = { str = "Fly to Loch Modan Stable your pet and make Thelsamar your home" },
			[36] = { str = "Go in the house behind the Inn, accept “Badlands Reagent Run" },
			[37] = { str = "Run to 65,65 and accept “Find Agmond”", x = 65, y = 65, zone = "Loch Modan" },
			[38] = { str = "Run down into Badlands at 46,76", x = 46, y = 76, zone = "Loch Modan" },
		}
	},
}
