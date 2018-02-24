--------------------------------------------------------------------------
-- GTFO_Spells.lua 
--------------------------------------------------------------------------
--[[
GTFO Spell List
Author: Zensunim of Malygos

Change Log:
	v0.2
		- Added Spells
	v0.3
		- Wrath spells
	v0.3.1
		- Naxx spells
	v0.3.2
		- Naxx, Archavon
	v0.3.3
		- Ulduar
	v1.0
		- Trial of the Crusader
	v1.0.1
		- Added Koralon's Flaming Cinder, Ulduar spells
		- Replaced some spell names with spell IDs
	v1.1
		- Replaced some spell names with spell IDs
		- Added Ground Fissure (Freya trash)
	v1.1.1
		- Fixed Lord Jaraxxus's Legion Flame
		- Added Lord Jaraxxus's Fel Inferno
		- Fixed Northrend Beast's Slime Pool
		- Fixed Northrend Beast's Fire Bomb
	v1.1.2
		- Added Deathstalker Visceri's Poison Bottle
		- Added Anub'arak's Scarabs' Acid-Drenched Mandibles
		- Added Mimiron's Flames
		- Added Freya Trash's Hurricane
	v1.1.3
		- Added Runemaster Molgeim's Rune of Death
		- Added Stormcaller Brundir's Lightning Tendrils
	v1.1.4
		- Added Drakuru's Blight Crystal Explosion
		- Added Toxic Waste (Pit of Saron)
		- Added Scourgelord Tyrannus's Icy Blast
		- Added Onyxia's Deep Breath
	v1.2
		- Added The Black Knight's Desecration
		- Added Bronjahm's Soulstorm
		- Added Marwyn's Well of Corruption
		- Added Marwyn's Corrupted Touch
		- Added Devourer of Souls' Well of Souls
		- Added Lord Marrowgar's Coldflame
		- Added Lady Deathwhisper's Death and Decay
]]--

if (not GTFO) then -- Add only if not already present

GTFO = {SpellID = {}, SpellName = {}};

GTFO.SpellID["40611"] = {
	desc = "Blaze (Illidan)";
	sound = 1;
};

GTFO.SpellID["41482"] = {
	desc = "Blizzard (Illidari Council)";
	sound = 1;
};

GTFO.SpellID["41481"] = {
	desc = "Flamestrike (Illidari Council)";
	sound = 1;
};

GTFO.SpellID["41541"] = {
	desc = "Consecration (Illidari Council)";
	sound = 1;
};

GTFO.SpellID["28865"] = {
	desc = "Consumption (Netherspite)";
	sound = 1;
};

GTFO.SpellID["31944"] = {
	desc = "Doomfire (Archimonde)";
	sound = 1;
};

GTFO.SpellID["30129"] = {
	desc = "Charred Earth (Nightbane)";
	sound = 1;
};

GTFO.SpellID["50746"] = {
	desc = "Burn (Illidan)";
	sound = 1;
};

GTFO.SpellID["62548"] = {
	desc = "Scorch (Ignis-10)";
	sound = 1;
};

GTFO.SpellID["62549"] = {
	desc = "Scorch (Ignis-10)";
	sound = 1;
};

GTFO.SpellID["63475"] = {
	desc = "Scorch (Ignis-25)";
	sound = 1;
};

GTFO.SpellID["63476"] = {
	desc = "Scorch (Ignis-25)";
	sound = 1;
};

GTFO.SpellID["29371"] = {
	desc = "Eruption (Heigan the Unclean)";
	sound = 1;
};

GTFO.SpellID["47579"] = {
	desc = "Freezing Cloud (Skadi)";
	sound = 1;
};

GTFO.SpellID["60020"] = {
	desc = "Freezing Cloud (Skadi)";
	sound = 1;
};

GTFO.SpellID["51103"] = {
	desc = "Frostbomb (Mage-Lord Urom)";
	sound = 2;
};

GTFO.SpellID["56926"] = {
	desc = "Thundershock (Jedoga Shadowseeker)";
	sound = 1;
};

GTFO.SpellID["60029"] = {
	desc = "Thundershock (Jedoga Shadowseeker - Heroic)";
	sound = 1;
};

GTFO.SpellID["58965"] = {
	desc = "Choking Cloud (Archavon 10)";
	sound = 1;
};

