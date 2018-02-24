--[[
Default Locale is English, those providing translations, just add it to the appropiate lua file
]]
local L = LibStub("AceLocale-3.0"):NewLocale("kgPanels","enUS",true)

--Artwork items
L["Delete from Library"] = true
L["Delete"] = true
L["Are you sure?"] = true
L["ART_PREVIEW"] = "Below is a preview of the artwork you just added. If you dont see the artwork, please reload your ui to ensure it is in the wow path."
L["Add"] = true

-- Panel items
L["OnClick"] = true
L["Enter the script for OnClick callback."] = true
L["OnLoad"] = true
L["Enter the script for OnLoad callback."] = true
L["OnLeave"] = true
L["Enter the script for OnLeave callback."] = true
L["OnEnter"] = true
L["Enter the script for OnEnter callback."] = true
L["OnHide"] = true
L["Enter the script for OnHide callback."] = true
L["OnShow"] = true
L["Enter the script for OnShow callback."] = true
L["OnUpdate"] = true
L["Enter the script for OnUpdate callback."] = true
L["OnEvent"] = true
L["Enter the script for OnEvent callback."] = true
L["Scripts"] = true
-- text options
L["Top"] = true
L["Middle"] = true
L["Bottom"] = true
L["Left"] = true
L["Right"] = true
L["Center"] = true
L["Vertical Justification"] = true
L["Justification of the text."] = true
L["Horizontal Justification"] = true
L["Y Offset"] = true
L["Y offset. NOTE: positive for right, negative for left."] = true
L["X Offset"] = true
L["X offset from center. NOTE: postive for up, negative for down."] = true
L["Text Positioning"] = true
L["Font"] = true
L["Font to use for this panel."] = true
L["Font Size"] = true
L["Size of the text in points."] = true
L["Font Color"] = true
L["Color for the text."] = true
L["Text"] = true
L["What you would like to appear on the panel."] = true
L["General Text Settings"] = true
L["Text Options"] = true
L["Blizzard"] = true
L["Texture Options"] = true
L["Background Texture"] = true
L["Name"] = true
L["Artwork to use for a background."] = true
L["Rotate"] = true
L["Rotate the artwork centered on the middle point."] = true
L["Flip Horizontally"] = true
L["Mirror this background."] = true
L["Flip Vertically"] = true
L["Invert the artwork."] = true
L["Border Texture"] = true
L["Border artwork."] = true
L["Border Edge Size"] = true
L["Border edge size, see the FAQ."] = true
L["Bottom Left"] = true
L["Bottom Right"] = true
L["Top Left"] = true
L["Top Right"] = true
L["Parent Frame"] = true
L["Frame you wish to parent against. NOTE: To parent against a panel you have already defined, simply use that name."] = true
L["Anchor Frame"] = true
L["Frame you wish to anchor this panel to."] = true
L["Anchor From"] = true
L["Anchoring from."] = true
L["Anchor To"] = true
L["Anchoring to."] = true
L["Parent And Anchor Settings"] = true
L["Scaling"] = true
L["Panel scaling options."] = true
L["Background"] = true
L["Low"] = true
L["Medium"] = true
L["High"] = true
L["Artwork"] = true
L["Dialog"] = true
L["Tooltip"] = true
L["Strata"] = true
L["Frame strata to set this in, Background is the lowest strata."] = true
L["Level"] = true
L["Panel level, for Z-Indexing."] = true
L["Y offsetting, positive for up, negative for down."] = true
L["X offsetting, positive for right, negative for left."] = true
L["Panel Height"] = true
L["Panel height."] = true
L["Panel Width"] = true
L["Panel width."] = true
L["Position Settings"] = true
L["Solid"] = true
L["Gradient"] = true
L["None"] = true
L["Horizontal"] = true
L["Vertical"] = true
L["Blend"] = true
L["Add"] = true
L["Mod"] = true
L["AlphaKey"] = true
L["Disable"] = true
L["Border Color"] = true
L["Border coloring."] = true
L["Background Color Blending"] = true
L["Blend mode for the background color."] = true
L["Background Gradient Color"] = true
L["Color to use for the gradient."] = true
L["Background Gradient Style"] = true
L["Gradient style of this panel."] = true
L["Background Color"] = true
L["Background color of this panel."] = true
L["Background Color Style"] = true
L["Color style of this panel. NOTE: None disables background coloring."] = true
L["Panel Opacity"] = true
L["Set the opacity of this panel."] = true
L["Color And Opacity Settings"] = true
L["kgPanel"] = true
L["Intercept Mouse Clicks"] = true
L["This option controls wether the panel will interact with the mouse. Required for OnLeave,OnEnter,OnClick"] = true
L["Lock Panel"] = true
L["Lock/Unlock this panel."] = true
L["General Settings"] = true
L["User defined Panel"] = true
L["Textures"] = true
L["Colors"] = true
L["Anchors"] = true
L["Postions"] = true
L["All"] = true
L["Paste"] = true
L["Perform a paste."] = true
L["From"] = true
L["Panel you wish to copy from."] = true
L["Copy"] = true
L["Copy configuration from another panel to use in this panel."] = true
L["Remove Panel"] = true
L["Delete this panel from the layout."] = true
L["Are you sure you wish to delete this panel? This can not be undone."] = true
L["Panel Layout"] = true
L["Set as Active Layout"] = true
L["Copy Layout To Clipboard"] = true
L["Export"] = true
L["Export this layout to the clipboard to copy and send to friends."] = true
L["Delete Layout"] = true
L["Delete this layout from your layout list."] = true
L["Rename Layout"] = true
L["Enter the new name of the layout"] = true
L["Change the name of this layout"] = true
L["Activate"] = true
L["Set this layout as your active layout."] = true
L["Default"] = true
L["Blizzard Tooltip"] = true
L["Blizzard Dialog"] = true
L["Panel Name"] = true
L["Name of this new panel"] = true
L["Create"] = true
L["Create a new panel with generic defaults"] = true
L["Panel already exists. Overwrite?"] = true
L["Create Using Defaults"] = true
L["Create a new panel using your specific defaults."] = true
L["Panel Creation"] = true
L["Active Panels"] = true
L["Default Panel Options"] = true
L["Layout Name"] = true
L["This is the name of the layout, as it will appear in drops downs, and the under the Layout tab."] = true
L["Create"] = true
L["Create a new layout. NOTE: This will change your current layout to the newly created layout."] = true
L["A layout with that name already exists. Overwrite?"] = true
L["Add New Layout"] = true
L["Layouts"] = true
L["Layout tab"] = true
L["Active Layout: "] = true
L["Art Library"] = true
L["Backgrounds"] = true
L["Borders"] = true
L["Add New Artwork"] = true
L["Artwork Name"] = true
L["This is the name as it will appear in drops down menus and the side tab."] = true
L["Artwork Type"] = true
L["Indicate what type of artwork you are adding."] = true
L["Artwork Path"] = true
L["This is the path to the texture you wish to add. NOTE: this path must be realtive to the WoW folder and seperated by '\\\\'"] = true
L["Create a new entry in the Artwork Library"] = true
L["Artwork already exists. Overwrite?"] = true
L["For help using kgPanels, please see the FAQ section."] = true
L["Enable Addon"] = true
L["This option allows you to turn kgPanels on/off"] = true
L["General Options"] = true
L["This is the general option menu. Core seetings are located in this main area."] = true
L["Addon Settings"] = true
L["Import New Layout"] = true
L["Import As.."] = true
L["Name to import this layout under."] = true
L["Import Layout"] = true
L["This will import a layout into your configuration."] = true
L["Import"] = true
L["Perform the import."] = true
L["kgPanels Layout Export"] = true
L["Press Ctrl-A to select the text, then Ctrl-C to copy."] = true
L["Press Cmd-A to select the text, then Cmd-C to copy."] = true
L["Background Insets"] = true
L["Inset Options"] = true
L["Top background inset."] = true
L["Left background inset."] = true
L["Bottom background inset."] = true
L["Right background inset."] = true
L["Scripts Dependency"] = true
L["Addon Name"] = true
L["Addon this Panels script depends."] = true
L["Frame Finder"] = true
L["Unknown"] = true
L["Frames"] = true
L["Tile Background"] = true
L["Tile the background texture, NOTE: this disables rotation and flipping."] = true
L["Tile Size"] = true
L["Size of each tile."] = true
L["Rename Panel"] = true
L["Change the name of this panel."] = true
L["There is already a panel with that name. Overwrite?"] = true
L["Rename"] = true
L["New name for this panel."] = true
L["Import from eePanels2"] = true
L["Import panels from eePanels2"] = true
L["Import complete, eePanels is now OFF, remember to disable or rmove eePanels2"] = true
L["FAQ"] = true
L["To create a panel you are required to have a layout active."] = true

