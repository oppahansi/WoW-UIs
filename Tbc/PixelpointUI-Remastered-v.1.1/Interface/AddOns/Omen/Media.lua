local MINOR_VERSION = tonumber(("$Revision: 66520 $"):match("%d+"))
if MINOR_VERSION > Omen.MINOR_VERSION then Omen.MINOR_VERSION = MINOR_VERSION end

local media = LibStub("LibSharedMedia-3.0")

media:Register("sound", "Rubber Ducky", [[Sound\Doodad\Goblin_Lottery_Open01.wav]])
media:Register("sound", "Cartoon FX", [[Sound\Doodad\Goblin_Lottery_Open03.wav]])
media:Register("sound", "Explosion", [[Sound\Doodad\Hellfire_Raid_FX_Explosion05.wav]])
media:Register("sound", "Shing!", [[Sound\Doodad\PortcullisActive_Closed.wav]])
media:Register("sound", "Wham!", [[Sound\Doodad\PVP_Lordaeron_Door_Open.wav]])
media:Register("sound", "Simon Chime", [[Sound\Doodad\SimonGame_LargeBlueTree.wav]])
media:Register("sound", "War Drums", [[Sound\Event Sounds\Event_wardrum_ogre.wav]])
media:Register("sound", "Cheer", [[Sound\Event Sounds\OgreEventCheerUnique.wav]])
media:Register("sound", "Humm", [[Sound\Spells\SimonGame_Visual_GameStart.wav]])
media:Register("sound", "Short Circuit", [[Sound\Spells\SimonGame_Visual_BadPress.wav]])
media:Register("sound", "Fel Portal", [[Sound\Spells\Sunwell_Fel_PortalStand.wav]])
media:Register("sound", "Fel Nova", [[Sound\Spells\SeepingGaseous_Fel_Nova.wav]])

media:Register("sound", "Aoogah!", [[Interface\AddOns\Omen\Media\Sounds\aoogah.ogg]])