GTFO.SpellID["61672"] = {
	desc = "Choking Cloud (Archavon 25)";
	sound = 1;
};

GTFO.SpellID["28547"] = {
	desc = "Chill (Sapphron 10)";
	sound = 1;
};

GTFO.SpellID["55699"] = {
	desc = "Chill (Sapphron 25)";
	sound = 1;
};

GTFO.SpellID["60919"] = {
	desc = "Rock Shower (Archavon Warder 10)";
	sound = 1;
};

GTFO.SpellID["60923"] = {
	desc = "Rock Shower (Archavon Warder 25)";
	sound = 1;
};

GTFO.SpellID["54362"] = {
	desc = "Poison (Grobbulus)";
	sound = 1;
};

GTFO.SpellID["28158"] = {
	desc = "Poison (Grobbulus)";
	sound = 1;
};

GTFO.SpellID["28241"] = {
	desc = "Poison (Grobbulus)";
	sound = 1;
};

GTFO.SpellID["54363"] = {
	desc = "Poison (Grobbulus)";
	sound = 1;
};

GTFO.SpellID["53400"] = {
	desc = "Acid Cloud (Hadronox)";
	sound = 1;
};

GTFO.SpellID["59419"] = {
	desc = "Acid Cloud (Hadronox - Heroic)";
	sound = 1;
};

GTFO.SpellID["64851"] = {
	desc = "Flaming Rune (Ulduar trash)";
	sound = 1;
};

GTFO.SpellID["64989"] = {
	desc = "Flaming Rune (Ulduar trash)";
	sound = 1;
};

GTFO.SpellID["50752"] = {
	desc = "Storm of Grief (Maiden of Grief)";
	sound = 1;
};

GTFO.SpellID["59772"] = {
	desc = "Storm of Grief (Maiden of Grief - Heroic)";
	sound = 1;
};

GTFO.SpellID["59451"] = {
	desc = "Mojo Puddle";
	sound = 1;
};

GTFO.SpellID["58994"] = {
	desc = "Mojo Puddle - Heroic";
	sound = 1;
};

GTFO.SpellID["55627"] = {
	desc = "Mojo Puddle";
	sound = 1;
};

GTFO.SpellID["62466"] = {
	desc = "Lightning Charge (Thorim)";
	sound = 1;
};

GTFO.SpellID["62451"] = {
	desc = "Unstable Energy (Freya 10)";
	sound = 1;
};

GTFO.SpellID["62865"] = {
	desc = "Unstable Energy (Freya 25)";
	sound = 1;
};

GTFO.SpellID["66881"] = {
	desc = "Slime Pool (Northrend Beasts 10 Normal)";
	sound = 1;
};

GTFO.SpellID["67639"] = {
	desc = "Slime Pool (Northrend Beasts 10 Heroic)";
	sound = 1;
};

GTFO.SpellID["67638"] = {
	desc = "Slime Pool (Northrend Beasts 25 Normal)";
	sound = 1;
};

GTFO.SpellID["67640"] = {
	desc = "Slime Pool (Northrend Beasts 25 Heroic)";
	sound = 1;
};

GTFO.SpellID["66320"] = {
	desc = "Fire Bomb (Northrend Beasts 10 Normal)";
	sound = 1;
};

GTFO.SpellID["67473"] = {
	desc = "Fire Bomb (Northrend Beasts 10 Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["67472"] = {
	desc = "Fire Bomb (Northrend Beasts 25 Normal)";
	sound = 1;
};

GTFO.SpellID["67475"] = {
	desc = "Fire Bomb (Northrend Beasts 25 Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["66877"] = {
	desc = "Legion Flame (Lord Jaraxxus 10 Normal)";
	sound = 1;
};

GTFO.SpellID["67071"] = {
	desc = "Legion Flame (Lord Jaraxxus 10 Heroic)";
	sound = 1;
};

GTFO.SpellID["67070"] = {
	desc = "Legion Flame (Lord Jaraxxus 25 Normal)";
	sound = 1;
};

GTFO.SpellID["67072"] = {
	desc = "Legion Flame (Lord Jaraxxus 25 Heroic)";
	sound = 1;
};

