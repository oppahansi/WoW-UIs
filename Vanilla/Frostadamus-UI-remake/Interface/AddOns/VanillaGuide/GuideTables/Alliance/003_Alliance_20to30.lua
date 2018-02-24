--[[--------------------------------------------------
003_Alliance_20to30.lua
Authors: mrmr
Version: 1.04.2
------------------------------------------------------
Description: Guide Serie - 003 From Lvl 20 to Lvl 30
    1.04.1
        -- First Release
            Alliance's Guide
            from level 20 to lever 30
    1.04.2
        -- no changes in here for this revision
------------------------------------------------------
Connection:
--]]--------------------------------------------------

Table_003_Alliance_20to30 = {
-----------20-21 Darkshore
    --[201] = {
    [2021] = {
        title = "20-21 Darkshore",
        --n = "20-21 Darkshore",
        --pID = 104, nID = 202, 
        --itemCount = 10,
        items = {
            [1] = { str = "20-21 Darkshore" },
            [2] = { str = "First thing, fly to Darnassus and get your new Skills." },
            [3] = { str = "Turn in  Onu  at 43,76 accept  The Master's Glaive.", x = 43, y = 76, zone = "Darkshore" },
            [4] = { str = "Go to 39,85 it should say you found Master’s Glaive(complete) now use the phial of scrying. Click it turn in  The Master's Glaive  accept  The Twilight Camp", x = 39, y = 85, zone = "Darkshore" },
            [5] = { str = "Click the Book at 38,86 turn in  The Twilight Camp  accept  Return to Onu.", x = 38, y = 86, zone = "Darkshore" },
            [6] = { str = "Accept  Therylune's Escape  (escort) at 38,87 and do it.", x = 38, y = 87, zone = "Darkshore" },
            [7] = { str = "Turn in  The Absent Minded Prospector pt.1  at 35,83 accept  The Absent Minded Prospector pt.2  and do it.", x = 35, y = 83, zone = "Darkshore" },
            [8] = { str = "Go west to 31,83 and 31,85 and accept  Beached Sea Turtle  at both.", x = 31, y = 83, zone = "Darkshore" },
            [9] = { str = "Go back to 43,76 and turn in  Return to Onu  accept  Mathystra Relics.", x = 43, y = 76, zone = "Darkshore" },
            [10] = { str = "Accept  The Sleeper Has Awakened  (escort) the sleeping bear behind Onu. Hotbar his horn because he falls asleep every minute or so. This quest will bring you into Ashenvale. Horn is in the box beside him. Note: since he follows you, with aspect of the cheetah on you can skip mobs by running down the road or taking the offroad." },
        }
    },


-----------21-22 Ashenvale
    --[202] = {
    [2122] = {
        title = "21-22 Ashenvale",
        --n = "21-22 Ashenvale",
        --pID = 201, nID = 203, 
        --itemCount = 33,
        items = {
            [1] = { str = "21-22 Ashenvale" },
            [2] = { str = "Run to 26,36 Maestra’s Post in Ashenvale, and this will complete  The Sleeper Has Awakened  Go turn it in straight ahead in the house.", x = 26, y = 36, zone = "Ashenvale" },
            [3] = { str = "Accept  Bathran's Hair." },
            [4] = { str = "Kill mobs around 31,31 in ruins of Ordil’Aran for  The Tower of Althalaxx pt.4  I then clear the camp a total of 4 times. If I find it early I still clear it 4 times total. I am then half way to 22.", x = 31, y = 31, zone = "Ashenvale" },
            [5] = { str = "Grab plant bundles for  Bathran's Hair  at 31,21 in Bathran’s Haunt", x = 31, y = 21, zone = "Ashenvale" },
            [6] = { str = "Go back to Maestra’s Post at 26,38 and turn in  The Tower of Althalaxx pt.4  Accept  The Tower of Althalaxx pt.5.", x = 26, y = 36, zone = "Ashenvale" },
            [7] = { str = "Turn in  Bathran's Hair  accept  Orendil's Cure." },
            [8] = { str = "Go to 22,51 turn in  Therylune's Escape.", x = 22, y = 51, zone = "Ashenvale" },
            [9] = { str = "Run into Astranaar at 33,48 and get FP", x = 33, y = 48, zone = "Ashenvale" },
            [10] = { str = "Accept  The Zoram Strand  right as you enter town." },
            [11] = { str = "Accept  On Guard in Stonetalon pt.1  on the house to the right." },
            [12] = { str = "Cross the road near the gazebo accept  Journey to Stonetalon Peak " },
            [13] = { str = "In the Inn accept  Raene's Cleansing pt.1  and  Culling the Threat." },
            [14] = { str = "Make Astranaar your home." },
            [15] = { str = "Turn in  Orendil's Cure  at the last house accept  Elune's Tear" },
            [16] = { str = "Go to The Zoram Strand. Stop at 14,31 accept  The Ancient Statuette ", x = 14, y = 31, zone = "Ashenvale" },
            [17] = { str = "do  The Zoram Strand  Naga all around here." },
            [18] = { str = "And  The Ancient Statuette  at 14,20 it’s on the ground. ", x = 14, y = 20, zone = "Ashenvale" },
            [19] = { str = "Turn in  The Ancient Statuette  at 14,31 accept  Ruuzel ", x = 14, y = 31, zone = "Ashenvale" },
            [20] = { str = "Do  Ruuzel  at 9,15 You don’t actually have to kill Ruuzel. Kill Lady Vespia. A 22 weak elite and doesn’t have guards like Ruuzel", x = 9, y = 15, zone = "Ashenvale" },
            [21] = { str = "Turn in  Ruuzel  at 14,20.", x = 14, y = 20, zone = "Ashenvale" },
            [22] = { str = "Turn in  Raene's Cleansing pt.1  at 20,42 accept  Raene’s Cleansing pt.2  Kill murlocs for the gem", x = 20, y = 42, zone = "Ashenvale" },
            [23] = { str = "Hearth back to Astranaar" },
            [24] = { str = "Turn in  The Zoram Strand  right as you enter town accept  Pridewings of Stonetalon" },
            [25] = { str = "Go to the Inn Turn in  Raene’s Cleansing pt.2  accept  Raene’s Cleansing pt.3  and  An Aggressive Defense " },
            [26] = { str = "Grind to 46,46 and grab  Elune's Tear", x = 46, y = 46, zone = "Ashenvale" },
            [27] = { str = "Go to 49,56 then grind north to 53,46 turn in  Raene’s Cleansing pt.3  accept  Raene’s Cleansing pt.4.", x = 49, y = 56, zone = "Ashenvale" },
            [28] = { str = "You should already be 22. Go to 55,61 and do  An Aggressive Defense", x = 55, y = 61, zone = "Ashenvale" },
            [29] = { str = "Hearth to Astranaar" },
            [30] = { str = "Turn in  An Aggressive Defense" },
            [31] = { str = "Go to the east exit house, turn in  Elune's Tear  accept  The Ruins of Stardust" },
            [32] = { str = "Exit Astranaar out the east exit follow the south path till you are at 33,66 and grab stardust covered bushes for  The Ruins of Stardust", x = 33, y = 66, zone = "Ashenvale" },
            [33] = { str = "Grind east to Talondeep path at 42,71", x = 42, y = 71, zone = "Ashenvale" },
        }
    },

-----------22-23 Stonetalon Mountains
    --[203] = {
    [2223] = {
        title = "22-23 Stonetalon Mountains",
        --n = "22-23 Stonetalon Mountains",
        --pID = 202, nID = 204,
        --itemCount = 10,
        items = {
            [1] = { str = "22-23 Stonetalon Mountains" },
            [2] = { str = "Run down Stonetalon to the hut at 58,62 accept  Super Reaper 6000", x = 58, y = 62, zone = "Stonetalon Mountains" },
            [3] = { str = "Then go to 59,66 and turn in  On Guard in Stonetalon pt.1  accept  On Guard in Stonetalon pt.2.", x = 59, y = 66, zone = "Stonetalon Mountains" },
            [4] = { str = "Turn it in right behind you accept  A Gnome’s Respite" },
            [5] = { str = "Kill Loggers and Deforesters for  A Gnome’s Respite  and Operators for  Super Reaper 6000  all around Windshear Crag. Operators hang out around buildings only." },
            [6] = { str = "Turn in  Super Reaper 6000  at the hut 58,62 SKIP  Further Instructions  Unless you want to run to Ratchet.", x = 58, y = 62, zone = "Stonetalon Mountains" },
            [7] = { str = "Then go to 59,66 and turn in  A Gnome’s Respite  accept  An Old Colleague  and  A Scroll From Mauren  We’ll do these later.", x = 59, y = 66, zone = "Stonetalon Mountains" },
            [8] = { str = "Stop at Mirkfallon Lake at 48,40 and kill Pridewings for  Pridewings of Stonetalon  South and East of it.", x = 48, y = 40, zone = "Stonetalon Mountains" },
            [9] = { str = "Run to 37,8 turn in  Journey to Stonetalon Peak  SKIP  Reclaiming The Charred Vale  for now", x = 37, y = 8, zone = "Stonetalon Mountains" },
            [10] = { str = "Grab FP at 36,7 and Fly to Auberdine.", x = 36, y = 7, zone = "Stonetalon Mountains" },
        }
    },

-----------23-24 Darkshore
    --[204] = {
    [2324] = {
        title = "23-24 Darkshore",
        --n = "23-24 Darkshore",
        --pID = 203, nID = 205,
        --itemCount = 20,
        items = {
            [1] = { str = "23-24 Darkshore" },
            [2] = { str = "Turn in Both  Beached Sea Turtle  on the dock" },
            [3] = { str = "Make Auberdine your home" },
            [4] = { str = "Turn in  The Absent Minded Prospector pt.2  just outside the merchant house accept  The Absent Minded Prospector pt.3 ." },
            [5] = { str = "Go in the last house accept  A Lost Master." },
            [6] = { str = "Fly to Darnassus and turn in  The Absent Minded Prospector pt.3  outside the Temple of the Moon at 31,84 accept  The Absent Minded Prospector pt.4  Get talents if you need them.", x = 31, y = 84, zone = "Darnassus" },
            [7] = { str = "Fly back to Auberdine." },
            [8] = { str = "Go to around 58,21 for  Mathystra Relics  The relics are all over.", x = 58, y = 21, zone = "Darkshore" },
            [9] = { str = "Stop at 56,13 accept  Gyromast's Retrieval  Kill raging reef crawlers around here and Murlocs north near the ship at 55,12", x = 56, y = 13, zone = "Darkshore" },
            [10] = { str = "Run north of Ruins of Mathystra killing sire’s and matriach’s for  A Lost Master  Also kill Foreststriders for  Gyromast's Retrieval" },
            [11] = { str = "Turn in  Gyromast's Retrieval  at 56,13 accept  Gyromast's Revenge.", x = 56, y = 13, zone = "Darkshore" },
            [12] = { str = "Turn the key on The First Mate at 55,18 somewhere in the middle he’s gonna attack you. You have to kill him. Then turn it in at 56,13", x = 55, y = 18, zone = "Darkshore" },
            [13] = { str = "Run back to Auberdine." },
            [14] = { str = "Turn in  A Lost Master pt.1  at the first house in town. Accept  A Lost Master pt.2" },
            [15] = { str = "Run down to 43,76 turn in  Mathystra Relics.", x = 43, y = 76, zone = "Darkshore" },
            [16] = { str = "Run down to 41,81 and do /wave at Grimclaw He’ll point southwest at the cave. Go to it at 45,85 and turn in  A Lost Master pt.2  accept  Escape Through Force  Run him back to Grimclaw at 41,81.", x = 41, y = 81, zone = "Darkshore" },
            [17] = { str = "If you’re not 24 yet or 1750 xp to 24, grind to 1750 until you level." },
            [18] = { str = "Hearth to Auberdine." },
            [19] = { str = "Turn in  Escape Through Force  at the house before exiting town. Accept  Trek to Ashenvale" },
            [20] = { str = "Fly to Darnassus and get new skills then Fly to Astranaar." },
        }
    },

-----------24-25 Ashenvale
    --[205] = {
    [2425] = {
        title = "24-25 Ashenvale",
        --n = "24-25 Ashenvale",
        --pID = 204, nID = 206,
        --itemCount = 16,
        items = {
            [1] = { str = "24-25 Ashenvale" },
            [2] = { str = "Turn in  Trek to Ashenvale  right in front of you when you hearth." },
            [3] = { str = "Run to the house on the East side, turn in  The Ruins of Stardust  accept  Fallen Sky Lake." },
            [4] = { str = "Run to the West side of town, turn in  Pridewings of Stonetalon  accept  Kayneth Stillwind" },
            [5] = { str = "Grind every mob down into Fire Scar Shrine and kill Ilkruk Mathrull at 25,61 for  The Tower of Althalaxx pt.5  Take him out as fast as you can. He summons 2 voidwalkers if you take too long.", x = 25, y = 61, zone = "Ashenvale" },
            [6] = { str = "Grind a path up to between 35,33 and 36,36 (he patrols) and kill Dal Bloodclaw for  Culling the Threat.", x = 35, y = 33, zone = "Ashenvale" },
            [7] = { str = "I then grind furbolg’s until I’m half way to 25 " },
            [8] = { str = "Then run to Maestra’s Post at 26,38 turn in  The Tower of Althalaxx pt.5  accept  The Tower of Althalaxx pt.6.", x = 26, y = 38, zone = "Ashenvale" },
            [9] = { str = "Accept  Supplies to Auberdine  (escort) may seem out of the way, you run into a fight of 4, and 2 fights of 3. You only go to the darkshore border and it completes. Easy 2900 xp, not far out of the way. Turn it back in at 26,38.", x = 26, y = 38, zone = "Ashenvale" },
            [10] = { str = "Run to Astranaar" },
            [11] = { str = "Turn in  Culling the Threat  at the inn " },
            [12] = { str = "Run down to Silverwing Refuge at 49,67 and accept Elemental Bracers do it in the lake here.", x = 49, y = 67, zone = "Ashenvale" },
            [13] = { str = "Once you have all 5 inact bracers, use the scroll on them and then hand it back in at 49,67 SKIP  Mage Summoner. ", x = 49, y = 67, zone = "Ashenvale" },
            [14] = { str = "I’m usually about 1 bar from 25 so I grind to 25 on the elementals " },
            [15] = { str = "Hearth to Auberdine" },
            [16] = { str = "Get on the boat to Menethil Harbor." },
        }
    },

-----------25-27 Wetlands
    --[206] = {
    [2526] = {
        title = "25-27 Wetlands",
        --n = "25-27 Wetlands",
        --pID = 205, nID = 207,
        --itemCount = 53,
        items = {
            [1] = { str = "25-27 Wetlands" },
            [2] = { str = "Stop at the end of the docks, accept  Claws From the Deep" },
            [3] = { str = "On the west side of town accept  Young Crocolisk Skins" },
            [4] = { str = "Go to the top of the castle, accept  War Banners" },
            [5] = { str = "On the east side of town accept  Digging Through the Ooze " },
            [6] = { str = "In front of the Inn accept  The Third Fleet  and  The Greenwarden" },
            [7] = { str = "Go to 49,56 then grind north to 53,46 turn in  Raene’s Cleansing pt.3  accept  Raene’s Cleansing pt.4.", x = 53, y = 46, zone = "Wetlands" },
            [8] = { str = "Make Menethil Harbor your home" },
            [9] = { str = "Go upstairs in the inn, turn in  The Absent Minded Prospector pt.4  accept  The Absent Minded Prospector pt.5" },
            [10] = { str = "Buy a  Flagon of Mead  from the bartender for  The Third Fleet  and give it to the guy outside the inn. Accept  The Cursed Crew " },
            [11] = { str = "On the bridge accept  In Search of the Excavation Team pt.1" },
            [12] = { str = "Kill Young Crocolisks just east of the bridge around 14,52 and north on the land of the lake also along the road to the greenwarden for  Young Crocolisk Skins ", x = 14, y = 52, zone = "Wetlands" },
            [13] = { str = "Kill Bluegill Murlocs and Gobbler at 18,40 for  Claws From the Deep", x = 18, y = 40, zone = "Wetlands" },
            [14] = { str = "Kill Mottled Raptors and Screechers around 25,46 for  The Absent Minded Prospector pt.5", x = 25, y = 46, zone = "Wetlands" },
            [15] = { str = "Enter the Excavation Site at 34,40.", x = 34, y = 40, zone = "Wetlands" },
            [16] = { str = "Run up the path on the left and grab the fossil near the 2 npc’s at 38,52 for  The Absent Minded Prospector pt.5", x = 38, y = 52, zone = "Wetlands" },
            [17] = { str = "Turn in  In Search of the Excavation Team pt.1  accept  In Search of the Excavation Team pt.2" },
            [18] = { str = "Accept  Uncovering the Past." },
            [19] = { str = "Outside the cave accept  Ormer s Revenge pt.1." },
            [20] = { str = "Go back to where you killed the raptors a few minutes ago at 25,46 and do  Ormer's Revenge pt.1  by killing mottled raptors and screechers.", x = 25, y = 46, zone = "Wetlands" },
            [21] = { str = "Run back up to the cave at 38,52 and turn in  Ormer's Revenge pt.1  accept  Ormer’s Revenge pt.2", x = 38, y = 52, zone = "Wetlands" },
            [22] = { str = "Now do both  Ormer’s Revenge pt.2  by killing Scythclaw and Razormaw Raptors below, and  Uncovering the Past  relics for this are all around the raptors. There are 4 different ones that randomly spawn but each is in it’s own shape which are: (Modr=Thin Red Vase) (Golm=Fat Yellow Vase) (Neru=Dirt Pile) (Ados=Tomb)." },
            [23] = { str = "Go back up to 38,52 and turn in  Ormer’s Revenge pt.2  accept  Ormer’s Revenge pt.3", x = 38, y = 52, zone = "Wetlands" },
            [24] = { str = "Turn in  Uncovering the Past" },
            [25] = { str = "Do  Ormer’s Revenge pt.3  atop the hill at 32,51 Sarltooth is a 29 But he’s as easy as the others. Go turn it back in at 38,52.", x = 32, y = 51, zone = "Wetlands" },
            [26] = { str = "Go in to Angerfang Encampment at 43,40 and do  War Banners", x = 43, y = 40, zone = "Wetlands" },
            [27] = { str = "Stop at 49,39 accept Daily Delivery.", x = 49, y = 39, zone = "Wetlands" },
            [28] = { str = "Run straight East from here to 56,40 and turn in  The Greenwarden  accept  Tramping Paws", x = 56, y = 40, zone = "Wetlands" },
            [29] = { str = "Kill Mosshide around 56,74 for  Tramping Paws  at the camp. They’re a fast respawn I couldn’t kill em fast enough. Turn it in at 56,40 and accept  Fire Taboo  You should be 26 by now, if not you will be soon", x = 56, y = 74, zone = "Wetlands" },
            [30] = { str = "Do  Fire Taboo  by killing any mosshides but the ones you just killed, The flints are easily dropped by the ones around 44,33 there is a few.", x = 44, y = 33, zone = "Wetlands" },
            [31] = { str = "Turn in  Fire Taboo  at 56,40 accept  Blisters on the Land  Now this is one of those quests you just do as you go. Fen Creepers are stealthed elementals that lurk in the water. If you see one, kill it.", x = 56, y = 40, zone = "Wetlands" },
            [32] = { str = "Hearth back to Menethil Harbor." },
            [33] = { str = "Turn in  The Absent Minded Prospector pt.5  2nd floor of the Inn" },
            [34] = { str = "Go inside the castle upstairs, turn in  War Banners  accept  Nek'Rosh's Gambit" },
            [35] = { str = "On the west side of town hand in Daily Delivery and  Young Crocolisk Skins  accept  Apprentice's Duties" },
            [36] = { str = "Go on the dock and turn in  Claws From the Deep  accept  Reclaiming Goods" },
            [37] = { str = "On the bridge hand in  In Search of the Excavation Team pt.2." },
            [38] = { str = "You should definitely be 26 by this point and near ½ way to 27. You can either wait till you fly through IF to get talents or do it now." },
            [39] = { str = "Touch the damaged crate at 13,41 turn in  Reclaiming Goods  accept  The Search Continues.", x = 13, y = 41, zone = "Wetlands" },
            [40] = { str = "Go just north to the next camp Touch the sealed barrel at 13,38 turn in  The Search Continues  accept  Search More Hovels.", x = 13, y = 38, zone = "Wetlands" },
            [41] = { str = "Go north again touch the half-burried barrel at 13,34 turn in  Search More Hovels  accept  Return the Statuette", x = 13, y = 34, zone = "Wetlands" },
            [42] = { str = "Stop at the sunken ships around 14,28 14,25 and kill the unded on either ship for  The Cursed Crew  Try to stay on top of the ships. Kill Snellig in the broken part of the first ship in the rear near the shore for the box.", x = 14, y = 28, zone = "Wetlands" },
            [43] = { str = "From here north you should be able to find Giant crocolisks for  Apprentice's Duties  as well as the fen dwellers (track hidden) in the waters all over this area while you head toward Ironbeard’s Tomb at 44,25 for  Digging Through the Ooze  Kill oozes for the bag.", x = 44, y = 25, zone = "Wetlands" },
            [44] = { str = "Now once all your fen creepers are dead head back to the greenwarden at 56,40 and hand it in.", x = 56, y = 40, zone = "Wetlands" },
            [45] = { str = "Hearth Back to Menethil Harbor." },
            [46] = { str = "Just outside hand in  The Cursed Crew  accept  Lifting the Curse." },
            [47] = { str = "Go north a little bit and hand in  Digging Through the Ooze" },
            [48] = { str = "Go to the west side of town, turn in  Apprentice's Duties." },
            [49] = { str = "Next down to the docks, hand in  Return the Statuette" },
            [50] = { str = "You should be 27 now. " },
            [51] = { str = "Fly to IF, get new skills, hand in  An Old Colleague  at 71,51 SKIP the next part", x = 71, y = 51, zone = "Wetlands" },
            [52] = { str = "Fly to SW, hand in  A Gnome’s Respite  at 43,80 SKIP the next part", x = 43, y = 80, zone = "Wetlands" },
            [53] = { str = "Fly to Lakeshire" },
        }
    },

-----------27-28 Lakeshire
    --[207] = {
    [2728] = {
        title = "27-28 Lakeshire",
        --n = "27-28 Lakeshire",
        --pID = 206, nID = 208,
        --itemCount = 18,
        items = {
            [1] = { str = "27-28 Lakeshire" },
            [2] = { str = "Accept  Blackrock Bounty  right in front of FP near bridge " },
            [3] = { str = "Accept  Blackrock Menace  just over bridge on right." },
            [4] = { str = "Go in the town hall, accept  Solomon's Law " },
            [5] = { str = "Accept  Wanted: Lieutenant Fangore  Outside the Inn on the wall " },
            [6] = { str = "Make Lakeshire your home" },
            [7] = { str = "Just west of town at the house past the inn, accept  An Unwelcome Guest  now go do it just west of this house at 16,49 (Bellygrub) kill him then hand it back in.", x = 16, y = 49, zone = "Redridge Mountains" },
            [8] = { str = "Go to Render’s Camp at 44,19 and kill the orcs here for  Blackrock Menace  while you head NW to 34,7 for  Blackrock Bounty ", x = 44, y = 19, zone = "Redridge Mountains" },
            [9] = { str = "Once at the cave kill for the axes and champions Go left when you go in towards the down area with water, there is an escort quest here." },
            [10] = { str = "You should have your axes and champions killed by the time you get to the escort. If not you can kill them on your way out." },
            [11] = { str = "Get the escort quest  Missing In Action  at 28,12 in the cave and escort him out. He’s a 25 elite so he won’t die easy. Once you’re out of the camp he starts running back to Lakeshire, turn the quest in right where you stop as well as  Blackrock Menace  SKIP  Tharil'Zun ", x = 28, y = 12, zone = "Redridge Mountains" },
            [12] = { str = "Run over the Bridge near the FP turn in,  Blackrock Bounty" },
            [13] = { str = "Kill the Gnolls all around 74,42 for  Solomon's Law  and Keep an eye out for  Wanted: Lieutenant Fangore  he is at 80,40 Make sure you clear the mobs around him or they come running in", x = 74, y = 42, zone = "Redridge Mountains" },
            [14] = { str = "Once you got those both done, grind on these shadowhide until youre about 4k or 2 bars from 28" },
            [15] = { str = "Hearth to Lakeshire" },
            [16] = { str = "Go in the town hall and turn in both  Solomon's Law  and  Wanted: Lieutenant Fangore" },
            [17] = { str = "You should have hit 28 after that." },
            [18] = { str = "Run down to the SW corner of Redredge Mountains, and take the path that forks south into Duskwood" },
        }
    },

-----------28-29 Duskwood
    --[208] = {
    [2829] = {
        title = "28-29 Duskwood",
        --n = "28-29 Duskwood",
        --pID = 207, nID = 209,
        --itemCount = 48,
        items = {
            [1] = { str = "28-29 Duskwood" },
            [2] = { str = "Note on Duskwood, it has a few long, pointless chains that you only do a few parts of, then SKIP the rest" },
            [3] = { str = "Follow the road until you get to Darkshire and get FP at 72,44", x = 72, y = 44, zone = "Duskwood" },
            [4] = { str = "Go to the house just south of FP at 79,47 accept  Look to the Stars pt.1  Buy a bronze tube from the gnome engineer just south of here at 78,48 and hand it back in, accept  Look to the Stars pt.2 ", x = 79, y = 47, zone = "Duskwood" },
            [5] = { str = "Go towards town and the first big house on the left outside accept  Worgen in the Woods pt.1" },
            [6] = { str = "Go in the house and accept  Raven Hill   The Hermit  and  Deliveries to Sven" },
            [7] = { str = "Exit the house and go straight to the house across the street and accept  The Legend of Stalvan pt.1  and  The Totem of Infliction." },
            [8] = { str = "Run out the door straight across to the Inn and make it your home." },
            [9] = { str = "Exit and go to the right, accept  The Night Watch pt.1" },
            [10] = { str = "Turn in  The Legend of Stalvan pt.1  SKIP the rest" },
            [11] = { str = "Start off doing  Worgen in the Woods pt.1  to the east of Duskwood around 64,46 by killing Nightbane Shadow Weaver", x = 64, y = 46, zone = "Duskwood" },
            [12] = { str = "Turn in  Worgen in the Woods pt.1  back in the center of town, accept  Worgen in the Woods pt.2" },
            [13] = { str = "Go back to around 64,46 and kill Nightbane Dark Runners now for  Worgen in the Woods pt.2  There are a lot in the camps", x = 64, y = 46, zone = "Duskwood" },
            [14] = { str = "Go turn in  Worgen in the Woods pt.2  in the center of town again and accept  Worgen in the Woods pt.3" },
            [15] = { str = "Run to the house at 81,59 turn in  Look to the Stars pt.2  accept  Look to the Stars pt.3", x = 81, y = 59, zone = "Duskwood" },
            [16] = { str = "Do  The Night Watch pt.1  and the skeleton finger part of  The Totem of Infliction  at Tranquil Garden Cemetary around 79,70.", x = 79, y = 70, zone = "Duskwood" },
            [17] = { str = "Ger Mary’s Looking Glass for  Look to the Stars pt.3  inside the chapel here from the insane ghoul" },
            [18] = { str = "Kill the mobs around 73,73 inside and out of the cave for  Worgen in the Woods pt.3.", x = 73, y = 73, zone = "Duskwood" },
            [19] = { str = "Hearth back to Darkshire." },
            [20] = { str = "Just outside the Inn, hand in  The Night Watch pt.1  accept  The Night Watch pt.2." },
            [21] = { str = "Go east from here and hand in  Worgen in the Woods pt.3  accept  Worgen in the Woods pt.4  go in the house and turn that in." },
            [22] = { str = "Go just south of the FP to 79,47 turn in  Look to the Stars pt.3  accept  Look to the Stars pt.4 ", x = 79, y = 47, zone = "Duskwood" },
            [23] = { str = "You should be over half way to 29, more near ¾ the way" },
            [24] = { str = "Stop at the ogre mound cave at 33,75 and kill Zzarc' Vul for  Look to the Stars pt.4  Stay left inside the cave", x = 33, y = 75, zone = "Duskwood" },
            [25] = { str = "Stop at the front of Raven Hill at 18,56 and turn in  Raven Hill  SKIP the rest since they’re grey", x = 18, y = 56, zone = "Duskwood" },
            [26] = { str = "Run north into the cemetery and kill skeletons for  The Night Watch pt.2  and spiders in here for  The Totem of Infliction." },
            [27] = { str = "Kill ghouls in the northern part of the cemetery at 22,38 to get ghoul fangs for  The Totem of Infliction", x = 22, y = 38, zone = "Duskwood" },
            [28] = { str = "Kill black widow’s east of the graveyard for the last part of  The Totem of Infliction" },
            [29] = { str = "Go to the shack NE of Raven Hill at 28,31 and turn in  The Hermit  accept  Supplies From Darkshire.", x = 28, y = 31, zone = "Duskwood" },
            [30] = { str = "Go to 17,29 at the grave and get  The Weathered Grave", x = 17, y = 29, zone = "Duskwood" },
            [31] = { str = "Run to 7,34 and turn in  Deliveries to Sven  accept  Sven's Revenge ", x = 7, y = 34, zone = "Duskwood" },
            [32] = { str = "Hearth to Darkshire" },
            [33] = { str = "Right in front of the inn, turn in  The Night Watch pt.2  accept  The Night Watch pt.3" },
            [34] = { str = "Go in town hall, turn in  The Weathered Grave  accept  Morgan Ladimore  Turn it in just out front of the town hall SKIP  Mor'Ladim " },
            [35] = { str = "Go in the house east of the Inn, turn in  The Totem of Infliction  and  Supplies From Darkshire  accept  Ghost Hair Thread " },
            [36] = { str = "Go in the last house to the east, turn in  Look to the Stars pt.4." },
            [37] = { str = "Go to Blind Mary in the house at 81,59 turn in  Ghost Hair Thread  accept  Return the Comb  Go turn it in at the house east of the Inn, accept  Deliver the Thread  ", x = 81, y = 59, zone = "Duskwood" },
            [38] = { str = "Go to 49,77 (you can sneak around everything to here by going towards STV and then to this location) and turn in  Sven's Revenge  accept  Sven’s Camp ", x = 49, y = 77, zone = "Duskwood" },
            [39] = { str = "Run up to the shack NE of Raven Hill and hand in  Deliver the Thread  accept  Zombie Juice" },
            [40] = { str = "Go to the underground at 23,35 kill plagued spreaders just around here and down inside for  The Night Watch pt.3  you probably won’t get them all in 1 pass.", x = 23, y = 35, zone = "Duskwood" },
            [41] = { str = "Grind your way back out then over to Sven at 7,34 hand in  Sven's Revenge  accept  The Shadowy Figure", x = 7, y = 34, zone = "Duskwood" },
            [42] = { str = "Hearth back to Darkshire" },
            [43] = { str = "Turn in  Zombie Juice  right in front of you, SKIP the rest" },
            [44] = { str = "Turn in  The Night Watch pt.3  right outside the Inn" },
            [45] = { str = "Turn in  The Shadowy Figure  at the house east of the Inn accept  The Shadowy Search Continues" },
            [46] = { str = "Turn it in at the town hall, accept  Inquire at the Inn  SKIP the rest" },
            [47] = { str = "If you happened to find An Old History Book (drops off all mobs in Duskwood) start the quest  An Old History Book  and Fly to SW and turn it in at 74,7 and accept  Southshore ", x = 74, y = 7, zone = "Duskwood" },
            [48] = { str = "Fly to Menethil Harbor and get on the boat to Auberdine, Fly to Ashenvale" },
        }
    },

-----------29-30 Ashenvale
    --[209] = {
    [2930] = {
        title = "29-30 Ashenvale",
        --n = "29-30 Ashenvale",
        --pID = 208, nID = 210,
        --itemCount = 18,
        items = {
            [1] = { str = "29-30 Ashenvale" },
            [2] = { str = "Make Astranaar your home." },
            [3] = { str = "Stop at 66,56 and touch the crystal for the first part of  The Tower of Althalaxx pt.6.", x = 66, y = 56, zone = "Ashenvale" },
            [4] = { str = "Kill Withered Ancients for the Wooden Key for  Raene’s Cleansing pt.4  around 55,35 then use the key on the chest at 54,35", x = 55, y = 35, zone = "Ashenvale" },
            [5] = { str = "Run to 53,46 turn in  Raene’s Cleansing pt.4  accept  Raene’s Cleansing pt.5", x = 53, y = 46, zone = "Ashenvale" },
            [6] = { str = "Go to 85,44 and turn in  Kayneth Stillwind  accept  Forsaken Diseases", x = 85, y = 44, zone = "Ashenvale" },
            [7] = { str = "Go to 81,48 and get the second part of  The Tower of Althalaxx pt.6 ", x = 81, y = 48, zone = "Ashenvale" },
            [8] = { str = "Go to 66,81 and do  Fallen Sky Lake  the mob is in the center", x = 66, y = 81, zone = "Ashenvale" },
            [9] = { str = "Kill rotting slimes until a chest falls east of the road near the lake for  Raene’s Cleansing pt.5" },
            [10] = { str = "Go to 75,71 and do  Forsaken Diseases  the bottle is on the table.", x = 75, y = 71, zone = "Ashenvale" },
            [11] = { str = "Hand in  Forsaken Diseases  at 85,44 SKIP the next part.", x = 85, y = 44, zone = "Ashenvale" },
            [12] = { str = "Hearth back to Astranaar" },
            [13] = { str = "Turn in  Fallen Sky Lake  at the last house on the east side of town" },
            [14] = { str = "Go to 53,46 turn in  Raene’s Cleansing pt.5  accept  Raene's Cleansing pt.5  Go turn it in at the shrine inside the tree at 56,49 accept  Raene’s Cleansing pt.6   Turn it back in at the moonwell at 53,46 accept  Raene’s Cleansing pt.7  die so you end up near town", x = 53, y = 46, zone = "Ashenvale" },
            [15] = { str = "Hand in  Raene’s Cleansing pt.7  at the Inn, SKIP the rest but keep the rod, you can use it forever to transform for fun =P" },
            [16] = { str = "Go to 26,38 turn in  The Tower of Althalaxx pt.6  SKIP the rest", x = 26, y = 38, zone = "Ashenvale" },
            [17] = { str = "Fly to Darnassus and get your level 30 talents" },
            [18] = { str = "Fly to Auberdine then get on the boat to Menethil Harbor" },
        }
    },

-----------30-30 Wetlands
    --[210] = {
    [3030] = {
        title = "30-30 Wetlands",
        --n = "30-30 Wetlands",
        --pID = 209, nID = 301,
        --itemCount = 18,
        items = {
            [1] = { str = "30-30 Wetlands" },
            [2] = { str = "Make Menethil Harbor your home." },
            [3] = { str = "Go to 14,25 and kill Captain Halyndor for his key on top of the ship, the chest is in the bottom of the ship. Send your pet in to grab all the aggro, then send it out to attack a murloc so it trains them all out. Touch the chest and turn in  Lifting the Curse  accept  The Eye of Paleth", x = 14, y = 25, zone = "Wetlands" },
            [4] = { str = "Touch the catapult at 47,47, hand in  Nek'Rosh's Gambit  accept  Defeat Nek’Rosh", x = 47, y = 47, zone = "Wetlands" },
            [5] = { str = "Go to 53,55 and clear the left side, walk up and around the back, to do  Defeat Nek’Rosh  clear anything he might aggro, die doing so if you must. He’s kinda weak. Pretty easy for a 32 elite.", x = 53, y = 55, zone = "Wetlands" },
            [6] = { str = "Hearth back to Menethil Harbor." },
            [7] = { str = "Turn in  The Eye of Paleth  right in front of you, accept  Cleansing the Eye." },
            [8] = { str = "Go up top of the castle, hand in  Defeat Nek’Rosh." },
            [9] = { str = "Accept  Fall of Dun Modr  just outside the inn " },
            [10] = { str = "Turn in  Fall of Dun Modr  at 49,18 accept  The Thandol Span pt.1", x = 49, y = 18, zone = "Wetlands" },
            [11] = { str = "Go half way across the bridge to 51,8 and go in the door that leads down, look for the dead dwarf body, hand in  The Thandol Span pt.1  accept  The Thandol Span pt.2  turn that back in at the camp at 49,18 accept  The Thandol Span pt.3 ", x = 51, y = 8, zone = "Wetlands" },
            [12] = { str = "Go back over the bridge, just to the right is a tinier bridge. Cross it and destroy the explosives cart for  The Thandol Span pt.3  at 48,88 accept  Plea to the Alliance", x = 48, y = 88, zone = "Wetlands" },
            [13] = { str = "Run into Arathi Highlands to Refuge Point at 45,47 and hand in  Plea to the Alliance.", x = 45, y = 47, zone = "Arathi Highlands" },
            [14] = { str = "Grab the FP" },
            [15] = { str = "You should be half way to 31 or more by now." },
            [16] = { str = "Run towards Hillsbrad Foothills." },
            [17] = { str = "Stop at 27,49 and run south into Stormgarde Keep, at the first intersection go right and hug the wall around over the bridge, buy all 3 first aid books at 26,58", x = 27, y = 49, zone = "Arathi Highlands" },
            [18] = { str = "Continue heading to Hillsbrad " },
        }
    },
}