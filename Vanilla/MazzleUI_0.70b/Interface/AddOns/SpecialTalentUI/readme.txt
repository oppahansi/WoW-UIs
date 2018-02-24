Special Talent by Aquendyn
v 1.08 beta 2

Improved Talent Frame.

You can see and interact with all three talent trees at once. Summary of your learned and planned talent points at the top. Plan your alts' templates.

--[ === Installing the addon

The zip file extracts files into two folders called SpecialTalent and SpecialTalentUI. The actual frame is loaded on demand. In the login screen, you must enable both addons or you will get the Blizzard's default talent frame. By default, both are enabled when you install this addon.

--[ === Opening the frame

Open Special Talent frame as you normally do for the default talent frame. That is, click the talent microbutton on your main bar or use a keybinding. (Open main menu, click keybinding. Look for Toggle Talent Pane, then assign a key.)

--[ == Learning and planning talents

There are two modes when you click a talent, learning and planning. When you first open the Special Talent frame, you are in learning mode. You can switch between learning and planning by clicking on the checkbox by the labels Learned and Planned at the top of the frame. On each talent button, planned points for that talent are light blue in the bottom left of the button, and learned points are yellow or green in the bottom right.

In learning mode, clicking on a talent will attempt to learn that talent. Check "Force Shift-click to Learn" so that you must hold down Shift before you can learn a talent. This prevents accidentally learning a talent with just a click.
The total points in each talent tree are displayed to the right of the tree name and by the yellow Learned label near the top of the frame. You see something like 0/0/0, where each number corresponds to the left, center, and right talent tree. After the equal sign '=' says spent points out of total points for your level.

In planning mode, you do not actually learn the talents. Left-clicking on a talent will add a point to that talent, to that tree, and to your entire planned template. Right-clicking will subtract a point. You can also scroll mouse wheel up or down to plan or unplan a talent, respectively. Check "Force Shift-click to Learn" so that you can Shift-click to learn a talent in planning mode.
The total points in each talent tree are displayed to the left of the tree name and by the blue Planned label near the top of the frame. You see something like 0/0/0, where each number corresponds to the left, center, and right talent tree. After the equal sign '=' says spent points out of total points for level 60.

There are some rules in planning mode.
1. You can't add more than 51 points total to your planned template.
2. Darkened buttons cannot be clicked until you have put enough points into the lower tiers, if a prerequisite talent's rank is not full, or if you have used up 51 points.
3. You can't remove a talent if that means you won't have enough points to support the higher tiers. First, remove the talents from the higher tiers.
4. You can't remove a talent if a dependent talent is planned. First, unplan the dependent talents, then unplan the first talent.

Reset the planned template takes two steps:
1. Click the checkbox to right of the Reset Planned Template button.
2. Click on the Reset Planned Template button.

--[ === Managing the Alts' Talents

You can see and plan your alts' talents by choosing the servers and names from the dropdown menus. If you try to select an alt and nothing changes, then that means your alt's class has not been saved. To do so first, log in your alt, and open Special Talent. Then, log out.

If the player chosen is not the active player, which is the current player that's logged in, then you cannot have that player learn talents. You can still plan his or her talents. So, the talent points and unspent points will always be for the active player.

--[ === Managing the tooltip

When your mouse hovers over a talent, a tooltip will pop up with that talent's information. If you have put any planned points into this talent, the planned rank will also show up as blue, as well as the talent's ability text for that rank.

If you want to see the ability text for all ranks, hold down Alt key as you move the mouse over the talent.

If the player is an alt, that is if he or she is not the active player that is logged in, then the tooltip will try to read the information from the local database stored in SpecialTalentData.lua. I'm thinking of how to get the ability text for languages besides English.

If the information you see on the tooltip is incorrect, please report the bug. Check for things like talent's name, maximum rank, mana cost, range, casting time, cooldown, requirements, and ability text.

--[ === Managing the frame

Minimize the frame by pressing the \/ button at the top right. Click on tabs at right side of frame to switch talent trees. When minimized, you can only manage the active player's talents.
Maximize again by pressing the /\ button.

Drag the frame by dragging the portrait at the top-left.
Type /script SpecialTalentFrame_ResetDrag() to place the frame at the default location.

--[ === Version History

1.08 beta 2
localized class name in frame title
localized german, french ability texts (unicode should work fine)
localized german, french strings

1.08 beta 1
alts talents
talent data base

1.07 beta 2 release
hold alt key on mouseover to show all ranks' data if you have WebData.lua
ability to reset planned template. check the box next to it first, then click reset button.

1.07 beta 1 release
remove virtual templates from toc (UIPanelTemplates.xml, CharacterFrameTemplates.xml, ItemButtonTemplate.xml)
fixed: show correct learned points in planning mode
SpecialTalent_GetTalentInfo to return learnRank and planRank

1.06
removed font.xml from toc
removed inherits from fontstrings, now uses font=
min and max arrow string constants
fixed: attempt to concatenate field 'points' (a nil value)
fixed: allow planning a talent that requires a skill (eg Nature's Grasp requires Entangling Roots)
fixed: disallow unplanning talent with dependency on same tier (eg Nature's Grasp)

1.05
fixed missing SpecialTalentFrameSaved
always show talent microbutton

1.04
added support for Talent Planner data to appear on tooltip. either enable Talent Planner or extract its WebData.lua into SpecialTalentUI folder. if you don't use Blizzard's talent frame, second option is better.
allow option to minimize Special Talent Frame

1.03
fixed in planning mode correct isLearnable value when rank < maxRank (in SpecialTalent_GetTalentPrereqs )
reduce button alpha instead of desaturate
mouse wheel to plan or unplan talent
shift-click to learn in planning mode (must turn on Force Shift-click to Learn)
removed unnecessary files
notes in toc files are now more descriptive

1.02
shows learned and planned points allocated/max ( = 0/51)
option to learn only on shift-click
show planned points by tree name (0 :Frost: 0)
drag frame by dragging topleft portrait
SpecialTalentFrame_ResetDrag() to undo drag
planning mode enable/disable buttons like learning mode
planning mode checks for prereqs, dependents, tiers (tooltip may not show right info)

1.01
buttons made bigger
added planning mode
removed keybinding
saved variable for planned templates
added readme.txt

1.00
shows all three talent trees