GTFO.SpellID["66496"] = {
	desc = "Fel Inferno (Lord Jaraxxus 10 Normal)";
	sound = 2;
};

GTFO.SpellID["68717"] = {
	desc = "Fel Inferno (Lord Jaraxxus 10 Heroic)";
	sound = 2;
};

GTFO.SpellID["68716"] = {
	desc = "Fel Inferno (Lord Jaraxxus 25 Normal)";
	sound = 2;
};

GTFO.SpellID["68718"] = {
	desc = "Fel Inferno (Lord Jaraxxus 25 Heroic)";
	sound = 2;
};

GTFO.SpellID["64704"] = {
	desc = "Devouring Flame (Razorscale 10)";
	sound = 1;
};

GTFO.SpellID["64733"] = {
	desc = "Devouring Flame (Razorscale 25)";
	sound = 1;
};

GTFO.SpellID["66684"] = {
	desc = "Flaming Cinder (Koralon 10)";
	sound = 1;
};

GTFO.SpellID["67332"] = {
	desc = "Flaming Cinder (Koralon 25)";
	sound = 1;
};

GTFO.SpellID["63346"] = {
	desc = "Focused Eyebeam (Kologarn 10)";
	sound = 1;
};

GTFO.SpellID["63976"] = {
	desc = "Focused Eyebeam (Kologarn 25)";
	sound = 1;
};

GTFO.SpellID["64459"] = {
	desc = "Seeping Feral Essence (Auriaya 10)";
	sound = 1;
};

GTFO.SpellID["64675"] = {
	desc = "Seeping Feral Essence (Auriaya 25)";
	sound = 1;
};

GTFO.SpellID["66351"] = {
	desc = "Mine Explosion (Mimiron 10)";
	sound = 1;
};

GTFO.SpellID["63009"] = {
	desc = "Mine Explosion (Mimiron 25)";
	sound = 1;
};

GTFO.SpellID["63157"] = {
	desc = "Ground Fissure (Freya Trash 10)";
	sound = 1;
};

GTFO.SpellID["63548"] = {
	desc = "Ground Fissure (Freya Trash 25)";
	sound = 1;
};

GTFO.SpellID["67594"] = {
	desc = "Poison Bottle (Trials of the Champion Regular)";
	sound = 1;
};

GTFO.SpellID["68316"] = {
	desc = "Poison Bottle (Trials of the Champion Heroic)";
	sound = 1;
};

GTFO.SpellID["65775"] = {
	desc = "Acid-Drenched Mandibles (Anub'arak 10 Normal)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["67861"] = {
	desc = "Acid-Drenched Mandibles (Anub'arak 10 Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["67862"] = {
	desc = "Acid-Drenched Mandibles (Anub'arak 25 Normal)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["67863"] = {
	desc = "Acid-Drenched Mandibles (Anub'arak 25 Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["64566"] = {
	desc = "Flames (Mimiron Hard Mode)";
	sound = 1;
};

GTFO.SpellID["63272"] = {
	desc = "Hurricane (Freya Trash)";
	sound = 1;
};

GTFO.SpellID["62269"] = {
	desc = "Rune of Death (Runemaster Molgeim 10)";
	sound = 1;
};

GTFO.SpellID["63490"] = {
	desc = "Rune of Death (Runemaster Molgeim 25)";
	sound = 1;
};

GTFO.SpellID["61886"] = {
	desc = "Lightning Tendrils (Stormcaller Brundir 10)";
	sound = 1;
};

GTFO.SpellID["63485"] = {
	desc = "Lightning Tendrils (Stormcaller Brundir 25)";
	sound = 1;
};

GTFO.SpellID["54115"] = {
	desc = "Blight Crystal Explosion (Drakuru)";
	sound = 1;
};

GTFO.SpellID["69024"] = {
	desc = "Toxic Waste";
	sound = 1;
};

GTFO.SpellID["70274"] = {
	desc = "Toxic Waste";
	sound = 1;
};

GTFO.SpellID["70436"] = {
	desc = "Toxic Waste";
	sound = 1;
};

GTFO.SpellID["69238"] = {
	desc = "Icy Blast (Scourgelord Tyrannus - Normal)";
	sound = 1;
};

GTFO.SpellID["69628"] = {
	desc = "Icy Blast (Scourgelord Tyrannus - Heroic)";
	sound = 1;
};

