==================
TargetButtons 0.36
::::::::::::::::::

Improving the target frame with easily accessible one-click buttons with the 
functionality of the right click menu. (Adds invite, follow, trade, whisper, 
duel, inspect buttons.)

Required dependencies: none
Optional dependencies: myAddons, GoodInspect, SuperInspect


------------------
FAQ:
..................

Q: How do I install this addon?
A: Place the TargetButtons folder in your WoW directory's Interface/Addons subdir.
   You might have to make the directory yourself if you have no other addons.

....
Q: What does this AddOn do?
A: It adds new buttons to the targeting frame when a friendly player is selected
   making it easier to access the functionality of the right click menu. The 
   buttons are: invite, follow, trade, whisper, duel, inspect.

....
Q: I don't need all the buttons, can I disable some of them?
A: Yes, all the buttons can be disabled/enabled. Open the Options window to do
   this.

....
Q: How do I open the Options windw?
A: If Cosmos is running, select TargetButtons from the Cosmos feature frame.
   If myAddons is installed, select TargetButtons from the myAddons list.
   If noone of this AddOns are running, type in /tboptions in the chat.

....
Q: I set the position of a button, but nothing happens. What's wrong?
A: Setting the position of each button separately is a feature only working in
   Free layout mode. If you select this layout mode, you can move the button.

....
Q: What's this all about layout modes?
A: The first version of the AddOn came with a unique layout (now called Classic),
   later the MiniGroup support had Left-to-right layout. When I made the AddOn 
   support free button positioning (Free mode) I just didn't want to remove the 
   Classic mode (because that's what I use) and Left-to-right mode (because I 
   worked with the code). Insteed I added a Right-to-left mode too. It's just 
   easier for people who are satisfied with one of the built-in layouts, they 
   don't have to set the position of the buttons by themselves.

...
Q: I like the Classic/Left-to-right/Right-to-left layout mode, but the buttons 
   are hovering my target frame. What should I do?
A: Use the 'Global offset' sliders to get TargetButtons to another place without 
   the need to set the place of all the buttons separately.

...
Q: What's the 'Set target frame' button for?
A: If you use the built-in Blizzard UI then this is useless for you. However if 
   you use a custom target frame like the one in MiniGroup, Linoleum or NurfedUI
   you can set up TargetButtons to arrange to the appropriate target frame. You 
   just have to know the name of the frame, enter it to the editbox and hit the
   button.

...
Q: Per-button resizing doesn't work, what's up with it?
A: You probably checked the checkbox near 'Global sizing' wich overrides 
   per-button settings. Uncheck this to get separate sizes for all buttons.

...
Q: I have GoodInspect/Superinspect running. Will the button always stay enabled?
A: Yes, you'll have the inspect button enabled all the time.




------------------
Version history:
..................

0.36
-interface version number changed to 11000 (1.10.0 patch)
-Set Target Frame works again. sorry!
-allows inspecting from far away when SuperInspect installed
 (just like GoodInspect)
-Cosmos is not a supported optional dependency anymore (didn't remove
 the code, please contact me if it makes some trouble in the future)

...
0.35
-interface version number changed to 10900 (1.9.0 patch)
-removed option to show inspect button when enemy player selected
 (inspecting cross-faction doesn't work anymore)
-duel button is now shown when enemy player selected (if showing
 the duel button at all is enabled)
-changed the code for showing buttons in free mode

...
0.34 (quick code, no test)
-interface version number changed to 1700 (1.7.0 patch)
-promote does promote to officer when in raid (I hope it does...)
-bugfix: invite button should now really stay enabled for raid
 officers (I hope it does...)

...
0.33
-interface version number changed to 1600 (1.6.0 patch)
-invite is replaced with promote when selected target is in players
 raid

...
0.32
-interface version number changed to 1500 (1.5.0 patch)
-options window images included (BattleGroundFrame images changed)
-inspect button is were it should be when enemy player selected
-raid officers have the invite button enabled (good thing in BG)

...
0.31 re
-bugfix: layout mode will now be remembered even if it's not set to
 Classic mode

...
0.31
-added translation: german
-added ability to move options frame
-value of sliders shown
-/tb changed to /tbopt (TackleBox conflict)

...
0.3
-redone art
-follow, trade, duel and inspect buttons will be disabled when target 
 is too far away (inspect stays enabled all the time when GoodInspect 
 is running)
-invite:
  .changes to 'promote to leader' when you're a party leader and 
   select a party member
  .disabled when you're not the party leader
-button resizing: global or per-button
-slider for space between buttons when layout is set to l-t-r or r-t-l
-myAddon support
-/tboptions now accessible via /tb
-a GUI worth to show
-removed some redundancy from the code, so
 PLEASE USE THE 'Reset defaults' BUTTON IF YOU HAD AN EARLIER VERSION
 INSTALLED!! This is important, that's why I shout... -_-

...
0.291
-removed Sea dependency never meant to be in the AddOn

...
0.29
-slash commands from earlier versions deleted
-has it's very own options frame, accessible via /tboptions or the
 Cosmos main page
-now supports ANY target frame
  (Please be aware of case sensitivity!!
   Examples:
   Blizzard built-in target frame:	TargetFrame
   MiniGroup v0.4 target frame:		MGTarget_Frame
   MiniGroup v0.5beta target frame:	MGtarget
   Linoleum target frame:		LTarget)
-4 modes:	classic: as seen in the first version
		left-to-right: as seen in the MiniGroup version
		right-to-left: similar to the above floating from the
			right side insteed
		free: x and y offset for any button set by you
-global offset values for the whole button group

...
0.211:
-Hotfix for bug when enemy player is selected

...
0.21
-Inspect button is now displayed for targets from the opposing faction
 too when TargetButtons recognizes GoodInspect.
-MiniGroup version recognized. Works with MiniGroup 0.4b and 0.5beta
 as intended.

...
0.2:
-MiniGroup is now supported, use /tminig to hide/reveal TargetButtons
 on your MiniGroup targeting frame
-/tstand now toggles if TargetButtons should be displayed on the
 standard targeting frame
-added optional Cosmos dependency, look for TargetButtons options in
 your Cosmos settings (I know checkbuttons would be great, but I'm not
 an expert in Cosmos, sry)

...
0.1:
-Invite, Follow, Trade, Whisper, Duel and Inspect buttons
-each button can be enabled/disabled separately with slash commands
-floating button layout


------------------
Notes:
..................

New versions get always uploaded to:
www.curse-gaming.com
ui.worldofwar.net

...
Suggestions are welcome!

...
TargetButtons needs a french translation, contact me please!


------------------
Author:
..................
Name:	QuippeR
E-mail: quipper@gmail.com
