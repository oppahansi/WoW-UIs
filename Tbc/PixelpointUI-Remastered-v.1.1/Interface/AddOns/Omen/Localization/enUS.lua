local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Omen", "enUS", true)
if not L then return end

L["Background color"] = true
L["Background texture"] = true
L["Bar options"] = true
L["Border color"] = true
L["Border texture"] = true
L["Color"] = true
L["Configure"] = true
L["Configure the labels that appear on the bars"] = true
L["Control the label fonts"] = true
L["Control the font size of the labels"] = true
L["Display options"] = true
L["Font"] = true
L["Font settings"] = true
L["Frame's border color"] = true
L["Height"] = true
L["Height of each bar"] = true
L["Labels"] = true
L["Window options"] = true
L["None"] = true
L["Open the configuration dialog"] = true
L["Options that control Omen's appearance"] = true
L["Options for modifying the look and feel of the main display"] = true
L["Options which affect the style of the threat bars"] = true
L["Outline"] = true
L["Size"] = true
L["Control the size of this frame"] = true
L["Spacing"] = true
L["Spacing between each bar"] = true
L["Stretch textures"] = true
L["Stretch textures to fit the width of the bar"] = true
L["Texture"] = true 
L["Thick Outline"] = true
L["The color of the labels"] = true
L["The font that the labels will use"] = true
L["The outline that the labels will use"] = true
L["The texture that the bar will use"] = true

L["Texture to use for the frame's background"] = true
L["Texture to use for the frame's border"] = true
L["Main display's border color"] = true
L["Bars window"] = true
L["Options that affect the appearance of the bar list window"] = true
L["Options that affect the appearance of the title window"] = true
L["Options that affect the appearance of the module list window"] = true
L["Title window"] = true
L["Hide version"] = true
L["Hide the version number and out-of-date notice"] = true
L["Hide"] = true
L["Hide this frame"] = true
L["Options not related to appearance"] = true
L["General options"] = true
L["TPS Update Frequency"] = true
L["Controls the speed at which TPS (threat per second) values update.\nRaise this value to increase performance, or set it to 0 to turn off TPS queries."] = true
L["Modules window"] = true
L["Defaults"] = true
L["Options that affect the appearance of all frames"] = true
L["Reset to defaults"] = true
L["Use global defaults for this frame"] = true
L["Show test bars"] = true
L["Test"] = true

L["Modules"] = true
L["Options for Omen's various modules"] = true

L["Lock Omen"] = true
L["Locks Omen in place and prevents it from being dragged or resized."] = true
L["Hide when not needed"] = true

L["Animate bars"] = true
L["Smoothly animate bar changes"] = true
L["Hides Omen when you are resting, not in a party, or in an arena or battleground"] = true
L["Error"] = true
L["Unable to use shake warning. If you have nameplates turned on, turn them off to enable shake warnings."] = true

L["Background opacity"] = true
L["Opacity of each bar's background"] = true
L["Background darkness"] = true
L["Darkness of each bar's background"] = true

L["Opacity"] = true
L["Opacity of the entire frame"] = true

L["Classes"] = true
L["DRUID"] = "Druid"
L["HUNTER"] = "Hunter"
L["MAGE"] = "Mage"
L["PALADIN"] = "Paladin"
L["PET"] = "Pet"
L["PRIEST"] = "Priest"
L["ROGUE"] = "Rogue"
L["SHAMAN"] = "Shaman"
L["WARLOCK"] = "Warlock"
L["WARRIOR"] = "Warrior"

L["Number of bars to show"] = true
L["Autocollapse"] = true
L["Collapse to show a minimum number of bars"] = true

L["Collapse hides bar list"] = true
L["Let autocollapse hide the bar list if no bars are shown"] = true
L["Collapse hides entire Omen window"] = true
L["Let autocollapse hide the |c00ffffffentire window|r if no bars are shown. Note: This |c00ffffffwill|r prevent you from switching modules out of combat."] = true

L["Grow Up"] = true
L["Grow bars upwards"] = true
L["Toggle Omen"] = true
L["Center Omen"] = true
L["Active when alone"] = true
L["Enable ThreatLib even when you aren't in a party and don't have a pet."] = true

L["Control the scale of the entire Omen GUI"] = true
L["Scale"] = true

L["Clamp to screen"] = true
L["Clamp the Omen frame to the screen"] = true

L["Skin"] = true
L["Save your current settings and load other skins"] = true
L["Load Skin..."] = true
L["Load a saved skin"] = true
L["Save Skin As..."] = true
L["Save the current settings as a skin"] = true

L["Click|r to toggle the Omen window"] = true
L["Right-click|r to open the options menu"] = true

L["Attach to minimap"] = true
L["FuBar options"] = true
L["Position"] = true
L["Left"] = true
L["Center"] = true
L["Right"] = true
L["Show text"] = true
L["Show icon"] = true

L["Standby"] = true
L["Hide minimap/FuBar icon"] = true

L["Configure Omen"] = true

L["Version Checks"] = true
L["Show all party member revisions"] = true
L["Show oudated party member revisions"] = true

L["ThreatLib Version Check: All party members"] = true
L["ThreatLib Version Check: Outdated party members"] = true
L["latest is"] = true

L["You have a pet"] = true
L["Show Omen when you have a pet out"] = true
L["You are alone"] = true
L["Show Omen when you are alone"] = true
L["You are in a party"] = true
L["Show Omen when you are in a 5-man party"] = true
L["You are in a raid"] = true
L["Show Omen when you are in a raid"] = true
L["Show when..."] = true
L["Show Omen when..."] = true
L["You are resting"] = true
L["Show Omen when you are resting"] = true
L["You are in a battleground"] = true 
L["Show Omen when you are in a battleground or arena"] = true
L["You are in a dungeon"] = true
L["Show Omen when you are in a dungeon (5 man and raid)"] = true

L["Unknown"] = true
L["Not compatible!"] = true

L["Issue threat clear"] = true
L["Issue threat clear (requires party leader or raid assistant)"] = true

L["Your version of Omen/Threat is out of date. Please update from WAU or http://files.wowace.com/Omen/Omen.zip when possible."] = true
L["Your version of Omen/Threat is out of date and is not compatible with the newest version. You should update from WAU or http://files.wowace.com/Omen/Omen.zip as soon as possible."] = true

L["Whisper older clients informing them to update."] = true
L["You must be the group leader or a group assistant to do this."] = true

BINDING_HEADER_OMEN = "Omen"
BINDING_NAME_OMENTOGGLE = "Toggle Omen"
BINDING_NAME_OMENNEXTMODULE = "Go to next module"
BINDING_NAME_OMENPREVMODULE = "Go to previous module"