GTFO.SpellID["67781"] = {
	desc = "Desecration (The Black Knight - Normal)";
	sound = 1;
};

GTFO.SpellID["67876"] = {
	desc = "Desecration (The Black Knight - Heroic)";
	sound = 1;
};

GTFO.SpellID["72362"] = {
	desc = "Well of Corruption (Marwyn)";
	sound = 1;
};

GTFO.SpellID["72383"] = {
	desc = "Corrupted Touch (Marwyn - Normal)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["72450"] = {
	desc = "Corrupted Touch (Marwyn - Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["68921"] = {
	desc = "Soulstorm (Bronjahm - Normal)";
	sound = 1;
};

GTFO.SpellID["69049"] = {
	desc = "Soulstorm (Bronjahm - Heroic)";
	sound = 1;
};

GTFO.SpellID["68863"] = {
	desc = "Well of Souls (Devourer of Souls - Normal)";
	sound = 1;
};

GTFO.SpellID["70323"] = {
	desc = "Well of Souls (Devourer of Souls - Heroic)";
	sound = 1;
};

GTFO.SpellID["71001"] = {
	desc = "Death and Decay (Lady Deathwhisper - 10 / 25 Phase 2)";
	sound = 1;
};

GTFO.SpellID["72108"] = {
	desc = "Death and Decay (Lady Deathwhisper - ??)";
	sound = 1;
};

GTFO.SpellID["72109"] = {
	desc = "Death and Decay (Lady Deathwhisper - 25 Phase 1)";
	sound = 1;
};

GTFO.SpellID["72110"] = {
	desc = "Death and Decay (Lady Deathwhisper - ??)";
	sound = 1;
};

GTFO.SpellID["69146"] = {
	desc = "Coldflame (Lord Marrowgar - 10 Normal)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["70824"] = {
	desc = "Coldflame (Lord Marrowgar - 10 Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["70823"] = {
	desc = "Coldflame (Lord Marrowgar - 25 Normal)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["70825"] = {
	desc = "Coldflame (Lord Marrowgar - 25 Heroic)";
	sound = 1;
	applicationOnly = true;
};

-- Named spells

GTFO.SpellName["Shadow Void"] = {
	desc = "Shadow Void";
	sound = 1;
};

GTFO.SpellName["Poison Cloud"] = {
	desc = "Poison Cloud";
	sound = 1;
};

GTFO.SpellName["Void Zone"] = {
	desc = "Void Zone";
	sound = 1;
};

GTFO.SpellName["Spirit Fount"] = {
	desc = "Spirit Fount";
	sound = 1;
};

GTFO.SpellName["Flamestrike"] = {
	desc = "Flamestrike (Generic)";
	sound = 2;
};

GTFO.SpellName["Blizzard"] = {
	desc = "Blizzard (Generic)";
	sound = 2;
};

GTFO.SpellName["Death and Decay"] = {
	desc = "Death and Decay (Generic)";
	sound = 2;
};

GTFO.SpellName["Raging Consecration"] = {
	desc = "Raging Consecration";
	sound = 2;
};

GTFO.SpellName["Rain of Fire"] = {
	desc = "Rain of Fire (Generic)";
	sound = 2;
};

GTFO.SpellName["Volley"] = {
	desc = "Volley (Generic)";
	sound = 2;
};

GTFO.SpellName["Hellfire"] = {
	desc = "Hellfire (Generic)";
	sound = 2;
};

GTFO.SpellName["Hurricane"] = {
	desc = "Hurricane (Generic)";
	sound = 2;
};

GTFO.SpellName["Magma Totem"] = {
	desc = "Magma Totem (Generic)";
	sound = 2;
};

GTFO.SpellName["Consumption"] = {
	desc = "Consumption";
	sound = 1;
};

-- There are 92 different spell IDs for this one!  Going to stick with the name for now...
GTFO.SpellName["Breath"] = {
	desc = "Breath (Onyxia)";
	sound = 1;
};


end

--PvP

PowaGTFOPvP = {
-- Paladin Consecration
["26573"] = true,
["20116"] = true,
["20922"] = true,
["20923"] = true,
["20924"] = true,
["48818"] = true,
["48819"] = true,
}
