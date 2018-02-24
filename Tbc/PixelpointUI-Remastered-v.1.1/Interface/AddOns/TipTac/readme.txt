TipTac - A Tooltip Addon
------------------------
TipTac is a tooltip enchancement addon, it allows you to configure various things such as changing the tip anchor, the font, the scale of tips, plus a lot more.
It can also show a special tip window for units instead of the normal one, which allows for extra customization, such as having it show buffs, debuffs, health and mana bar, this can of course be disabled if you prefer the normal tip.

To open the option dialog, just use "/tip" without any parameters. Use "/tip anchor" to show the anchor frame and position it as you want.

You can always get the latest release of this addon on either WoWInterface.com or Curse.com.
Post your comments, questions and suggestions for this addon on either of these sites. 

Current Features
----------------
- Based on the default mode in TipBuddy, but can be configured in appearance in many ways.
- Shows the buffs and debuffs of the target with cooldown models. Has option to make it only show castable buffs and removable debuffs.
- When in a raid or party, it has an option to show who is targeting the unit.
- Vast anchoring options allows you to change between Normal, Mouse and Smart Anchor, this is configurable for both unit and non-unit tips.
- Anchoring frame lets you decide where exactly you want tips with the normal anchoring option anchored.
- Able to change the font face and size for all tips in the User Interface. Uses "LibSharedMedia" if installed.
- Can show a Health and Mana, Energy, Rage or Focus bar inside the tip, which can be enabled or disabled as you prefer.
- Tips are getting updated at a customizable interval to display changes.
- Unit tip fades out of display when no longer valid, fade time can be configured.
- Allows for you to change the background and border color of the TipTacTip and any of the modified tip.

Layout Templates
----------------
Currently TipTac comes with a few presets, these are a collection of preset settings. You can find the presets in the options.
I plan to work on layout option so you can eventually save and load personal layouts. But for now I am looking for more layout presets to include in future releases of TipTac.

Special Tip Modification
------------------------
TipTac does not only configure the tip for units, you can also use TipTac to modify other tips in the WoW Interface.
The way they are getting modified are both in scale and appearance. The border and background of the modified tips can be changed to colors of your desire.
You can disable this appearance change by disabling the option "Hook Special Tips" under the General tab of the options dialog.
Currently these tips are getting modified: GameTooltip, ShoppingTooltip1, ShoppingTooltip2, ItemRefTooltip, WorldMapTooltip and AtlasLootTooltip. You can add more if you wish by editing the "TipTac.lua" file.

TipTac & MobInfo2
-----------------
Since the 08.01.17 release, this should no longer be a problem since I renamed the config variable.
Apparently, without letting me know, the author of MobInfo2 has made it so that when the option "Hide the other Tooltip" is enabled, it will disable the TipTac unit tip. To get TipTac to show this again, you just have to disable this option in MobInfo2.
Would have been nice if the author would have told me or at least write something in the MobInfo2 documentation. Because people are blaming my mod for not working due to this.

Saving Settings Per Character
-----------------------------
If you prefer to have TipTac have individual settings for each your characters, you will have to manually edit the TipTac.toc file and change the line:
	## SavedVariables: TipTac_Config
Into the following line:
	## SavedVariablesPerCharacter: TipTac_Config

Lacking Features, Ideas & Problems
----------------------------------
- The tooltip always fades for mailboxs, braziers, signs, etc, not sure how this could be worked around, any help on this issue is appreciated.
- Anchoring the tip depending on what content is shown, it being a unit or not, can be hard to determine as the call to GameTooltip_SetDefaultAnchor() is called before the GTT content is set, any solution?
  Due to this, some anchoring combinations might not work well if showing the TipTacTip is diabled.
- Scrab the entire TipTacTip and just modify the GTT. Although this could pose a problem to other mods which rely on scanning the GTT for info?
- Cast Bar in addition to the already existing health and power bar.