L["1. kgPanels"] = true
L["2. Artwork"] = true
L["3. Textures"] = true
L["4. Text"] = true
L["5. Scripting"] = true
L["6. Import and Export"] = true
L["FAQ_1_1"] = [[
|cffffffffWhat is this layout stuff?|r

kgPanels organizes panels to a layout. Each layout is stored globally, and any given character simply sets the active layout you wish to use.
]]
L["FAQ_1_2"] = [[
|cffffffffI want to add a panel, but the create button(s) are greyed out. What am I doing wrong?|r

You have to have a layout selected. In the layout menu, click the layout you want to use, and activate it.
]]
L["FAQ_1_3"] = [[
|cffffffffParenting and Anchoring|r

kgPanels supports using YOUR defined panel name for parenting. 
Do not use kgPanelsxxx for a parent name. Doing so may cause unspecified behavior, as kgPanels recycles frames as needed. 
So again if you create a panel called 'silly panel' you can use 'silly panel' as the parent and anchor name.
]]
L["FAQ_1_4"] = [[
|cffffffffFinding frame names|r

kgPanels configuration system, adds a keybinding for the Framefinder. Under keybinding define a key for the frame finder
After that its as simple as hitting the key to bring up the frame finder and show you what frames are under the mouse.
]]
L["FAQ_2_1"] = [[
|cffffffffHow do I add Artwork?|r

You use the artwork library to add new peices as you need. If you have shared media installed those items will also appear in the dropdown list.
]]
L["FAQ_2_2"] = [[
|cffffffffWhy dont I see my color blending when I have a texture set?|r

Set your background style to gradiant or solid to blend the color into the texture.
]]
L["FAQ_2_3"] = [[
|cffffffffHow do I change the border color?|r

Set the color in the main section for a given panel.
]]
L["FAQ_2_4"] = [[
|cffffffffWhen i change the opacity I get mixed results|r

The main Opacity setting overrids the color opactiy.
]]
L["FAQ_3_1"] = [[
|cffffffffI just added a texture to the library but I dont see it. What am I doing wrong?|r

When you add a texture you must be sure that WoW can see the directory and the file is spelled correctly. If you just added this file to disk, you will need to restart
WoW for it to pick up the new file in its path.
]]
L["FAQ_3_2"] = [[
|cffffffffI added a border but it looks funny. Am I doing something wrong?|r

No, unfortunetly WoW doesnt always return a size for a texture, so kgPanels uses a default 50x50 size for borders. This may result in squished texture graphics for borders.
]]
L["FAQ_3_3"] = [[
|cffffffffI want to mirror some texture art. How do I do that?|r

Use the flip horizontal option for the texture. To reverse top and bottom use flip vertical.
]]
L["FAQ_3_4"] = [[
|cffffffffWhat is border edge size?|r

This is the size clipping used by WoW for borders. Changin this value will make your borders thicker or thinner as you change the value.
]]
L["FAQ_3_5"] = [[
|cffffffffDoes kgPanels support SharedMedia?|r
Yes
]]
L["FAQ_4_1"] = [[
|cffffffffI want to use a particular font, but the list only shows 'Blizzard'. How do I add more fonts?|r

Right now font support is limited. kgPanels will use any fonts available with SharedMedia. The other Option is to replace the default blizzard font ala Clearfont and ClearFont2
]]
L["FAQ_5_1"] = [[
|cffffffffScripting variables available|r
In any defined script the following variables are available:|r

|cffff6666self|r, which is always set to the panel invoking the script.|r

|cffff6666self.bg|r, this is the background art frame.|r

|cffff6666self.text|r, this is the fontstring for the frame.|r

|cffff6666kgPanels|r, this is a reference to the kgPanels object.|r

]]
L["FAQ_5_2"] = [[
|cffffffffkgPanels script usable functions|r

|cffff6666kgPanels:FetchFrame(name)|r, this will get any frame defined in your layout.|r

|cffff6666kgPanels:ActivateLayout(name)|R, this allows you to switch layouts.|r

There are other functions, however without detailed knowledge of internal data structures it is advised you do not use them.|r
]]
L["FAQ_5_3"] = [[
|cffffffffPassed in variables|r

Each handler passes in the upper level args, (see wowwiki Event api). 
The first variable is always self. 

OnEvent, we broke up the vararg so your function can simply reference arg1, arg2, arg3, etc..|r

OnUpdate provides the argument time|r

OnClick provides te argument button|r

]]
L["FAQ_5_4"] = [[
|cffffffffI added an OnEvent script but it never fires. What am I missing?|r

In your OnLoad, register for the events you wish to receive. i.e.|r

self:RegisterEvent("PLAYER_LOGIN")|r

At this current time, Non WoW generated events are not available. So receiving AceEvent-3.0 only message wont trigger your OnEvent.|r
However if you so choose you can could embed AceEvent-3.0 into the frame reference. Please be aware this may cause you to receive events twice.|r
]]
L["FAQ_5_5"] = [[
|CffffffffI added an OnClick/OnEnter/OnLeave script 
but nothing happens. What am I doing wrong?|r

You need to enable the mouse for the panel to receive those events.

]]
L["FAQ_5_6"] = [[
|cffffffffAre tehre some sample scripts?|r

Sample scripts will be posted on wowace.
]]
L["FAQ_6_1"] = [[
|cffffffffI tried to import a layout but nothign happened, whats going on?|r
Check your console, if the data failed to unpack their should be a message telling you why.
]]
L["FAQ_6_2"] = [[
|cffffffffI tried to export but was unable to import. What happened?|r
Did you follow the status line to copy to your system clipboard?
]]
L["FAQ_6_3"] = [[
|cffffffffHow do I import my old eePanels setup?|r

Load up eePanels, go to the layout menu add a new name and click import
from eePanels. It will import as much as it can and try to guess parenting
as much as possible. Scripts DO NOT import from eePanels.
]]





















































