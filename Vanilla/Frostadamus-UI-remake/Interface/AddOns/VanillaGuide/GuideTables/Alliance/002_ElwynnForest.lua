--[[--------------------------------------------------
002_ElwynnForest.lua
Authors: mrmr
Version: 1.04.2
------------------------------------------------------
Description: Guide Serie - 001 Elwynn Forest
    1.04.1
        -- First Release
            Human Elwynn Forest's Guide
            from level 1 to lever 12
    1.04.2
    	-- no changes in here for this revision
------------------------------------------------------
Connection:
--]]--------------------------------------------------

Table_002_ElwynnForest = {
-----------1-10 Elwynn Forest
	--[15] = {
	[0110] = {
		title = "1-10 Elwynn Forest",
		--n = "1-10 Elwynn Forest",
		--pID = 1, nID = 16,
		--itemCount = 69,
		items = {
			[1] = { str = "1-10 Elwynn Forest" },
			[2] = { str = "Directly in front of where you start accept A Threat Within then go in the building and turn it in, accept Kobold Camp Cleanup" },
			[3] = { str = "Run back out, and turn in Welcome! at the wagons at 47,41", x = 47, y = 41, zone = "Elwynn Forest" },
			[4] = { str = "Go to the nook at the NW corner of the building at 48,40 and accept Wolves Across the Border", x = 48, y = 40, zone = "Elwynn Forest" },
			[5] = { str = "Kill the wolves all in front of you for Wolves Across the Border  while working your way to the kobold vermin at 47,35 for Kobold Camp Cleanup", x = 47, y = 35, zone = "Elwynn Forest" },
			[6] = { str = "Go back to 48,40 and turn in Wolves Across the Border", x = 48, y = 40, zone = "Elwynn Forest" },
			[7] = { str = "Run into the house at 48,41 and turn in Kobold Camp Cleanup accept Simple Letter and Investigate Echo Ridge", x = 48, y = 41, zone = "Elwynn Forest" },
			[8] = { str = "Go to the warrior trainer at 50,42 and turn in Simple Letter and train", x = 50, y = 42, zone = "Elwynn Forest" },
			[9] = { str = "Exit the house and grab Brotherhood of Thieves just outside" },
			[10] = { str = "Go NW toward the cave at 47,32 and kill kobold workers on the way up tp it for Investigate Echo Ridge", x = 47, y = 32, zone = "Elwynn Forest" },
			[11] = { str = "Go West to 54,40 and go south killing the defias until you finish Brotherhood of Thieves you should have dinged 4 by the time you’re done, if not just kill until you are", x = 54, y = 40, zone = "Elwynn Forest" },
			[12] = { str = "Run back to the abbey at 48,42 and turn in Brotherhood of Thieves accept Milly Osworth and Bounty on Garrick Padfoot", x = 48, y = 42, zone = "Elwynn Forest" },
			[13] = { str = "Go inside the house and turn in Investigate Echo Ridge accept Skirmish at Echo Ridge then get new skills" },
			[14] = { str = "Go north of the house at 50,39 next to the barn, turn in Milly Osworth accept Milly's Harvest", x = 50, y = 39, zone = "Elwynn Forest" },
			[15] = { str = "Go back east and grab the grapes in the garden at 54,48 for Milly's Harvest then NE to 57,48 you’ll see a shack with padfoot and a thug. Kill him for Bounty on Garrick Padfoot", x = 57, y = 48, zone = "Elwynn Forest" },
			[16] = { str = "Go back to 50,39 and turn in Milly's Harvest accept Grape Manifest", x = 50, y = 39, zone = "Elwynn Forest" },
			[17] = { str = "Go into the cave at 47,31 and kill kobold laborer’s for Skirmish at Echo Ridge", x = 47, y = 31, zone = "Elwynn Forest" },
			[18] = { str = "Hearth back to the Abbey" },
			[19] = { str = "Turn in Bounty on Garrick Padfoot right in front of you" },
			[20] = { str = "Go inside the house, turn in Skirmish at Echo Ridge accept Report to Goldshire" },
			[21] = { str = "Go to the top of the tower through the spiral staircase, turn in Grape Manifest" },
			[22] = { str = "Go to 45,47 and accept Rest and Relaxation", x = 45, y = 47, zone = "Elwynn Forest" },
			[23] = { str = "If you’re not 6 you should be close, just grind on a few mobs while you head towards the house near goldshire at 46,62 and pick up skinning if you want it", x = 46, y = 42, zone = "Elwynn Forest" },
			[24] = { str = "Reach goldshire and enter the Inn at 42,65", x = 42, y = 65, zone = "Elwynn Forest" },
			[25] = { str = "Just to your left accept Kobold Candles" },
			[26] = { str = "Near the bar turn in Rest and Relaxation and make Goldshire your home" },
			[27] = { str = "Exit the Inn and go straight out, turn in Report to Goldshire accept The Fargodeep Mine" },
			[28] = { str = "Get your new skills in town here." },
			[29] = { str = "Go near the carts at 42,67 and accept Gold Dust Exchange", x = 42, y = 67, zone = "Elwynn Forest" },
			[30] = { str = "Go south to the Fargodeep Mine at 39,82 and kill the kobold until you complete all 3 quests The Fargodeep Mine, Gold Dust Exchange, and Kobold Candles Make sure you go in the lower entrance so The Fargodeep Mine is easier", x = 39, y = 82, zone = "Elwynn Forest" },
			[31] = { str = "Once all 3 are done go to the stonefield farm just up the hill east at 34,84 and accept Lost Necklace SKIP Princess Must Die! it’s just too hard to do alone.", x = 34, y = 84, zone = "Elwynn Forest" },
			[32] = { str = "Go east to the Maclure Vinyard at 43,80 and accept Young Lovers", x = 43, y = 80, zone = "Elwynn Forest" },
			[33] = { str = "Go to 43,85 and turn in Lost Necklace accept Pie For Billy then turn around and kill boars until it’s finished.", x = 43, y = 85, zone = "Elwynn Forest" },
			[34] = { str = "Go back west to 34,84 and turn in Pie For Billy and accept Back to Billy", x = 34, y = 84, zone = "Elwynn Forest" },
			[35] = { str = "Go west some to the river at 29,85 and turn in Young Lovers accept Speak with Gramma", x = 29, y = 85, zone = "Elwynn Forest" },
			[36] = { str = "Go back to 34,84 and turn in Speak with Gramma in the house, accept Note to William", x = 34, y = 84, zone = "Elwynn Forest" },
			[37] = { str = "Run back east to 43,85 and turn in Back to Billy accept Goldtooth", x = 43, y = 85, zone = "Elwynn Forest" },
			[38] = { str = "Go in the bottom entrance of the fargodeep mine at 39,82 and to about 41,78 inside and kill goldtooth for Goldtooth You should ding 7 sometime in the cave or before you came in.", x = 41, y = 78, zone = "Elwynn Forest" },
			[39] = { str = "Hearth back to Goldshire" },
			[40] = { str = "In the Inn turn in Kobold Candles accept Shipment to Stormwind also turn in Note to William accept Collecting Kelp" },
			[41] = { str = "Straight outside the Inn, turn in The Fargodeep Mine accept The Jasperlode Mine" },
			[42] = { str = "South near the fence, turn in Gold Dust Exchange You should have dinged lvl 7 now, accept A Fishy Peril" },
			[43] = { str = "Turn around by the blacksmith and turn it in, accept Further Concerns" },
			[44] = { str = "Kill murlocs around the lake at 51,65 for Collecting Kelp", x = 51, y = 65, zone = "Elwynn Forest" },
			[45] = { str = "Grind up to the Jasperlode mine at 61,53 and run through it about half way to 60,50 for The Jasperlode Mine", x = 60, y = 50, zone = "Elwynn Forest" },
			[46] = { str = "Run to the bridge at 73,72 and turn in Further Concerns accept Find the Lost Guards and Protect the Frontier", x = 73, y = 72, zone = "Elwynn Forest" },
			[47] = { str = "Stop at the house NE of here at 79,68 and accept Red Linen Goods", x = 79, y = 68, zone = "Elwynn Forest" },
			[48] = { str = "At the center of the camp, 81,66, accept A Bundle of Trouble", x = 81, y = 66, zone = "Elwynn Forest" },
			[49] = { str = "Run just west of the waterfall at 72,60 touch the mangled body and turn in Find the Lost Guards accept Discover Rolf’s Fate if this doesn’t make you ding 8 then grind that last tiny bit.", x = 72, y = 60, zone = "Elwynn Forest" },
			[50] = { str = "Go to the murloc camp at 79,55 and loot the mangled body there (might need a group, but usually always people here) and turn in Discover Rolf’s Fate accept Report to Thomas", x = 79, y = 55, zone = "Elwynn Forest" },
			[51] = { str = "Go south to 81,66 and turn in “A Bundle of Trouble”", x = 81, y = 66, zone = "Elwynn Forest" },
			[52] = { str = "Cross the road and go south and east and finish killing the bears and wolves for “Protect the Frontier” bears are kinda scarce so you might have to search." },
			[53] = { str = "While doing this you can get some, if not all, of the red bandannas for  Red Linen Goods at 90,78", x = 90, y = 78, zone = "Elwynn Forest" },
			[54] = { str = "Go back to 73,72 near the bridge and turn in “Protect the Frontier” and “Report to Thomas” acept “Deliver Thomas' Report”", x = 73, y = 72, zone = "Elwynn Forest" },
			[55] = { str = "Go down to the pumpkin patch at 69,78 and kill the rest of the defias for Red Linen Goods ", x = 69, y = 78, zone = "Elwynn Forest" },
			[56] = { str = "You might find Furlbrow's Deed on the defias while you’re killing defias just hold it for now." },
			[57] = { str = "Go to 79,68 and turn in Red Linen Goods it should make you lvl 9 or bring you really close", x = 79, y = 68, zone = "Elwynn Forest" },
			[58] = { str = "Stop at the bridge again at 73,72 and accept “Report to Gryan Stoutmantle” must be 9 to accept", x = 73, y = 72, zone = "Elwynn Forest" },
			[59] = { str = "Hearth to Goldshire" },
			[60] = { str = "By the front door turn in “Collecting Kelp” accept “The Escape”" },
			[61] = { str = "Just outside the Inn turn in “The Jasperlode Mine” and “Deliver Thomas' Report” SKIPt “Cloth and Leather Armor” accept “Westbrook Garrison Needs Help!”" },
			[62] = { str = "In the blacksmith house right here accept “Elmore's Task” then get training" },
			[63] = { str = "Run south to the maclure vinyard at 43,89 and turn in “The Escape”", x = 43, y = 89, zone = "Elwynn Forest" },
			[64] = { str = "Run west to the stonefield farm at 34,84 and turn in “Goldtooth”", x = 34, y = 84, zone = "Elwynn Forest" },
			[65] = { str = "Go NW to 34,74 and turn in “Westbrook Garrison Needs Help!” accept “Riverpaw Gnoll Bounty” You will also see the wanted poster and it’s the famous old hogger quest. He’s a tough lvl 11 elite and is not easy so skip it, unless you have a group it’s up to you. Remember on new servers you’re probably still within range of everyone so it shouldn’t be hard to get done.", x = 34, y = 74, zone = "Elwynn Forest" },
			[66] = { str = "Go just south of the road and start killing gnolls for “Riverpaw Gnoll Bounty” they can also drop a gold schedule which starts a quest" },
			[67] = { str = " Go back up to 34,74 and turn in “Riverpaw Gnoll Bounty” ", x = 34, y = 74, zone = "Elwynn Forest" },
			[68] = { str = "You should be very close to 10 now." },
			[69] = { str = "Follow the road west into Westfall" },
		}
	},

-----------10-12 Westfall and Lock Modan
	--[16] = {
	[1012] = {
		title = "10-12 Westfall and Lock Modan",
		--n = "10-12 Westfall and Lock Modan",
		--pID = 15, nID = 101,
		--itemCount = 34,
		items = {
			[1] = { str = "10-12 Westfall and Lock Modan" },
			[2] = { str = "Go to 59,19 and turn in “Furlbrow’s Deed” if you found it before", x = 59, y = 19, zone = "Westfall" },
			[3] = { str = "Accept “Westfall Stew” SKIP “Poor Old Blanchy”" },
			[4] = { str = "Go in the house at 56,30 and turn in “Westfall Stew”", x = 56, y = 30, zone = "Westfall" },
			[5] = { str = "Go to 56,47 and turn in “Report to Gryan Stoutmantle”", x = 56, y = 47, zone = "Westfall" },
			[6] = { str = "Go in the tower and accept “A Swift Message”" },
			[7] = { str = "Get the FP at 56,52 and turn in “A Swift Message” accept “Continue to Stormwind”", x = 56, y = 52, zone = "Westfall" },
			[8] = { str = "Fly to SW unless you did hogger, then hearth to Goldshire and turn it in outside the Inn then train" },
			[9] = { str = "In SW go to 56,64 and turn in “Shipment to Stormwind”", x = 56, y = 64, zone = "Stormwind" },
			[10] = { str = "Train new weapons at 57,57", x = 57, y = 57, zone = "Stormwind" },
			[11] = { str = "Go to 74,47 and turn in “Continue to Stormwind” accept “Dungar Longdrink”", x = 74, y = 47, zone = "Stormwind" },
			[12] = { str = "Go to 51,12 and turn in “Elmore's Task”  accept “Stormpike's Delivery” this will be done on the way to the wetlands", x = 51, y = 12, zone = "Stormwind" },
			[13] = { str = "Go to 78,45 and accept “A Warrior’s Training” or your classes lvl 10 quest.", x = 78, y = 45, zone = "Stormwind" },
			[14] = { str = "Go to 66,62 and turn in “Stormpike's Delivery” accept “Return to Lewis” then fly back to Westfall", x = 66, y = 62, zone = "Stormwind" },
			[15] = { str = "Go to the tower at 56,47 and turn in “Return to Lewis” super easy xp", x = 56, y = 47, zone = "Westfall" },
			[16] = { str = "Fly back to SW  Go in the bar at 74,37 and turn in “A Warrior’s Training” accept “Bartleby the Drunk” then turn around and hand it in accept “Beat Bartleby", x = 74, y = 37, zone = "Stormwind" },
			[17] = { str = "Kick bartleby’s ass then talk to him again and accept “Bartleby's Mug” then turn it in behind you and learn your defense" },
			[18] = { str = "Go into the tram at 63,8 and take it to IF", x = 63, y = 8, zone = "Stormwind" },
			[19] = { str = "Once it stops accept “Deeprun Rat Roundup” just collect 5 rats and turn it in. You could skip this and keep the flute, It can really piss people off if you play it non stop around the IF bank. SKIP “Me Brother, Nipsy” unless you go back to SW on the tram because you get crap xp" },
			[20] = { str = "Grab the FP at 55,47", x = 55, y = 47, zone = "Ironforge" },
			[21] = { str = "After the rat quest you should be real close to 11" },
			[22] = { str = "Leave IF and head into Dun Morogh" },
			[23] = { str = "Run east to 68,55 and accept “The Public Servant”", x = 68, y = 55, zone = "Dun Morogh" },
			[24] = { str = "Go behind him and accept “Those Blasted Troggs!”" },
			[25] = { str = "Go in the pidd below and kill the troggs here and in the cave for both quests then turn them back in at 68,55", x = 68, y = 55, zone = "Dun Morogh" },
			[26] = { str = "Go east to 80,51 and follow the path into Loch Modan", x = 80, y = 51, zone = "Dun Morogh" },
			[27] = { str = " Go to 22,73 and accept In Defense of the King's Lands”", x = 22, y = 73, zone = "Loch Modan" },
			[28] = { str = "Go up in the tower and accept The Trogg Threat" },
			[29] = { str = "At 33,50 grab the FP", x = 33, y = 50, zone = "Loch Modan" },
			[30] = { str = "Look for the wandering guidrd and accept “Rat Catching”" },
			[31] = { str = "Kill troggs from 27,53 and north for In Defense of the King's Lands” and The Trogg Threat", x = 27, y = 53, zone = "Loch Modan" },
			[32] = { str = "Go back to 22,73 and turn them both in", x = 22, y = 73, zone = "Loch Modan" },
			[33] = { str = "Go north to the tower at 24,18 and turn in “Stormpike's Delivery”", x = 24, y = 18, zone = "Loch Modan" },
			[34] = { str = "You should be 12 now or close to it. You can grind if you’d like but it doesn’t matter much. Follow the Night Elf to IF guide but just go backwards. You’re going to go north through the wetlands to menethil, then boat to auberdine from here." },
		}
	},
}